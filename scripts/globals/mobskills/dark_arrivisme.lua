---------------------------------------------
--  Dark Arrivisme
--
--  Description: Magic Dark damage.
-- Additional effect: Dispels 3 buffs, knockback, and gains a all Killer (intimidation) effect
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if mob:getHPP() > 50 then
        return 1
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 5
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, tpz.magic.ele.DARK, dmgmod, TP_NO_EFFECT, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)
    MobBuffMove(mob, tpz.effect.PROWESS_KILLER, 75, 0, 60)
    MobMultipleDispelMove(mob, target, skill, 3, tpz.magic.ele.DARK, tpz.effectFlag.DISPELABLE)
    return dmg
end
