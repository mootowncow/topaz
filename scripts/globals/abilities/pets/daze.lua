---------------------------------------------------
-- Daze
---------------------------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/automatonweaponskills")

---------------------------------------------------

function onMobSkillCheck(target, automaton, skill)
    local master = automaton:getMaster()
    getAutoTP(master)
    return master:countEffect(tpz.effect.THUNDER_MANEUVER)
end

function onPetAbility(target, pet, skill)
    local numhits = 1
    local params = {}
    params.ftp100 = 6.0 -- 6.0
    params.ftp200 = 6.5 -- 8.5
    params.ftp300 = 7.0 -- 11.0
    params.str_wsc = 0.0
    params.dex_wsc = 0.6
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.accBonus = 50

    local tp = pet:getLocalVar("TP")
    local effect = tpz.effect.STUN
    local power = 1
    local duration = 12
    local bonus = 0

    local damage = AutoPhysicalWeaponSkill(pet, target, skill, tpz.attackType.RANGED, numhits, TP_DMG_BONUS, params)
    dmg = AutoPhysicalFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.RANGED, tpz.damageType.RANGED, damage.hitslanded, params)
    AutoPhysicalStatusEffectWeaponSkill(pet, target, skill, effect, power, duration, numhits, TP_DMG_BONUS, params, bonus, tp)

    return dmg
end
