-----------------------------------
-- Tartarus Torpor
-- Staff weapon skill
-- Skill Level: N/A
-- Puts to sleep enemies within the area of effect and lowers their magical defense and magical evasion. Duration of effect varies with TP.
-- Aligned with the Breeze Gorget, Thunder Gorget, Aqua Gorget & Snow Gorget.
-- Aligned with the Breeze Belt, Thunder Belt, Aqua Belt & Snow Belt.
-- Element: Darkness
-- Modifiers: STR: 30% INT:30% 
-- 100%TP    200%TP    300%TP
-- 1.75      1.75      1.75
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftp100 = 2.0 params.ftp200 = 2.1 params.ftp300 = 2.3
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.5
    params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.ele = tpz.magic.ele.DARK
    params.skill = tpz.skill.STAFF
    params.includemab = true
	params.enmityMult = 0.5
	params.bonusmacc = 100

    if USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.int_wsc = 0.8
    end

    local damage, criticalHit, tpHits, extraHits = doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
	if damage > 0 then player:trySkillUp(target, tpz.skill.STAFF, tpHits+extraHits) end
		
		
	local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.DARK, 50, tpz.effect.SLEEP_I)
    if damage > 0 and resist >= 0.5 then
        local duration = tp / 1000 * 60
        if not target:hasStatusEffect(tpz.effect.SLEEP_I) then
            target:addStatusEffect(tpz.effect.SLEEP_I, 10, 0, duration * resist)
        end
    end
	
	local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.LIGHTNING, 50, tpz.effect.MAGIC_DEF_DOWN)
    if damage > 0 and resist >= 0.5 then
        local duration = tp / 1000 * 60
        target:delStatusEffect(tpz.effect.MAGIC_DEF_BOOST)
        if not target:hasStatusEffect(tpz.effect.MAGIC_DEF_DOWN) then
            target:addStatusEffect(tpz.effect.MAGIC_DEF_DOWN, 10, 0, duration * resist)
        end
    end
	
	local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.LIGHTNING, 50, tpz.effect.MAGIC_EVASION_DOWN)
    if damage > 0 and resist >= 0.5 then
        local duration = tp / 1000 * 60
        if not target:hasStatusEffect(tpz.effect.MAGIC_EVASION_DOWN) then
            target:delStatusEffect(tpz.effect.MAGIC_EVASION_BOOST_II)
            target:addStatusEffect(tpz.effect.MAGIC_EVASION_DOWN, 10, 0, duration * resist)
        end
    end

    return tpHits, extraHits, criticalHit, damage
end
