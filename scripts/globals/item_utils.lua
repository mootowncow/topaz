-----------------------------------
-- Item Utils
-----------------------------------
require('scripts/globals/utils')
require('scripts/globals/items')
-----------------------------------
tpz = tpz or {}
tpz.itemUtils = {}

tpz.itemUtils.removableEffects =
{
    tpz.effect.PARALYSIS,
    tpz.effect.POISON,
    tpz.effect.BLINDNESS,
    tpz.effect.SILENCE,
    tpz.effect.DISEASE,
    tpz.effect.PETRIFICATION,
    tpz.effect.BIND,
    tpz.effect.WEIGHT,
    tpz.effect.ADDLE,
    tpz.effect.BURN,
    tpz.effect.FROST,
    tpz.effect.CHOKE,
    tpz.effect.RASP,
    tpz.effect.SHOCK,
    tpz.effect.DROWN,
    tpz.effect.DIA,
    tpz.effect.BIO,
    tpz.effect.STR_DOWN,
    tpz.effect.DEX_DOWN,
    tpz.effect.VIT_DOWN,
    tpz.effect.AGI_DOWN,
    tpz.effect.INT_DOWN,
    tpz.effect.MND_DOWN,
    tpz.effect.CHR_DOWN,
    tpz.effect.MAX_HP_DOWN,
    tpz.effect.MAX_MP_DOWN,
    tpz.effect.ATTACK_DOWN,
    tpz.effect.EVASION_DOWN,
    tpz.effect.DEFENSE_DOWN,
    tpz.effect.MAGIC_DEF_DOWN,
    tpz.effect.INHIBIT_TP,
    tpz.effect.MAGIC_ACC_DOWN,
    tpz.effect.MAGIC_ATK_DOWN
}

tpz.itemUtils.foodOnItemCheck = function(target, foodType)
    local result     = 0
    local targetRace = target:getRace()
    local canEatFish = targetRace == tpz.race.MITHRA or target:getMod(tpz.mod.EAT_RAW_FISH) == 1
    local canEatMeat = targetRace == tpz.race.GALKA or target:getMod(tpz.mod.EAT_RAW_MEAT) == 1

    if
        (foodType == tpz.foodType.RAW_FISH and not canEatFish) or
        (foodType == tpz.foodType.RAW_MEAT and not canEatMeat)
    then
        result = tpz.msg.basic.CANNOT_EAT
    end

    if target:hasStatusEffect(tpz.effect.FOOD) then
        result = tpz.msg.basic.IS_FULL
    end

    return result
end

tpz.itemUtils.itemBoxOnItemCheck = function(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = tpz.msg.basic.ITEM_NO_USE_INVENTORY
    end

    return result
end

tpz.itemUtils.skillBookCheck = function(target, skillID)
    local skill   = skillID
    local mainCap = target:getMaxSkillLevel(target:getMainLvl(), target:getMainJob(), skill) or 0
    local subCap  = target:getMaxSkillLevel(target:getSubLvl(), target:getSubJob(), skill) or 0
    local mainDif = (mainCap * 10) / 10 - (target:getCharSkillLevel(skill) * 10) / 100
    local subDif  = (subCap * 10) / 10 - (target:getCharSkillLevel(skill) * 10) / 100
    local noSkill = 0

    if mainCap == 0 then
        noSkill = noSkill + 1
    end

    if subCap == 0 then
        noSkill = noSkill + 1
    end

    if noSkill >= 2 then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end

    if mainCap > 0 and mainDif <= 0 then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end

    if subCap > 0 and mainCap == 0 and subDif <= 0 then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

tpz.itemUtils.skillBookUse = function(target, skillID)
    target:trySkillUp(skillID, target:getMainLvl(), true, true)
end

tpz.itemUtils.pickItemRandom = function(target, itemgroup) -- selects an item from a weighted result table
    -- possible results
    local items = itemgroup

    -- sum weights
    local sum = 0
    for i = 1, #items do
        sum = sum + items[i][1]
    end

    -- pick the weighted result
    local item = 0
    local pick = math.random(1, sum)
    sum = 0

    for i = 1, #items do
        sum = sum + items[i][1]
        if sum >= pick then
            item = items[i][2]
            break
        end
    end

    return item
end

tpz.itemUtils.removeShield = function(effect, target)
    if effect == tpz.effect.PHYSICAL_SHIELD then
        target:delStatusEffect(tpz.effect.MAGIC_SHIELD)
    else
        target:delStatusEffect(tpz.effect.PHYSICAL_SHIELD)
    end
end

tpz.itemUtils.addItemShield = function(target, power, duration, effect, special)
    if target:hasStatusEffect(effect) then
        local shield            = target:getStatusEffect(effect)
        local activeshieldpower = shield:getPower()

        if activeshieldpower > power then
            target:messageBasic(tpz.msg.basic.NO_EFFECT)
        else
            tpz.itemUtils.removeShield(effect, target)
            target:addStatusEffect(effect, power, 0, duration, 0, special)
            target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, effect)
        end
    else
        tpz.itemUtils.removeShield(effect, target)
        target:addStatusEffect(effect, power, 0, duration, 0, special)
        target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, effect)
    end
