-----------------------------------------
-- ID: 5266
-- Item: Blackened Muddy Siredon
-- Additional Effect: Stops Shikaree Regain
-----------------------------------------
local ID = require("scripts/zones/Bearclaw_Pinnacle/IDs")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onItemCheck(target)
    local poolid = target:getPool()
    if poolid == 3598 or poolid == 3600 or poolid == 3601 then
        return 0
    end

    return 1
end

function onItemUse(target, item)
    if target:getLocalVar("distracted") ~= 0 then
        target:showText(target, target:getLocalVar("chat") + 6)
    else
        target:showText(target, target:getLocalVar("chat") + 5)
    end

    if target:getLocalVar("distracted") ~= 0 and target:getPool() == 3601 then
        -- Can only be used once for Shikaree Z
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    else
        target:setLocalVar("distracted", 1)
        target:setMod(tpz.mod.REGAIN, 0)
        target:queue(math.random(30, 90) * 1000, function(target)
            if target:isDead() then return; end;

            target:setLocalVar("distracted", 2)
            target:setMod(tpz.mod.REGAIN, target:getLocalVar("regain"))
        end)
    end
end
