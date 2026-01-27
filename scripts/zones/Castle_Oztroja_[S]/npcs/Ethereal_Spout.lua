-----------------------------------
-- Area: Castle_Oztroja [S]
-- A Malicious Manifest BCNM Exit
-- !gotoid 17183547
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja_[S]/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/bcnm")
-----------------------------------

function onTrigger(player, npc)
    local zone = player:getZone()
    player:leaveBattlefield(1)
    player:setPos(-99.99, -71.75, -27.36, 63)
    player:ChangeMusic(tpz.music.type.DAY, zone:getBackgroundMusicDay())
    player:ChangeMusic(tpz.music.type.NIGHT, zone:getBackgroundMusicNight())
    player:ChangeMusic(tpz.music.type.BATTLE_SOLO, zone:getSoloBattleMusic())
    player:ChangeMusic(tpz.music.type.BATTLE_PARTY, zone:getPartyBattleMusic())
    player:setLocalVar("[battlefield]area", 0)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end