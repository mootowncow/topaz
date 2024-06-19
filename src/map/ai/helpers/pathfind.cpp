/*
===========================================================================

Copyright (c) 2010-2015 Darkstar Dev Teams

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include "pathfind.h"
#include "../../zone.h"
#include "../../entities/baseentity.h"
#include "../../entities/mobentity.h"
#include "../ai_container.h"
#include "../../../common/utils.h"

CPathFind::CPathFind(CBaseEntity* PTarget)
{
    m_PTarget = PTarget;
    m_pathFlags = 0;
    m_carefulPathing = false;
    Clear();
}

CPathFind::~CPathFind()
{
    m_PTarget = nullptr;
    Clear();
}

bool CPathFind::RoamAround(const position_t& point, float maxRadius, uint8 maxTurns, uint16 roamFlags)
{
    TracyZoneScoped;
    Clear();

    m_roamFlags = roamFlags;

    if (isNavMeshEnabled())
    {

        if (FindRandomPath(point, maxRadius, maxTurns, roamFlags))
        {
            return true;
        }
        else
        {
            Clear();
            return false;
        }
    }
    else
    {
        // no point worm roaming cause it'll move one inch
        if (m_roamFlags & ROAMFLAG_WORM)
        {
            Clear();
            return false;
        }

        m_points.push_back({point.x - 1 + rand() % 2, point.y, point.z - 1 + rand() % 2, 0, 0});

    }

    return true;
}

bool CPathFind::PathTo(const position_t& point, uint8 pathFlags, bool clear)
{
    TracyZoneScoped;
    // don't follow a new path if the current path has script flag and new path doesn't
    if (IsFollowingPath() && (m_pathFlags & PATHFLAG_SCRIPT) && !(pathFlags & PATHFLAG_SCRIPT))
        return false;

    if (clear)
    {
        Clear();
    }

    m_pathFlags = pathFlags;

    if (isNavMeshEnabled())
    {
        bool result = false;

        if (m_pathFlags & PATHFLAG_WALLHACK)
        {
            result = FindClosestPath(m_PTarget->loc.p, point);
        }
        else
        {
            result = FindPath(m_PTarget->loc.p, point);
        }

        if (!result)
        {
            Clear();
        }

        return result;
    }
    else
    {
        if (clear)
            Clear();

        m_points.push_back(point);
    }

    return true;
}

bool CPathFind::PathInRange(const position_t& point, float range, uint8 pathFlags /*= 0*/, bool clear /*= true*/)
{
    TracyZoneScoped;
    if (clear)
    {
        Clear();
    }
    m_distanceFromPoint = range;
    return PathTo(point, pathFlags, false);
}

bool CPathFind::PathAround(const position_t& point, float distanceFromPoint, uint8 pathFlags)
{
    TracyZoneScoped;
    Clear();
    //position_t* lastPoint = &point;

    //float randomRadian = tpzrand::GetRandomNumber<float>(0, 2 * (float)M_PI);
    //lastPoint->x += cosf(randomRadian) * distanceFromPoint;
    //lastPoint->z += sinf(randomRadian) * distanceFromPoint;

    // save for sliding logic
    m_originalPoint = point;
    m_distanceFromPoint = 1;

    // Don't clear path so
    // original point / distance are kept
    return PathTo(point, pathFlags, false);
}

bool CPathFind::PathThrough(std::vector<position_t>&& points, uint8 pathFlags)
{
    TracyZoneScoped;
    Clear();

    m_pathFlags = pathFlags;

    AddPoints(std::move(points), m_pathFlags & PATHFLAG_REVERSE);

    return true;
}

bool CPathFind::WarpTo(const position_t& point, float maxDistance)
{
    TracyZoneScoped;
    Clear();

    position_t newPoint = nearPosition(point, maxDistance, (float)M_PI);

    m_PTarget->loc.p.x = newPoint.x;
    m_PTarget->loc.p.y = newPoint.y;
    m_PTarget->loc.p.z = newPoint.z;
    m_PTarget->loc.p.moving = 0;

    LookAt(point);
    m_PTarget->updatemask |= UPDATE_POS;

    return true;
}

bool CPathFind::isNavMeshEnabled()
{
    return m_PTarget->loc.zone && m_PTarget->loc.zone->m_navMesh != nullptr;
}

