-----------------------------------
-- Refulgent Arrow
-- Archery weapon skill
-- Skill level: 280
-- Delivers a magical attack that deals Light damage. Unresistable.
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

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftp100 = 2.0 params.ftp200 = 2.1 params.ftp300 = 2.3
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.5 params.int_wsc = 0.0
    params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.ele = tpz.magic.ele.LIGHT
    params.skill = tpz.skill.ARCHERY
    params.includemab = true
    params.noResist = true
	params.enmityMult = 0.5
    params.bonusmacc = 100

    if USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftp200 = 6.7 params.ftp300 = 10.0
        params.agi_wsc = 1.0
    end

    -- Apply Aftermath
    tpz.aftermath.addStatusEffect(player, tp, tpz.slot.RANGED, tpz.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
	if IsWSDamageMessage(target, action) then player:trySkillUp(target, tpz.skill.ARCHERY, tpHits+extraHits) end

    return tpHits, extraHits, criticalHit, damage
end
