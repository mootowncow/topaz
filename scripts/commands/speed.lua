---------------------------------------------------------------------------------------------------
-- func: speed
-- desc: Sets the targets movement speed.
---------------------------------------------------------------------------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")

cmdprops =
{
    permission = 1,
    parameters = "i"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!speed <0-255>")
end

function onTrigger(player, speed)
    local targ = player:getCursorTarget()

    if (targ == nil) then
        targ = player
    end

    if not speed then
        player:PrintToPlayer(string.format('Current Speed: %u', player:getSpeed()))
        return
    end

    if (targ:isMob() or targ:isPet() or targ:isPC()) then

        -- Validate speed amount
        if speed < 0 or speed > 255 then
            error(player, 'Invalid speed amount.')

            return
        end

        -- Bypass speed and inform player.
        local baseSpeed = speed

        if speed == 0 then
            if player:hasStatusEffect(tpz.effect.MOUNTED) then
                baseSpeed = -20
            else
                baseSpeed = 40
            end

            player:PrintToPlayer('Returning to your regular speed.')
        else
            player:PrintToPlayer('Bypassing regular speed calculations and limits.')
            player:PrintToPlayer('Set speed value to "0" to return to your regular speed.')
            player:PrintToPlayer(string.format("%s's new speed: %u", targ:getName(), speed))
        end

        targ:setMod(tpz.mod.MOVE_SPEED_OVERIDE, speed)
        targ:speed(baseSpeed)
    else
        error(player, "Invalid target.")
        return
    end
end
