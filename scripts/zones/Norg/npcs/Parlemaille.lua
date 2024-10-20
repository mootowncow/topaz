-----------------------------------
-- Area: Norg
--  NPC: Parlemaille
-- Standard Info NPC
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    -20.369047, 1.097733, -24.847025,
    -20.327482, 1.097733, -25.914215,
    -20.272402, 1.097733, -27.108938,
    -20.094927, 1.097733, -26.024536,
    -19.804167, 1.097733, -13.467897,
    -20.166626, 1.097733, -29.047626,
    -20.415781, 1.097733, -30.099203,
    -20.956963, 1.097733, -31.050713,
    -21.629911, 1.097733, -31.904819,
    -22.395691, 1.097733, -32.705379,
    -23.187502, 1.097733, -33.450657,
    -24.126440, 1.097733, -33.993565,
    -25.146549, 1.097733, -34.370991,
    -24.118807, 1.097733, -34.021263,
    -23.177444, 1.097733, -33.390072,
    -22.360268, 1.097733, -32.672077,
    -21.594837, 1.097733, -31.877075,
    -20.870659, 1.097733, -30.991661,
    -20.384108, 1.097733, -29.968874,
    -20.212332, 1.097733, -28.944513,
    -20.144073, 1.097733, -27.822714,
    -20.110937, 1.097733, -26.779232,
    -19.802849, 1.097733, -13.406805,
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
    player:startEvent(88)
npc:wait()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
    npc:wait(0)
end
