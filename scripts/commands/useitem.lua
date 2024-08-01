---------------------------------------------------------------------------------------------------
-- func: useitem
-- desc: Tells the target mob to use item
---------------------------------------------------------------------------------------------------
require("scripts/globals/items")

cmdprops =
{
    permission = 1,
    parameters = "ss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!useitem")
end

function onTrigger(player, item, self)
    local targ = player:getCursorTarget()
    
    if targ == nil or (not targ:isMob() and not targ:isPC()) then
        error(player, "you must select a target monster with the cursor first")
    else
        
        item = tonumber(item) or tpz.items[string.upper(item)]
        
        if (item == nil) then
            error(player, "Invalid item.")
            return
        end
        
        if (self == nil) then
            printf("Using item %d", item)
            targ:useItem(item)
        else
            targ:useItem(item, targ)
        end
    end
end

