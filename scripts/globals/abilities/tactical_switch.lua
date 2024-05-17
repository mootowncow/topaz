-----------------------------------
-- Ability: Tactical Switch
-- Description: Grants your TP to your automaton.
-- Obtained: PUP Level 40
-- Recast Time: 00:01:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if not player:getPet() then
        return tpz.msg.basic.REQUIRES_A_PET, 0
    elseif not player:getPetID() or not (player:getPetID() >= 69 and player:getPetID() <= 72) then
        return tpz.msg.basic.PET_CANNOT_DO_ACTION, 0
    end
    return 0, 0
end

function onUseAbility(player, target, ability)
    local buffTable = {
        { Maneuver = tpz.effect.FIRE_MANEUVER,      Effect = tpz.effect.MULTI_STRIKES,   Power = 100 },
        { Maneuver = tpz.effect.ICE_MANEUVER,       Effect = tpz.effect.MAGIC_ATK_BOOST, Power = 30  },
        { Maneuver = tpz.effect.WIND_MANEUVER,      Effect = tpz.effect.DOUBLE_SHOT,     Power = 100 },
        { Maneuver = tpz.effect.EARTH_MANEUVER,     Effect = tpz.effect.REPRISAL,        Power = 33  },
        { Maneuver = tpz.effect.THUNDER_MANEUVER,   Effect = tpz.effect.POTENCY,         Power = 100 },
        { Maneuver = tpz.effect.WATER_MANEUVER,     Effect = tpz.effect.MAGIC_DEF_BOOST, Power = 70  },
        { Maneuver = tpz.effect.LIGHT_MANEUVER,     Effect = tpz.effect.GEO_REGEN,       Power = 100 },
        { Maneuver = tpz.effect.DARK_MANEUVER,      Effect = tpz.effect.INTENSION,       Power = 15  },
    }
    local pet = player:getPet()
    local returnBuff = tpz.effect.NONE

    -- Apply buffs to pet
    for _, buffs in ipairs(buffTable) do
        if player:hasStatusEffect(buffs.Maneuver) then
            local power = buffs.Power
            local duration = player:countEffect(buffs.Maneuver) * 10
            local tick = 0
            if (buffs.Power == tpz.effect.REGEN) then
                tick = 3
            end
            local subpower = 0
            if (buffs.Effect == tpz.effect.REPRISAL) then
                subpower = pet:getMaxHP() * 0.5
            end
            returnBuff = buffs.Effect
            pet:addStatusEffect(buffs.Effect, power, tick, duration, 0, subpower)
        end
    end

    -- Remove all stacks of maneuvers from the player
    for v = tpz.effect.FIRE_MANEUVER, tpz.effect.DARK_MANEUVER do
        while player:hasStatusEffect(v) do
            player:delStatusEffect(v)
        end
    end

    return returnBuff
end
