-----------------------------------
-- Area: Halvung
--  Mob: Troll_Mythril_Guard
-----------------------------------
mixins = {require("scripts/mixins/weapon_break")}
require("scripts/globals/mobs")
require("scripts/globals/status")
require("scripts/globals/pathfind")
-----------------------------------
function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onPath(mob)
	local Monamaq = GetMobByID(17031440)
	mob:pathTo(Monamaq:getXPos(), Monamaq:getYPos(), Monamaq:getZPos())
end

function onMobFight(mob, target)
    local monamaq = GetMobByID(17031440)
    -- Shares target with Mythril Mouth Monamaq
    if monamaq:isAlive() then
        mob:setMobMod(tpz.mobMod.SHARE_TARGET, monamaq:getShortID())
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end

