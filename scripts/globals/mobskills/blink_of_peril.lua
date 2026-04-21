---------------------------------------------
--  Blink of Peril
--
--  Description: Unleashes a devastating gaze attack on a single target that sharply reduces HP and resets enmity.
--  Type: Physical
--  Utsusemi/Blink absorb: No
--  Range: Single Target
--  Notes: Very short range, easily evaded by walking away from it.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/magic")
require("scripts/globals/msg")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    if target:isFacing(mob) then
        local hpp = 0.95
        local dmg = MobThroatStabMove(mob, target, skill, hpp, tpz.attackType.PHYSICAL,tpz.damageType.NONE,MOBPARAM_IGNORE_SHADOWS)
        target:takeDamage(dmg, mob, tpz.attackType.NONE, tpz.damageType.NONE)
        if ((skill:getMsg() ~= tpz.msg.basic.SHADOW_ABSORB) and (dmg > 0)) then   target:tryInterruptSpell(mob, dmg) end
        mob:resetEnmity(target)
        return dmg
    else
        return skill:setMsg(tpz.msg.basic.SKILL_MISS)
    end
end