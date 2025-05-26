---------------------------------------------------
-- Clarsach Call
-- Grants Siren Attack +25%, Defense +25%, Acuracy +25, Evasion +25 Magic Attack Bonus +25, Magic Defense Bonus +25, and Magic Evasion +25
-- Buff duration is 3 min.
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/summon")
---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill, master)
    local params = {}
    params.multiplier = 9
    params.tp150 = 9
    params.tp300 = 9
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.3
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = AvatarMagicalBP(pet, target, skill, tpz.magic.ele.WIND, params, INT_BASED, 0)
    dmg = AvatarMagicalFinalAdjustments(damage, pet, skill, target, tpz.attackType.MAGICAL, tpz.magic.ele.WIND, params)
    master:setMP(0)

    local effectsList =
    {
        tpz.effect.ATTACK_BOOST, tpz.effect.DEFENSE_BOOST,
        tpz.effect.ACCURACY_BOOST, tpz.effect.EVASION_BOOST,
        tpz.effect.MAGIC_ATK_BOOST, tpz.effect.MAGIC_DEF_BOOST,
        tpz.effect.MAGIC_EVASION_BOOST_II
    }

    for _, effect in pairs (effectsList) do
        pet:addStatusEffect(effect, 25, 0, 180)
    end

    return dmg
end
