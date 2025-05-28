---------------------------------------------------
-- Level ?(1) Holy
-- 0 TP: 2.0
-- 1500 TP: 2.5
-- 3000 TP: 3.0
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/summon")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    getAvatarTP(player)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local params = {}
    params.multiplier = 2.0
    params.tp150 = 2.5
    params.tp300 = 3.0
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.3
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = AvatarMagicalBP(pet, target, skill, tpz.magic.ele.LIGHT, params, MND_BASED, 0)
    dmg = AvatarMagicalFinalAdjustments(damage, pet, skill, target, tpz.attackType.MAGICAL, tpz.magic.ele.LIGHT, params)

    return dmg
end
