-- Wamouracampa family mixin
-- animsub 1= rolled up, animsub 0 = stretched out
-- Takes reduced physical damage and increased magical when rolled up.
-- Takes normal physical damage and reduced magical when streched out.

require("scripts/globals/mixins")
require("scripts/globals/utils")
require("scripts/globals/zone")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.wamouracampa = function(mob)
    mob:addListener("SPAWN", "WAMOURACAMPA_SPAWN", function(mob)
	    mob:AnimationSub(0)
        mob:setMod(tpz.mod.MOVE, 0)
        mob:setMod(tpz.mod.DMGPHYS, 0)
        mob:setMod(tpz.mod.UDMGMAGIC, -33)
        mob:setLocalVar("formTime", os.time() + math.random(43, 47))
        if canEvolve(mob) then
            mob:hideName(false)
            mob:untargetable(false)
            mob:setLocalVar("evolveTime", os.time() + math.random(900, 3600)) -- Between 1 minutes and 1 Vana'diel day
        end
    end)

    mob:addListener("ROAM_TICK", "WAMOURACAMPA_ROAM", function(mob)
        local ID = zones[mob:getZoneID()]
        local roamTime = mob:getLocalVar("formTime")
        if mob:AnimationSub() == 0 and os.time() > roamTime then
            mob:AnimationSub(1)
            mob:setMod(tpz.mod.MOVE, -25)
            mob:setMod(tpz.mod.DMGPHYS, -33)
            mob:setMod(tpz.mod.UDMGMAGIC, 33)
            mob:setLocalVar("formTime", os.time() + math.random(43, 47))
        elseif mob:AnimationSub() == 1 and os.time() > roamTime then
            mob:AnimationSub(0)
            mob:setMod(tpz.mod.MOVE, 0)
            mob:setMod(tpz.mod.DMGPHYS, 0)
            mob:setMod(tpz.mod.UDMGMAGIC, -33)
            mob:setLocalVar("formTime", os.time() + math.random(43, 47))
        end

        if canEvolve(mob) then
            local evolveTime = mob:getLocalVar("evolveTime")
            if os.time() > evolveTime then
                local princeID = mob:getID()
                local wamoura = GetMobByID(princeID + 1)
                wamoura:setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos() + 1)
                mob:hideName(true)
                mob:untargetable(true)
                DespawnMob(princeID)
                wamoura:spawn()
                DisallowRespawn(princeID, true)
            end
        end
    end)

    mob:addListener("COMBAT_TICK", "WAMOURACAMPA_COMBAT", function(mob)
        local fightTime = mob:getLocalVar("formTime")
	    local Animation = mob:getLocalVar("Animation")

        if Animation == 0 then
	        mob:setLocalVar("Animation", math.random(1,2)) --Random roll for animation
	    elseif Animation == 1 and os.time() > fightTime and not IsMobBusy(mob) then
            mob:AnimationSub(1)
            mob:setMod(tpz.mod.MOVE, -25)
            mob:setMod(tpz.mod.UDMGMAGIC, -33)
            mob:setLocalVar("formTime", os.time() + math.random(43, 47))
		    mob:setLocalVar("Animation", math.random(1,2)) --Random roll for animation
        elseif Animation == 2 and os.time() > fightTime and not IsMobBusy(mob) then
            mob:AnimationSub(0)
            mob:setMod(tpz.mod.MOVE, 0)
            mob:setMod(tpz.mod.UDMGMAGIC, 33)
            mob:setLocalVar("formTime", os.time() + math.random(43, 47))
		    mob:setLocalVar("Animation", math.random(1,2)) --Random roll for animation
        end
    end)
end

function canEvolve(mob)
    local zone = mob:getZoneID()
    local canPrinceEvolve = false
    local mobId = mob:getID()
    local ID = zones[mob:getZoneID()]

    for i,v in pairs(ID.mob.EVOLVING_WAMOURA_PRINCES) do
        if mobId == v then   
            canPrinceEvolve = true
        end
    end

    return canPrinceEvolve    
end

return g_mixins.families.wamouracampa
