-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Morgmox Moldnoggin
-----------------------------------
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
-----------------------------------
function onMobEngaged(mob, target)
    local pet = GetMobByID(mob:getID()+1)
    if not pet:isSpawned() then
		utils.spawnPetInBattle(mob, pet, true, false, true)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end
