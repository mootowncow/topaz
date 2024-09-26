---------------------------------------------
-- Healing Breath II
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
    local mobs = {
        GetMobByID(mob:getID() - 3),
        GetMobByID(mob:getID() - 2),
        GetMobByID(mob:getID() - 1)
    };
    table.sort(mobs, function(a,b)
        return (a:getHPP() < b:getHPP());
    end)

    local lowestShikaree = mobs[1];

    if mob:checkDistance(lowestShikaree) < 10 then 
        return MobPercentHealMove(mob, lowestShikaree, skill, 0.20)
    end
end

