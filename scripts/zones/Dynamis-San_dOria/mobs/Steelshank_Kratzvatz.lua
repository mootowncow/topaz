-----------------------------------
-- Area: Dynamis - San d'Oria
--  Mob: Steelshank Kratzvatz
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
    local pet = GetMobByID(mob:getID()+1)
    pet:spawn()
    dynamis.setUpOdiousNM(mob)
end

function onMobEngaged(mob, target)
    local pet = GetMobByID(mob:getID()+1)
    ApplyConfrontationPet(mob, pet)
    pet:updateEnmity(target)
end

function onMobFight(mob, target)
    local pet = mob:getID()+1
    if GetMobByID(pet):isDead() then
        tpz.mix.jobSpecial.config(mob, {
            between = 60,
            specials =
            {
                {id = tpz.jsa.INVINCIBLE, cooldown = 0, hpp = 90},
                {id = tpz.jsa.CHARM, cooldown = 0, hpp = 90},
            },
        })
    else
        tpz.mix.jobSpecial.config(mob, {
            between = 60,
            specials =
            {
                {id = tpz.jsa.INVINCIBLE, cooldown = 0, hpp = 90},
                {id = tpz.jsa.FAMILIAR, cooldown = 0, hpp = 90},
            },
        })
    end
end

function onMobDespawn(mob)
    OnBattleEndConfrontation(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    OnBattleEndConfrontation(mob)
end
