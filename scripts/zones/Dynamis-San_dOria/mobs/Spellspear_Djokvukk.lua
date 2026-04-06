-----------------------------------
-- Area: Dynamis - San d'Oria
--  Mob: Spellspear Djokvukk
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

function onMobEngaged(mob, target)
end

function onMobFight(mob, target)
    tpz.mix.jobSpecial.config(mob, {
        between = 120,
        specials =
        {
            {id = tpz.jsa.CHAINSPELL, cooldown = 0, hpp = 90},
            {id = tpz.jsa.CALL_WYVERN, cooldown = 0, hpp = 90},
        },
    })
    
    local pet = GetMobByID(mob:getID()+1)
    if pet:isSpawned() then
        ApplyConfrontationPet(mob, pet)
        pet:updateEnmity(target)
    end
end

function onMobDespawn(mob)
    OnBattleEndConfrontation(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    OnBattleEndConfrontation(mob)
end
