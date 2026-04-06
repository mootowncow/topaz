-----------------------------------
-- Area: Dynamis - San d'Oria
--  Mob: Overlord's Tombstone
-- Note: Mega Boss
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
    mob:setMod(tpz.mod.REFRESH, 300)
    mob:delImmunity(tpz.immunity.STUN)
    mob:delImmunity(tpz.immunity.PARALYZE)
    mob:delImmunity(tpz.immunity.BLIND)
    mob:delImmunity(tpz.immunity.POISON)

    local pet = GetMobByID(mob:getID()+1)
    local pet2 = GetMobByID(mob:getID()+2)
    pet:spawn() 
    pet2:spawn()
    ApplyConfrontationPet(mob, pet)
    ApplyConfrontationPet(mob, pet2)
end

function onMobEngaged(mob, target)
    local pet = GetMobByID(mob:getID()+1)
    local pet2 = GetMobByID(mob:getID()+2)
    ApplyConfrontationPet(mob, pet)
    ApplyConfrontationPet(mob, pet2)
    pet:updateEnmity(target)
    pet2:updateEnmity(target)
end

function onMobFight(mob, target)
end

function onMobDespawn(mob)
    OnBattleEndConfrontation(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    dynamis.megaBossOnDeath(mob, player, isKiller)
    OnBattleEndConfrontation(mob)
end
