---------------------------------------------
-- Call Beast
-- Call my pet.
---------------------------------------------
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:hasPet() or mob:getPet() == nil then
        return 1
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    mob:spawnPet()
    local enemy = mob:getTarget()
    local pet = mob:getPet()
    if (enemy ~= nil) then
        pet:updateEnmity(enemy)
    end

    skill:setMsg(tpz.msg.basic.NONE)

    return 0
end
