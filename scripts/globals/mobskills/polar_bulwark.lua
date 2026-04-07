---------------------------------------------
-- Polar Bulwark
--
-- Description: Grants a Magic Shield effect for a time.
-- Type: Enhancing
--
-- Range: Self
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:hasStatusEffect(tpz.effect.MAGICAL_SHIELD) then
        return 1
    end

    if (mob:getFamily() == 316) then
        local mobSkin = mob:getModelId()

        if (mobSkin == 1796) then
            return 0
        else
            return 1
        end
    end

    if (mob:AnimationSub() < 2) then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffectOne = tpz.effect.MAGIC_SHIELD
    skill:setMsg(MobBuffMove(mob, typeEffectOne, 1, 0, 60))
    local effect1 = mob:getStatusEffect(typeEffectOne)
    effect1:unsetFlag(tpz.effectFlag.DISPELABLE)
    mob:delStatusEffectSilent(tpz.effect.PHYSICAL_SHIELD)

    return tpz.effect.MAGIC_SHIELD
end
