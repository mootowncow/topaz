---------------------------------------------------
-- Double Slap M=6, 2 (still guessing here)
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/summon")
require("scripts/globals/summon")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local numhits = 2
    local ftp = 3.6640625
    local params = {}
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.3

    local damage = AvatarPhysicalBP(pet, target, skill, tpz.attackType.PHYSICAL, numhits, ftp, TP_CRIT_VARIES, params) -- TP_ACC_BONUS in retail but it sucks!
    dmg = AvatarPhysicalFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, damage.hitslanded, params)

    return dmg
end