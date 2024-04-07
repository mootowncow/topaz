---------------------------------------------------
-- Ability: Feral Howl
-- Terrorizes the target.
-- Obtained: Beastmaster Level 75 (Merits)
-- Recast Time: 00:01:30
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local duration = 30 + player:getMod(tpz.mod.FERAL_HOWL_DURATION)
    local bonusAcc = (player:getMerit(tpz.merit.FERAL_HOWL) * 5) - 5
    local skill = player:getWeaponSkillType(tpz.slot.MAIN)
    local resist = applyResistanceAbility(player, target, tpz.magic.ele.EARTH, skill, bonusAcc)

    -- Half duration on NMs
    if target:isNM() then
        duration = duration * 0.5
    end
    if (resist >= 0.5) and not target:hasStatusEffect(tpz.effect.TERROR) and not target:hasStatusEffect(tpz.effect.STUN) then
        target:addStatusEffect(tpz.effect.TERROR, 1, 0, duration)
        ability:setMsg(tpz.msg.basic.JA_ENFEEB_IS)
    else
        ability:setMsg(tpz.msg.basic.JA_NO_EFFECT_2)
    end

    return tpz.effect.TERROR
end
