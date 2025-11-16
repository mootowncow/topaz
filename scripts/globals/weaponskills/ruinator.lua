-----------------------------------
-- Ruinator
-- Axe weapon skill
-- Skill level: 357
-- Description: Delivers a four-hit attack. params.accuracy varies with TP
-- In order to obtain Ruinator, the quest Martial Mastery must be completed.
-- This Weapon Skill's first hit params.ftp is duplicated for all additional hits
-- Aligned with the Aqua Gorget, Snow Gorget & Breeze Gorget
-- Aligned with the Aqua Belt, Snow Belt & Breeze Belt.
-- Element: None
-- Modifiers: STR:73~85%, depending on merit points upgrades.
-- 100%TP    200%TP    300%TP
-- 1.08       1.08      1.08
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 4
    params.ftp100 = 1.08 params.ftp200 = 1.08 params.ftp300 = 1.08
    params.str_wsc = 0.60 + (player:getMerit(tpz.merit.RUINATOR) / 100) params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.accuracyVariesWithTP = true
    params.atk100 = 1.1; params.atk200 = 1.1; params.atk300 = 1.1
    params.multiHitfTP = true

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.str_wsc = 0.7 + (player:getMerit(tpz.merit.RUINATOR) / 100)
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
	if IsWSDamageMessage(target, action) then player:trySkillUp(target, tpz.skill.AXE, tpHits+extraHits) end
	if IsWSDamageMessage(target, action) then target:tryInterruptSpell(player, tpHits+extraHits) end
    return tpHits, extraHits, criticalHit, damage

end
