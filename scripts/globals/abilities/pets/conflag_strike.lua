---------------------------------------------------
-- Conflag Strike
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/summon")
require("scripts/globals/magic")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local params = {}
    params.multiplier = 5
    params.tp150 = 7
    params.tp300 = 9
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.3
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local effect = tpz.effect.MAGIC_DEF_DOWN
    local power = 30
    local duration = 60
    local subid = 0
    local subpower = 63
    local tier = 0
    local bonus = 0
    params.DOT = true

    local damage = AvatarMagicalBP(pet, target, skill, tpz.magic.ele.FIRE, params, INT_BASED, 0)
    dmg = AvatarMagicalFinalAdjustments(damage, pet, skill, target, tpz.attackType.BREATH, tpz.magic.ele.FIRE, params)
    AvatarStatusEffectBPSub(avatar, target, effect, power, duration, subid, subpower, tier, params, bonus)

    return dmg
end