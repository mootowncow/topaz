------------------------------
-- Area: Den of Rancor
--   NM: Ogama
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
------------------------------
function onMobSpawn(mob)
    mob:addMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.DEFP, 35)
    mob:addMod(tpz.mod.ACC, 25) 
    mob:addMod(tpz.mod.EVA, 25)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobFight(mob, target)
    local battletime = mob:getBattleTime()
    local twohourTime = mob:getLocalVar("twohourTime")
    local wingsTime = mob:getLocalVar("wingsTime")
    local wingsDown = mob:getLocalVar("wingsDown")
    local hitTrigger = mob:getLocalVar("TriggerHit")

    if twohourTime == 0 then
        printf("Setting two hour time");
        mob:setLocalVar("twohourTime", math.random(57, 87))
    elseif battletime >= twohourTime and wingsDown == 0 then
        printf("Wings Up");
        mob:useMobAbility(1338) -- Infernal Pestilence 
        mob:setLocalVar("wingsTime", battletime + 3)
        mob:setLocalVar("wingsDown", 1)
    end

    if battletime >= wingsTime and wingsDown == 1 then
        printf("Wings Down");
        mob:setLocalVar("twohourTime", battletime + math.random(57, 87))
        mob:setLocalVar("wingsTime", 0)
        mob:setLocalVar("wingsDown", 0)
    end

    if mob:getHPP() <= 75 and hitTrigger == 0 then
        mob:addMod(tpz.mod.ACC, 50)
        mob:setMod(tpz.mod.ATTP, 50)
        mob:setLocalVar("TriggerHit", 1)
    end
    if mob:getHPP() <= 50 and hitTrigger == 1 then
        mob:addMod(tpz.mod.ACC, 50)
        mob:setMod(tpz.mod.ATTP, 100)
        mob:setLocalVar("TriggerHit", 2)
    end
    if mob:getHPP() <= 25 and hitTrigger == 2 then
        mob:addMod(tpz.mod.ACC, 50)
        mob:setMod(tpz.mod.ATTP, 150)
        mob:setLocalVar("TriggerHit", 3)
    end
    if mob:getHPP() <= 10 and hitTrigger == 3 then
        mob:addMod(tpz.mod.ACC, 50)
        mob:setMod(tpz.mod.ATTP, 200)
        mob:setLocalVar("TriggerHit", 4)
    end
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 486 or 488 or 490 or 492   then
        mob:addHP(mob:getMaxHP() * .05)    
    end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.HP_DRAIN, {chance = 100, power = math.random(200, 250)})
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 398)
end
