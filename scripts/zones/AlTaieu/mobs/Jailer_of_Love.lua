-----------------------------------
-- Area: Al'Taieu
--   NM: Jailer of Love
-- !pos 431.522 -0.912 -603.503 33
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
require("scripts/globals/status")
-----------------------------------
local elementToAbsorb =
{
    [307] = tpz.mod.FIRE_ABSORB,  -- Substitute
    [404] = tpz.mod.ICE_ABSORB,   -- Smite of Rage
    [603] = tpz.mod.WIND_ABSORB,  -- Lateral Slash
    [604] = tpz.mod.EARTH_ABSORB, -- Throat Stab
    [624] = tpz.mod.LTNG_ABSORB,  -- Vulture 1
    [625] = tpz.mod.WATER_ABSORB, -- Vulture 2
    [626] = tpz.mod.DARK_ABSORB, -- Vulture 3
    [627] = tpz.mod.LIGHT_ABSORB, -- Vulture 4
}


function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
    mob:setMod(tpz.mod.SUSC_TO_WS_STUN,1)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 18)
end

function onMobSpawn(mob)
	mob:setDamage(280)
    mob:setMod(tpz.mod.ATT, 437) -- 500
    mob:setMod(tpz.mod.DEF, 580) -- 620
    mob:addMod(tpz.mod.EVA, 10)  -- 355
    mob:setMod(tpz.mod.MDEF, 60) -- +60
    mob:setMod(tpz.mod.REFRESH, 400)
    mob:setMod(tpz.mod.UDMGMAGIC, -58)
    mob:setMod(tpz.mod.REGAIN, 75)
    mob:setMod(tpz.mod.REGEN, 250)
    mob:addMod(tpz.mod.MATT, 100)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
    mob:setLocalVar("element",math.random(1,8))
    mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.STANDBACK))
    mob:setMobMod(tpz.mobMod.STANDBACK_RANGE, 13)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
    mob:SetAutoAttackEnabled(true)
    mob:SetMobAbilityEnabled(true)
    mob:SetMagicCastingEnabled(true)
    mob:setLocalVar("af1", 1)
    mob:setLocalVar("af2", 1)
    mob:setLocalVar("af3", 1)
end

function onMobRoam(mob)
    mob:SetAutoAttackEnabled(true)
    mob:SetMobAbilityEnabled(true)
    mob:SetMagicCastingEnabled(true)
    mob:untargetable(false)
end

function onMobEngaged(mob, target)
    mob:setLocalVar("pop_pets", os.time() + 150)
    mob:setLocalVar("shift", os.time() + math.random(120, 180))
    mob:setLocalVar("element", math.random(1, 8)) -- pick a random element to absorb after engaging
    mob:setMod(tpz.mod.FIRE_ABSORB + mob:getLocalVar("element") - 1, 100)
    mob:AnimationSub(2)
    mob:hideName(false)
    mob:untargetable(false)
end

