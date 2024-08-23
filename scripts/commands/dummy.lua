---------------------------------------------------------------------------------------------------
-- func: dummy
-- desc: Turns the mob into a target dummy, yay!
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!notattack")
end

function onTrigger(player)
    
    local targ = player:getCursorTarget()
    
    if targ == nil or targ:isMob() == false then
        error(player, "you must select a target monster with the cursor first")
    end
    if targ:getLocalVar("Autoattack")  == 0 then
        targ:SetAutoAttackEnabled(false)
        targ:setLocalVar("Autoattack", 1) 
        player:PrintToPlayer(string.format("%s's auto-attack disabled.", targ:getName()))
    else
        targ:SetAutoAttackEnabled(true)
        targ:setLocalVar("Autoattack", 0) 
        player:PrintToPlayer(string.format("%s's auto-attack enabled.", targ:getName()))
    end
    if targ:getLocalVar("Cast")  == 0 then
        targ:SetMagicCastingEnabled(false)
        targ:setLocalVar("Cast", 1) 
        player:PrintToPlayer(string.format("%s's casting disabled.", targ:getName()))
    else
        targ:SetMagicCastingEnabled(true)
        targ:setLocalVar("Cast", 0) 
        player:PrintToPlayer(string.format("%s's casting enabled.", targ:getName()))
    end
    if targ:getLocalVar("WS")  == 0 then
        targ:SetMobAbilityEnabled(false)
        targ:setLocalVar("WS", 1) 
        player:PrintToPlayer(string.format("%s's WS disabled.", targ:getName()))
    else
        targ:SetMobAbilityEnabled(true)
        targ:setLocalVar("WS", 0) 
        player:PrintToPlayer(string.format("%s's WS enabled.", targ:getName()))
    end

    local immortal = false
    if targ:getLocalVar("Immortal") == 1 then
        targ:setLocalVar("Immortal", 0)
    else
        targ:setLocalVar("Immortal", 1)
        immortal = true
    end
    targ:setUnkillable(immortal)

    if immortal then
        targ:addMod(tpz.mod.REGEN, 1000)
        player:PrintToPlayer(string.format("%s is now immortal!", targ:getName()))
    else
        targ:delMod(tpz.mod.REGEN, 1000)
        player:PrintToPlayer(string.format("%s is mortal again.", targ:getName()))
    end
 end
