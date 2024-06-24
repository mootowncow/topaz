---------------------------------------------
--  Feral Peck
--
--  Description: Reduces targets' HP within a frontal cone by 90% and resets enmity of those hit.
--  Type: Physical
--  Utsusemi/Blink absorb: No
--  Range: Frontal Cone
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/magic")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    local result = 1
    if (mob:getPool() == 5869) then -- Only used by certain NM's
	    if not target:isInfront(mob, 90) then
            result = 1
        else
            result = 0
        end
    end
    return result
end


function onMobWeaponSkill(target, mob, skill)
    local hpp = 0.95
    local dmg = MobThroatStabMove(mob, target, skill, hpp, tpz.attackType.PHYSICAL,tpz.damageType.NONE,MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.NONE)
    if ((skill:getMsg() ~= tpz.msg.basic.SHADOW_ABSORB) and (dmg > 0)) then   target:tryInterruptSpell(mob, dmg) end
    if (MobPhysicalHit(mob, skill)) then
        mob:resetEnmity(target)
    end
    return dmg
end

