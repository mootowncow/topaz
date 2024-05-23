-----------------------------------
-- Blade Yu
-- Katana weapon skill
-- Skill Level: 280
-- Delivers a water elemental attack. Additional effect Magic Attack Down. Durration varies with TP.
-- Aligned with the Aqua Gorget & Soil Gorget.
-- Aligned with the Aqua Belt & Soil Belt.
-- Element: Water
-- Modifiers: DEX:50%  INT:50%
-- 100%TP    200%TP    300%TP
-- 3.0      3.0      3.0
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.ftp100 = 2.0 params.ftp200 = 2.1 params.ftp300 = 2.3
    params.str_wsc = 0.0 params.dex_wsc = 0.5 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.ele = tpz.magic.ele.WATER
    params.skill = tpz.skill.KATANA
    params.includemab = true
	params.enmityMult = 0.5
	params.bonusmacc = 100

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.ftp100 = 3 params.ftp200 = 3 params.ftp300 = 3
        params.dex_wsc = 0.4 params.int_wsc = 0.4
    end

    local damage, criticalHit, tpHits, extraHits = doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.FIRE, 100, tpz.effect.MAGIC_ATK_DOWN)
    local duration = (75 + (tp/1000 * 15))
    duration = duration * resist

    if (damage > 0 and not target:hasStatusEffect(tpz.effect.MAGIC_ATK_DOWN) and resist >= 0.5) then
       target:addStatusEffect(tpz.effect.MAGIC_ATK_DOWN, 25, 0, duration)
    end

	if damage > 0 then player:trySkillUp(target, tpz.skill.KATANA, tpHits+extraHits) end
	
    return tpHits, extraHits, criticalHit, damage
end
