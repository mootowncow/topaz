-----------------------------------
-- Impulse Drive
-- Polearm weapon skill
-- Skill Level: 240
-- Delivers a two-hit attack. Damage varies with TP.
-- In order to obtain Impulse Drive, the quest Methods Create Madness must be completed.
-- Will stack with Sneak Attack.
-- Aligned with the Shadow Gorget, Soil Gorget & Snow Gorget.
-- Aligned with the Shadow Belt, Soil Belt & Snow Belt.
-- Element: None
-- Modifiers: STR:50%
-- 100%TP    200%TP    300%TP
-- 1.00      1.50      2.50
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 2
    params.ftp100 = 1.0 params.ftp200 = 3.0 params.ftp300 = 3.5
    params.str_wsc = 0.6 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.ftp200 = 3 params.ftp300 = 5.5
        params.str_wsc = 1.0
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
	if IsWSDamageMessage(target, action) then player:trySkillUp(target, tpz.skill.POLEARM, tpHits+extraHits) end
	if IsWSDamageMessage(target, action) then target:tryInterruptSpell(player, tpHits+extraHits) end
    jobUtil.AddIgnisRune(player, damage)

    return tpHits, extraHits, criticalHit, damage

end
