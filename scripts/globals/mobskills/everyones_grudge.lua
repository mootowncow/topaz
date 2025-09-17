---------------------------------------------
--  Everyones Grudge
--
--  Notes: Invokes collective hatred to spite a single target.
--   Damage done is 5x the amount of tonberries you have killed! For NM's using this it is 50 x damage.
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local realDmg = 0
    local grudgeVar = target:getCharVar("EVERYONES_GRUDGE_KILLS")

    if target:isPet() or target:isTrust() then
        local master = target:getMaster()
        if master:isPC() then
            grudgeVar = master:getCharVar("EVERYONES_GRUDGE_KILLS")
        end
    end

    if target:isAlly() then
        grudgeVar = 50
    end

    realDmg = grudgeVar

    local dmg = MobFinalAdjustments(realDmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL)

    return dmg
end
