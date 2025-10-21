-----------------------------------
-- Full Break
-- Great Axe weapon skill
-- Skill level: 225 (Warriors only.)
-- Lowers enemy's attack, defense, params.accuracy, and evasion. Duration of effect varies with TP.
-- Lowers attack and defense by 12.5%, evasion by 20 points, and estimated to also lower params.accuracy by 20 points.
-- These enfeebles are given as four seperate status effects, resists calculated seperately for each. They almost always wear off simultaneously, but have been observed to wear off at different times.
-- Strong against: Coeurls.
-- Immune: Antica, Cockatrice, Crawlers, Worms.
-- Will stack with Sneak Attack.
-- Aligned with the Aqua Gorget & Snow Gorget.
-- Aligned with the Aqua Belt & Snow Belt.
-- Element: Earth
-- Modifiers: STR:50%  VIT:50%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 1
    params.ftp100 = 1 params.ftp200 = 1 params.ftp300 = 1
    params.str_wsc = 0.5 params.dex_wsc = 0.0 params.vit_wsc = 0.5 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1
    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    local power1 = 25
    local power2 = 40
    local bonus = 25
    -- Imperial Bhuj Hidden Effect
    local gaxe = player:getEquipID(tpz.slot.MAIN)
	if gaxe == 18485 then -- Imperial Bhuj
        power1 = 30
        power2 = 50
        bonus = 50
    end

    if (damage > 0) then
        local duration = (tp/1000) * 180
        local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.WIND, bonus, tpz.effect.DEFENSE_DOWN)
        if (target:hasStatusEffect(tpz.effect.DEFENSE_DOWN) == false) and resist >= 0.5  then
            target:addStatusEffect(tpz.effect.DEFENSE_DOWN, power1, 0, duration * resist)
        end
        local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.WATER, bonus, tpz.effect.ATTACK_DOWN)
        if (target:hasStatusEffect(tpz.effect.ATTACK_DOWN) == false) and resist >= 0.5  then
            target:addStatusEffect(tpz.effect.ATTACK_DOWN, power1, 0, duration * resist)
        end
        local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.ICE, bonus, tpz.effect.EVASION_DOWN)
        if (target:hasStatusEffect(tpz.effect.EVASION_DOWN) == false) and resist >= 0.5  then
            target:addStatusEffect(tpz.effect.EVASION_DOWN, power2, 0, duration * resist)
        end
        local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.EARTH, bonus, tpz.effect.ACCURACY_DOWN)
        if (target:hasStatusEffect(tpz.effect.ACCURACY_DOWN) == false) and resist >= 0.5  then
            target:addStatusEffect(tpz.effect.ACCURACY_DOWN, power2, 0, duration * resist)
        end
    end

	if damage > 0 then player:trySkillUp(target, tpz.skill.GREAT_AXE, tpHits+extraHits) end
	if damage > 0 then target:tryInterruptSpell(player, tpHits+extraHits) end

    return tpHits, extraHits, criticalHit, damage
end
