---------------------------------------------------------------------------------------------------
-- func: setstatus <mobid-optional>
-- desc: Despawns the given mob/npc <t> or mobID/npcid)
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "i"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setstatus {mobID}")
end

function onTrigger(player, mobId, statustoggle)

    local zone = player:getZone()
    if zone:getType() == tpz.zoneType.INSTANCED then
        local instance = player:getInstance()
        local targ
        if (mobId == nil) then
            targ = player:getCursorTarget()
            if (targ == nil or not targ:isMob()) then
                error(player, "You must either provide a mobID or target a mob.")
                return
            end
        else
            targ = GetNPCByID(mobId, instance)
            if (targ == nil) then
                error(player, "Invalid mobID.")
                return
            end
        end
        -- set status
        GetNPCByID(mobId, instance):setStatus(tpz.status.statustoggle)
        player:PrintToPlayer(string.format("Set status for %s %i.", targ:getName(), targ:getID()))
    else
        if (mobId == nil) then
            targ = player:getCursorTarget()
            if (targ == nil or not targ:isMob()) then
                error(player, "You must either provide a mobID or target a mob.")
                return
            end
        else
            targ = GetNPCByID(mobId)
            if (targ == nil) then
                error(player, "Invalid mobID.")
                return
            end
        end
        -- set status
        GetNPCByID(mobId):setStatus(tpz.status.statustoggle)
    end
end
