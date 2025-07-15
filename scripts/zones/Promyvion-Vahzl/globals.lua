-- Zone: Promyvion-Vahzl
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = require("scripts/zones/Promyvion-Vahzl/IDs")
-----------------------------------
function ApplyEmptyAbsorbMods(mob)
    local ElementAbsorbMods =
    {
        [1] = tpz.mod.FIRE_ABSORB,
        [2] = tpz.mod.ICE_ABSORB,
        [3] = tpz.mod.WIND_ABSORB,
        [4] = tpz.mod.EARTH_ABSORB,
        [5] = tpz.mod.LTNG_ABSORB,
        [6] = tpz.mod.WATER_ABSORB,
        [7] = tpz.mod.LIGHT_ABSORB,
        [8] = tpz.mod.DARK_ABSORB
    }
    local element = mob:getLocalVar("element")
    local absorbMod = ElementAbsorbMods[element]

    -- Clear old absorbs
    for _, mod in pairs(ElementAbsorbMods) do
        mob:setMod(mod, 0)
    end

    -- Apply new absorb (current element)
    if absorbMod then
        mob:setMod(absorbMod, 100)
    else
        printf("Mob has invalid absorb mod for element value: %i", element)
    end
end