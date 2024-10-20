-----------------------------------
-- Area: Windurst Walls
--  NPC: Pakeke
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -118.747, -5.000, 145.220, -- Force turn.
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.643, -5.000, 145.220,
    -118.747, -5.000, 145.220, -- Force turn.
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
    -118.782, -5.000, 145.220,
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    onPath(npc)
end

function onPath(npc)
    tpz.path.patrolsimple(npc, path, flags)
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(292)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
