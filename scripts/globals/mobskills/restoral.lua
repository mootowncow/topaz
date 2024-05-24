---------------------------------------------
-- Restoral
-- Description: Restores HP.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:getFamily() == 119 then -- Single Gear
        return 0
    end
    local AnimationSub = mob:AnimationSub()
    if AnimationSub > 0 then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    -- Regrows a gear on use
    -- Each remaining gear doubles the amount healed when used.
    local AnimationSub = mob:AnimationSub()
    if AnimationSub == 2 then
        if (math.random(1,100) <= 10) then -- ~10% chance to restore a gear on use
            mob:AnimationSub(1)
            skill:setMsg(tpz.msg.basic.SELF_HEAL)
            mob:setLocalVar("GearNumber", 2)
        end
        return MobPercentHealMove(mob, target, skill, 0.10) -- TODO % healed. 1 Gears
    end
    if AnimationSub == 1 then
        if (math.random(1,100) <= 10) then -- ~10% chance to restore a gear on use
            mob:AnimationSub(0)
            skill:setMsg(tpz.msg.basic.SELF_HEAL)
            mob:setLocalVar("GearNumber", 3)
        end
        return MobPercentHealMove(mob, target, skill, 0.15) -- TODO % healed.
    end
    skill:setMsg(tpz.msg.basic.SELF_HEAL)
    mob:setLocalVar("GearNumber", 3)
    return MobPercentHealMove(mob, target, skill, 0.20) -- TODO % healed.
end
