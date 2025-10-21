-----------------------------------
-- Armor Break
-- Great Axe weapon skill
-- Skill level: 100
-- Lowers enemy's defense. Duration of effect varies with TP.
-- Lowers defense by as much as 25% if unresisted.
-- Strong against: Antica, Bats, Cockatrice, Dhalmel, Lizards, Mandragora, Worms.
-- Immune: Ahriman.
-- Will stack with Sneak Attack.
-- Aligned with the Thunder Gorget.
-- Aligned with the Thunder Belt.
-- Element: Wind
-- Modifiers: STR:20%  VIT:20%
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
    params.str_wsc = 0.2 params.dex_wsc = 0.0 params.vit_wsc = 0.2 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
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

    if (damage > 0) then
        -- Try to apply Defense Down
        local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.WIND, bonus, tpz.effect.DEFENSE_DOWN, tpz.skill.GREAT_AXE)
        if not target:hasStatusEffect(tpz.effect.DEFENSE_DOWN) and (resist >= 0.5) then
            local duration = (120 + (tp/1000 * 60))
            target:addStatusEffect(tpz.effect.DEFENSE_DOWN, power, 0, duration * resist)
        end

        -- Try to apply Crit Hit Evasion Down
        local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.EARTH, bonus, tpz.effect.CRIT_HIT_EVASION_DOWN, tpz.skill.GREAT_AXE)
        if not target:hasStatusEffect(tpz.effect.CRIT_HIT_EVASION_DOWN) and (resist >= 0.5) then
            local duration = (120 + (tp/1000 * 60))
            target:addStatusEffect(tpz.effect.CRIT_HIT_EVASION_DOWN, power / 5, 0, duration * resist)
        end
    end

	if damage > 0 then player:trySkillUp(target, tpz.skill.GREAT_AXE, tpHits+extraHits) end
	if damage > 0 then target:tryInterruptSpell(player, tpHits+extraHits) end

    return tpHits, extraHits, criticalHit, damage
end
