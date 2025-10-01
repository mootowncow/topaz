-- Zone: Spire of Vahzl
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = require("scripts/zones/Spire_of_Vahzl/IDs")
-----------------------------------
vahzl = {}

vahzl.PATH_RIGHT = 1
vahzl.PATH_TOP = 2
vahzl.PATH_LEFT = 3

vahzl.PullingThePlugSpawnPositions =
{
    { X =-257, Y= 60.00, Z = 0.0 },   -- Right (Blue)
    { X =-240, Y= 60.00, Z = -16 },   -- North (Green)
    { X =-221, Y =60.000,Z = 0   }    -- Left (Teal)
}

function vahzl.PathToNextPoint(mob)
    local currentPath = mob:getLocalVar("path")
    local target = vahzl.PullingThePlugSpawnPositions[currentPath]

    printf("Pathing to point %d", currentPath)
    mob:pathTo(target.X, target.Y, target.Z)
end


function vahzl.StartPathing(mob)
    local movePlatform = mob:getLocalVar("movePlatform")
    local pathing = mob:getLocalVar("pathing")
    local BattleTime = mob:getBattleTime()

	if movePlatform == 0 then
		mob:setLocalVar("movePlatform", BattleTime + 30)
	elseif BattleTime >= movePlatform then
        if pathing == 0 then
            mob:setLocalVar("pathing", 1)
        end

        mob:speed(40)
        mob:clearPath()
        vahzl.PathToNextPoint(mob)
        mob:SetAutoAttackEnabled(false)
        mob:SetMagicCastingEnabled(false)
        mob:SetMobAbilityEnabled(false)
        mob:setLocalVar("movePlatform", BattleTime + 30)
	end
end

function vahzl.StopPathing(mob)
    local currentPath = mob:getLocalVar("path")
    if currentPath == 0 then
        return
    end

	local Pos = mob:getPos()
    local currentPosx = vahzl.PullingThePlugSpawnPositions[currentPath].X

	if (Pos.x == currentPosx) then
        local pathing = mob:getLocalVar("pathing")
        printf("Stop pathing")
        if pathing == 1 then
            mob:speed(0)
            mob:clearPath()
            mob:SetAutoAttackEnabled(true)
            mob:SetMagicCastingEnabled(true)
            mob:SetMobAbilityEnabled(true)
            mob:setLocalVar("pathing", 0)

            -- rotate 1 → 2 → 3 → 1
            mob:setLocalVar("path", (currentPath % 3) + 1)
        end
    end
end