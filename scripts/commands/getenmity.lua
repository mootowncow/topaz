 ---------------------------------------------------------------------------------------------------
-- func: getenmity
-- desc: Prints the target mob's current CE and VE towards you and your pet
---------------------------------------------------------------------------------------------------
require("scripts/globals/status")

cmdprops =
{
    permission = 2,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!getenmity")
end

function onTrigger(player)
    
    local targ = player:getCursorTarget()
    
    if targ == nil or targ:isMob() == false or player:hasStatusEffect(tpz.effect.CHARM_I) or player:hasStatusEffect(tpz.effect.CHARM_II) then
        error(player, "You must select a target monster with the cursor first")
    end
    
    player:PrintToPlayer(string.format("Your enmity against %s is ... CE = %u ... VE = %u", targ:getName(), targ:getCE(player), targ:getVE(player)))

    local pet = player:getPet()
    if pet then
        player:PrintToPlayer(string.format("Your pet's enmity against %s is ... CE = %u ... VE = %u", targ:getName(), targ:getCE(pet), targ:getVE(pet)))
    end
 end
