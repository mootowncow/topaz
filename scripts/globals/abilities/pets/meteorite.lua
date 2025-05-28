---------------------------------------------------
-- Meteorite
-- 0 TP: 3.5 (5.375 at 75)
-- 1500 TP: 4 (8.16 at 75)
-- 3000 TP: 4.25 (10.5 at 75)
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
    local lvl = pet:getMainLvl()
    local params = {}
    params.multiplier = 3.5 + (lvl / 40) 
    params.tp150 = 4 + (lvl / 18) 
    params.tp300 = 4.25 + (lvl / 12) 
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.3
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = AvatarMagicalBP(pet, target, skill, tpz.magic.ele.LIGHT, params, INT_BASED, 0)
    dmg = AvatarMagicalFinalAdjustments(damage, pet, skill, target, tpz.attackType.MAGICAL, tpz.magic.ele.LIGHT, params)

    return dmg
end
