-----------------------------------
-- Exenterator
-- Skill level: 357
-- Terpsichore: Aftermath effect varies with TP.
-- In order to obtain Exenterator, the quest Martial Mastery must be completed.
-- Description: Delivers a fourfold attack that lowers enemy's params.accuracy. Effect duration varies with TP.
-- Aligned with the Breeze Gorget, Thunder Gorget & Soil Gorget.
-- Aligned with the Breeze Belt, Thunder Belt & Soil Belt.
-- Notes: Stacks with itself allowing continuous params.acc down
-- params.acc down isn't the same as the spell Blind or sources which are the same as blind allowing both to stack
-- Element: None
-- Modifiers: AGI:73~85%, depending on merit points upgrades.
-- 100%TP    200%TP    300%TP
-- 1.0        1.0       1.0
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 4
    params.ftp100 = 1.5 params.ftp200 = 1.5 params.ftp300 = 1.5
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.60 + (player:getMerit(tpz.merit.EXENTERATOR) / 100) params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1.25; params.atk200 = 1.25; params.atk300 = 1.25
    params.multiHitfTP = true

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.agi_wsc = 0.7 + (player:getMerit(tpz.merit.EXENTERATOR) / 100)
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
	if IsWSDamageMessage(target, action) then player:trySkillUp(target, tpz.skill.DAGGER, tpHits+extraHits) end
	if IsWSDamageMessage(target, action) then target:tryInterruptSpell(player, tpHits+extraHits) end


    local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.EARTH, 0, tpz.effect.ACCURACY_DOWN)
    if IsWSDamageMessage(target, action) and not target:hasStatusEffect(tpz.effect.ACCURACY_DOWN) and resist >= 0.5) then
        local duration = tp / 1000 * 60
        target:delStatusEffect(tpz.effect.ACCURACY_BOOST)
        target:addStatusEffect(tpz.effect.ACCURACY_DOWN, 30, 0, duration * resist)
    end

    return tpHits, extraHits, criticalHit, damage
end
