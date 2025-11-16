-----------------------------------
-- Shell Crusher
-- Staff weapon skill
-- Skill Level: 175
-- Lowers target's defense. Duration of effect varies with TP.
-- If unresisted, lowers target defense by 25%.
-- Will stack with Sneak Attack.
-- Aligned with the Breeze Gorget.
-- Aligned with the Breeze Belt.
-- Element: None
-- Modifiers: STR:100%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 5
    params.ftp100 = 1 params.ftp200 = 1 params.ftp300 = 1
    params.str_wsc = 0.5 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.str_wsc = 1.0
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
		if IsWSDamageMessage(target, action) then player:trySkillUp(target, tpz.skill.STAFF, tpHits+extraHits) end
		if IsWSDamageMessage(target, action) then target:tryInterruptSpell(player, tpHits+extraHits) end

	local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.WIND, 0, tpz.effect.DEFENSE_DOWN)
    if IsWSDamageMessage(target, action) and target:hasStatusEffect(tpz.effect.DEFENSE_DOWN) == false and resist >= 0.5 then
        local duration = (120 + (tp/1000 * 60))
        target:delStatusEffect(tpz.effect.DEFENSE_BOOST)
        target:addStatusEffect(tpz.effect.DEFENSE_DOWN, 25, 0, duration * resist)
    end
    return tpHits, extraHits, criticalHit, damage

end
