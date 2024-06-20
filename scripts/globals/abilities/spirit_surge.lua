-----------------------------------
-- Ability: Spirit Surge
-- Adds your wyvern's strength to your own.
-- Obtained: Dragoon Level 1
-- Recast Time: 1:00:00
-- Duration: 1:00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/job_util")
-----------------------------------

function onAbilityCheck(player, target, ability)
    -- Cannot use with zero runes
    local Runes = player:getLocalVar("UndaRunes")
    if Runes < 3 then
        return tpz.msg.basic.CANNOT_PERFORM_ACTION, 0
    end
    -- The wyvern must be present in order to use Spirit Surge
   if (player:getPet() == nil) then
        return tpz.msg.basic.REQUIRES_A_PET, 0
   elseif (player:getPetID() ~= tpz.pet.id.WYVERN) then
      return tpz.msg.basic.NO_EFFECT_ON_PET, 0
   else
      return 0, 0
   end
end

function onUseAbility(player, target, ability)
   jobUtil.ConsumeUndaRune(player, target, tpz.effect.SPIRIT_SURGE, 10)
end