bool CPathFind::ValidPosition(const position_t& pos)
{
    TracyZoneScoped;
    if (isNavMeshEnabled())
    {
        return m_PTarget->loc.zone->m_navMesh->validPosition(pos);
    }
    else
    {
        return true;
    }
}

void CPathFind::LimitDistance(float maxLength)
{
    m_maxDistance = maxLength;
}

void CPathFind::StopWithin(float within)
{
    TracyZoneScoped;
    if (!IsFollowingPath()) return;
    // TODO: cut up path

    position_t& lastPoint = m_points.back();
    position_t* secondLastPoint = nullptr;

    if (m_points.size() == 1)
    {
        secondLastPoint = &m_PTarget->loc.p;
    }
    else
    {
        secondLastPoint = &m_points[m_points.size() - 2];
    }

    float distanceTo = distance(lastPoint, *secondLastPoint);

    if (distanceTo > within)
    {
        // reduce last point to stop within the given number
        float radians = atanf((secondLastPoint->z - lastPoint.z) / (secondLastPoint->x - lastPoint.x)) * (float)(M_PI / 180.0f);

        lastPoint.x -= cosf(radians) * within;
        lastPoint.z -= sinf(radians) * within;
    }
    else
    {
        // i'm already there, stop moving
        if (m_points.size() == 1)
        {
            Clear();
        }
        else
        {
            // remove last point, it'll make me too close
            m_points.pop_back();
        }
    }
}

void CPathFind::FollowPath()
{
    TracyZoneScoped;
    if (!IsFollowingPath()) return;

    m_onPoint = false;

    // move mob to next point
    position_t& targetPoint = m_points[m_currentPoint];

    StepTo(targetPoint, m_pathFlags & PATHFLAG_RUN);

    if (isNavMeshEnabled() && m_carefulPathing)
    {
        m_PTarget->loc.zone->m_navMesh->snapToValidPosition(m_PTarget->loc.p);
    }

    if (m_maxDistance && m_distanceMoved >= m_maxDistance)
    {
        // if I have a max distance, check to stop me
        Clear();

        m_onPoint = true;
    }
    else if (AtPoint(targetPoint))
    {
        m_currentPoint++;

        if (m_currentPoint >= (int16)m_points.size())
        {
            FinishedPath();
        }

        m_onPoint = true;
        //#event onPoint event
    }
}

void CPathFind::StepTo(const position_t& pos, bool run)
{
    TracyZoneScoped;
    float speed = GetRealSpeed();

    // TODO should this be /20 for everyone?
    float stepDistance = speed / 24.5f; // 40 ms means 4 units per second, so 1.6 units per step (server tick rate is 2.5/sec)

    int8 mode = 2;

    if (!run)
    {
        mode = 1;
        stepDistance /= 2;
    }

    float distanceTo =   distance(m_PTarget->loc.p, pos);
    float diff_y =       pos.y - m_PTarget->loc.p.y;

    // face point mob is movingB towards
    LookAt(pos);

    if (distanceTo <= m_distanceFromPoint + stepDistance)
    {
        m_distanceMoved += distanceTo - m_distanceFromPoint;

        if (m_distanceFromPoint == 0)
        {
            m_PTarget->loc.p.x = pos.x;
            m_PTarget->loc.p.y = pos.y;
            m_PTarget->loc.p.z = pos.z;
        }
        else
        {
            float radians = (1 - (float)m_PTarget->loc.p.rotation / 256) * 2 * (float)M_PI;

            m_PTarget->loc.p.x += cosf(radians) * (distanceTo - m_distanceFromPoint);
            m_PTarget->loc.p.z += sinf(radians) * (distanceTo - m_distanceFromPoint);
            if (abs(diff_y) > .5f)
            {
                // Don't step too far vertically by simply utilizing the slope
                float new_y = m_PTarget->loc.p.y + stepDistance * (pos.y - m_PTarget->loc.p.y) / distance(m_PTarget->loc.p, pos, true);
                float min_y = (pos.y + m_PTarget->loc.p.y - abs(pos.y - m_PTarget->loc.p.y)) / 2;
                float max_y = (pos.y + m_PTarget->loc.p.y + abs(pos.y - m_PTarget->loc.p.y)) / 2;
                // clamp new_y between start and end vertical position
                new_y = new_y < min_y ? min_y : new_y;
                m_PTarget->loc.p.y = new_y > max_y ? max_y : new_y;
            }
            else
            {
                m_PTarget->loc.p.y = pos.y;
            }
        }
    }
    else
    {
        m_distanceMoved += stepDistance;
        // take a step towards target point
        float radians = (1 - (float)m_PTarget->loc.p.rotation / 256) * 2 * (float)M_PI;

        m_PTarget->loc.p.x += cosf(radians) * stepDistance;
        m_PTarget->loc.p.z += sinf(radians) * stepDistance;
        if (abs(diff_y) > .5f)
        {
            // Don't step too far vertically by simply utilizing the slope
            float new_y = m_PTarget->loc.p.y + stepDistance * (pos.y - m_PTarget->loc.p.y) / distance(m_PTarget->loc.p, pos, true);
            float min_y = (pos.y + m_PTarget->loc.p.y - abs(pos.y - m_PTarget->loc.p.y)) / 2;
            float max_y = (pos.y + m_PTarget->loc.p.y + abs(pos.y - m_PTarget->loc.p.y)) / 2;
            // clamp new_y between start and end vertical position
            new_y = new_y < min_y ? min_y : new_y;
            m_PTarget->loc.p.y = new_y > max_y ? max_y : new_y;
        }
        else
        {
            m_PTarget->loc.p.y = pos.y;
        }

    }


    m_PTarget->loc.p.moving += (uint16)((0x36 * ((float)speed / 0x28)) - (0x14 * (mode - 1)));

    if (m_PTarget->loc.p.moving > 0x2fff)
    {
        m_PTarget->loc.p.moving = 0;
    }

    m_PTarget->updatemask |= UPDATE_POS;
}

