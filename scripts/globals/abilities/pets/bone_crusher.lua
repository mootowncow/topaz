---------------------------------------------------
-- Bone Crusher
---------------------------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/automatonweaponskills")

---------------------------------------------------

function onMobSkillCheck(target, automaton, skill)
    local master = automaton:getMaster()
    getAutoTP(master)
    return master:countEffect(tpz.effect.LIGHT_MANEUVER)
end

function onPetAbility(target, pet, skill)
    local numhits = 3
    local params = {}
    params.ftp100 = 1.66
    params.ftp200 = 1.66
    params.ftp300 = 1.66
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.6
    params.agi_wsc = 0.0
    params.int_wsc = 0.0 
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local tp = pet:getLocalVar("TP")
    local effect = tpz.effect.STUN
    local power = 1
    local duration = 12
    local bonus = 0

    -- +1.0 fTP vs Undead
    if target:isUndead() then
        params.ftp100 = 2.66
        params.ftp200 = 2.66
        params.ftp300 = 2.66
    end

    local damage = AutoPhysicalWeaponSkill(pet, target, skill, tpz.attackType.PHYSICAL, numhits, TP_NONE, params)
    dmg = AutoPhysicalFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, damage.hitslanded, params)
    AutoPhysicalStatusEffectWeaponSkill(pet, target, skill, effect, power, duration, numhits, TP_DMG_BONUS, params, bonus, tp)

    return dmg
end
