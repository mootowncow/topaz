-----------------------------------------
-- ID: 5391
-- Soldier's Drink
-- Increases the enemies damage taken by 50% for 30 seconds.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/utils")
require("scripts/globals/mobs")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local effect = tpz.effect.SOLDIERS_DRINK
    local power = 1
    local duration = 60
    local playerName = target:getName()
    local mob = target:getTarget()
    local mobName = MobName(mob)
    if (mob ~= nil) then
        utils.MessageParty(target, 'The ' .. mobName .. ' is now vulnerable!', 0xD, none)
        mob:addStatusEffectEx(tpz.effect.INCREASED_DAMAGE_TAKEN, tpz.effect.INCREASED_DAMAGE_TAKEN, 1, 0, 30)
    end
end
