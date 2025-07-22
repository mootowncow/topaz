-----------------------------------
-- Area: Riverne - Site A01
--   NM:Shieldtrap
--   Notes: Spell list changes based on day of the week it is engaged
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_A01/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.EEM_SILENCE, 5)
end

function onMobEngaged(mob, target)
    local daySpellLists =
    {
        [0] = {  -- Firesday
            145, 175, 235, 100, 249
        },
        [1] = {  -- Earthsday
            54, 103, 160, 238, 190
        },
        [2] = {  -- Watersday
            170, 200, 105, 226, 55, 240
        },
        [3] = {  -- Windsday
            237, 53, 102, 59, 155, 185
        },
        [4] = {  -- Iceday
            250, 58, 258, 236, 180, 150
        },
        [5] = {  -- Lightningsday
            251, 104, 252, 239, 195, 165
        },
        [6] = {  -- Lightsday
            53, 54, 57, 49, 45, 108, 112, 360, 24, 29, 34, 39, 21
        },
        [7] = {  -- Darksday
            254, 231, 247, 245, 273, 260, 266, 267, 268, 269, 270, 271, 272
        },
    }
    local day = VanadielDayOfTheWeek()
    
    -- Clear any existing spells just in case
    mob:clearSpellList()

    -- Add spells for the day
    for _, spellId in ipairs(daySpellLists[day]) do
        mob:addSpellListEntry(spellId)
    end
end

function onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller, noKiller)
end