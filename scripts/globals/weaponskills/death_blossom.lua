-----------------------------------
-- Death Blossom
-- Sword weapon skill (RDM main only)
-- Description: Delivers a threefold attack that lowers target's magic evasion. Chance of lowering target's magic evasion varies with TP. Murgleis: Aftermath effect varies with TP.
-- Lowers magic evasion by up to 10.
-- Effect lasts up to 55 seconds.
-- Available only after completing the Unlocking a Myth (Red Mage) quest.
-- Aligned with the Breeze Gorget, Thunder Gorget, Aqua Gorget & Snow Gorget.
-- Aligned with the Breeze Belt, Thunder Belt, Aqua Belt & Snow Belt.
-- Modifiers: STR:30%  MND:50%
-- 100%TP     200%TP      300%TP
--  4              4           4        new
-- 1.125      1.125      1.125        old

-- Changed to non-elemental magic damage!
-- 2.0 / 2.5 / 3.0 ftp
-- 100% MND WSC
-- MAB included
-- 100 bonus macc
-- -50% enmity
-----------------------------------
require("scripts/globals/aftermath")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/weaponskills")
-----------------------------------
function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftp100 = 2.0 params.ftp200 = 2.1 params.ftp300 = 2.3
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.5 params.chr_wsc = 0.0
    params.ele = tpz.magic.ele.NONE
    params.skill = tpz.skill.SWORD
    params.includemab = true
	params.enmityMult = 0.5
	params.bonusmacc = 100

    if USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftp100 = 4.0 params.ftp200 = 4.0 params.ftp300 = 4.0
    end

    -- Apply aftermath
    tpz.aftermath.addStatusEffect(player, tp, tpz.slot.MAIN, tpz.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
	if damage > 0 then player:trySkillUp(target, tpz.skill.SWORD, tpHits+extraHits) end
	

    local maccBonus = math.floor(MaccTPModifier(tp))
    local resist = applyResistanceAddEffect(player, target, tpz.magic.ele.THUNDER, maccBonus, tpz.effect.MAGIC_EVASION_DOWN)
    if (damage > 0) and (resist >= 0.5) then
        target:addStatusEffect(tpz.effect.MAGIC_EVASION_DOWN, 10, 0, 60 * resist)
    end

    return tpHits, extraHits, criticalHit, damage
end
