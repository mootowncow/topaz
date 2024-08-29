---------------------------------------------------------------------------------------------------
-- func: setmobmod
-- desc: Sets the specified mob modifier to the specified value on the cursor target or mob ID
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")

cmdprops =
{
    permission = 1,
    parameters = "sis"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setmod {modifier} {amount} {optional target}")
end

function onTrigger(player, modifier, amount, target)

    if not modifier or not amount then
        error(player, "Must specify modifier and amount. ")
        return
    end

    local modID = tonumber(modifier) or tpz.mobMod[string.upper(modifier)]
    if not modID then
        error(player, "No valid modifier found. ")
        return
    end

    if target then
       target = GetMobByID(tonumber(arg1))
    else
        target = player:getCursorTarget()
    end

    if not target or target:isNPC() or not target:isMob() or not target:isTrust() then
        error(player, "No valid target found. place cursor on a non-npc / non-player object or specify a mob ID. ")
        return
    end

    local oldmod = target:getMobMod(modID)
    target:setMobMod(modID, amount)
    player:PrintToPlayer(string.format("Target name: %s (Target ID: %i) | Old %s modifier value: %i | New %s modifier value: %i", target:getName(), target:getID(), modifier, oldmod, modifier, amount))
end
