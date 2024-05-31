-------------------------------
-- Skill: Tornado Kick
-- Class: H2H Weapon Skill
-- Level: 280
-- Mods : STR:40% VIT:40%
-- 100%TP   200%TP  300%TP
-- 1.5      1.7    2.0
-- Delivers a threefold attack. Damage varies with TP
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 3
    params.ftp100 = 0.5 params.ftp200 = 0.5 params.ftp300 = 0.5
    params.str_wsc = 0.25 params.dex_wsc = 0.0 params.vit_wsc = 0.25 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.15 params.crit200 = 0.25 params.crit300 = 0.40
    params.canCrit = true
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1
    params.kick = true -- https://www.bluegartr.com/threads/112776-Dev-Tracker-Findings-Posts-%28NO-DISCUSSION%29?p=6712150&viewfull=1#post6712150

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.ftp100 = 2.0 params.ftp200 = 3.875 params.ftp300 = 7.0
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
	if damage > 0 then player:trySkillUp(target, tpz.skill.HAND_TO_HAND, tpHits+extraHits) end
	if damage > 0 then target:tryInterruptSpell(player, tpHits+extraHits) end
	return tpHits, extraHits, criticalHit, damage
end
