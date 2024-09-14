-----------------------------------
-- Area: Giddeus
--   NM: Vaa Huja the Erudite
-- Involved in Quests: Dark Legacy
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobDeath(mob, player, isKiller, noKiller)
    local darkLegacyCS = player:getCharVar("darkLegacyCS")

    if (darkLegacyCS == 3 or darkLegacyCS == 4) then
        player:setCharVar("darkLegacyCS", 5)
    end
end
