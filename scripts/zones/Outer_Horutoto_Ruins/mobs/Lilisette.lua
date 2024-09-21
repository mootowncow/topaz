------------------------------
-- Area: Outer Horutoto Ruins
--   Lilisette
--   !additem 476 
--   !pos -571 0.4000 740.0266
-- Mythic weapon fight
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/titles")
require("scripts/globals/mobs")
require("scripts/globals/status")
------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobSpawn(mob)
    SetGenericNMStats(mob)
	mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
end

function onMobFight(mob, target)
    local battletime = mob:getBattleTime()
    local Dance = mob:getLocalVar("Dance")
    local DanceChangeTime = mob:getLocalVar("DanceChangeTime")

    if Dance == 0 then
        mob:setLocalVar("DanceChangeTime", 3)
        mob:setLocalVar("Dance", 1)
    elseif battletime >= DanceChangeTime and Dance == 1 then
        MessageGroup(mob, target, "Now I'm really hyped!",0,"Lilisette")
        mob:useMobAbility(3308) -- Thorned Dance
		mob:useMobAbility(25) -- evisceration
		mob:useMobAbility(2313) -- Reverse Flourish
		mob:useMobAbility(29)  -- pyrrhic_kleos
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 6038)
        mob:setLocalVar("DanceChangeTime", battletime + 60)
        mob:setLocalVar("Dance", 2)
    end

    if battletime >= DanceChangeTime and Dance == 2 then
        MessageGroup(mob, target, "The funs just getting started!",0,"Lilisette")
        mob:useMobAbility(3309) -- Sensual Dance
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 6039)
        mob:setLocalVar("DanceChangeTime", battletime + 60)
        mob:setLocalVar("Dance", 1)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    OnDeathMessage(mob, player, isKiller, noKiller, "Let's dance again some other time!",0,"Lilisette")
end


