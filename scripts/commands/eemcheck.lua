function onTrigger(player)
    local targ = player:getCursorTarget();
    if (targ ~= nil)  then
        if (targ:isMob() or targ:isPet() or targ:isTrust()) then
            local amnesia = targ:getMod(tpz.mod.EEM_AMNESIA)
            local virus = targ:getMod(tpz.mod.EEM_VIRUS)
            local silence = targ:getMod(tpz.mod.EEM_SILENCE)
            local gravity = targ:getMod(tpz.mod.EEM_GRAVITY)
            local stun = targ:getMod(tpz.mod.EEM_STUN)
            local lightSleep = targ:getMod(tpz.mod.EEM_LIGHT_SLEEP)
            local charm = targ:getMod(tpz.mod.EEM_CHARM)
            local paralyze = targ:getMod(tpz.mod.EEM_PARALYZE)
            local bind = targ:getMod(tpz.mod.EEM_BIND)
            local slow = targ:getMod(tpz.mod.EEM_SLOW)
            local petrify = targ:getMod(tpz.mod.EEM_PETRIFY)
            local terror = targ:getMod(tpz.mod.EEM_TERROR)
            local poison = targ:getMod(tpz.mod.EEM_POISON)
            local darkSleep = targ:getMod(tpz.mod.EEM_DARK_SLEEP)
            local blind = targ:getMod(tpz.mod.EEM_BLIND)

            player:PrintToPlayer(string.format("%s EEM 1: Amnesia: %i, Virus: %i, Silence: %i, Gravity: %i, Stun: %i, Sleep(L): %i, Charm: %i, Paralyze: %i", targ:getName(), amnesia, virus, silence, gravity, stun, lightSleep, charm, paralyze))
            player:PrintToPlayer(string.format("%s EEM 2: Bind: %i, Slow: %i, Petrify: %i, Terror: %i, Poison: %i, Sleep(D): %i, Blind: %i", targ:getName(), bind, slow, petrify, terror, poison, darkSleep, blind))
        else
            player:PrintToPlayer("Must select a mob or pet using in game cursor first.");
        end
    end
end
---------------------------------------------------------------------------------------------------
-- func: statcheck
-- desc: Prints the Stats of the currently selected target under the cursor
---------------------------------------------------------------------------------------------------
require("scripts/globals/status")

cmdprops =
{
    permission = 1,
    parameters = ""
};