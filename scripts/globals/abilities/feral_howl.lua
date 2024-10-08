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
    local effect = tpz.effect.TERROR
    local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.EARTH, bonusAcc, tpz.effect.NONE, skill)

    if isNoEffectMsg(player, target, effect, params) then
        return ability:setMsg(tpz.msg.basic.JA_NO_EFFECT_2)
    end

    -- Half duration on NMs
    if target:isNM() then
        duration = duration * 0.5
    end
    if (resist >= 0.5) then
        target:addStatusEffect(effect, 1, 0, duration)
        ability:setMsg(tpz.msg.basic.JA_ENFEEB_IS)
    else
        ability:setMsg(tpz.msg.basic.JA_NO_EFFECT_2)
    end

    return effect
end
