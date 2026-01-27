-----------------------------------

--   Helper functions for instances

-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/utils")
-----------------------------------

instanceUtil = {}
------------------------------------------------------------------------------------------
-- Finds an available Chest NPC
-- returns the available crate NPC or nil if one is not available
------------------------------------------------------------------------------------------
local function getBestChest(mob)
    local instance = mob:getInstance()
    local ID = zones[mob:getZoneID()]
    local crateNPC = nil
    local possibleCrates = {}

    possibleCrates = ID.armoury_crates

    for _,v in pairs(possibleCrates) do
        local npc = GetNPCByID(v, instance)
        if (npc ~= nil and npc:getStatus() ~= tpz.status.NORMAL) then
            
            crateNPC = npc
            break
        end
    end
    return crateNPC
end

function instanceUtil.spawnArmouryCrateOnMobDeath(mob, x, y, z, r)
    local npc = getBestChest(mob)

    if npc == nil then
        return
    end

    npc:resetLocalVars()
    npc:setAnimation(0)
    npc:AnimationSub(12)
    npc:setPos(x, y, z, r)
    npc:setStatus(tpz.status.NORMAL)
    npc:entityAnimationPacket("deru")

    return npc:getID()
end

instanceUtil.ImperialAgentRescue = {}

function instanceUtil.ImperialAgentRescue.SpawnChestOnMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local instance = mob:getInstance()
        local pos = mob:getPos()
        local chestId = instanceUtil.spawnArmouryCrateOnMobDeath(mob, pos.x, pos.y, pos.z, pos.rot)
        if (chestId ~= nil) then
            GetNPCByID(chestId, instance):setLocalVar("Message", 0)
        end
    end
end