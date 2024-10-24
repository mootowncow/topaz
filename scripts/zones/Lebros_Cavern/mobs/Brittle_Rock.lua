-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
--  Mob: Brittle Rock
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:addMod(tpz.mod.DMG, -98)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:SetAutoAttackEnabled(false)
    mob:setMod(tpz.mod.DEF, 1500)
    mob:setMod(tpz.mod.MDEF, 900)
end

function onMobDeath(mob, player, isKiller, noKiller)
    local instance = mob:getInstance()
    if mob:getID() == ID.mob[21].BRITTLE_ROCK1 then
        GetNPCByID(ID.npc._1rx, instance):setAnimation(8)
    elseif mob:getID() == ID.mob[21].BRITTLE_ROCK2 then
        GetNPCByID(ID.npc._1ry, instance):setAnimation(8)
    elseif mob:getID() == ID.mob[21].BRITTLE_ROCK3 then
        GetNPCByID(ID.npc._1rz, instance):setAnimation(8)
    elseif mob:getID() == ID.mob[21].BRITTLE_ROCK4 then
        GetNPCByID(ID.npc._jr0, instance):setAnimation(8)
    elseif mob:getID() == ID.mob[21].BRITTLE_ROCK5 then
        GetNPCByID(ID.npc._jr1, instance):setAnimation(8)
    end
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end
