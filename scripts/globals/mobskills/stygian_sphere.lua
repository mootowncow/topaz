---------------------------------------------
-- Stygian Sphere
-- Description: Restores ~2000 HP.
-- Iratham variants gain a magic shield, stoneskin, and MAB boost. Magic damage removes the shield. 
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/zone")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local zone = mob:getZoneID()

    -- TODO: Iratham variants also
    if (zone == tpz.zone.WALK_OF_ECHOES) then
        mob:setMod(tpz.mod.MAGIC_SS, 1500)
    end

    local healAmount = MobHealMoveExact(mob, target, skill, math.random(1900, 2050))
    MobSelfDispelMove(mob, skill)
    skill:setMsg(tpz.msg.basic.SELF_HEAL)
    return healAmount
end
