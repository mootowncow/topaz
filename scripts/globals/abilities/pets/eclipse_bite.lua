---------------------------------------------------
-- Eclipse Bite
-- Three-hit attack
-- Additional Effect: 25/tick bleeding effect
-- Dispels Regen off the target.
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/summon")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local numhits = 3
    local ftp = 3
    local params = {}
    params.str_wsc = 0.0
    params.dex_wsc = 0.3
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.DOT = true
    params.ELEMENT_OVERRIDE = tpz.magic.ele.DARK

    local effect = tpz.effect.REGEN
    local power = -25
    local duration = 120
    local bonus = 0

    local damage = AvatarPhysicalBP(pet, target, skill, tpz.attackType.PHYSICAL, numhits, ftp, TP_DMG_BONUS, params)
    dmg = AvatarPhysicalFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, damage.hitslanded, params)
    target:delStatusEffectSilent(effect)
    AvatarPhysicalStatusEffectBP(pet, target, skill, effect, power, duration, params, bonus)

    return dmg
end
