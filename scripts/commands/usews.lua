---------------------------------------------------------------------------------------------------
-- func: useWs
-- desc: Tells the target mob to use specificed weapon skill.
---------------------------------------------------------------------------------------------------
require("scripts/globals/weaponskillids")

cmdprops =
{
    permission = 1,
    parameters = "ss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!useWS")
end

function onTrigger(player, weaponSkill, self)
    local targ = player:getCursorTarget()
    
    if targ == nil or (not targ:isMob() and not targ:isPet()) then
        error(player, "you must select a target monster with the cursor first")
    else
        
        weaponSkill = tonumber(weaponSkill) or tpz.tpz.weaponskill[string.upper(weaponSkill)]
        
        if (weaponSkill == nil) then
            error(player, "Invalid weapon skill.")
            return
        end
        
        if (self == nil) then
            targ:useWeaponSkill(weaponSkill)
        else
            targ:useWeaponSkill(weaponSkill, targ)
        end
    end
end

