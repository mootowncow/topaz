-----------------------------------
-- Area: The Shrine of Ru'Avitau
--   NM: Mother Globe
-- TODO: Looked like pets had an additional effect: stun with an unknown proc rate
-- TODO: "Links with Slave Globes, and Slave Globes link with Defenders. Defenders do not link with Slave Globes or Mother Globe."
-----------------------------------
local ID = require("scripts/zones/The_Shrine_of_RuAvitau/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/pathfind")
-----------------------------------
function spawnPetInBattle(mob, pet)
    mob:entityAnimationPacket("casm")
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(false)
    mob:SetMobAbilityEnabled(false)
    mob:timer(3000, function(mob)
        mob:entityAnimationPacket("shsm")
        mob:SetAutoAttackEnabled(true)
        mob:SetMagicCastingEnabled(true)
        mob:SetMobAbilityEnabled(true)
        pet:spawn()
        pet:updateEnmity(mob:getTarget())
        pet:setMobMod(tpz.mobMod.SHARE_TARGET, mob:getTarget())
    end)
end

function spawnPetRoaming(mob, pet, pPet)
    mob:entityAnimationPacket("casm")
    mob:timer(3000, function(mob)
        if mob:isAlive() then
            mob:entityAnimationPacket("shsm")
            pet:spawn()
            if pPet == nil then
                pet:pathTo(mob:getXPos() + 0.15, mob:getYPos(), mob:getZPos() + 0.15)
            else
                pet:pathTo(pPet:getXPos() + 0.5, pPet:getYPos(), pPet:getZPos() + 0.5)
            end
        end
    end)
end



function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end



function onMobSpawn(mob)
    SetGenericNMStats(mob)
	mob:addStatusEffect(tpz.effect.SHOCK_SPIKES, 65, 0, 3600)
    local now = os.time()
    mob:addStatusEffectEx(tpz.effect.SHOCK_SPIKES, 0, 60, 0, 0) -- ~60 damage
    mob:setLocalVar("Initial_SlaveTimer", now)
    mob:setLocalVar("SlaveRecast", now)

    mob:addListener("ENGAGE", "MOTHER_GLOBE_ENGAGE", function(mob, target)
        for i = ID.mob.MOTHER_GLOBE.SLAVE_START, ID.mob.MOTHER_GLOBE.SLAVE_END do
            local pet = GetMobByID(i)
            if pet:isSpawned() then
                pet:updateEnmity(target)
            end
        end
    end)

    mob:setLocalVar("path", 0)
    mob:setLocalVar("pathstep", 0)
    onMobRoam(mob)
end


function onMonsterMagicPrepare(mob, target)
	rnd = math.random()

    if (rnd < 0.5) then
        return 196 -- thundaga III
    elseif (rnd < 0.7) then
        return 167 -- thunder IV
    elseif (rnd < 0.9) then
        return 212 -- burst
    else
        return 239 -- shock
    end
    return 0 -- Still need a return, so use 0 when not casting
end


