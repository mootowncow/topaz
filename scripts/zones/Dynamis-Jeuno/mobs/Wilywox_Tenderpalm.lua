-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Wilywox Tenderpalm
-----------------------------------
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
local ID = require("scripts/zones/Dynamis-Jeuno/IDs")
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
     mob:addMod(tpz.mod.DEFP, 30) 
     mob:addMod(tpz.mod.ATTP, 20)
     mob:addMod(tpz.mod.ACC, 50) 
     mob:addMod(tpz.mod.EVA, 30)
     mob:setMod(tpz.mod.REFRESH, 300)
     OnBattleStartConfrontation(mob)
end

function onMobFight(mob, target)
    tpz.mix.jobSpecial.config(mob, {
        between = 360,
        specials =
        {
            {id = tpz.jsa.PERFECT_DODGE, cooldown = 0, hpp = 50},
            {id = tpz.jsa.BENEDICTION, cooldown = 0, hpp = 25},
        },
    })
end

function onMobDespawn(mob)
    OnBattleEndConfrontation(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    OnBattleEndConfrontation(mob)
end
