-----------------------------------
-- Area: Monarch Linn
--  Mob: Razon
-- Fire in the Sky
-- !addkeyitem monarch_Beard
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/mobs")
-----------------------------------
local ThreeClusters = 571
local TwoClusters = 573
local OneCluster = 572

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.HTHRES, 250)
    mob:setMod(tpz.mod.SLASHRES, 250)
    mob:setMod(tpz.mod.PIERCERES, 250)
    mob:setMod(tpz.mod.RANGEDRES, 1000)
    mob:setMod(tpz.mod.IMPACTRES, 250)
    mob:setMod(tpz.mod.UDMGMAGIC, 100)
    for sdt = tpz.mod.SDT_FIRE, tpz.mod.SDT_DARK do
        mob:setMod(sdt, 150)
    end
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:AnimationSub(0)
    mob:setLocalVar("ElementSwapTime", 120)
end

function onMobEngaged(mob, target)
    mob:AnimationSub(0)
end


function onMobInitialize(mob)
end

function onMobFight(mob, target)
    local SelfDestructCounter = mob:getLocalVar("SelfDestructCounter")
    local ElementSwapTime = mob:getLocalVar("ElementSwapTime")
    local BattleTime = mob:getBattleTime()
    -- Self-Destructs at 2 minutes,4 minutes, then 5 minutes., if below the health threshold, it will deal 0 damage.
    -- Final threshold is him being alive
    if BattleTime >= 120 and SelfDestructCounter == 0 then
        --printf("Boom 1");
        mob:useMobAbility(ThreeClusters) -- 650 damage
        mob:setLocalVar("SelfDestructCounter", 1)
    end
    if BattleTime >= 240 and SelfDestructCounter == 1  then
        --printf("Boom 2");
        mob:useMobAbility(TwoClusters) -- 750 damage
        mob:setLocalVar("SelfDestructCounter", 2)
    end
    if BattleTime >= 300 and SelfDestructCounter == 2 then
        --printf("Boom 3 - Fail");
        mob:useMobAbility(OneCluster) -- 1500 damage
        mob:setLocalVar("SelfDestructCounter", 3)
    end

    -- Change Self-Destruct trigger element every 2 minutes
    if BattleTime >= ElementSwapTime then
         mob:setLocalVar("RNGelement", math.random(1,8))
         --printf("Changing element")
         mob:setLocalVar("ElementSwapTime", BattleTime + 120)
    end
end

function onMagicHit(caster, target, spell)
    local DAY = target:getLocalVar("RNGelement")
    local ELEM = target:getLocalVar("RNGelement")
    local TP = target:getTP() -- maybe skill: gettp()?
    local SelfDestructCounter = target:getLocalVar("SelfDestructCounter")
    local WeknessTriggered = target:getLocalVar("WeknessTriggered")

    if ELEM == 0 then
         target:setLocalVar("RNGelement", math.random(1,8))
         ELEM = target:getLocalVar("RNGelement")
    end
    -- First nuke reveals the element that will make him explode. Additional nukes of that element cause him to Self-Sestruct
    -- This shares a counter with timer based Self-Destruct in onMobFight
    if ((ELEM == spell:getElement()) and (caster:isPC() or caster:isPet())) and WeknessTriggered == 0 then
        --printf("2 Hour Cloud");
        target:weaknessTrigger(1) -- Yellow !!!
        target:setLocalVar("WeknessTriggered", 1)
    end
    if WeknessTriggered == 1 then
        if ((ELEM == spell:getElement()) and (caster:isPC() or caster:isPet())) and SelfDestructCounter == 0 then
            --printf("Cast Boom 1");
            target:weaknessTrigger(1) -- Yellow !!!
            target:useMobAbility(ThreeClusters)  -- 650 damage
            target:setLocalVar("SelfDestructCounter", 1)
        elseif ((ELEM == spell:getElement()) and (caster:isPC() or caster:isPet())) and SelfDestructCounter == 1 then
            --printf("Cast Boom 2");
            target:weaknessTrigger(1) -- Yellow !!!
            target:useMobAbility(TwoClusters)  -- 750 damage
            target:setLocalVar("SelfDestructCounter", 2)
        elseif ((ELEM == spell:getElement()) and (caster:isPC() or caster:isPet())) and SelfDestructCounter == 2 then
            --printf("Cast Boom 3");
            target:weaknessTrigger(1) -- Yellow !!!
            target:useMobAbility(OneCluster)  -- 1500 damage
        end
    end
    return 1
end

function onMobDeath(mob, player, isKiller, noKiller)
end