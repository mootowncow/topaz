-----------------------------------
-- Gale Axe
-- Axe weapon skill
-- Skill level: 70
-- Chokes enemy. Duration of effect varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Breeze Gorget.
-- Aligned with the Breeze Belt.
-- Element: Wind
-- Modifiers: STR:30%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)
  
	local params = {}
    params.ftp100 = 1.5 params.ftp200 = 1.7 params.ftp300 = 2.0
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.3
    params.ele = tpz.magic.ele.WIND
    params.skill = tpz.skill.AXE
    params.includemab = true
	params.enmityMult = 0.5
	params.bonusmacc = 50

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.ftp300 = 3.75
        params.str_wsc = 0.4 params.int_wsc = 0.4
    end

    local damage, criticalHit, tpHits, extraHits = doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
	local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.WIND, 0)
    if damage > 0 and resist >= 0.5 then
        local duration = (tp/1000 * 30) + 60
        local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.WIND, params.bonusmacc, tpz.effect.CHOKE)
        if not target:hasStatusEffect(tpz.effect.CHOKE) and not target:hasStatusEffect(tpz.effect.FROST) then
            target:addStatusEffect(tpz.effect.CHOKE, 10, 3, duration * resist)
        end
	end
	if damage > 0 then player:trySkillUp(target, tpz.skill.AXE, tpHits+extraHits) end
	
    return tpHits, extraHits, criticalHit, damage
end
