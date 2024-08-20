-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Defender
-----------------------------------
require("scripts/globals/regimes")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setLocalVar("petCount", 1)
    mob:addMod(tpz.mod.EVA, 100)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobFight(mob, target)
    local auraGear = GetMobByID(mob:getID() + 1)
    local petCount = mob:getLocalVar("petCount")

    -- Summons an Aura Gear every 15 seconds.
    -- TODO: Casting animation for before summons. When he spawns them isn't exactly retail accurate.
    -- Defenders can also still spawn the Aura Gears while sleeping, etc.
    -- Maximum number of pets Defender can spawn is 5
    if petCount <= 5 and mob:getBattleTime() % 15 < 3 and mob:getBattleTime() > 3 and not auraGear:isSpawned() and mob:getLocalVar("summoning") == 0 then
        mob:setLocalVar("summoning", 1)
        mob:SetAutoAttackEnabled(false)
        mob:SetMagicCastingEnabled(false)
        mob:SetMobAbilityEnabled(false)
        mob:entityAnimationPacket("casm")

        mob:timer(3000, function(mob)
            if mob:isAlive() then
                local petCount = mob:getLocalVar("petCount")
                mob:SetAutoAttackEnabled(true)
                mob:SetMagicCastingEnabled(true)
                mob:SetMobAbilityEnabled(true)
                mob:entityAnimationPacket("shsm")
                local auraGear = GetMobByID(mob:getID() + 1)
                auraGear:setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos() + 1)
                auraGear:spawn()
                auraGear:updateEnmity(mob:getTarget())
                mob:setLocalVar("petCount", petCount + 1)
                mob:setLocalVar("summoning", 0)
            end
        end)
    end

    -- make sure pet has a target
    if auraGear:getCurrentAction() == tpz.act.ROAMING then
        auraGear:updateEnmity(target)
    end
end

function onMobDisengage(mob)
    local auraGearId = mob:getID() + 1

    mob:resetLocalVars()

    if GetMobByID(auraGearId):isSpawned() then
        DespawnMob(auraGearId)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.regime.checkRegime(player, mob, 749, 1, tpz.regime.type.GROUNDS)
end

function onMobDespawn( mob )
    local auraGearId = mob:getID() + 1

    mob:resetLocalVars()

    if GetMobByID(auraGearId):isSpawned() then
        DespawnMob(auraGearId)
    end
end
