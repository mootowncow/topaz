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

    local chance = 75
    local stunEEM = target:getMod(tpz.mod.EEM_STUN)

    if (pet:getMod(tpz.mod.SHIELD_BASH) > 0) then -- 100% chance to stun if Hammermill is equipped
        chance = 100
    end

    if
        (math.random() * 100 <= chance) and
        not target:hasStatusEffect(tpz.effect.STUN) and
        (stunEEM > 5)
    then
        target:addStatusEffect(tpz.effect.STUN, 1, 0, 6)
    end

    local slowPower = pet:getMod(tpz.mod.AUTO_SHIELD_BASH_SLOW)
    if slowPower > 0 then
        local duration = 30
        if slowPower == 12 then
            duration = 30
        elseif slowPower == 19 then
            duration = 60
        elseif slowPower == 25 then
            duration = 90
        end
        target:addStatusEffect(tpz.effect.SLOW, slowPower * 100, 0, duration)
    end

    local damage = AutoPhysicalWeaponSkill(pet, target, skill, tpz.attackType.PHYSICAL, numhits, TP_NONE, params)
    dmg = AutoPhysicalFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, damage.hitslanded, params)
    target:addEnmity(pet, 450, 900)

    -- Add Hammermill damage bonus
    dmg = math.floor(dmg * 1 + (pet:getMod(tpz.mod.SHIELD_BASH) / 100))

    return dmg
end