function onMobRoam(mob)
	if not mob:hasStatusEffect(tpz.effect.SHOCK_SPIKES) then
		mob:addStatusEffect(tpz.effect.SHOCK_SPIKES, 65, 0, 3600)
	end

    local now = os.time()
    local slaves = mob:getLocalVar("SlavesSpawned")
    local slaveRecast = mob:getLocalVar("SlaveRecast")
    if slaves > 6 then
        mob:setLocalVar("SlavesSpawned", 0)
    end
    if slaves < 6 and (now >= mob:getLocalVar("Initial_SlaveTimer") + 60) then
        for i = ID.mob.MOTHER_GLOBE.SLAVE_START, ID.mob.MOTHER_GLOBE.SLAVE_END do
            local pet = GetMobByID(i)
            if not pet:isSpawned() and (now > slaveRecast + 10) then
                local pPet = nil
                local petId = pet:getID()
                switch (petId): caseof {
                    [17506397] = function()
                        pet:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
                        spawnPetRoaming(mob, pet, pPet)
                    end,
                    [17506398] = function()
                        pPet = GetMobByID(petId - 1)
                        pet:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
                        spawnPetRoaming(mob, pet, pPet)
                    end,
                    [17506399] = function()
                        pPet = GetMobByID(petId - 1)
                        pet:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
                        spawnPetRoaming(mob, pet, pPet)
                    end,
                    [17506400] = function()
                        pPet = GetMobByID(petId - 1)
                        pet:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
                        spawnPetRoaming(mob, pet, pPet)
                    end,
                    [17506401] = function()
                        pPet = GetMobByID(petId - 1)
                        pet:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
                        spawnPetRoaming(mob, pet, pPet)
                    end,
                    [17506402] = function()
                        pPet = GetMobByID(petId - 1)
                        pet:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
                        spawnPetRoaming(mob, pet, pPet)
                    end,
                }
                mob:setLocalVar("SlaveRecast", now)
                mob:setLocalVar("SlavesSpawned", mob:getLocalVar("SlavesSpawned") + 1)
                break
            end
        end
    end

    local Pos = mob:getPos()
    local pathingTable =
    {
        { x =  860, y = -100, z = -539  },
        { x =  893, y = -100, z = -575  },
        { x =  858, y = -100, z = -618  },
        { x =  822, y = -100, z = -573  },
    }

    tpz.path.loop(mob, pathingTable, tpz.path.flag.RUN)
end


function onMobFight(mob, target) 
    local now = os.time()
    local slaves = mob:getLocalVar("SlavesSpawned")
    local slaveRecast = mob:getLocalVar("SlaveRecast")
	if not mob:hasStatusEffect(tpz.effect.SHOCK_SPIKES) then
		mob:addStatusEffect(tpz.effect.SHOCK_SPIKES, 65, 0, 3600)
	end

    if slaves > 6 then
        mob:setLocalVar("SlavesSpawned", 0)
    end

        -- Summons a single orb every 30 seconds.  Needs to be last, so other code runs.
        -- TODO: Should have a SMN casting effect for ~3-5 seconds while calling.
    if slaves < 6 and (now >= mob:getLocalVar("Initial_SlaveTimer")) then
        for i = ID.mob.MOTHER_GLOBE.SLAVE_START, ID.mob.MOTHER_GLOBE.SLAVE_END do
            local pet = GetMobByID(i)
            if not pet:isSpawned() and (now > slaveRecast + 30) then
                local pPet = nil
                local petId = pet:getID()
                switch (petId): caseof {
                    [17506397] = function() 
                        pet:setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos())
                        spawnPetInBattle(mob, pet)
                    end,
                    [17506398] = function() 
                        pet:setSpawn(mob:getXPos() + 2, mob:getYPos(), mob:getZPos())
                        spawnPetInBattle(mob, pet)
                    end,
                    [17506399] = function() 
                        pet:setSpawn(mob:getXPos() + 3, mob:getYPos(), mob:getZPos())
                        spawnPetInBattle(mob, pet)
                    end,
                    [17506400] = function() 
                        pet:setSpawn(mob:getXPos() + 4, mob:getYPos(), mob:getZPos())
                        spawnPetInBattle(mob, pet)
                    end,
                    [17506401] = function() 
                        pet:setSpawn(mob:getXPos() + 5, mob:getYPos(), mob:getZPos())
                        spawnPetInBattle(mob, pet)
                    end,
                    [17506402] = function() 
                        pet:setSpawn(mob:getXPos() + 6, mob:getYPos(), mob:getZPos())
                        spawnPetInBattle(mob, pet)
                    end,
                }
                mob:setLocalVar("SlaveRecast", now)
                mob:setLocalVar("SlavesSpawned", mob:getLocalVar("SlavesSpawned") + 1)
                break
            end
        end
    end
end


function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENTHUNDER)
end

function onMobDespawn(mob)
    local respawn = 14400
    mob:setRespawnTime(respawn) -- 4 hours
    SetServerVariable("MG_Respawn", (os.time() + respawn))
    mob:removeListener("MOTHER_GLOBE_ENGAGE")
end



function onMobDespawn(mob)
    mob:setRespawnTime(14400) -- 4 hours
end
