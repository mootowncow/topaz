-----------------------------------
-- Refulgent Arrow
-- Archery weapon skill
-- Skill level: 280
-- Delivers a twofold attack. Damage varies with TP. (Only 1 hit)
-- Aligned with the Aqua Gorget & Light Gorget.
-- Aligned with the Aqua Belt & Light Belt.
-- Element: None
-- Modifiers: STR: 60% http://www.bg-wiki.com/bg/Refulgent_Arrow
-- 100%TP    200%TP    300%TP
-- 3.00      4.25      7.00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------
-- TODO: Nether Blast style damage, only reduced by MDT or w/e and always does same damage never resists
function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 1
    params.ftp100 = 3.0 params.ftp200 = 4.25 params.ftp300 = 5.0
    params.str_wsc = 0.16 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.25 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.ftp100 = 3 params.ftp200 = 4.25 params.ftp300 = 7
        params.str_wsc = 0.6
    end

    local damage, criticalHit, tpHits, extraHits = doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
	if damage > 0 then player:trySkillUp(target, tpz.skill.ARCHERY, tpHits+extraHits) end

    return tpHits, extraHits, criticalHit, damage
end
