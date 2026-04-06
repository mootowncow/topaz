-----------------------------------
-- Area: Dynamis - San d'Oria
--  Mob: Spellspear Djokvukk
-----------------------------------
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
    local Pet = GetMobByID(mob:getID()+1)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 30)
    SetGenericNMStats(mob)
    mob:setMobMod(tpz.mod.MP_BASE, 10000)
    Pet:spawn()
    ApplyConfrontation(mob, Pet)
    Pet:updateEnmity(target)
     
end

function onMobFight(mob, target)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.CHAINSPELL, cooldown = 180, hpp = 90},
        },
    })
end

function onMobDespawn(mob)
    OnBattleEndConfrontation(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    OnBattleEndConfrontation(mob)
end
