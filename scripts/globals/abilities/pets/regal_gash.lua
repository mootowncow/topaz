---------------------------------------------------
-- Regal Gash
-- Piercing
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
    local ftp = 5
    local params = {}
    params.str_wsc = 0.2
    params.dex_wsc = 0.2
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local effect = tpz.effect.DEFENSE_DOWN
    local power = 12
    local duration = 60
    local bonus = 100

    local damage = AvatarPhysicalBP(pet, target, skill, tpz.attackType.PHYSICAL, numhits, ftp, TP_ACC_BONUS, params)
    dmg = AvatarPhysicalFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, damage.hitslanded, params)
    AvatarPhysicalStatusEffectBP(pet, target, skill, effect, power, duration, params, bonus)

    return dmg
end