-----------------------------------
-- Area: Vunkerl Inlet [S]
--   ANNM
--   NM: Procrustes
--  !addkeyitem RED_LABELED_CRATE
-----------------------------------
require("scripts/globals/annm")
require("scripts/globals/status")
-----------------------------------
function onMobSpawn(mob)
    mob:setLocalVar("colossalSlamTime", os.time() + math.random(45, 60))
    tpz.annm.NMMods(mob) 
end

function onMobFight(mob, target)
    local colossalSlamTime = mob:getLocalVar("colossalSlamTime")
    local drawInTick = mob:getLocalVar("drawInTick")

    -- Draws in players then uses Colossal Slam every 90 seconds
    if os.time() >= colossalSlamTime then
        local zonePlayers = mob:getZone():getPlayers()
        for _, zonePlayer in pairs(zonePlayers) do
            local mobX = mob:getXPos()
            local mobY = mob:getYPos()
            local mobZ = mob:getZPos()
            if os.time() >= drawInTick then
                mob:setLocalVar("drawInTick", os.time() + 3)
                local nearbyPlayers = mob:getPlayersInRange(40)
                if nearbyPlayers == nil then return end
                zonePlayer:setPos(mob:getXPos() + math.random(1, 3), mob:getYPos(), mob:getZPos() + math.random(1, 3))
                zonePlayer:addStatusEffect(tpz.effect.BIND, 1, 0, 8)
            end
        end
		mob:useMobAbility(2578) -- Colossal Slam
        mob:setLocalVar("colossalSlamTime", os.time() + 45)
	end

    -- Handle Maelstrom being interrupted
    mob:addListener("WEAPONSKILL_STATE_INTERRUPTED", "PROCRUSTES_INTERRUPTED", function(mob, skill)
        if (skill == 2578) then
            mob:setLocalVar("colossalSlamTime", os.time())
        end
    end)
    tpz.annm.PetShield(mob, 17117554, 17117559)
end


function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.annm.SpawnChest(mob, player, isKiller)
end

function onMobDespawn(mob)
end
