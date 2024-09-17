-----------------------------------
-- Spinning Slash
-- Great Sword weapon skill
-- Skill level: 225
-- Delivers a single-hit attack. Damage varies with TP.
-- Modifiers: STR:30%  INT:30%
-- 100%TP     200%TP     300%TP
-- 2.5         3        3.5
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------
function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 1
    params.ftp100 = 2.5 params.ftp200 = 3.0 params.ftp300 = 3.5
    params.str_wsc = 0.3 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.3 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1.5; params.atk200 = 1.5; params.atk300 = 1.5

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
		if damage > 0 then player:trySkillUp(target, tpz.skill.GREAT_SWORD, tpHits+extraHits) end
		if damage > 0 then target:tryInterruptSpell(player, tpHits+extraHits) end
    return tpHits, extraHits, criticalHit, damage
end
