-----------------------------------
-- Blade Kamu
-- Katana weapon skill
-- Skill Level: N/A
-- Delivers a earth elemental damage. Additional effect Magic Attack Down.
-- Durration varies with TP. Duration of effect varies with TP. Nagi: Aftermath effect varies with TP.
-- Effect lasts 60 seconds @ 100 TP, 90 seconds @ 200 TP, and 120 seconds @ 300 TP
-- Available only after completing the Unlocking a Myth (Ninja) quest.
-- Aligned with the Shadow Gorget, Thunder Gorget & Breeze Gorget.
-- Aligned with the Shadow Belt, Thunder Belt & Breeze Belt.
-- Element: None
-- Modifiers: STR:50%  INT:50%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
require("scripts/globals/aftermath")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftp100 = 2.5 params.ftp200 = 2.7 params.ftp300 = 3.0
    params.str_wsc = 0.0 params.dex_wsc = 0.4 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.4 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1.5 params.atk200 = 1.5 params.atk300 = 1.5
    params.hybridWS = true
    params.ele = tpz.magic.ele.EARTH
    params.skill = tpz.skill.KATANA
    params.includemab = true
	params.bonusmacc = 50
	params.enmityMult = 1.5

    if USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.6 params.int_wsc = 0.6
        params.atk100 = 1.3125; params.atk200 = 1.3125; params.atk300 = 1.3125
    end

    -- Apply Aftermath
    tpz.aftermath.addStatusEffect(player, tp, tpz.slot.MAIN, tpz.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.EARTH, 0)

    if damage > 0 and (target:hasStatusEffect(tpz.effect.ACCURACY_DOWN) == false) and resist >= 0.5 then
        local duration = tp / 1000 * 60
        target:delStatusEffect(tpz.effect.ACCURACY_BOOST)
        target:addStatusEffect(tpz.effect.ACCURACY_DOWN, 30, 0, duration * resist)
    end

	if damage > 0 then player:trySkillUp(target, tpz.skill.KATANA, tpHits+extraHits) end
	if damage > 0 then target:tryInterruptSpell(player, tpHits+extraHits) end

    return tpHits, extraHits, criticalHit, damage
end
