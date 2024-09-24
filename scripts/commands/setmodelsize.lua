---------------------------------------------------------------------------------------------------
-- func: setmodelsize <flags> <optional MobID>
-- desc: Used to manipulate a mob's model size for testing.
--       MUST either target a mob first or else specify a Mob ID.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "si"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setmodelsize <modelSize> {mob ID}")
end

function onTrigger(player, modelSize, target)
    -- validate modelSize
    if (modelSize == nil) then
        error(player, "You must supply a modelSize value.")
        return
    end

    -- validate target
    local targ
    if (target == nil) then
        targ = player:getCursorTarget()
        if (targ == nil or not targ:isMob()) then
            error(player, "You must either supply a mob ID or target a mob.")
            return
        end
    else
        targ = GetMobByID(target)
        if (targ == nil) then
            error(player, "Invalid mob ID.")
            return
        end
    end

    -- set modelSize
    targ:setModelSize(modelSize)
    player:PrintToPlayer( string.format("Set %s %i modelSize to %i.", targ:getName(), targ:getID(), modelSize) )
end
