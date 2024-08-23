-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--   ANNM
--   NM: Amaranth
--  !addkeyitem GREEN_LABELED_CRATE
-----------------------------------
require("scripts/globals/annm")
require("scripts/globals/status")
-----------------------------------
function onMobSpawn(mob)
    mob:setLocalVar("CharmTime", 45)
    tpz.annm.NMMods(mob) 
end

function onMobFight(mob, target)

    if  tpz.annm.PetShield(mob, 17170651, 17170656) then
        return
    end

    local bee = GetMobByID(17171292)
	local beeTimer = mob:getLocalVar("beeTimer")
	local battleTime = mob:getBattleTime()

    -- Spawns a bee that slowly walks towards it. If the bee is eaten, will level up and fully heal
    if (beeTimer == 0) then
        mob:setLocalVar("beeTimer", battleTime + 15)
    elseif (battleTime >= beeTimer) then
        bee:setSpawn(mob:getXPos() + 15, mob:getYPos(), mob:getZPos() + math.random(3, 5))
        utils.spawnPetInBattle(mob, bee)
        mob:setLocalVar("beeTimer", battleTime + 45)
    end

    if bee:isAlive() and (mob:checkDistance(bee) <= 5) then
        mob:useMobAbility(tpz.mob.skills.BLOODY_CARESS, bee) -- TODO: Doesn't properly target bee CBattleEntity::ValidTarget()
        bee:setHP(0) -- TODO: Remove this after fixing the above
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.annm.SpawnChest(mob, player, isKiller)
end

function onMobDespawn(mob)
end
