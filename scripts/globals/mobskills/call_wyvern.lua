---------------------------------------------
-- Call Wyvern
-- Call my pet.
---------------------------------------------
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:getPool() == 21 then -- Absolute Virtue
        return 0
    end
    if mob:hasPet() or mob:getPet() == nil then
        return 1
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local enemy = mob:getTarget()
    if mob:getPool() == 21 then -- Absolute Virtue
        for v = 16912877, 16912882, 1 do
            GetMobByID(v):spawn()
            if (enemy ~= nil) then
                v:updateEnmity(enemy)
            end
        end
    else
        mob:spawnPet()
        local pet = mob:getPet()
        if (enemy ~= nil) then
            pet:updateEnmity(enemy)
        end
    end

    skill:setMsg(tpz.msg.basic.NONE)

    return 0
end
