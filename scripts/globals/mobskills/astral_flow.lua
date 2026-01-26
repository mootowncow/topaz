---------------------------------------------
-- Astral Flow
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

local avatarOffsets =
{
    [17444883] = 3, -- Vermilion-eared Noberry
    [17453078] = 3, -- Duke Dantalian
    [17453085] = 3, -- Duke Dantalian
    [17453092] = 3, -- Duke Dantalian
    [17506670] = 5, -- Kirin
}

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    skill:setMsg(tpz.msg.basic.USES)
    local mobID = mob:getID()
    local avatarId = 0

    if avatarOffsets[mobID] then
        avatarId = mobID + avatarOffsets[mobID]
    else
        avatarId = mobID + 2 -- default offset
    end

    local avatar = GetMobByID(avatarId)

    if mob:getPool() ~= 6770 then
        if not avatar:isSpawned() then
            avatar:setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos() + 1)
            avatar:spawn()
            avatar:updateEnmity(mob:getTarget())
        end
    end

    mob:addStatusEffect(tpz.effect.ASTRAL_FLOW, 1, 0, 180)

    return tpz.effect.ASTRAL_FLOW
end
