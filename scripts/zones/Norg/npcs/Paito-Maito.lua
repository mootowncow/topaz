-----------------------------------
-- Area: Norg
--  NPC: Paito-Maito
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -71.189713, -9.413510, 74.024879,
    -71.674171, -9.317029, 73.054794,
    -72.516525, -9.298064, 72.363213,
    -73.432983, -9.220915, 71.773857,
    -74.358955, -9.142115, 71.163277,
    -75.199585, -9.069098, 70.583145,
    -76.184708, -9.006280, 70.261375,
    -77.093193, -9.000236, 70.852921,
    -77.987053, -9.037421, 71.464264,
    -79.008476, -9.123112, 71.825165,
    -80.083740, -9.169785, 72.087944,
    -79.577698, -9.295252, 73.087708,
    -78.816307, -9.365192, 73.861855,
    -77.949852, -9.323165, 74.500496,
    -76.868950, -9.301287, 74.783707,
    -75.754913, -9.294973, 74.927345,
    -74.637566, -9.341335, 74.902016,
    -73.521400, -9.382154, 74.747322,
    -72.420792, -9.415255, 74.426178,
    -71.401161, -9.413510, 74.035446,
    -70.392426, -9.413510, 73.627884,
    -69.237152, -9.413510, 73.155815,
    -70.317207, -9.413510, 73.034027,
    -71.371315, -9.279585, 72.798569,
    -72.378838, -9.306310, 72.392982,
    -73.315544, -9.230491, 71.843933,
    -74.225883, -9.153550, 71.253113,
    -75.120522, -9.076024, 70.638908,
    -76.054642, -9.019394, 70.204910,
    -76.981323, -8.999838, 70.762978,
    -77.856903, -9.024825, 71.403915,
    -78.876686, -9.115798, 71.789764,
    -79.930756, -9.171277, 72.053635,
    -79.572502, -9.295024, 73.087646,
    -78.807686, -9.364762, 73.869614,
    -77.916420, -9.321617, 74.516357,
    -76.824738, -9.300390, 74.790466,
    -75.738380, -9.295794, 74.930130,
    -74.620911, -9.341956, 74.899994,
    -73.493645, -9.382988, 74.739204,
    -72.413185, -9.415321, 74.420128,
    -71.452393, -9.413510, 74.054657,
    -70.487755, -9.413510, 73.666130,
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
    player:startEvent(90)
    npc:wait()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
    npc:wait(0)
end
