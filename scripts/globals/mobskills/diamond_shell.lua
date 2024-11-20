---------------------------------------------
-- Diamond Shell
-- Covers the user in icey spikes and absorbs damage. Enemies that hit it take ice damage.
-- Stoneskin portion cannot be removed with dispel.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobs")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    CheckQuadavModel(mob, skill, 2116, 358, 1563)
	if mob:hasStatusEffect(tpz.effect.PHYSICAL_SHIELD) then
		return 1
	end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffectOne = tpz.effect.PHYSICAL_SHIELD
    MobBuffMove(mob, typeEffectOne, 4, 0, 300) -- Behind PDT
    local effect1 = mob:getStatusEffect(typeEffectOne)
    effect1:unsetFlag(tpz.effectFlag.DISPELABLE)

    skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT) -- lasted 15 mins

    return tpz.effect.PHYSICAL_SHIELD
end
