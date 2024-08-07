---------------------------------------------
-- Charm
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local isArkAngelMR = mob:getPool() == 238

    if isArkAngelMR then
        if mob:hasStatusEffect(tpz.effect.CONFRONTATION) then
            skill:setAoe(1)
            skill:setDistance(50)
        end
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    MobCharmMove(mob, target, skill, 0, 180)

    return tpz.effect.CHARM_I
end
