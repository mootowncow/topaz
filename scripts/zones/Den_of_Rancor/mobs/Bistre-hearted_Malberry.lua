-----------------------------------
-- Area: Den of Rancor
--   NM: Bistre-hearted Malberry
-----------------------------------
require("scripts/globals/hunts")
mixins =
{
    require("scripts/mixins/families/tonberry"),
}
-----------------------------------
function onMobSpawn(mob)
    mob:addMod(tpz.mod.MATT, 20)
    mob:addMod(tpz.mod.DEFP, 25)
    mob:setMod(tpz.mod.UFASTCAST, 50)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
    mob:setMod(tpz.mod.REFRESH, 400)
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
end

function onMobFight(mob, target)
    local battletime = mob:getBattleTime()
    local twohourTime = mob:getLocalVar("twohourTime")
    local wingsTime = mob:getLocalVar("wingsTime")
    local wingsDown = mob:getLocalVar("wingsDown")

    if twohourTime == 0 then
        printf("Setting two hour time");
        mob:setLocalVar("twohourTime", math.random(20, 30))
    elseif battletime >= twohourTime and wingsDown == 0 then
        printf("Wings Up");
        mob:useMobAbility(2525) -- Chilling Roar(10s AOE Terror)
        mob:castSpell(218) -- Meteor
        mob:setLocalVar("wingsTime", battletime + 10)
        mob:setLocalVar("wingsDown", 1)
    end

    if battletime >= wingsTime and wingsDown == 1 then
        printf("Wings Down");
        mob:SetMagicCastingEnabled(false)
        mob:setLocalVar("twohourTime", battletime + math.random(20, 30))
        mob:setLocalVar("wingsTime", 0)
        mob:setLocalVar("wingsDown", 0)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 397)
end
