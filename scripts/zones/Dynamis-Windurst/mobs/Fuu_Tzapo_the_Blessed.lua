-----------------------------------
-- Area: Dynamis - Windurst
--  Mob: Fuu Tzapo the Blessed
-----------------------------------
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special"),
    require("scripts/mixins/remove_doom")
}
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
        between = 300,
        specials =
        {
            {id = tpz.jsa.MIGHTY_STRIKES, cooldown = 0, hpp = 90},
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
