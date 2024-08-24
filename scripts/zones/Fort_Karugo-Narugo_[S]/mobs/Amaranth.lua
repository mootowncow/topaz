-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--   ANNM
--   NM: Amaranth
--  !addkeyitem GREEN_LABELED_CRATE
-----------------------------------
require("scripts/globals/annm")
-----------------------------------

function onMobSpawn(mob)
    mob:setLocalVar("CharmTime", 45)
    tpz.annm.NMMods(mob)
    mob:setMobMod(tpz.mobMod.FRIENDLY_FIRE, 1)
end

function onMobFight(mob, target)
    if tpz.annm.PetShield(mob, 17170651, 17170656) then
        return
    end
    local bee = GetMobByID(17171292)
	local beeTimer = mob:getLocalVar("beeTimer")

    -- Spawns a bee that slowly walks towards it. If the bee is eaten, will level up and fully heal
    if not bee:isSpawned() then
        if (beeTimer == 0) then
            mob:setLocalVar("beeTimer", os.time() + 15)
        elseif (os.time() >= beeTimer) then
            bee:setSpawn(mob:getXPos() + 30, mob:getYPos(), mob:getZPos() + math.random(3, 5))
            utils.spawnPetInBattle(mob, bee)
            mob:setLocalVar("beeTimer", os.time() + 60)
        end
    end

    if bee:isAlive() and (mob:checkDistance(bee) <= 5) then
        mob:useMobAbility(tpz.mob.skills.BLOODY_CARESS, bee)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    DespawnMob(17171292)
    tpz.annm.SpawnChest(mob, player, isKiller)
end

function onMobDespawn(mob)
    DespawnMob(17171292)
end
