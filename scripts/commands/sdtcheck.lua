function onTrigger(player)
    local targ = player:getCursorTarget();
    if (targ ~= nil)  then
        if (targ:isMob() or targ:isPet() or targ:isTrust()) then
            local fire = targ:getMod(tpz.mod.SDT_FIRE)
            local ice = targ:getMod(tpz.mod.SDT_ICE)
            local wind = targ:getMod(tpz.mod.SDT_WIND)
            local earth = targ:getMod(tpz.mod.SDT_EARTH)
            local water = targ:getMod(tpz.mod.SDT_WATER)
            local thunder = targ:getMod(tpz.mod.SDT_THUNDER)
            local dark = targ:getMod(tpz.mod.SDT_DARK)
            local light = targ:getMod(tpz.mod.SDT_LIGHT)

            local hthres = targ:getMod(tpz.mod.HTHRES)
            local pierceres = targ:getMod(tpz.mod.PIERCERES)
            local rangedres = targ:getMod(tpz.mod.RANGEDRES)
            local impactres = targ:getMod(tpz.mod.IMPACTRES)
            local slashres = targ:getMod(tpz.mod.SLASHRES)
            local spdefdown = targ:getMod(tpz.mod.SPDEF_DOWN)

            player:PrintToPlayer(string.format("%s SDT 1: Fire: %i, Ice: %i, Wind: %i, Earth: %i, Water: %i, Thunder: %i, Dark: %i, Light: %i", targ:getName(), fire, ice, wind, earth, water, thunder, dark, light))
            player:PrintToPlayer(string.format("%s SDT 2: hthres: %i, pierceres: %i, rangedres: %i, impactres: %i, slashres: %i, spdefdown: %i", targ:getName(), hthres, pierceres, rangedres, impactres, slashres, spdefdown))
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