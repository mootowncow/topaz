-----------------------------------
-- Area: Beadeaux_[S]
-- The Buried God BCNM exit
-- !gotoid 17154819
-----------------------------------
local ID = require("scripts/zones/Beadeaux_[S]/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/bcnm")
-----------------------------------

function onTrigger(player, npc)
    local zone = player:getZone()
    player:leaveBattlefield(1)
    player:setPos(299.79, 40, 36, 61)
    player:ChangeMusic(tpz.music.type.DAY, zone:getBackgroundMusicDay())
    player:ChangeMusic(tpz.music.type.NIGHT, zone:getBackgroundMusicNight())
    player:ChangeMusic(tpz.music.type.BATTLE_SOLO, zone:getSoloBattleMusic())
    player:ChangeMusic(tpz.music.type.BATTLE_PARTY, zone:getPartyBattleMusic())
    player:setLocalVar("[battlefield]area", 0)
end

function onEventUpdate(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

function onEventFinish(player, csid, option)
    if EventFinishBCNM(player, csid, option) then
        return
    end
end