-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Lord of Onzozo
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/regimes")
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
end

function onMobInitialize(mob)
    mob:addMod(tpz.mod.UFASTCAST, 50)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
end

function onMonsterMagicPrepare(mob, target)
    local rnd = math.random()

    if rnd < 0.4 then
        return 201 -- Waterga III
    elseif rnd < 0.7 then
        return 214 -- Flood
    elseif rnd < 0.9 then
        return 361 -- Blindga
    else
        return 172 -- Water IV
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.regime.checkRegime(player, mob, 774, 1, tpz.regime.type.GROUNDS)
end
