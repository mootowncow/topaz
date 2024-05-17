-----------------------------------------
-- ID: 5246
-- Item: Drachenessence
-- Item Effect: Instantly restores 25% of pet HP
-----------------------------------------
require("scripts/globals/msg")
require("scripts/globals/pets")
-----------------------------------------

function onItemCheck(target)
    if not target:hasPet() or target:getPetID() ~= tpz.pet.id.WYVERN then
        return tpz.msg.basic.REQUIRES_A_PET
    end
    return 0
end

function onItemUse(target)
    local pet = target:getPet()
    local totalHP = pet:getMaxHP() / 4
    pet:addHP(totalHP)
    pet:messageBasic(tpz.msg.basic.RECOVERS_HP, 0, totalHP)
end
