-----------------------------------------
-- ID: 5836
-- Item: tube_of_healing_salve_ii
-- Item Effect: Instantly restores 100% of pet HP
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/items")
function onItemCheck(target)
    if not target:hasPet() then
        return tpz.msg.basic.NO_TARGET_AVAILABLE
    end
    return 0
end

function onItemUse(target)
    local item = GetItem(tpz.items.TUBE_OF_HEALING_SALVE_II)
    local param = item:getParam() / 100
    local pet = target:getPet()
    pet:addHP(pet:getMaxHP() * param)
    target:messagePublic(tpz.msg.basic.RECOVERS_HP, pet, param)
end
