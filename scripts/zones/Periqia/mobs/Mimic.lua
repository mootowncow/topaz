-----------------------------------
-- Area: Periqia (Requiem)
--  Mob: Mimic
-----------------------------------
local ID = require("scripts/zones/Periqia/IDs")
-----------------------------------
function onMobSpawn(mob)
    mob:hideName(true)
	mob:setMobMod(tpz.mobMod.SOUND_RANGE, 15)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 2) 
    mob:setMobMod(tpz.mobMod.CHECK_AS_NM, 1)
end

function onMobFight(mob, target)
    mob:hideName(false)
end

function onMobRoam(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    --mob:setPos(-299.5302,-15.5611,140.4806,90)
end

function onMobEngaged(mob)
    mob:hideName(false)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addTempItem(5389) -- spy's drink
    player:addTempItem(5440) -- dusty wing
    player:addTempItem(5840) -- stalwarts gambir
    for _, member in pairs(player:getAlliance()) do
        if member:getZoneID() == player:getZoneID() then
            member:messageName(ID.text.PLAYER_OBTAINS_ITEM, player, 5389, param2, param3, param4, nil)
        end
    end
    for _, member in pairs(player:getAlliance()) do
        if member:getZoneID() == player:getZoneID() then
            member:messageName(ID.text.PLAYER_OBTAINS_ITEM, player, 5440, param2, param3, param4, nil)
        end
    end
    for _, member in pairs(player:getAlliance()) do
        if member:getZoneID() == player:getZoneID() then
            member:messageName(ID.text.PLAYER_OBTAINS_ITEM, player, 5840, param2, param3, param4, nil)
        end
    end
end

function onMobDespawn(mob)
end
