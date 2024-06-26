-----------------------------------
-- Ability: Reward
-- Feeds pet to restore its HP.
-- Obtained: Beastmaster Level 12
-- Recast Time: 1:30
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/pets")
require("scripts/globals/msg")
require("scripts/globals/items")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability, action)

    -- 1st need to get the pet food is equipped in the range slot.
    local rangeObj = player:getEquipID(tpz.slot.AMMO)

    local minimumHealing = 0
    local totalHealing = 0
    local playerMnd = player:getStat(tpz.mod.MND)
    local rewardHealingMod = player:getMod(tpz.mod.REWARD_HP_BONUS)
    local regenAmount = 1 -- 1 is the minimum.
    local regenTime = 180 -- 3 minutes

    local pet = player:getPet()
    local petCurrentHP = pet:getHP()
    local petMaxHP = pet:getMaxHP()
    local jpValue = 1 + (player:getJobPointLevel(tpz.jp.REWARD_EFFECT) / 100)


    -- Need to start to calculate the HP to restore to the pet.
    -- Please note that I used this as base for the calculations:
    -- http://wiki.ffxiclopedia.org/wiki/Reward

    switch (rangeObj) : caseof {
        [tpz.items.PET_FOOD_ALPHA_BISCUIT] = function (x)
            -- printf("Food: pet food alpha biscuit.")
            minimumHealing = 50
            regenAmount = 1
            totalHealing = math.floor(minimumHealing + 2*(playerMnd-10))
        end,
        [tpz.items.PET_FOOD_BETA_BISCUIT] = function (x)
            -- printf("Food: pet food beta biscuit.")
            minimumHealing = 180
            regenAmount = 3
            totalHealing = math.floor(minimumHealing + 1*(playerMnd-33))
         end,
        [tpz.items.PET_FOOD_GAMMA_BISCUIT] = function (x)
            -- printf("Food: pet food gamma biscuit.")
            minimumHealing = 300
            regenAmount = 5
            totalHealing = math.floor(minimumHealing + 1*(playerMnd-35)) -- TO BE VERIFIED.
        end,
        [tpz.items.PET_FOOD_DELTA_BISCUIT] = function (x)
            -- printf("Food: pet food delta biscuit.")
            minimumHealing = 530
            regenAmount = 8
            totalHealing = math.floor(minimumHealing + 2*(playerMnd-40)) -- TO BE VERIFIED.
        end,
        [tpz.items.PET_FOOD_EPSILON_BISCUIT] = function (x)
            -- printf("Food: pet food epsilon biscuit.")
            minimumHealing = 750
            regenAmount = 11
            totalHealing = math.floor(minimumHealing + 2*(playerMnd-45))
         end,
        [tpz.items.PET_FOOD_ZETA_BISCUIT] = function (x)
            -- printf("Food: pet food zeta biscuit.")
            minimumHealing = 900
            regenAmount = 14
            totalHealing = math.floor(minimumHealing + 3*(playerMnd-45))
        end,
        [tpz.items.PET_FOOD_ETA_BISCUIT] = function (x)
            -- printf("Food: pet food eta biscuit.")
            minimumHealing = 1200
            regenAmount = 17
            totalHealing = math.floor(minimumHealing + 4*(playerMnd-50))
        end,
        [tpz.items.PET_FOOD_THETA_BISCUIT] = function (x)
            -- printf("Food: pet food theta biscuit.")
            minimumHealing = 1600
            regenAmount = 20
            totalHealing = math.floor(minimumHealing + 4*(playerMnd-55))
        end,
        [tpz.items.PET_ROBORANT] = function (x)
            -- printf("Food: pet food pet roborant.")
            minimumHealing = 0
            regenAmount = 0
            totalHealing = 0
            -- Removes Sleep, Poison, Petrification, Curse, Paralyze, Blind, Weight, Slow, Silence, Choke, Frost, Rasp, Burn, Drown, Shock, Dia, Bio
            for v = tpz.effect.SLEEP, tpz.effect.CURSE_I do
                pet:delStatusEffectSilent(v)
            end
            for v = tpz.effect.BIND, tpz.effect.SLOW do
                pet:delStatusEffectSilent(v)
            end
            for v = tpz.effect.BURN, tpz.effect.BIO do
                pet:delStatusEffectSilent(v)
            end
        end,
        [tpz.items.PET_POULTICE] = function (x)
            -- printf("Food: pet food pet poultice.")
            minimumHealing = 0
            regenAmount = 6
            regenTime = 300 -- 5 minutes
            totalHealing = 0
        end,
    }



    -- Now calculating the bonus based on gear.
    local body = player:getEquipID(tpz.slot.BODY)


    switch (body) : caseof {
        [12646] = function (x) -- beast jackcoat
            -- This will remove Paralyze, Poison and Blind from the pet.
            -- printf("Beast jackcoat detected.")
            pet:delStatusEffectSilent(tpz.effect.PARALYSIS)
            pet:delStatusEffectSilent(tpz.effect.POISON)
            pet:delStatusEffectSilent(tpz.effect.BLINDNESS)
            end,
        [14481] = function (x) -- beast jackcoat +1
            -- This will remove Paralyze, Poison, Blind, Weight, Slow and Silence from the pet.
            -- printf("Beast jackcoat +1 detected.")
            pet:delStatusEffectSilent(tpz.effect.PARALYSIS)
            pet:delStatusEffectSilent(tpz.effect.POISON)
            pet:delStatusEffectSilent(tpz.effect.BLINDNESS)
            pet:delStatusEffectSilent(tpz.effect.WEIGHT)
            pet:delStatusEffectSilent(tpz.effect.SLOW)
            pet:delStatusEffectSilent(tpz.effect.SILENCE)
            end,
        [15095] = function (x) -- monster jackcoat
            -- This will remove Weight, Slow and Silence from the pet.
            -- printf("Monster jackcoat detected.")
            pet:delStatusEffectSilent(tpz.effect.WEIGHT)
            pet:delStatusEffectSilent(tpz.effect.SLOW)
            pet:delStatusEffectSilent(tpz.effect.SILENCE)
            end,
        [14481] = function (x) -- monster jackcoat +1
            -- This will remove Paralyze, Poison, Blind, Weight, Slow and Silence from the pet.
            -- printf("Monster jackcoat +1 detected.")
            pet:delStatusEffectSilent(tpz.effect.PARALYSIS)
            pet:delStatusEffectSilent(tpz.effect.POISON)
            pet:delStatusEffectSilent(tpz.effect.BLINDNESS)
            pet:delStatusEffectSilent(tpz.effect.WEIGHT)
            pet:delStatusEffectSilent(tpz.effect.SLOW)
            pet:delStatusEffectSilent(tpz.effect.SILENCE)
            end,
    }

    -- Adding bonus to the total to heal.

    if (rewardHealingMod ~= nil and rewardHealingMod > 0) then
        totalHealing = totalHealing + math.floor(totalHealing * rewardHealingMod / 100)
    end

    -- Add Job point bonus
    totalHealing = math.floor(totalHealing * jpValue)

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

    -- Add Beast Healer merits
    regenAmount = regenAmount + player:getMerit(tpz.merit.BEAST_HEALER)
    
    -- Only apply regen if applying a stronger or equal effect
    if (regenAmount >= pet:getMod(tpz.mod.REGEN)) then
        pet:delStatusEffectSilent(tpz.effect.REGEN)
        pet:addStatusEffect(tpz.effect.REGEN, regenAmount, 3, regenTime) -- 3 = tick, each 3 seconds.
    end

    player:removeAmmo()
    player:updateEnmityFromCure(pet, totalHealing)

    return totalHealing
end
