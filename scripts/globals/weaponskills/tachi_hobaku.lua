-----------------------------------
-- Tachi Hobaku
-- Great Katana weapon skill
-- Skill Level: 30
-- Stuns enemy. Chance of stun varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Snow Gorget.
-- Aligned with the Snow Belt.
-- Element: None
-- Modifiers: STR:60%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 1
    params.ftp100 = 1.8 params.ftp200 = 1.8 params.ftp300 = 1.8
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.35 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.str_wsc = 0.6
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
	if IsWSDamageMessage(target, action) then player:trySkillUp(target, tpz.skill.GREAT_KATANA, tpHits+extraHits) end
	if IsWSDamageMessage(target, action) then target:tryInterruptSpell(player, tpHits+extraHits) end
    jobUtil.AddIgnisRune(player, damage)

    local maccBonus = math.floor(MaccTPModifier(tp))
    local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.THUNDER, maccBonus, tpz.effect.STUN)
    if IsWSDamageMessage(target, action)) and not target:hasStatusEffect(tpz.effect.STUN) and (resist >= 0.5) then
        local duration = 12 * resist
        target:addStatusEffect(tpz.effect.STUN, 1, 0, duration)
    end
    return tpHits, extraHits, criticalHit, damage
end
