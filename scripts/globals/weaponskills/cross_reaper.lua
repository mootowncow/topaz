-----------------------------------
-- Cross Reaper
-- Scythe weapon skill
-- Skill level: 225
-- Delivers a two-hit attack. Damage varies with TP.
-- Modifiers: STR:30%  MND:30%
-- 100%TP     200%TP     300%TP
-- 2.0         2.25    2.5
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
------------------------------------
function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftp100 = 1.0 params.ftp200 = 1.5 params.ftp300 = 2.0
    params.str_wsc = 0.5 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.5 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200=0.0 params.crit300=0.0
    params.canCrit = false
    params.acc100 = 0 params.acc200=0 params.acc300=0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.ftp100 = 2.0 params.ftp200 = 4.0 params.ftp300 = 7.0
        params.str_wsc = 0.6 params.mnd_wsc = 0.6
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
		if damage > 0 then player:trySkillUp(target, tpz.skill.SCYTHE, tpHits+extraHits) end
		if damage > 0 then target:tryInterruptSpell(player, tpHits+extraHits) end
    return tpHits, extraHits, criticalHit, damage
end
