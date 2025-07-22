---------------------------------------------
-- Gala Macabre
-- Family: Corse
-- Description: Charms all targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: N/A
-- Range: Radial
-- Notes: Only used by some notorious monsters like Xolotl and Giltine.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    MobCharmMove(mob, target, skill, 0, 180)

    return tpz.effect.CHARM_I
end
