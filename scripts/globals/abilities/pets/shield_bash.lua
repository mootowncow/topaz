---------------------------------------------
--  Shield Bash
---------------------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/automatonweaponskills")

---------------------------------------------------

function onMobSkillCheck(target, pet, skill)
    return 0
end

function onPetAbility(target, pet, skill, master, action)
    local numhits = 1
    local params = {}
    params.ftp100 = 1.0
    params.ftp200 = 1.0
    params.ftp300 = 1.0
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.NO_TP_CONSUMPTION = true

    local tp = pet:getLocalVar("TP")
    local effect = tpz.effect.STUN
    local power = 1
    local duration = 6
    local bonus = 200

    local effect2 = tpz.effect.SLOW
    local power2 = pet:getMod(tpz.mod.AUTO_SHIELD_BASH_SLOW)
    local duration2 = 30
    local bonus2 = 200
    if (power2 == 1200) then
        duration = 30
    elseif (power2 == 2000) then
        duration = 60
    elseif (power2 == 2500) then
        duration = 75
    end

    local damage = AutoPhysicalWeaponSkill(pet, target, skill, tpz.attackType.PHYSICAL, numhits, TP_NONE, params)
    local dmg = AutoPhysicalFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, damage.hitslanded, params)
    AutoPhysicalStatusEffectWeaponSkill(pet, target, skill, effect, power, duration, numhits, TP_EFFECT_DURATION, params, bonus, tp)

    -- Add Hammermill Slow effect
    if (power2 > 0) then
        AutoPhysicalStatusEffectWeaponSkill(pet, target, skill, effect2, power2, duration2, numhits, TP_EFFECT_DURATION, params, bonus2, tp)
    end

    target:addEnmity(pet, 450, 900)

    -- Add Hammermill damage bonus
    dmg = math.floor(dmg * 1 + (pet:getMod(tpz.mod.SHIELD_BASH) / 100))

    return dmg
end
