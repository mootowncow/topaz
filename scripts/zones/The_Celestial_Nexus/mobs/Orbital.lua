-----------------------------------
-- Area: The Celestial Nexus
--  Mob: Orbital
-- Zilart Mission 16 BCNM Fight
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.REFRESH, 400)
    mob:setHP(10000)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobFight(mob, target)
	mob:setMod(tpz.mod.REGAIN, 50)
	local EaldOne = GetMobByID(17518595)
	local EaldTwo = GetMobByID(17518600)
	local EaldThree = GetMobByID(17518605)
    -- Shares enmity with Ealdnarche
	if EaldOne:isSpawned() then
		mob:setMobMod(tpz.mobMod.SHARE_TARGET, EaldOne:getShortID())
	elseif EaldTwo:isSpawned() then
		mob:setMobMod(tpz.mobMod.SHARE_TARGET, EaldTwo:getShortID())
	elseif EaldThree:isSpawned() then
		mob:setMobMod(tpz.mobMod.SHARE_TARGET, EaldThree:getShortID())
	end
end

function onMobRoam(mob)
    mob:setHP(10000)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onEventUpdate(player, csid, option)
    -- printf("updateCSID: %u", csid)
end

function onEventFinish(player, csid, option, target)
    -- printf("finishCSID: %u", csid)

    if (csid == 32004) then
        if (GetMobByID(target:getID()-1):getName() == "Orbital") then
            DespawnMob(target:getID())
            DespawnMob(target:getID()-1)
            DespawnMob(target:getID()-3)
            DespawnMob(target:getID()-4)
            mob = SpawnMob(target:getID()-2)
            mob:updateEnmity(player)
            --the "30 seconds of rest" you get before he attacks you, and making sure he teleports first in range
            mob:addStatusEffectEx(tpz.effect.BIND, 0, 1, 0, 30)
            mob:addStatusEffectEx(tpz.effect.SILENCE, 0, 1, 0, 40)
        else
            DespawnMob(target:getID())
            DespawnMob(target:getID()+1)
            DespawnMob(target:getID()-2)
            DespawnMob(target:getID()-3)
            mob = SpawnMob(target:getID()-1)
            mob:updateEnmity(player)
            -- the "30 seconds of rest" you get before he attacks you, and making sure he teleports first in range
            mob:addStatusEffectEx(tpz.effect.BIND, 0, 1, 0, 30)
            mob:addStatusEffectEx(tpz.effect.SILENCE, 0, 1, 0, 40)
        end
    end

end
