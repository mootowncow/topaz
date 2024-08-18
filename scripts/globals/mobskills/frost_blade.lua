---------------------------------------------
-- Frost Blade
-- Description: Applies Enblizzard and absorbs Ice damage.
-- Type: Enhancing
-- Used only by Kam'lanaut. Enblizzard aspect adds 70+ to his melee attacks.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.ENBLIZZARD
    skill:setMsg(MobBuffMove(mob, typeEffect, 65, 0, 300))
    local effect1 = mob:getStatusEffect(typeEffect)
    effect1:unsetFlag(tpz.effectFlag.DISPELABLE)
    return typeEffect
end
