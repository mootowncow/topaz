-----------------------------------
-- Area: The Shrine of Ru'Avitau
--   NM: Kirin
-----------------------------------
local ID = require("scripts/zones/The_Shrine_of_RuAvitau/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/titles")
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize( mob )
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
	mob:setDamage(155)
    mob:setMod(tpz.mod.ATT, 522)
    mob:setMod(tpz.mod.DEF, 465) -- 515
    mob:setMod(tpz.mod.REFRESH, 300)
    mob:setMod(tpz.mod.REGEN, 50)
    mob:setMod(tpz.mod.REGAIN, 50)
    mob:setMod(tpz.mod.MATT, 50)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:SetAutoAttackEnabled(true)
    mob:SetMobAbilityEnabled(true)
    mob:SetMagicCastingEnabled(true)
    mob:setUnkillable(true)
    mob:setLocalVar("GodsSummoned", 0)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.ASTRAL_FLOW, hpp = 24},
        },
    })
end

function onMobRoam(mob)
    mob:SetAutoAttackEnabled(true)
    mob:SetMobAbilityEnabled(true)
    mob:SetMagicCastingEnabled(true)
end

function onMobFight(mob, target)
    local GodsSummoned = mob:getLocalVar("GodsSummoned")
    local spawnLock = mob:getLocalVar("SpawnLock")

    ----------------------------------------
    -- Check if any gods are alive
    ----------------------------------------
    local anyPetAlive = false
    for i = ID.mob.KIRIN + 1, ID.mob.KIRIN + 4 do
        local pet = GetMobByID(i)
        if pet and pet:isAlive() then
            anyPetAlive = true
            break
        end
    end

    ----------------------------------------
    -- Disable / Enable Kirin
    ----------------------------------------
    if anyPetAlive then
        mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
        mob:SetAutoAttackEnabled(false)
        mob:SetMobAbilityEnabled(false)
        mob:SetMagicCastingEnabled(false)
    else
        mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
        mob:SetAutoAttackEnabled(true)
        mob:SetMobAbilityEnabled(true)
        mob:SetMagicCastingEnabled(true)

        -- remove invulnerability when no gods alive
        mob:setMod(tpz.mod.UDMGPHYS, 0)
        mob:setMod(tpz.mod.UDMGRANGE, 0)
        mob:setMod(tpz.mod.UDMGMAGIC, 0)
        mob:setMod(tpz.mod.UDMGBREATH, 0)

        -- Killable only after all 4 gods are dead
        if mob:getLocalVar("GodsSummoned") == 4 then
            mob:setUnkillable(false)
        end
    end

    ----------------------------------------
    -- Spawn helper
    ----------------------------------------
local function spawnGod(nextPhase)
    if mob:getLocalVar("SpawnLock") ~= 0 then return end

    mob:setLocalVar("SpawnLock", 1)

    local godsRemaining = {}
    for i = 1, 4 do
        if mob:getLocalVar("add"..i) == 0 then
            table.insert(godsRemaining, i)
        end
    end

    if #godsRemaining == 0 then
        mob:setLocalVar("SpawnLock", 0)
        return
    end

    local g = godsRemaining[math.random(#godsRemaining)]
    local godID = ID.mob.KIRIN + g

    -- start animation
    mob:entityAnimationPacket("casm")

    mob:timer(3000, function(mobArg)
        mobArg:entityAnimationPacket("shsm")

        local god = SpawnMob(godID)

        if god then
            god:setPos(mobArg:getXPos() + 3, mobArg:getYPos(), mobArg:getZPos())
            god:updateEnmity(target)
        end

        -- mark spawned
        mobArg:setLocalVar("add"..g, 1)
        mobArg:setLocalVar("GodsSummoned", nextPhase)

        -- make Kirin immune while gods are up
        mobArg:setMod(tpz.mod.UDMGPHYS, -100)
        mobArg:setMod(tpz.mod.UDMGRANGE, -100)
        mobArg:setMod(tpz.mod.UDMGMAGIC, -100)
        mobArg:setMod(tpz.mod.UDMGBREATH, -100)

        -- unlock AFTER everything finishes
        mobArg:setLocalVar("SpawnLock", 0)
    end)
end

    ----------------------------------------
    -- Phase triggers
    ----------------------------------------
    if mob:getHPP() <= 75 and GodsSummoned == 0 then
        spawnGod(1)

    elseif mob:getHPP() <= 50 and GodsSummoned == 1 then
        spawnGod(2)

    elseif mob:getHPP() <= 25 and GodsSummoned == 2 then
        spawnGod(3)

    elseif mob:getHPP() <= 5 and GodsSummoned == 3 then
        spawnGod(4)
    end

    ----------------------------------------
    -- Make sure gods engage
    ----------------------------------------
    for i = ID.mob.KIRIN + 1, ID.mob.KIRIN + 4 do
        local god = GetMobByID(i)
        if god and god:isSpawned() and god:getCurrentAction() == tpz.act.ROAMING then
            god:updateEnmity(target)
        end
    end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENSTONE, {chance = 100, power = math.random(150, 250)})
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addTitle( tpz.title.KIRIN_CAPTIVATOR )
    player:showText( mob, ID.text.KIRIN_OFFSET + 1 )
end

function onMobDespawn( mob )
end
