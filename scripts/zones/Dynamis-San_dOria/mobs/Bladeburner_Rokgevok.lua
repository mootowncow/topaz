-----------------------------------
-- Area: Dynamis - San d'Oria
--  Mob: Bladeburner Rokgevok
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
        between = 90,
        specials =
        {
            {id = tpz.jsa.MANAFONT, cooldown = 0, hpp = 90},
            {id = tpz.jsa.MIGHTY_STRIKES, cooldown = 0, hpp = 90},
        },
    })

    if mob:hasStatusEffect(tpz.effect.MIGHTY_STRIKES) then
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 100)
    else
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 25)
    end
end

function onMobDespawn(mob)
    OnBattleEndConfrontation(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    OnBattleEndConfrontation(mob)
end
