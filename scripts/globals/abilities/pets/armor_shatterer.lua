---------------------------------------------------
-- Armor Shatterer
---------------------------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/automatonweaponskills")

---------------------------------------------------

function onMobSkillCheck(target, automaton, skill)
    local master = automaton:getMaster()
    getAutoTP(master)
    return master:countEffect(tpz.effect.WIND_MANEUVER)
end

function onPetAbility(target, pet, skill)
    local numhits = 1
    local params = {}
    params.ftp100 = 6.0
    params.ftp200 = 6.0
    params.ftp300 = 6.0
    params.str_wsc = 0.0
    params.dex_wsc = 0.5
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.attkMod = 1.25

    local tp = pet:getLocalVar("TP")
    local effect = tpz.effect.DEFENSE_DOWN
    local power = 15
    local duration = 90
    local bonus = 200

    local damage = AutoPhysicalWeaponSkill(pet, target, skill, tpz.attackType.RANGED, numhits, TP_EFFECT_DURATION, params)
    local dmg = AutoPhysicalFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.RANGED, tpz.damageType.RANGED, damage.hitslanded, params)
    AutoPhysicalStatusEffectWeaponSkill(pet, target, skill, effect, power, duration, numhits, TP_EFFECT_DURATION, params, bonus, tp)

    return dmg
end