-----------------------------------
-- Ability: Maintenance
-- Cures your automaton of status ailments. Special items required
-- Obtained: Puppetmaster Level 30
-- Recast Time: 1:30
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/pets")
require("scripts/globals/msg")
require("scripts/globals/utils")

local idStrengths = {
    [18731] = 1, -- Automaton Oil
    [18732] = 2, -- Automaton Oil + 1
    [18733] = 3, -- Automaton Oil + 2
    [19185] = 4  -- Automaton Oil + 3
}

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local id = player:getEquipID(tpz.slot.AMMO)
    local pet = player:getPet()
    local effectID

    local function removeStatus()
        local removables =
        {
            tpz.effect.FLASH, tpz.effect.BLINDNESS, tpz.effect.ELEGY, tpz.effect.REQUIEM, tpz.effect.PARALYSIS, tpz.effect.POISON,
            tpz.effect.CURSE_I, tpz.effect.DISEASE, tpz.effect.PLAGUE, tpz.effect.WEIGHT, tpz.effect.BIND,
            tpz.effect.BIO, tpz.effect.DIA, tpz.effect.BURN, tpz.effect.FROST, tpz.effect.CHOKE, tpz.effect.RASP, tpz.effect.SHOCK, tpz.effect.DROWN,
            tpz.effect.STR_DOWN, tpz.effect.DEX_DOWN, tpz.effect.VIT_DOWN, tpz.effect.AGI_DOWN, tpz.effect.INT_DOWN, tpz.effect.MND_DOWN,
            tpz.effect.CHR_DOWN, tpz.effect.ADDLE, tpz.effect.SLOW, tpz.effect.HELIX, tpz.effect.ACCURACY_DOWN, tpz.effect.ATTACK_DOWN,
            tpz.effect.EVASION_DOWN, tpz.effect.DEFENSE_DOWN, tpz.effect.MAGIC_ACC_DOWN, tpz.effect.MAGIC_ATK_DOWN, tpz.effect.MAGIC_EVASION_DOWN,
            tpz.effect.MAGIC_DEF_DOWN, tpz.effect.CRIT_HIT_EVASION_DOWN, tpz.effect.MAX_TP_DOWN, tpz.effect.MAX_MP_DOWN, tpz.effect.MAX_HP_DOWN,
            tpz.effect.SLUGGISH_DAZE_1, tpz.effect.SLUGGISH_DAZE_2, tpz.effect.SLUGGISH_DAZE_3, tpz.effect.SLUGGISH_DAZE_4, tpz.effect.SLUGGISH_DAZE_5,
            tpz.effect.LETHARGIC_DAZE_1, tpz.effect.LETHARGIC_DAZE_2, tpz.effect.LETHARGIC_DAZE_3, tpz.effect.LETHARGIC_DAZE_4, tpz.effect.LETHARGIC_DAZE_5,
            tpz.effect.WEAKENED_DAZE_1, tpz.effect.WEAKENED_DAZE_2, tpz.effect.WEAKENED_DAZE_3, tpz.effect.WEAKENED_DAZE_4, tpz.effect.WEAKENED_DAZE_5,
            tpz.effect.HELIX, tpz.effect.KAUSTRA, tpz.effect.SILENCE, tpz.effect.PETRIFICATION
        }

        for i, effect in ipairs(removables) do
            if (pet:hasStatusEffect(effect)) then
                local currentEffect = pet:getStatusEffect(effect)
                local effectFlags = currentEffect:getFlag()
                print(effectFlags)
                if (bit.band(effectFlags, tpz.effectFlag.WALTZABLE) ~= 0) or (effect == tpz.effect.PETRIFICATION) then
                    pet:delStatusEffect(effect)
                    effectID = effect
                    return true
                end
            end
        end
        return false
    end

    local function removeStatusPlayer()
        local removables =
        {
            tpz.effect.FLASH, tpz.effect.BLINDNESS, tpz.effect.ELEGY, tpz.effect.REQUIEM, tpz.effect.PARALYSIS, tpz.effect.POISON,
            tpz.effect.CURSE_I, tpz.effect.DISEASE, tpz.effect.PLAGUE, tpz.effect.WEIGHT, tpz.effect.BIND,
            tpz.effect.BIO, tpz.effect.DIA, tpz.effect.BURN, tpz.effect.FROST, tpz.effect.CHOKE, tpz.effect.RASP, tpz.effect.SHOCK, tpz.effect.DROWN,
            tpz.effect.STR_DOWN, tpz.effect.DEX_DOWN, tpz.effect.VIT_DOWN, tpz.effect.AGI_DOWN, tpz.effect.INT_DOWN, tpz.effect.MND_DOWN,
            tpz.effect.CHR_DOWN, tpz.effect.ADDLE, tpz.effect.SLOW, tpz.effect.HELIX, tpz.effect.ACCURACY_DOWN, tpz.effect.ATTACK_DOWN,
            tpz.effect.EVASION_DOWN, tpz.effect.DEFENSE_DOWN, tpz.effect.MAGIC_ACC_DOWN, tpz.effect.MAGIC_ATK_DOWN, tpz.effect.MAGIC_EVASION_DOWN,
            tpz.effect.MAGIC_DEF_DOWN, tpz.effect.CRIT_HIT_EVASION_DOWN, tpz.effect.MAX_TP_DOWN, tpz.effect.MAX_MP_DOWN, tpz.effect.MAX_HP_DOWN,
            tpz.effect.SLUGGISH_DAZE_1, tpz.effect.SLUGGISH_DAZE_2, tpz.effect.SLUGGISH_DAZE_3, tpz.effect.SLUGGISH_DAZE_4, tpz.effect.SLUGGISH_DAZE_5,
            tpz.effect.LETHARGIC_DAZE_1, tpz.effect.LETHARGIC_DAZE_2, tpz.effect.LETHARGIC_DAZE_3, tpz.effect.LETHARGIC_DAZE_4, tpz.effect.LETHARGIC_DAZE_5,
            tpz.effect.WEAKENED_DAZE_1, tpz.effect.WEAKENED_DAZE_2, tpz.effect.WEAKENED_DAZE_3, tpz.effect.WEAKENED_DAZE_4, tpz.effect.WEAKENED_DAZE_5,
            tpz.effect.HELIX, tpz.effect.KAUSTRA, tpz.effect.SILENCE, tpz.effect.PETRIFICATION
        }

        for i, effect in ipairs(removables) do
            if (player:hasStatusEffect(effect)) then
                local currentEffect = player:getStatusEffect(effect)
                local effectFlags = currentEffect:getFlag()
                if (bit.band(effectFlags, tpz.effectFlag.WALTZABLE) ~= 0) or (effect == tpz.effect.PETRIFICATION) then
                    player:delStatusEffect(effect)
                    effectID = effect
                    return true
                end
            end
        end
        return false
    end

    local toremove = idStrengths[id] or 1
    local removed = 0

    repeat
        if not removeStatus() then break end
        toremove = toremove - 1
        removed = removed + 1
    until (toremove <= 0)

    if player:hasStatusEffect(tpz.effect.LUX) then
        local toremovePlayer = idStrengths[id] or 1
        local removed = 0

        repeat
            if not removeStatusPlayer() then break end
            toremovePlayer = toremovePlayer - 1
            removed = removed + 1
        until (toremovePlayer <= 0)
    end

    player:removeAmmo()

    if removed > 0 then
        player:messagePublic(tpz.msg.basic.EFFECTS_DISAPPEAR, pet, removed, removed)
    else
        target:messagePublic(tpz.msg.basic.NO_EFFECT, pet)
    end
    player:delStatusEffect(tpz.effect.LUX)

    return effectID
end
