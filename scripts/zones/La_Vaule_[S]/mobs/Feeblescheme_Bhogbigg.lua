-----------------------------------
-- Area: La Vaule [S]
--   NM: Feeblescheme Bhogbigg
-- Immune to Silence, Sleep, Bind, Gravity, Paralyze
-- Summon animation to summon "grenade / vials".
-- Grenade is summoned every 5-60s
-- Grenades run towards a random target and uses one of their TP moves then depop after.
-- Vials stay alive spamming Noxious Spray (Poison for 30/tick). Can only have 1 vial active max.
-- 9 dmg did 8% of a vials HP so ~110 HP
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/wotg")
require("scripts/globals/utils")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    tpz.wotg.NMMods(mob)
end

function onMobEngaged(mob, target)
    mob:setLocalVar("grenadeTime", os.time() + math.random(5, 60))
    mob:setLocalVar("vialTime", os.time() + math.random(5, 15))
end

function onMobFight(mob, target)
    local grenadeTime = mob:getLocalVar("grenadeTime")
    local vialTime = mob:getLocalVar("vialTime")
    local vialsSummoned = mob:getLocalVar("vialsSummoned")
    local grenade = GetMobByID(mob:getID() +1)
    local vial = GetMobByID(mob:getID() +4)

    -- Grenade is summoned every 5-60s
    -- Grenades run towards a random target and uses one of their TP moves then depop after.
    if os.time() >= grenadeTime then
        if grenade:isSpawned() then grenade = GetMobByID(mob:getID() +2) end
        if grenade:isSpawned() then grenade = GetMobByID(mob:getID() +3) end
        if not grenade:isSpawned() then
            mob:setLocalVar("grenadeTime", os.time() + math.random(15, 60))
            grenade:setSpawn(mob:getXPos() + math.random(1, 3), mob:getYPos(), mob:getZPos() + math.random(1, 3))
            utils.spawnPetInBattle(mob, grenade, true, true)
        end
    end
    if os.time() >= vialTime then -- Vials stay alive spamming Noxious Spray (Poison for 30/tick). Can only have 1 vial active max.
        if (vialsSummoned >= 5) then
            mob:setLocalVar("vialTime", os.time() + 360)
            mob:setLocalVar("vialsSummoned", 0)
            return
        end
        if not vial:isSpawned() then
            mob:setLocalVar("vialTime", os.time() + math.random(30, 60))
            mob:setLocalVar("vialsSummoned", vialsSummoned +1)
            vial:setSpawn(mob:getXPos() + math.random(1, 3), mob:getYPos(), mob:getZPos() + math.random(1, 3))
            utils.spawnPetInBattle(mob, vial, true, true)
        end
    end
end

function onMobWeaponSkillPrepare(mob, target)
    local tpMoves = {606, 2263}
    return tpMoves[math.random(#tpMoves)]
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.MagianT4(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(7200) -- 2 hours
end