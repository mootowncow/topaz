-----------------------------------
--
--     tpz.effect.WOTG_DUNGEONS
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------
-- onEffectGain Action
-----------------------------------
function onEffectGain(target, effect)
    target:addMod(tpz.mod.PAST_DUNGEON_MASTER, effect:getPower())

    if target:isPC() then
        local augmentModPower = target:getMod(tpz.mod.PAST_DUNGEON_MASTER) or 0
        target:PrintToPlayer("You will now gain more augments on your items! (Amount: " .. augmentModPower .. ", max 5)", tpz.msg.textColor.HIDDEN, none)
    end
end

-----------------------------------
-- onEffectTick Action
-----------------------------------

function onEffectTick(target, effect)
end

-----------------------------------
-- onEffectLose Action
-----------------------------------

function onEffectLose(target, effect)
    target:delMod(tpz.mod.PAST_DUNGEON_MASTER, effect:getPower())
end