end

tpz.itemUtils.addItemEffect = function(target, effect, power, duration, subpower)
    if target:hasStatusEffect(effect) then
        local buff        = target:getStatusEffect(effect)
        local effectpower = buff:getPower()

        if effectpower > power then
            target:messageBasic(tpz.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(effect, power, 0, duration, 0, subpower)
        end
    else
        target:addStatusEffect(effect, power, 0, duration, 0, subpower)
    end
end

tpz.itemUtils.addTwoItemEffects = function(target, effect1, effect2, power1, power2, duration)
    if target:hasStatusEffect(effect1) then
        local buff        = target:getStatusEffect(effect1)
        local effectpower = buff:getPower()

        if effectpower > power1 then
            target:messageBasic(tpz.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(effect1, power1, 0, duration, 0, power1)
        end
    else
        target:addStatusEffect(effect1, power1, 0, duration, 0, power1)
    end

    if target:hasStatusEffect(effect2) then
        local buff        = target:getStatusEffect(effect2)
        local effectpower = buff:getPower()

        if effectpower > power2 then
            target:messageBasic(tpz.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(effect2, power2, 0, duration, 0, power2)
        end
    else
        target:addStatusEffect(effect2, power2, 0, duration, 0, power2)
    end
end

tpz.itemUtils.addItemExpEffect = function(target, effect, power, duration, subpower)
    local deleffect = tpz.effect.COMMITMENT

    if effect == deleffect then
        deleffect = tpz.effect.DEDICATION
    end

    if target:hasStatusEffect(effect) then
        local buff        = target:getStatusEffect(effect)
        local effectpower = buff:getPower()

        if effectpower > power then
            target:messageBasic(tpz.msg.basic.NO_EFFECT)
        else
            target:delStatusEffectSilent(deleffect)
            target:addStatusEffect(effect, power, 0, duration, 0, subpower)
        end
    else
        target:delStatusEffectSilent(deleffect)
        target:addStatusEffect(effect, power, 0, duration, 0, subpower)
    end
end

tpz.itemUtils.removeStatus = function(target, effects)
    for _, effect in ipairs(effects) do
        if target:delStatusEffect(effect) then
            return true
        end
    end

    if target:eraseStatusEffect() ~= 255 then
        return true
    end

    return false
end

tpz.itemUtils.removeMultipleEffects = function(target, effects, count, random)
    local effectsToRemove = effects

    if random == 1 then -- randomize which effects get removed
        effectsToRemove = utils.shuffle(effects)
    end

    if count > 0 then
        local removed = 0

        for i = 0, count do
            if not tpz.itemUtils.removeStatus(target, effectsToRemove) then
                break
            end

            removed = removed + 1

            if removed >= count then
                break
            end
        end

        return removed
    end
end

-- Augment slots are 0-3
function tpz.itemUtils.HasAugment(item, augmentId)
    for slot = 0, 3 do
        local augId, augVal = item:getAugment(slot)
        if augId == augmentId then
            return augVal
        end
    end
    return false
end

--[[ How to use DumpItemAugments
local item = player:getEquip(0) -- e.g. main weapon

if item then
    tpz.itemUtils.DumpItemAugments(item)
end
]]
function tpz.itemUtils.PrintItemAugments(item)
    if item == nil then
        printf("[itemUtils] No item provided.")
        return
    end

    printf("[itemUtils] Augments for: %s", item:getName())
    local foundAugment = false

    for slot = 0, 3 do -- corrected to 0-3
        local augId, augVal = item:getAugment(slot)
        if augId ~= 0 then
            foundAugment = true
            local augName = "Unknown"
            if tpz.augments and tpz.augments[augId] then
                augName = tpz.augments[augId]
            end
            printf("  Slot %d: ID %d (%s), Value %d", slot, augId, augName, augVal)
        end
    end

    if not foundAugment then
        printf("  No augments found on this item.")
    end
end

--[[ How to use GetItemAugments()
local item = player:getEquip(0) -- main hand

if item then
    local augments = tpz.itemUtils.GetItemAugments(item)

    for _, aug in ipairs(augments) do
        printf("Slot %d: ID %d (%s), Value %d", aug.slot, aug.id, aug.name, aug.value)
    end

    if #augments == 0 then
        printf("No augments found on this item.")
    end
end
]]
function tpz.itemUtils.GetItemAugments(item)
    local augments = {}

    if item == nil then
        printf("[GetItemAugments] No item provided")
        return augments
    end

    for slot = 0, 3 do -- slots 0-3
        local augId, augVal = item:getAugment(slot)
        if augId ~= 0 then
            local name = tpz.augments.getAugmentName(augId) or "Unknown"
            printf("[GetItemAugments] Slot %d: ID=%d (%s), Value=%d", slot, augId, name, augVal)
            table.insert(augments, {
                slot  = slot,
                id    = augId,
                value = augVal,
                name  = name
            })
        else
            printf("[GetItemAugments] Slot %d: empty", slot)
        end
    end

    return augments
end

function tpz.itemUtils.GetItemAugmentArrays(item)
    local augments = {}
    local augmentsPower = {}

    -- Fill with zeros by default (slots 0 to 3)
    for slot = 0, 3 do
        augments[slot + 1] = 0
        augmentsPower[slot + 1] = 0
    end

    if item == nil then
        printf("[GetItemAugmentArrays] No item provided")
        return augments, augmentsPower
    end

    local augTable = tpz.itemUtils.GetItemAugments(item)

    for _, aug in ipairs(augTable) do
        printf("[GetItemAugmentArrays] Slot %d: ID=%d, Value=%d", aug.slot, aug.id, aug.value)
        augments[aug.slot + 1] = aug.id
        augmentsPower[aug.slot + 1] = aug.value
    end

    return augments, augmentsPower
end

function tpz.itemUtils.BuildAddItemArgs(augTable, trialNumber)
    local args = {}

    -- pack aug0 to aug3 and their values
    for slot = 0, 3 do
        args[slot * 2 + 1] = augTable[slot + 1].id or 0
        args[slot * 2 + 2] = math.min(augTable[slot + 1].value or 0, 31)
    end

    -- pack trialNumber at arg[9]
    args[9] = trialNumber or 0

    -- optionally pack aug4val (if you use 5 augments in your system)
    -- args[10] = augTable[5] and math.min(augTable[5].value or 0, 31) or 0

    return args
end


--[[ How to use ApplyAugmentsToItem()
    -- Not sure if this works
    local item = player:getEquip(0)
    local augments = tpz.itemUtils.GetItemAugments(item)

    local newItem = player:getEquip(1)
    tpz.itemUtils.ApplyAugmentsToItem(newItem, augments)
    Expects a table like (Created from GetItemAugments()):
    {
        { slot = 1, id = 1, value = 50, name = "HP" },
        { slot = 3, id = 28, value = 5, name = "PDT" },
        -- etc.
    }

]]
function tpz.itemUtils.ApplyAugmentsToItem(item, augmentTable)
    if item == nil then
        printf("[itemUtils] ApplyAugmentsToItem: No item provided.")
        return
    end

    if augmentTable == nil or #augmentTable == 0 then
        printf("[itemUtils] ApplyAugmentsToItem: No augments to apply.")
        return
    end

    for _, aug in ipairs(augmentTable) do
        if aug.slot and aug.id and aug.value then
            item:setAugment(aug.slot, aug.id, aug.value)
            printf("[itemUtils] Applied augment to slot %d: ID %d (%s), Value %d",
                aug.slot, aug.id, aug.name or "Unknown", aug.value)
        else
            printf("[itemUtils] Skipped invalid augment entry: %s", tostring(aug))
        end
    end
end

tpz.itemUtils.temps = {}

tpz.itemUtils.temps.HPBoost = function(target, itemId, power, duration)
    local oldPower = 0
    local party = target:getPartyWithTrusts()

    -- Apply effect to Trusts
    for _, member in ipairs(party) do
        if member:isTrust() and not member:hasStatusEffect(tpz.effect.MAX_HP_DOWN) then

            local oldPowerTrust = 0

            if member:hasStatusEffect(tpz.effect.MAX_HP_BOOST) then
                oldPowerTrust = member:getStatusEffect(tpz.effect.MAX_HP_BOOST):getPower()
            end

            -- Don't overwrite a stronger HP boost with a weaker one
            if power > oldPowerTrust then
                member:delStatusEffectSilent(tpz.effect.MAX_HP_BOOST)
                member:addStatusEffect(tpz.effect.MAX_HP_BOOST, power, 0, duration)
            end
        end
    end

    -- If the target has Max HP Down, the item has no effect on them
    if target:hasStatusEffect(tpz.effect.MAX_HP_DOWN) then
        -- TODO: Doesn't work on simple log
        return target:messagePublic(tpz.msg.basic.ITEM_NO_EFFECT, target, itemId)
    end

    if target:hasStatusEffect(tpz.effect.MAX_HP_BOOST) then
        oldPower = target:getStatusEffect(tpz.effect.MAX_HP_BOOST):getPower()
    end

    -- Don't overwrite a stronger HP boost with a weaker one
    if power >= oldPower then
        target:delStatusEffectSilent(tpz.effect.MAX_HP_BOOST)
        target:addStatusEffect(tpz.effect.MAX_HP_BOOST, power, 0, duration)
    else
        -- TODO: Doesn't work on simple log
        return target:messagePublic(tpz.msg.basic.ITEM_NO_EFFECT, target, itemId)
    end
end

tpz.itemUtils.temps.MPBoost = function(target, itemId, power, duration)
    local oldPower = 0
    local party = target:getPartyWithTrusts()

    -- Apply effect to Trusts
    for _, member in ipairs(party) do
        if member:isTrust() and not member:hasStatusEffect(tpz.effect.MAX_MP_DOWN) then

            local oldPowerTrust = 0

            if member:hasStatusEffect(tpz.effect.MAX_MP_BOOST) then
                oldPowerTrust = member:getStatusEffect(tpz.effect.MAX_MP_BOOST):getPower()
            end

            -- Don't overwrite a stronger MP boost with a weaker one
            if power > oldPowerTrust then
                member:delStatusEffectSilent(tpz.effect.MAX_MP_BOOST)
                member:addStatusEffect(tpz.effect.MAX_MP_BOOST, power, 0, duration)
            end
        end
    end

    -- If the target has Max MP Down, the item has no effect on them
    if target:hasStatusEffect(tpz.effect.MAX_MP_DOWN) then
        -- TODO: Doesn't work on simple log
        return target:messagePublic(tpz.msg.basic.ITEM_NO_EFFECT, target, itemId)
    end

    if target:hasStatusEffect(tpz.effect.MAX_MP_BOOST) then
        oldPower = target:getStatusEffect(tpz.effect.MAX_MP_BOOST):getPower()
    end

    -- Don't overwrite a stronger MP boost with a weaker one
    if power >= oldPower then
        target:delStatusEffectSilent(tpz.effect.MAX_MP_BOOST)
        target:addStatusEffect(tpz.effect.MAX_MP_BOOST, power, 0, duration)
    else
        -- TODO: Doesn't work on simple log
        return target:messagePublic(tpz.msg.basic.ITEM_NO_EFFECT, target, itemId)
    end
end