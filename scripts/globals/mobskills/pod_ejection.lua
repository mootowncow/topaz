---------------------------------------------
-- Pod Ejection
---------------------------------------------
require("scripts/globals/mobs")
---------------------------------------------

function onMobSkillCheck(target,mob,skill)
    local pod = GetMobByID(mob:getID() + 1)
    local currentForm = mob:getLocalVar("form")
    if not pod:isSpawned() and mob:AnimationSub() == 2 then -- On 2 legs
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local battlefield = mob:getBattlefield()
    local pod = GetMobByID(mob:getID() +1)
    if not pod:isSpawned() then
        if battlefield then
            local players = battlefield:getPlayers()
            local random = math.random(1, #players)
            pod:setSpawn(mob:getXPos() + math.random(1, 3), mob:getYPos(), mob:getZPos() + math.random(1, 3))
            pod:spawn()
            pod:updateEnmity(players[random])
        else
            local NearbyEntities = mob:getNearbyEntities(10)
            if NearbyEntities and #NearbyEntities > 0 then
                local randomTarget = NearbyEntities[math.random(1, #NearbyEntities)]
                if randomTarget:isAlive() then
                    pod:setSpawn(mob:getXPos() + math.random(1, 3), mob:getYPos(), mob:getZPos() + math.random(1, 3))
                    pod:spawn()
                    ApplyConfrontation(mob, pod)
                    if (randomTarget:getAllegiance() ~= mob:getAllegiance()) then
                        pod:updateEnmity(randomTarget)
                    end
                end
            end
        end
    end

    skill:setMsg(tpz.msg.basic.NONE)
    return 0
end