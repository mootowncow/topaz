---------------------------------------------
--  Optic Induration (Charge)
--
--  Description: Charges up a powerful, calcifying beam directed at targets in a fan-shaped area of effect. Additional effect: Petrification & enmity reset
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown cone
--  Notes: Charges up (three times) before actually being used (except Jailer of Temperance, who doesn't need to charge it up). The petrification lasts a very long time.
---------------------------------------------
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
local ID = require("scripts/zones/Grand_Palace_of_HuXzoi/IDs")
---------------------------------------------
function onMobSkillCheck(target,mob,skill)
    -- Rarely used Optic Induration. Only charge if not an NM and in normal mode (no bars or rings)
    if mob:getLocalVar("charge_count") > 0 then
        return 0
    elseif mob:getID() == ID.mob.JAILER_OF_TEMPERANCE then
        return 1
    elseif mob:AnimationSub() > 1 then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local charge_count = mob:getLocalVar("charge_count")
    if charge_count == 0 then
        mob:setLocalVar("charge_total", 3)
        mob:SetAutoAttackEnabled(false)
        mob:setLocalVar("charge_count", 1)
        mob:timer(4000, function(mob)
            mob:useMobAbility(1464)
        end)
    else
        charge_count = charge_count + 1
        local charge_total = mob:getLocalVar("charge_total")
        if charge_count == charge_total then
            mob:timer(4000, function(mob)
                mob:useMobAbility(1465)
            end)
            mob:timer(4500, function(mob)
                mob:SetAutoAttackEnabled(true)
                mob:setLocalVar("charge_count", 0)
                mob:setLocalVar("charge_total", 0)
            end)
        else
            mob:setLocalVar("charge_count", charge_count)
            mob:timer(4000, function(mob)
                mob:useMobAbility(1464)
            end)
        end
    end

    skill:setMsg(tpz.msg.basic.NONE)
    return 0
end
