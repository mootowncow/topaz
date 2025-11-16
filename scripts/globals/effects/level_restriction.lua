-----------------------------------
--
--     tpz.effect.LEVEL_RESTRICTION
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------

function onEffectGain(target, effect)
    target:levelRestriction(effect:getPower())
    target:messageBasic(tpz.msg.basic.LEVEL_RESTRICTED, effect:getPower(), 0, 0, false) -- <target>'s level is restricted to <param>

    if target:getObjType() == tpz.objType.PC then
        target:clearTrusts()
    end
    -- When level restriction status is inflicted upon a player, all of that player's positive magical effects are removed.
    -- Some buffs, such as Signet/Sanction/Sigil, Dedication, equipment-gained Reraise, and food aren't removed.
    -- There are some very rare cases where the restriction removes no buffs at all, such as during All by Myself,
    -- Eco-Warrior, and all "Trial-Size" avatar fights.
    -- https://ffxiclopedia.fandom.com/wiki/Level_Restriction
    local effects = target:getStatusEffects()

    for i, effect in ipairs(effects) do
        -- check mask bit for tpz.effectFlag.DISPELABLE
        if (utils.mask.getBit(effect:getFlag(), 0) and effect:getType() ~= tpz.effect.RERAISE) then
            target:delStatusEffectSilent(effect:getType())
        end
    end
end


function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:levelRestriction(0)
    if target:getObjType() == tpz.objType.PC then
        target:clearTrusts()
    end
end
