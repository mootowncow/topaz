---------------------------------------------
-- Entice
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/msg")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target,mob,skill)
    if mob:getName() == 'Siren_Prime' then
        return 0
    end
    if mob:hasStatusEffect(tpz.effect.SOUL_VOICE) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.CHARM_I
    MobCharmMove(mob, target, skill, 0, 60)

    return typeEffect
end
