-----------------------------------
-- Area: Apollyon NW
--  Mob: Kaiser Behemoth
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/pathfind")
local ID = require("scripts/zones/Apollyon/IDs")
-----------------------------------
local flags = tpz.path.flag.NONE
local path =
{
    {-596.004, -0.254, 242.034},
    {-587.224, -0.254, 303.720},
    {-551.515, -0.254, 310.600},
    {-522.507, -0.254, 281.024},
    {-543.916, -0.254, 246.509},
    {-569.656, -0.254, 239.459}
}

function onMobSpawn(mob)
    mob:setMod(tpz.mod.DEF, 4000)
	mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
end

function onMobFight(mob, target)
	local MeteorTime = mob:getLocalVar("MeteorTime")
    local setPosTime = mob:getLocalVar("setPosTime")
	local BattleTime = mob:getBattleTime()

	if (MeteorTime == 0) then
		mob:setLocalVar("MeteorTime", BattleTime + 60)
	elseif (BattleTime >= MeteorTime) then
		mob:castSpell(218) -- Meteor
		mob:setLocalVar("MeteorTime", BattleTime + 70)
	end

    -- Don't immediately teleport after meteor
    mob:addListener("MAGIC_STATE_EXIT", "KB_MAGIC_STATE_EXIT", function(mob, spell)
        local BattleTime = mob:getBattleTime()
        mob:setLocalVar("setPosTime", BattleTime +10)
    end)

    local distance = 5 -- how far behind to place mob
    local targetHeading = target:getRotPos()

    -- Behind position
    local behindX = target:getXPos() + math.sin(targetHeading) * distance
    local behindZ = target:getZPos() - math.cos(targetHeading) * distance
    local behindY = target:getYPos()
    local speed = mob:getSpeed()

    if speed == 0 then
        mob:setLocalVar("setPosTime", BattleTime + 10)
    end

    if (setPosTime == 0) then
		mob:setLocalVar("setPosTime", BattleTime + 10)
	elseif (BattleTime >= setPosTime) then
        if not IsMobBusy(mob) and not mob:hasPreventActionEffect() and speed > 0 then
            if (mob:checkDistance(target) >= 8) then
                mob:setPos(behindX, behindY, behindZ)
                mob:setLocalVar("setPosTime", BattleTime + 10)
            end
        end
    end
end

function onMobRoam(mob)
    if not mob:isFollowingPath() then
        local point = math.random(#path)
        while point == mob:getLocalVar("point") do
            point = math.random(#path)
        end
        mob:setLocalVar("point", point)
        mob:pathTo(path[point][1], path[point][2], path[point][3], flags)
    end
end

function onSpellPrecast(mob, spell)
    if (spell:getID() == 218) then -- Meteor
        spell:setAoE(tpz.magic.aoe.RADIAL)
        spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
        spell:setRadius(30)
        spell:setAnimation(280)
        spell:setMPCost(1)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        GetNPCByID(ID.npc.APOLLYON_NW_CRATE[5]):setStatus(tpz.status.NORMAL)
    end
end

