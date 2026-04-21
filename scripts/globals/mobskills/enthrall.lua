---------------------------------------------
-- Enthrall
-- Description: AOE charm and Caturae "Sippoy" costume
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if mob:getHPP() > 50 then
        return 1
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)

    MobCharmMove(mob, target, skill, 2212, 60)

    return tpz.effect.CHARM_I
end
