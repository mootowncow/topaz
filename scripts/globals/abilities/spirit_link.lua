-----------------------------------
-- Ability: Spirit Link
-- Sacrifices own HP to heal Wyvern's HP.
-- Obtained: Dragoon Level 25
-- Recast Time: 1:30
-- Duration: Instant
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/job_util")
-----------------------------------

function cutEmpathyEffectTable(validEffects, i, maxCount)
    local delindex = 1

    while maxCount < i do
        delindex = math.random(1, i)
        while validEffects[delindex+1] ~= nil do
            validEffects[delindex] = validEffects[delindex+1]
            delindex = delindex + 1
        end
        validEffects[delindex+1] = nil -- could be in the above loop, but unsure if Lua allows copying of nil?
        i = i - 1
    end

    return validEffects
end

function onAbilityCheck(player, target, ability)
   if (player:getPet() == nil) then
        return tpz.msg.basic.REQUIRES_A_PET, 0
   elseif (player:getPetID() ~= tpz.pet.id.WYVERN) then
      return tpz.msg.basic.NO_EFFECT_ON_PET, 0
   else
      return 0, 0
   end
end

function onUseAbility(player, target, ability)

    local playerHP = player:getHP()
    local drainamount = (math.random(25, 35) / 100) * playerHP

    -- Prevents player HP lose if wyvern is at full HP
    if (player:getPet():getHP() == player:getPet():getMaxHP()) then
        drainamount = 0
    end

    -- Don't drain more HP than your pet has HP
    if ((player:getPet():getMaxHP() - player:getPet():getHP()) < drainamount) then
        local jpValue = player:getJobPointLevel(tpz.jp.SPIRIT_LINK_EFFECT)
        drainamount = (player:getPet():getMaxHP() - player:getPet():getHP())
        drainamount = drainamount * (1 - (0.01 * jpValue))
    end

    -- Add Unda runes on each use, up to 3 total.
    jobUtil.AddUndaRune(player)

    if (player:hasStatusEffect(tpz.effect.STONESKIN)) then
        local skin = player:getMod(tpz.mod.STONESKIN)

        if (skin >= drainamount) then
            if (skin == drainamount) then
                player:delStatusEffectSilent(tpz.effect.STONESKIN)
            else
                local effect = player:getStatusEffect(tpz.effect.STONESKIN)
                effect:setPower(effect:getPower() - drainamount) -- fixes the status effeect so when it ends it uses the new power instead of old
                player:delMod(tpz.mod.STONESKIN, drainamount) --removes the amount from the mod
            end
        else
            player:delStatusEffectSilent(tpz.effect.STONESKIN)
            player:takeDamage(drainamount - skin)
        end
    else
        player:takeDamage(drainamount)
    end

    local pet = player:getPet()
    local healPet = drainamount * 2
    local petTP = pet:getTP()
    local regenAmount = player:getMainLvl()/3 -- level/3 tic regen

    if (player:getEquipID(tpz.slot.HEAD)==15238) then
        healPet = healPet + 15
    end

    pet:delStatusEffectSilent(tpz.effect.POISON)
    pet:delStatusEffectSilent(tpz.effect.BLINDNESS)
    pet:delStatusEffectSilent(tpz.effect.PARALYSIS)

    if (math.random(1, 2) == 1) then
        pet:delStatusEffectSilent(tpz.effect.DOOM)
    end

    -- Remove sleep if wyvern is healed
    if (pet:getHP() < pet:getMaxHP()) then 
        removeSleepEffects(pet)
    end

    -- Empathy copying
    local merits = player:getMerit(tpz.merit.EMPATHY)
    if merits > 0 then
        local effects = player:getStatusEffects()
        local validEffects = { }
        local i = 0 -- highest existing index
        local copyi = 0

        for _, effect in ipairs(effects) do
            if bit.band(effect:getFlag(), tpz.effectFlag.EMPATHY) == tpz.effectFlag.EMPATHY then
                validEffects[i+1] = effect
                i = i + 1
            end
        end

        if i < merits then
            merits = i
        elseif i > merits then
            validEffects = cutEmpathyEffectTable(validEffects, i, merits)
        end

        local copyEffect = nil
        while copyi < merits do
            copyEffect = validEffects[copyi+1]
            if pet:hasStatusEffect(copyEffect:getType()) then
                pet:delStatusEffectSilent(copyEffect:getType())
            end

            pet:addStatusEffect(copyEffect:getType(), copyEffect:getPower(), copyEffect:getTick() / 1000, math.ceil((copyEffect:getTimeRemaining())/1000)) -- id, power, tick, duration(convert ms to s)
            copyi = copyi + 1
        end
    end

    pet:addExp(200 * merits)
    pet:addHP(healPet) --add the hp to pet
    player:updateEnmityFromCure(pet, healPet)
    pet:addStatusEffect(tpz.effect.REGEN, regenAmount, 3, 18, 0, 0, 0) -- Was 90 seconds of regen. Changed to 15s due to being reduced in CD
    player:addTP(petTP/2) --add half pet tp to you
    pet:delTP(petTP) -- remove half tp from pet
end
