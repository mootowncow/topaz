---------------------------------------------------
-- String Shredder
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
    local numhits = 3
    local params = {}
    params.ftp100 = 1.5
    params.ftp200 = 1.5
    params.ftp300 = 1.5
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.5
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.attkMod = 1.36

    local damage = AutoPhysicalWeaponSkill(pet, target, skill, tpz.attackType.PHYSICAL, numhits, TP_CRIT_VARIES, params)
    dmg = AutoPhysicalFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, damage.hitslanded, params)

    return dmg
end
