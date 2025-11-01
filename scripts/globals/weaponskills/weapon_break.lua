-----------------------------------
-- Weapon Break
-- Great Axe weapon skill
-- Skill level: 175
-- Lowers enemy's attack. Duration of effect varies with TP.
-- Lowers attack by 25% and weapon damage by 25.
-- Strong against: Manticores, Orcs, Rabbits, Raptors, Sheep.
-- Immune: Crabs, Crawlers, Funguars, Quadavs, Pugils, Sahagin, Scorpion.
-- Will stack with Sneak Attack.
-- Aligned with the Thunder Gorget.
-- Aligned with the Thunder Belt.
-- Element: Water
-- Modifiers: STR:60%  VIT:60%
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
    params.str_wsc = 0.32 params.dex_wsc = 0.0 params.vit_wsc = 0.32 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.str_wsc = 0.6 params.vit_wsc = 0.6
    end

    local power = 25
    local bonus = 25
    -- Imperial Bhuj Hidden Effect
    local gaxe = player:getEquipID(tpz.slot.MAIN)
	if gaxe == 18485 then -- Imperial Bhuj
        power = 30
        bonus = 50
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.WATER, bonus, tpz.effect.ATTACK_DOWN)
    if IsWSDamageMessage(target, action) and target:hasStatusEffect(tpz.effect.ATTACK_DOWN) == false) and resist >= 0.5  then
        local duration = (120 + (tp/1000 * 60))
        target:addStatusEffect(tpz.effect.ATTACK_DOWN, power, 0, duration * resist, 0, power, 0)
    end
	if IsWSDamageMessage(target, action) then player:trySkillUp(target, tpz.skill.GREAT_AXE, tpHits+extraHits) end
	if IsWSDamageMessage(target, action) then target:tryInterruptSpell(player, tpHits+extraHits) end

    return tpHits, extraHits, criticalHit, damage
end
