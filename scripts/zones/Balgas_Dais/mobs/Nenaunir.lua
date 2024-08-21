-----------------------------------
-- Area: Balga's Dais
--  Mob: Nenaunir
-- BCNM: Harem Scarem
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 20)
    mob:setMobMod(tpz.mobMod.CHARMABLE, 0)
end

function onMobEngaged(mob, target)
    mob:useMobAbility(tpz.mob.skills.WHISTLE)
end

function onMobFight(mob, target)
end

function onMobWeaponSkillPrepare(mob, target)
    local wivesDead = true

    for i = 1, 5 do
        local wife = GetMobByID(mob:getID() + i)
        if wife:isAlive() then
            wivesDead = false
            break
        end
    end

    if wivesDead then
        return tpz.mob.skills.HEALING_BREEZE
    end
end


function onMobDeath(mob, player, isKiller, noKiller)
end
