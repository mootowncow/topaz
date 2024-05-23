-----------------------------------
-- Flash Nova
-- Skill level: 280
-- Delivers light elemental damage. Additional effect: Flash. Chance of effect varies with TP.
-- Generates +100% enmity.
-- Does not stack with Sneak Attack
-- Aligned with Aqua Gorget.
-- Aligned with Aqua Belt.
-- Properties:
-- Element: Light
-- Skillchain Properties:Induration Reverberation
-- Modifiers: STR:50% MND:50%
-- Damage Multipliers by TP:
--     100%TP    200%TP     300%TP
--      3.00     3.00     3.00
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.ftp100 = 2.0 params.ftp200 = 2.1 params.ftp300 = 2.3
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.5 params.chr_wsc = 0.0
    params.ele = tpz.magic.ele.LIGHT
    params.skill = tpz.skill.CLUB
    params.includemab = true
	params.enmityMult = 2.0
	params.bonusmacc = 100

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.str_wsc = 0.5 params.mnd_wsc = 0.5
    end

    local damage, criticalHit, tpHits, extraHits = doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
	if damage > 0 then player:trySkillUp(target, tpz.skill.CLUB, tpHits+extraHits) end
	
    local maccBonus = math.floor(MaccTPModifier(tp) * 10) -- 100/200/300
    local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.LIGHT, maccBonus, tpz.effect.FLASH)
    if (dmg > 0 and not target:hasStatusEffect(tpz.effect.FLASH) and resist >= 0.5) then
        local duration = 12 * resist
        target:addStatusEffect(tpz.effect.FLASH, 300, 3, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end
