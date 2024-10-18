-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Novv the Whitehearted
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onMobSpawn(mob)
    mob:addMod(tpz.mod.DEFP, 25) 
    mob:addMod(tpz.mod.EVA, 20)
    mob:setMod(tpz.mod.UFASTCAST, 50)
    mob:setMod(tpz.mod.REFRESH, 400)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
end

function onMobFight(mob, target)
    local battletime = mob:getBattleTime()
    local twohourTime = mob:getLocalVar("twohourTime")
    local wingsTime = mob:getLocalVar("wingsTime")
    local wingsDown = mob:getLocalVar("wingsDown")

    if twohourTime == 0 then
        printf("Setting two hour time");
        mob:setLocalVar("twohourTime", math.random(60, 120))
    elseif battletime >= twohourTime and wingsDown == 0 then
        printf("Wings Up");
        mob:useMobAbility(696) -- Soul Voice
        mob:useMobAbility(780) -- Spinning Fin(10s Terror)
        mob:castSpell(417, mob) -- Honor March
        mob:setLocalVar("wingsTime", battletime + 10)
        mob:setLocalVar("wingsDown", 1)
    end

    if battletime >= wingsTime and wingsDown == 1 then
        printf("Wings Down");
        mob:setLocalVar("twohourTime", battletime + math.random(50, 110))
        mob:setLocalVar("wingsTime", 0)
        mob:setLocalVar("wingsDown", 0)
    end

    if (mob:hasStatusEffect(tpz.effect.MARCH) == true) then
        mob:setMod(tpz.mod.ATTP, 200)
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 25)
    else
        mob:setMod(tpz.mod.ATTP, 0)
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 0)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end
