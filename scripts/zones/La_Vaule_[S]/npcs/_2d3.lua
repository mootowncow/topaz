-----------------------------------
-- Area: La Vaule[S]
-- The Bloodbathed Crown BCNM Exit
-- !gotoid 17126107
-----------------------------------
local ID = require("scripts/zones/La_Vaule_[S]/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/bcnm")
-----------------------------------

function onTrigger(player, npc)
    local zone = player:getZone()
    player:leaveBattlefield(1)
    player:setPos(-106.83, -0, -181.36, 255)
    player:ChangeMusic(tpz.music.type.DAY, zone:getBackgroundMusicDay())
    player:ChangeMusic(tpz.music.type.NIGHT, zone:getBackgroundMusicNight())
    player:ChangeMusic(tpz.music.type.BATTLE_SOLO, zone:getSoloBattleMusic())
    player:ChangeMusic(tpz.music.type.BATTLE_PARTY, zone:getPartyBattleMusic())
    player:setLocalVar("[battlefield]area", 0)
end

function onEventUpdate(player, csid, option, extras)
end

function onEventFinish(player, csid, option)
end