-- Aeolian Edge
-- Dagger weapon skill
-- Delivers an area attack that deals wind elemental damage. Damage varies with TP.
-- Skill Level: 280
-- Aligned with the Breeze Gorget, Soil Gorget & Thunder Gorget.
-- Aligned with the Breeze Belt, Soil Belt & Thunder Belt.
-- Element: Wind
-- Skillchain Properties: Impaction / Scission / Detonation
-- Modifiers: DEX:40% INT:40%
-- 100%TP    200%TP    300%TP
-- 2.0      3.0       4.5
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.ftp100 = 2.0 params.ftp200 = 2.1 params.ftp300 = 2.3
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.5 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.ele = tpz.magic.ele.WIND
    params.skill = tpz.skill.DAGGER
    params.includemab = true
	params.bonusmacc = 100
    params.aoe = true

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.ftp100 = 2 params.ftp200 = 3 params.ftp300 = 4.5 -- https://www.bg-wiki.com/bg/Aeolian_Edge
        params.dex_wsc = 0.4 params.int_wsc = 0.4
    end

    local damage, criticalHit, tpHits, extraHits = doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
	if damage > 0 then player:trySkillUp(target, tpz.skill.DAGGER, tpHits+extraHits) end
	

    return tpHits, extraHits, criticalHit, damage
end
