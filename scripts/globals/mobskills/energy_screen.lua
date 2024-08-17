---------------------------------------------
-- Energy_Screen
--
-- Description: Invincible

---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
	if mob:hasStatusEffect(tpz.effect.PHYSICAL_SHIELD) or mob:hasStatusEffect(tpz.effect.MAGIC_SHIELD) then
		return 1
	end
    local phase = mob:getLocalVar("battlePhase")
    if (phase >= 3) then
        if mob:getLocalVar("nuclearWaste") == 0 and mob:getLocalVar("citadelBuster") == 0 then
            return 0
        end
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffectOne = tpz.effect.PHYSICAL_SHIELD
    skill:setMsg(MobBuffMove(mob, typeEffectOne, 1, 0, 60))
    local effect1 = mob:getStatusEffect(typeEffectOne)
    effect1:unsetFlag(tpz.effectFlag.DISPELABLE)

    return typeEffectOne
end
