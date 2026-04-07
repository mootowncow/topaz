-----------------------------------
-- Area: Dynamis - San d'Oria
--  Mob: Bloodfist Voshgrosh
-----------------------------------
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
require("scripts/globals/dynamis")
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
    dynamis.setUpOdiousNM(mob)
end

function onMobFight(mob, target)
    tpz.mix.jobSpecial.config(mob, {
        between = 60,
        specials =
        {
            {id = tpz.jsa.HUNDRED_FISTS, cooldown = 0, hpp = 90},
            {id = tpz.jsa.BLOOD_WEAPON, cooldown = 0, hpp = 90},
        },
    })

    if mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS) then
        mob:setMod(tpz.mod.COUNTER, 75)
    else
        mob:setMod(tpz.mod.COUNTER, 20)
    end

    if mob:hasStatusEffect(tpz.effect.BLOOD_WEAPON) then
        mob:setMod(tpz.mod.CRITHITRATE, 100)
    else
        mob:setMod(tpz.mod.COUNTER, 5)
    end
end

function onMobDespawn(mob)
    OnBattleEndConfrontation(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    OnBattleEndConfrontation(mob)
end
