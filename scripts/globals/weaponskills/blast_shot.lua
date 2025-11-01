-----------------------------------
-- Blast Shot
-- Marksmanship weapon skill
-- Skill Level: 200
-- Delivers a melee-distance ranged attack. Defense ignore varies with TP.
-- Aligned with the Snow Gorget & Light Gorget.
-- Aligned with the Snow Belt & Light Belt.
-- Element: None
-- Modifiers: AGI:30%
-- 100%TP    200%TP    300%TP
-- 2.00      2.00      2.00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 1
    params.ftp100 = 2 params.ftp200 = 2.3 params.ftp300 = 2.7
    params.str_wsc = 0.5 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1
	params.ignoresDef = true
    params.ignored100 = 0.50
    params.ignored200 = 0.50
    params.ignored300 = 0.50

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.agi_wsc = 0.7
    end

    local damage, criticalHit, tpHits, extraHits = doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
	if IsWSDamageMessage(target, action) then player:trySkillUp(target, tpz.skill.MARKSMANSHIP, tpHits+extraHits) end

    return tpHits, extraHits, criticalHit, damage
end
