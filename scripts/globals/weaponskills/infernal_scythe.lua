-----------------------------------
-- Infernal Scythe
-- Scythe weapon skill
-- Skill Level: 280
-- Deals darkness elemental damage and burns target.
-- Attack Down effect is -25% attack.
-- Aligned with the Shadow Gorget & Aqua Gorget.
-- Aligned with the Shadow Belt & Aqua Belt.
-- Element: None
-- Modifiers: STR: 30% INT: 70%
-- 100%TP    200%TP    300%TP
-- 3.50        3.50      3.50
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.ftp100 = 2.0 params.ftp200 = 2.1 params.ftp300 = 2.3
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.5 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.ele = tpz.magic.ele.DARK
    params.skill = tpz.skill.SCYTHE
    params.includemab = true
	params.enmityMult = 0.5
	params.bonusmacc = 100

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.int_wsc = 0.7
    end

    local damage, criticalHit, tpHits, extraHits = doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
	local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.FIRE, 0)
    if damage > 0 and resist >= 0.5 then
        local duration = (tp/1000 * 30) + 60
        local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.FIRE, params.bonusmacc, tpz.effect.BURN)
        if not target:hasStatusEffect(tpz.effect.BURN) and not target:hasStatusEffect(tpz.effect.DROWN) then
            target:addStatusEffect(tpz.effect.BURN, 33, 3, duration * resist)
        end
	end
	if IsWSDamageMessage(target, action) then player:trySkillUp(target, tpz.skill.SCYTHE, tpHits+extraHits) end

    return tpHits, extraHits, criticalHit, damage
end