bool CPathFind::FindPath(const position_t& start, const position_t& end)
{
    TracyZoneScoped;
    m_points = m_PTarget->loc.zone->m_navMesh->findPath(start, end);
    m_currentPoint = 0;

    if (m_points.size() <= 0)
    {
        ShowNavError("CPathFind::FindPath Entity (%s - %d) could not find path\n", m_PTarget->GetName(), m_PTarget->id);

        // Send mob back to their spawn point and disengage
        CMobEntity* PMob = (CMobEntity*)m_PTarget;
        if (PMob)
        {
            if (!PMob->isCharmed && !PMob->PAI->IsEngaged())
            {
                PMob->loc.p.x = PMob->m_SpawnPoint.x;
                PMob->loc.p.y = PMob->m_SpawnPoint.y;
                PMob->loc.p.z = PMob->m_SpawnPoint.z;
                PMob->loc.p.rotation = PMob->m_SpawnPoint.rotation;
            }
        }

        return false;
    }

    return true;
}

bool CPathFind::FindRandomPath(const position_t& start, float maxRadius, uint8 maxTurns, uint16 roamFlags)
{
    TracyZoneScoped;

    if (!isNavMeshEnabled())
    {
        return false;
    }

    auto m_turnLength = static_cast<uint8_t>(tpzrand::GetRandomNumber<uint32>(maxTurns) + 1);

    // Seemingly arbitrary value to pass for maxRadius, all values seem to give similar results, likely due to navmesh polygons being too dense?
    float maxRadiusForPolyQuery = maxRadius / 10.f;
    position_t startPosition = start;

    // find end points for turns, iterate potentially twice as many times to account for erroneous turnPoints
    for (int i = 0; i < m_turnLength * 2; i++)
    {
        // look for new turnPoint. findRandomPosition doesn't guarantee the new point is within the radius
        auto status = m_PTarget->loc.zone->m_navMesh->findRandomPosition(startPosition, maxRadiusForPolyQuery);

        // couldn't find one point so just break out
        if (status.first != 0)
        {
            return false;
        }

        float distSq = distanceSquared(startPosition, status.second, true);
        // only add the roam point if it's _actually_ within range of the spawn point...
        if (distSq < maxRadius * maxRadius)
        {
            m_turnPoints.emplace_back(status.second);
        }
        // else
        // {
        //     ShowDebug("CPathFind::FindRandomPath (%s - %d) random point too far: sq distance (%f)", m_POwner->GetName(), m_POwner->id, distSq);
        // }
        if (m_turnPoints.size() >= m_turnLength)
            break;
    }
    if (m_turnPoints.size() > 0)
    {
        m_points = m_PTarget->loc.zone->m_navMesh->findPath(start, m_turnPoints[0]);
        m_currentPoint = 0;
    }

    return !m_points.empty();
}



