------------------------------
-- Area: Outer Horutoto Ruins
--   Goblin Tomb Raider
--   !additem 479
-- Mythic weapon fight
------------------------------
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
    local BombTime = mob:getLocalVar("BombTime")
    local Guard = GetMobByID(17572321)
    local GuardTwo = GetMobByID(17572322)
    local GuardThree = GetMobByID(17572323)
    local GuardFour = GetMobByID(17572324)
    local GuardFive = GetMobByID(17572325)
    local GuardSix = GetMobByID(17572326)
    local GuardSeven = GetMobByID(17572327)
    local GuardEight = GetMobByID(17572328)

    if BombTime == 0 then
        --printf("Setting bombs spawn time");
        mob:setLocalVar("BombTime", math.random(60, 90))
    elseif battletime >= BombTime then
        --printf("Spawning Bombs");
        mob:useMobAbility(624) -- 2 hour "cloud" animation
        mob:setTP(0)
        local zonePlayers = mob:getZone():getPlayers()
        for _, zonePlayer in pairs(zonePlayers) do
            zonePlayer:PrintToPlayer("You want what's in my bag? Fine, take it!",0,"Goblin")
        end
        Guard:spawn()
        GuardTwo:spawn()
        GuardThree:spawn()
        GuardFour:spawn()
        GuardFive:spawn()
        GuardSix:spawn()
        GuardSeven:spawn()
        GuardEight:spawn()
        Guard:updateEnmity(target)
        GuardTwo:updateEnmity(target)
        GuardThree:updateEnmity(target)
        GuardFour:updateEnmity(target)
        GuardFive:updateEnmity(target)
        GuardSix:updateEnmity(target)
        GuardSeven:updateEnmity(target)
        GuardEight:updateEnmity(target)
        mob:setLocalVar("BombTime", battletime + math.random(180, 300))
    end
end

function onMobWeaponSkill(target, mob, skill)
    if (skill:getID() == 590) or (skill:getID() == 27) then
        local BombTossCounter = mob:getLocalVar("BombTossCounter")
        local BombTossMax = mob:getLocalVar("BombTossMax")

        if BombTossCounter == 0 and BombTossMax == 0 then
            BombTossMax = math.random(5, 10)
            mob:setLocalVar("BombTossMax", BombTossMax)
        end

        BombTossCounter = BombTossCounter + 1
        mob:setLocalVar("BombTossCounter", BombTossCounter)

        if BombTossCounter > BombTossMax then
            mob:setLocalVar("BombTossCounter", 0)
            mob:setLocalVar("BombTossMax", 0)
        else
            mob:useMobAbility(591)
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    local zonePlayers = mob:getZone():getPlayers()
    for _, zonePlayer in pairs(zonePlayers) do
        player:PrintToPlayer("I..guess..you...deserve...it...m...m..more...",0,"Goblin")
        break
    end
    DespawnMob(Guard)
    DespawnMob(GuardTwo)
    DespawnMob(GuardThree)
    DespawnMob(GuardFour)
    DespawnMob(GuardFive)
    DespawnMob(GuardSix)
    DespawnMob(GuardSeven)
    DespawnMob(GuardEight)
end
