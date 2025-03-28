------------------------------
-- Area: Crawlers Nest [S]
--   NM: Honey Wespe
--   Involved in: Witchweed
------------------------------
require("scripts/globals/wotg")
-----------------------------------
function onMobSpawn(mob)
    tpz.wotg.onMobSpawn(mob)
end

function onMobRoam(mob, target)
    tpz.wotg.onMobRoam(mob)
end

function onMobFight(mob, target)
    tpz.wotg.onMobFight(mob)
end
 
function onMobDeath(mob, player, isKiller, noKiller)
    local witchweed = GetMobByID(17478240)
    local level = witchweed:getMainLvl()

    -- Level up Witchweed on death
    witchweed:setLocalVar("beeTimer", os.time() + 45)
    witchweed:useMobAbility(tpz.mob.skills.LEVEL_UP, witchweed)
    witchweed:setMobLevel(level +1)

    -- Mods and Mobmods are cleared on leveling up, need to readd them
    tpz.wotg.onMobSpawn(witchweed)
    witchweed:setMobMod(tpz.mobMod.SKILL_LIST, 1208)
end

function onMobDespawn(mob)
end
