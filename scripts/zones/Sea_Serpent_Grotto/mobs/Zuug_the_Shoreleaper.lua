-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Pahh the Gullcaller
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
function onMobSpawn(mob)
    mob:addMod(tpz.mod.ATTP, 50)
    mob:addMod(tpz.mod.DEFP, 35)
    mob:addMod(tpz.mod.ACC, 50) 
    mob:addMod(tpz.mod.EVA, 20)
    mob:setMobMod(tpz.mobMod.SKILL_LIST, 6011)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
end

function onMobFight(mob, target)
    local battletime = mob:getBattleTime()
    local twohourTime = mob:getLocalVar("twohourTime")
    local wingsTime = mob:getLocalVar("wingsTime")
    local wingsDown = mob:getLocalVar("wingsDown")

    if twohourTime == 0 then
        printf("Setting two hour time");
        mob:setLocalVar("twohourTime", math.random(30, 45))
    elseif battletime >= twohourTime and wingsDown == 0 then
        printf("Wings Up");
        mob:useMobAbility(1893) -- Spirit Surge
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 6012)
        mob:addStatusEffect(tpz.effect.REGAIN, 3000, 3, 13)
        mob:addMod(tpz.mod.ATTP, 50)
        mob:addMod(tpz.mod.DEFP, 50)
        mob:addMod(tpz.mod.ACC, 100) 
        mob:setLocalVar("wingsTime", battletime + 13)
        mob:setLocalVar("wingsDown", 1)
    end

    if battletime >= wingsTime and wingsDown == 1 then
        printf("Wings Down");
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 6011)
        mob:delMod(tpz.mod.ATTP, 50)
        mob:delMod(tpz.mod.DEFP, 50)
        mob:delMod(tpz.mod.ACC, 100) 
        mob:setLocalVar("twohourTime", battletime + math.random(30, 45))
        mob:setLocalVar("wingsTime", 0)
        mob:setLocalVar("wingsDown", 0)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 382)
end