bool CPathFind::FindClosestPath(const position_t& start, const position_t& end)
{
    TracyZoneScoped;
    m_points = m_PTarget->loc.zone->m_navMesh->findPath(start, end);
    m_currentPoint = 0;
    m_points.push_back(end);  // this prevents exploits with navmesh / impassible terrain

/* this check requirement is never met as intended since m_points are never empty when mob has a path
    if (m_points.empty())
    {
        // this is a trick to make mobs go up / down impassible terrain
        m_points.push_back(end);
    }
*/

    return true;
}

void CPathFind::LookAt(const position_t& point)
{
    // Avoid unpredictable results if we're too close.
    if (!distanceWithin(m_PTarget->loc.p, point, 0.1f, true))
    {
        m_PTarget->loc.p.rotation = worldAngle(m_PTarget->loc.p, point);
        m_PTarget->updatemask |= UPDATE_POS;
    }
}

bool CPathFind::OnPoint()
{
    return m_onPoint;
}

float CPathFind::GetRealSpeed()
{
    uint8 baseSpeed = m_PTarget->speed;

    // Lets not factor in player map conf or mod's to non players. 
    // (Mobs should just have speed set directly instead, and NPC's don't have mods)
   // if (m_PTarget->objtype == TYPE_PC)
    // Twilight: Let's revert that so we don't break the gravity spell when cast on mobs
    if (m_PTarget->objtype != TYPE_NPC)

    {
        baseSpeed = ((CBattleEntity*)m_PTarget)->GetSpeed();
    }

    // Lets not check mob things on non mobs
    if (m_PTarget->objtype == TYPE_MOB)
    {
        if (baseSpeed == 0 && (m_roamFlags & ROAMFLAG_WORM))
        {
            baseSpeed = 20;
        }
        // using 'else if' so we don't mess with worm speed.
        else if (m_PTarget->animation == ANIMATION_ATTACK)
        {
            baseSpeed = baseSpeed + map_config.mob_speed_mod;
        }
    }

    return baseSpeed;
}

bool CPathFind::IsFollowingPath()
{
    return !m_points.empty();
}

bool CPathFind::IsFollowingScriptedPath()
{
    return IsFollowingPath() && m_pathFlags & PATHFLAG_SCRIPT;
}

bool CPathFind::AtPoint(const position_t& pos)
{
    if (m_distanceFromPoint == 0)
        return distanceWithin(m_PTarget->loc.p, pos, 0.1f);
    else
        return distanceWithin(m_PTarget->loc.p, pos, m_distanceFromPoint + 0.2f);
}

bool CPathFind::InWater()
{
    if (m_PTarget->loc.zone->GetWeather() == WEATHER_SQUALL)
    {
        return true;
    }
    if (isNavMeshEnabled())
    {
        return m_PTarget->loc.zone->m_navMesh->inWater(m_PTarget->loc.p);
    }

    return false;
}

const position_t& CPathFind::GetDestination() const
{
    return m_points.back();
}

void CPathFind::SetCarefulPathing(bool careful)
{
    m_carefulPathing = careful;
}

void CPathFind::Clear()
{
    m_distanceFromPoint = 0;
    m_pathFlags = 0;
    m_roamFlags = 0;
    m_points.clear();

    m_currentPoint = 0;
    m_maxDistance = 0;
    m_distanceMoved = 0;

    m_onPoint = true;

    m_currentTurn = 0;
    m_turnPoints.clear();
}

void CPathFind::AddPoints(std::vector<position_t>&& points, bool reverse)
{
    if (points.size() > MAX_PATH_POINTS)
    {
        ShowWarning("CPathFind::AddPoints Given too many points (%d). Limiting to max (%d)\n", points.size(), MAX_PATH_POINTS);
        points.resize(MAX_PATH_POINTS);
    }

    m_points = std::move(points);

    if (reverse)
        std::reverse(m_points.begin(), m_points.end());
}

void CPathFind::FinishedPath()
{
    m_currentTurn++;

    // turning is only available to navmeshed maps
    if (m_currentTurn < m_turnPoints.size() && isNavMeshEnabled())
    {
        // move on to next turn
        position_t& nextTurn = m_turnPoints[m_currentTurn];

        bool result = FindPath(m_PTarget->loc.p, nextTurn);

        if (!result)
        {
            Clear();
        }
    }
    else
    {
        Clear();
    }
}
