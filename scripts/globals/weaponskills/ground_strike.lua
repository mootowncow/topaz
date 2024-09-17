-----------------------------------
-- Ground Strike
-- Great Sword weapon skill
-- Skill level: 250 QUESTED
-- Delivers a single-hit attack. Damage varies with TP.
-- Modifiers: STR:50% INT:50%
-- 100%TP     200%TP     300%TP
-- 1.5         1.75    3.0
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------
function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 1
    params.ftp100 = 2.0 params.ftp200 = 2.2 params.ftp300 = 2.5
    params.str_wsc = 0.5 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.5 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1.75; params.atk200 = 1.75; params.atk300 = 1.75

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
		if damage > 0 then player:trySkillUp(target, tpz.skill.GREAT_SWORD, tpHits+extraHits) end
		if damage > 0 then target:tryInterruptSpell(player, tpHits+extraHits) end
    return tpHits, extraHits, criticalHit, damage
end
