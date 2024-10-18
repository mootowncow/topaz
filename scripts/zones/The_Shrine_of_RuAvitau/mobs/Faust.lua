-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Faust
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/pathfind")
local ID = require("scripts/zones/The_Shrine_of_RuAvitau/IDs")
-----------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
	mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 30)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
end


function onMobFight(mob, target)
    local changeTime = mob:getLocalVar("changeTime")
    local state = mob:getLocalVar("state")
    -- > 40% uses Typhoon back to back every 15 seconds
    if mob:getHPP() >= 50 and mob:getBattleTime() - changeTime >= 15 and mob:checkDistance(mob:getTarget()) <= 10 then
        mob:useMobAbility(539)
        mob:timer(4000, function(faust)
            if faust:checkDistance(faust:getTarget()) <= 10 then
                faust:useMobAbility(539)
            end
        end)
        mob:setLocalVar("changeTime", mob:getBattleTime())
    -- < 40% spams Typhoon over and over
    elseif mob:getHPP() < 50 and state == 0 then
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 368)
        mob:setMod(tpz.mod.REGAIN, 3000)
        mob:setLocalVar("state", 1)
    end
end

function onMobRoam(mob)
    local Turn = mob:getLocalVar("Turn")
    local Time = os.time()
    local facingDirection = {255, 190}
    if Time > Turn then
        if (mob:getRotPos() == 255) then
            mob:setPos(mob:getXPos(),mob:getYPos(),mob:getZPos(), 190)
            mob:setLocalVar("Turn", Time + 30)
        else
            mob:setPos(mob:getXPos(),mob:getYPos(),mob:getZPos(), 255)
            mob:setLocalVar("Turn", Time + 30)
        end
    end
end

function onMobEngaged(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobDisengage(mob)
    mob:setLocalVar("changeTime", 0)
    mob:setLocalVar("state", 0)
    mob:setMobMod(tpz.mobMod.SKILL_LIST, 0)
    mob:delMod(tpz.mod.REGAIN, 3000)
    mob:setTP(0)
end

function onMobDeath(mob, player, isKiller, noKiller)
end


function onMobDespawn(mob)
    mob:setRespawnTime(14400) -- 4 hours
end
