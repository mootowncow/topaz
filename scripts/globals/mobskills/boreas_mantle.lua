---------------------------------------------
-- Boreas Mantle
--
-- Description: Spawns 4 clones of itself that disappear after 30 seconds
-- Used only by Phantom Puk
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    mobid = mob:getID()
    player = mob:getTarget()
    local clonehp = 500
    local hpp = mob:getHPP() / 100.0
    local maxhp = clonehp / hpp
    local despawnTimer = math.random(15, 20)
    -- Clones despawn after 15-20s
    for cloneid = mobid + 1, mobid + 4 do
        clone = SpawnMob(cloneid)
        clone:setLocalVar("boreasDespawnTimer", despawnTimer)
        clone:setHP(clonehp)
        clone:updateEnmity(player)
        clone:setPos(mob:getXPos(), mob:getYPos(), mob:getZPos())
        clone:addStatusEffect(tpz.effect.BLINK, 3, 0, 300)
    end

    mob:timer(30000, function(mob)
        mobid = mob:getID()
        for cloneid = mobid + 1, mobid + 4 do
            if GetMobAction(cloneid) ~= 0 then
                DespawnMob(cloneid)
            end
        end
    end)

    skill:setMsg(tpz.msg.basic.NONE)
    return 0
end
