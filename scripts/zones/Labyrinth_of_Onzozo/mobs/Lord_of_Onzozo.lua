-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Lord of Onzozo
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/regimes")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:addMod(tpz.mod.DEFP, 25) 
    mob:addMod(tpz.mod.ATTP, 50)
    mob:setMod(tpz.mod.ACC, 100) 
    mob:addMod(tpz.mod.EVA, 50)
    mob:setMod(tpz.mod.MACC, 100) 
    mob:setMobMod(tpz.mobMod.GIL_MIN, 20000)
end

function onMobInitialize(mob)
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

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 774, 1, tpz.regime.type.GROUNDS)
end