function onMobFight(mob, target, pet)
    local now = os.time()

    -- Disable movement / attacking if pets are out
    for i = 16912849, 16912875 do
        local pet = GetMobByID(i)
        if pet:isSpawned() then
            mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
            mob:SetAutoAttackEnabled(false)
            mob:SetMobAbilityEnabled(false)
            mob:SetMagicCastingEnabled(false)
        end
    end

    -- Set spell list based on current element JOL is absorbing
    local currentAbsorb = mob:getLocalVar("element")
    if currentAbsorb == 1 then -- fire
        mob:setSpellList(485)
    elseif currentAbsorb == 2 then -- ice
        mob:setSpellList(486)
    elseif currentAbsorb == 3 then -- wind
        mob:setSpellList(487)
    elseif currentAbsorb == 4 then -- earth
        mob:setSpellList(488)
    elseif currentAbsorb == 5 then -- lightning
        mob:setSpellList(489)
    elseif currentAbsorb == 6 then -- water
        mob:setSpellList(490)
    elseif currentAbsorb == 7 then -- light
        mob:setSpellList(484)
    elseif currentAbsorb == 8 then -- dark
        mob:setSpellList(491)
    end

    -- reduce regen after nine Xzomits and Hpemdes are killed
    if mob:getLocalVar("JoL_Regen_Reduction") == 0 and mob:getLocalVar("JoL_Qn_xzomit_Killed") >= 9 and mob:getLocalVar("JoL_Qn_hpemde_Killed") >= 9 then
        mob:setLocalVar("JoL_Regen_Reduction", 1)
        mob:setMod(tpz.mod.REGEN, 50)
    end


    -- spawn minions in 2.5 minute intervals
    if mob:getCurrentAction() ~= tpz.action.MAGIC_CASTING and now > mob:getLocalVar("pop_pets") then
        mob:stun(3000)
        mob:entityAnimationPacket("casm")
        mob:setLocalVar("pop_pets", os.time() + 150)
        mob:timer(3000, function(mob)
            if mob:isDead() then return; end

            local minionGroup =
            {
                [0] = 10, -- Qnxzomit
                [1] = 19, -- Qnhpemde
                [2] =  1, -- Ruphuabo
                [3] = 13, -- Qnxzomit
                [4] = 22, -- Qnhpemde
                [5] =  4, -- Ruphuabo
                [6] = 16, -- Qnxzomit
                [7] = 25, -- Qnhpemde
            }

            mob:entityAnimationPacket("shsm")
            local pos = mob:getPos()
            local spawns = mob:getLocalVar("SPAWNS")
            local mobid = mob:getID()
            local target = mob:getTarget()
            if spawns < 8 then
                local minionOffset = mobid + minionGroup[spawns]
                local pet1 = GetMobByID(minionOffset + 0)
                pet1:setSpawn(pos.x, pos.y - 1, pos.z)
                pet1:spawn()
                if target then pet1:updateEnmity(target); end
                local pet2 = GetMobByID(minionOffset + 1)
                pet2:setSpawn(pos.x, pos.y - 2, pos.z)
                pet2:spawn()
                if target then pet2:updateEnmity(target); end
                local pet3 = GetMobByID(minionOffset + 2)
                pet3:setSpawn(pos.x, pos.y - 3, pos.z)
                pet3:spawn()
                if target then pet3:updateEnmity(target); end
                mob:setLocalVar("SPAWNS", spawns + 1)
                if mob:getHPP() >= 51 and mob:getHPP() <= 75 then 
                    if (pet1:isAlive() or pet2:isAlive() or pet3:isAlive()) and mob:getLocalVar("af1") == 1 then
                        mob:useMobAbility(604)
                        mob:setLocalVar("af1", 0)
                    end
                elseif mob:getHPP() >= 26 and mob:getHPP() <= 50 then
                    if (pet1:isAlive() or pet2:isAlive() or pet3:isAlive()) and mob:getLocalVar("af2") == 1 then
                        mob:useMobAbility(604)
                        mob:setLocalVar("af2", 0)
                    end
                elseif mob:getHPP() >= 1 and mob:getHPP() <= 25 then
                    if (pet1:isAlive() or pet2:isAlive() or pet3:isAlive()) and mob:getLocalVar("af3") == 1 then
                        mob:useMobAbility(604)
                        mob:setLocalVar("af3", 0)
                    end
                end
            else
                -- determine which sharks are currently spawned
                local phuaboUp = {}
                local phuaboDn = {}
                for i = mobid + 1, mobid + 9 do
                    local phuabo = GetMobByID(i)
                    if phuabo:isAlive() then
                        table.insert(phuaboUp, i)
                    elseif not phuabo:isSpawned() then
                        table.insert(phuaboDn, i)
                    end
                end

                -- how many sharks spawn depends on number currently alive
                -- https://www.bg-wiki.com/bg/Jailer_of_Love
                local numToSpawn = 0
                if #phuaboUp == 2 then
                    numToSpawn = 1
                elseif #phuaboUp == 0 or #phuaboUp == 3 then
                    numToSpawn = 3
                elseif #phuaboUp == 1 then
                    numToSpawn = math.random(3)
                end
                
                -- spawn sharks
                for i = 1, math.min(numToSpawn, #phuaboDn) do
                    local pet = GetMobByID(phuaboDn[i])
                    pet:setSpawn(pos.x, pos.y - 1, pos.z)
                    pet:spawn()
                    if target then pet:updateEnmity(target); end
                    if mob:getHPP() >= 51 and mob:getHPP() <= 75 then 
                        if pet:isAlive()and mob:getLocalVar("af1") == 1 then
                            mob:useMobAbility(604)
                            mob:setLocalVar("af1", 0)
                        end
                    elseif mob:getHPP() >= 26 and mob:getHPP() <= 50 then
                        if pet:isAlive() and mob:getLocalVar("af2") == 1 then
                            mob:useMobAbility(604)
                            mob:setLocalVar("af2", 0)
                        end
                    elseif mob:getHPP() >= 1 and mob:getHPP() <= 25 then
                        if pet:isAlive() and mob:getLocalVar("af3") == 1 then
                            mob:useMobAbility(604)
                            mob:setLocalVar("af3", 0)
                        end
                end
                end
                
            end
        end)
    end
   
    -- change elements
    if now > mob:getLocalVar("shift") then
        mob:useMobAbility(624)
        -- Remove previous absorb mod
        local previousAbsorb = mob:getLocalVar("element")
        mob:setMod(tpz.mod.FIRE_ABSORB + mob:getLocalVar("element") - 1, 0)

        mob:setLocalVar("shift", os.time() + math.random(120, 180))
        mob:setLocalVar("element", math.random(1, 8)) -- pick a random element to absorb
        -- Add current absorb
        mob:setMod(tpz.mod.FIRE_ABSORB + mob:getLocalVar("element") - 1, 100)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    -- despawn pets
    for i = ID.mob.JAILER_OF_LOVE + 1, ID.mob.JAILER_OF_LOVE + 27 do
        if GetMobByID(i):isSpawned() then
            DespawnMob(i)
        end
    end
    -- Spawn AV
    local AV = GetMobByID(ID.mob.ABSOLUTE_VIRTUE)
    local mobX = mob:getXPos()
    local mobY = mob:getYPos()
    local mobZ = mob:getZPos()
    AV:setSpawn(mobX, mobY, mobZ)
    AV:spawn()
    AV:updateClaim(player)
end

function onMobDespawn(mob)
end