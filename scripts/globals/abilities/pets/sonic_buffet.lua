---------------------------------------------------
-- Sonic Buffet
-- Additional effect: Dispel
-- Wind alligned dispel
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
    params.multiplier = 8.203125
    params.tp150 = 9.203125
    params.tp300 = 10.703125
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.3
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.IGNORES_SHADOWS = true

    local damage = AvatarMagicalBP(pet, target, skill, tpz.magic.ele.WIND, params, INT_BASED, 0)
    dmg = AvatarMagicalFinalAdjustments(damage, pet, skill, target, tpz.attackType.MAGICAL, tpz.magic.ele.WIND, params)
    AvatarDispelMove(pet, target, skill, tpz.magic.ele.WIND, tpz.effectFlag.DISPELABLE)

    return dmg
end
