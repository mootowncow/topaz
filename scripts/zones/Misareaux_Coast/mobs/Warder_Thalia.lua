-----------------------------------
-- Area: Misareaux Coast
-- Mob: Warder Thalia
-----------------------------------
require("scripts/globals/missions")
mixins = {require("scripts/mixins/warders_cop")}
local ID = require("scripts/zones/Misareaux_Coast/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:SetMobAbilityEnabled(false) -- ability use handled in mixin
    mob:setLocalVar("warder", 3)
    mob:setLocalVar("electro", 1)
end

function onMobDisengage(mob)
    -- reset variables so that disengaging mobs won't break mixin
    mob:setLocalVar("changeTime", 0)
    mob:setLocalVar("initiate", 0)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.A_PLACE_TO_RETURN and player:getCharVar("PromathiaStatus") == 1) then
        player:setCharVar("Warder_Thalia_KILL", 1)
    end
end
