---------------------------------------------
-- Healing Breath III
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/msg")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local master = GetMobByID(mob:getID() -3)
    local mobs = {
        GetMobByID(mob:getID() - 3),
        GetMobByID(mob:getID() - 2),
        GetMobByID(mob:getID() - 1)
    };
    table.sort(mobs, function(a,b)
        return (a:getHPP() < b:getHPP());
    end)

    local lowestShikaree = mobs[1];
    master:setLocalVar("forceBreath", 0)

    if mob:checkDistance(lowestShikaree) < 10 then 
        return MobPercentHealMove(mob, lowestShikaree, skill, 0.25)
    end
end

