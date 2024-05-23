-----------------------------------
-- Starburst
-- Staff weapon skill
-- Skill Level: 100
-- Deals light or darkness elemental damage. Damage varies with TP.
-- Aligned with the Shadow Gorget & Aqua Gorget.
-- Aligned with the Shadow Belt & Aqua Belt.
-- Element: Light/Dark (Random)
-- Modifiers: :    STR:40% MND:40%
-- 100%TP    200%TP    300%TP
-- 1.00      2.00      2.50
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftp100 = 1.5 params.ftp200 = 1.7 params.ftp300 = 2.0
    params.str_wsc = 0.0 params.dex_wsc = 0.0
    params.vit_wsc = 0.0 params.agi_wsc = 0.0
    params.int_wsc = 0.3 params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.skill = tpz.skill.STAFF
    params.includemab = true
	params.enmityMult = 0.5
	params.bonusmacc = 50
    -- 50/50 shot of being light or dark
    params.ele = tpz.magic.ele.LIGHT
    if math.random() < 0.5 then
        params.ele = tpz.magic.ele.DARK
    end

    if USE_ADOULIN_WEAPON_SKILL_CHANGES == true then
        params.str_wsc = 0.4 params.mnd_wsc = 0.4
    end

    local damage, criticalHit, tpHits, extraHits = doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
	if damage > 0 then player:trySkillUp(target, tpz.skill.STAFF, tpHits+extraHits) end
		
    return tpHits, extraHits, criticalHit, damage
end
