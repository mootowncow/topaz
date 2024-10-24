-----------------------------------
-- Ability: Repair
-- Uses oil to restore pet's HP.
-- Obtained: Puppetmaster Level 15
-- Recast Time: 3:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/pets")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    -- 1st need to get the pet food is equipped in the range slot.
    local rangeObj = player:getEquipID(tpz.slot.AMMO)
    local totalHealing = 0
    local regenAmount = 0
    local regenTime = 0
    local pet = player:getPet()
    local petCurrentHP = pet:getHP()
    local petMaxHP = pet:getMaxHP()

    -- Need to start to calculate the HP to restore to the pet.
    -- Please note that I used this as base for the calculations:
    -- http://ffxiclopedia.wikia.com/wiki/Repair

    switch (rangeObj) : caseof {
        [18731] = function (x) -- Automaton Oil
            regenAmount = 10
            totalHealing = petMaxHP * 0.1
            regenTime = 30
            end,
        [18732] = function (x) -- Automaton Oil + 1
            regenAmount = 20
            totalHealing = petMaxHP * 0.2
            regenTime = 60
            end,
        [18733] = function (x) -- Automaton Oil + 2
            regenAmount = 30
            totalHealing = petMaxHP * 0.3
            regenTime = 90
            end,
        [19185] = function (x) -- Automaton Oil + 3
            regenAmount = 40
            totalHealing = petMaxHP * 0.4
            regenTime = 120
            end,
    }

    local function removeStatus()
        --if pet:delStatusEffect(tpz.effect.DOOM) then return true end
        if pet:delStatusEffect(tpz.effect.PETRIFICATION) then return true end
        if pet:delStatusEffect(tpz.effect.SILENCE) then return true end
        if pet:delStatusEffect(tpz.effect.BANE) then return true end
        if pet:delStatusEffect(tpz.effect.CURSE_I) then return true end
        if pet:delStatusEffect(tpz.effect.PARALYSIS) then return true end
        if pet:delStatusEffect(tpz.effect.PLAGUE) then return true end
        if pet:delStatusEffect(tpz.effect.POISON) then return true end
        if pet:delStatusEffect(tpz.effect.DISEASE) then return true end
        if pet:delStatusEffect(tpz.effect.BLINDNESS) then return true end
        if pet:eraseStatusEffect() ~= 255 then return true end
        return false
    end

    local toremove = player:getMod(tpz.mod.REPAIR_EFFECT)

    --[[if (feet == 28240) then -- This item isn't implemented so im leaving this here for reference
        toremove = 1
    end]]

    while toremove > 0 do
        if not removeStatus() then break end
        toremove = toremove - 1
    end

    local bonus = 1 + player:getMerit(tpz.merit.REPAIR_EFFECT)/100

    totalHealing = totalHealing * bonus

    bonus = bonus + player:getMod(tpz.mod.REPAIR_POTENCY)/100

    regenAmount = regenAmount * bonus

    -- Cooldown logic
    if player:hasStatusEffect(tpz.effect.LUX) then
        local playerCurrentHP = player:getHP()
        local playerMaxHP = player:getMaxHP()
        local playerdiff = playerMaxHP - playerCurrentHP
        local totalPlayerHealing = totalHealing * 2
        if (playerdiff < totalPlayerHealing) then
            totalPlayerHealing = playerdiff
        end

        if player:hasStatusEffect(tpz.effect.CURSE_II) then
            totalPlayerHealing = 0
        end
        player:addHP(totalPlayerHealing)
        player:delStatusEffect(tpz.effect.REGEN)
        player:addStatusEffect(tpz.effect.REGEN, regenAmount, 3, regenTime)
        player:updateEnmityFromCure(player, totalPlayerHealing)
    end

    local diff = petMaxHP - petCurrentHP

    if (diff < totalHealing) then
        totalHealing = diff
    end

    -- Handle Zombie
    if pet:hasStatusEffect(tpz.effect.CURSE_II) then
        totalHealing = 0
    end

    pet:addHP(totalHealing)
    pet:wakeUp()

    -- Apply regen
    pet:delStatusEffect(tpz.effect.REGEN)
    pet:addStatusEffect(tpz.effect.REGEN, regenAmount, 3, regenTime) -- 3 = tick, each 3 seconds.
    player:removeAmmo()
    player:updateEnmityFromCure(pet, totalHealing)
    player:delStatusEffect(tpz.effect.LUX)

    return totalHealing
end
