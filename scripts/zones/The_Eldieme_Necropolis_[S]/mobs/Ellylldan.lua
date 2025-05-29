-----------------------------------
-- Area: The Eldieme Necropolis [S] (175)
--   ANNM
--   NM: Ellylldan
--  !addkeyitem RED_LABELED_CRATE
-----------------------------------
require("scripts/globals/annm")
require("scripts/globals/status")
require("scripts/globals/pathfind")
-----------------------------------
function onMobSpawn(mob)
    mob:setMod(tpz.mod.MOVE, 0)
    mob:SetAutoAttackEnabled(false)
    mob:setLocalVar("patrolPath", 1)
    mob:setLocalVar("damageTick", 0)
    tpz.annm.NMMods(mob) 
end

function onMobFight(mob, target)
	local patrolPath = mob:getLocalVar("patrolPath")
    local damageTick = mob:getLocalVar("damageTick")
    local hp = mob:getHPP()
    local Pos = mob:getPos()

    mob:setMod(tpz.mod.REGEN, 0)

    -- Damage nearby players and drain their MP while patorlling around
    if os.time() >= damageTick then
        mob:setLocalVar("damageTick", os.time() + 3)
        local nearbyPlayers = mob:getPlayersInRange(12)
        if nearbyPlayers == nil then return end
        for _,v in ipairs(nearbyPlayers) do
            local mp = math.floor((v:getMaxMP() * math.random(1, 3)) / 10)
            local dmg = 500
            dmg = v:magicDmgTaken(dmg, tpz.magic.ele.DARK)
            v:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)
            v:delMP(mp)
        end
    end
    -- Movement speed decereases as HP lowers
    if (hp < 25) then
        mob:setMod(tpz.mod.MOVE, 15)
    elseif (hp < 50) then
        mob:setMod(tpz.mod.MOVE, 10)
    elseif (hp < 75) then
        mob:setMod(tpz.mod.MOVE, 5)
    end

    if mob:getTP() >= 1000 then
        mob:setTP(3000)
        mob:setLocalVar("patrolPath", 0)
    end

    -- Swap to other patrol route once ending first route
    if (Pos.x == 253) and (Pos.y == -15) and (Pos.z == -180) and (patrolPath == 1) then
        mob:setLocalVar("patrolPath", 2)
    end
    if (Pos.x == 374) and (Pos.y == -31) and (Pos.z == -339) and (patrolPath == 2) then
        mob:setLocalVar("patrolPath", 1)
    end
    -- Patrol around the area and never auto-attack
	if (patrolPath == 1) then
		mob:pathTo( 253, -15, -180) -- Position needs to be added
	end
	
	if (patrolPath == 2) then
		mob:pathTo(374, -31, -339) -- Position needs to be added
	end
    tpz.annm.PetShield(mob, 17494280, 17494285)
end

function onMobWeaponSkill(target, mob, skill)
    -- After using a TP move, continue on a random patrol path
    if skill:getID() > 0 then
        mob:setLocalVar("patrolPath", math.random(1, 2))
    end
    -- Changes SDT after using Berserk
    if skill:getID() == 2217 then -- Berserk
        -- Remove previous absorb mod
        local previousAbsorb = mob:getLocalVar("element")
        mob:setMod(tpz.mod.FIRE_ABSORB + mob:getLocalVar("element") - 1, 0)

        mob:setLocalVar("element", math.random(1, 8)) -- pick a random element to absorb
        -- Add current absorb and change SDT
        mob:setMod(tpz.mod.FIRE_ABSORB + mob:getLocalVar("element") - 1, 100)
        ChangeElement(mob)
    end
end

function ChangeElement(mob)
    local currentElement = mob:getLocalVar("element")
    print("element %s", currentElement)
    if currentElement == 1 then -- fire
        mob:setMod(tpz.mod.SDT_FIRE, 5)
        mob:setMod(tpz.mod.SDT_ICE, 5)
        mob:setMod(tpz.mod.SDT_WIND, 5)
        mob:setMod(tpz.mod.SDT_EARTH, 5)
        mob:setMod(tpz.mod.SDT_THUNDER, 5)
        mob:setMod(tpz.mod.SDT_WATER, 100)
        mob:setMod(tpz.mod.SDT_LIGHT, 5)
        mob:setMod(tpz.mod.SDT_DARK, 5)
    elseif currentElement == 2 then -- ice
        mob:setMod(tpz.mod.SDT_FIRE, 100)
        mob:setMod(tpz.mod.SDT_ICE, 5)
        mob:setMod(tpz.mod.SDT_WIND, 5)
        mob:setMod(tpz.mod.SDT_EARTH, 5)
        mob:setMod(tpz.mod.SDT_THUNDER, 5)
        mob:setMod(tpz.mod.SDT_WATER, 5)
        mob:setMod(tpz.mod.SDT_LIGHT, 5)
        mob:setMod(tpz.mod.SDT_DARK, 5)
    elseif currentElement == 3 then -- wind
        mob:setMod(tpz.mod.SDT_FIRE, 5)
        mob:setMod(tpz.mod.SDT_ICE, 100)
        mob:setMod(tpz.mod.SDT_WIND, 5)
        mob:setMod(tpz.mod.SDT_EARTH, 5)
        mob:setMod(tpz.mod.SDT_THUNDER, 5)
        mob:setMod(tpz.mod.SDT_WATER, 5)
        mob:setMod(tpz.mod.SDT_LIGHT, 5)
        mob:setMod(tpz.mod.SDT_DARK, 5)
    elseif currentElement == 4 then -- earth
        mob:setMod(tpz.mod.SDT_FIRE, 5)
        mob:setMod(tpz.mod.SDT_ICE, 5)
        mob:setMod(tpz.mod.SDT_WIND, 100)
        mob:setMod(tpz.mod.SDT_EARTH, 5)
        mob:setMod(tpz.mod.SDT_THUNDER, 5)
        mob:setMod(tpz.mod.SDT_WATER, 5)
        mob:setMod(tpz.mod.SDT_LIGHT, 5)
        mob:setMod(tpz.mod.SDT_DARK, 5)
    elseif currentElement == 5 then -- lightning
        mob:setMod(tpz.mod.SDT_FIRE, 5)
        mob:setMod(tpz.mod.SDT_ICE, 5)
        mob:setMod(tpz.mod.SDT_WIND, 5)
        mob:setMod(tpz.mod.SDT_EARTH, 100)
        mob:setMod(tpz.mod.SDT_THUNDER, 5)
        mob:setMod(tpz.mod.SDT_WATER, 5)
        mob:setMod(tpz.mod.SDT_LIGHT, 5)
        mob:setMod(tpz.mod.SDT_DARK, 5)
    elseif currentElement == 6 then -- water
        mob:setMod(tpz.mod.SDT_FIRE, 5)
        mob:setMod(tpz.mod.SDT_ICE, 5)
        mob:setMod(tpz.mod.SDT_WIND, 5)
        mob:setMod(tpz.mod.SDT_EARTH, 5)
        mob:setMod(tpz.mod.SDT_THUNDER, 100)
        mob:setMod(tpz.mod.SDT_WATER, 5)
        mob:setMod(tpz.mod.SDT_LIGHT, 5)
        mob:setMod(tpz.mod.SDT_DARK, 5)
    elseif currentElement == 7 then -- light
        mob:setMod(tpz.mod.SDT_FIRE, 5)
        mob:setMod(tpz.mod.SDT_ICE, 5)
        mob:setMod(tpz.mod.SDT_WIND, 5)
        mob:setMod(tpz.mod.SDT_EARTH, 5)
        mob:setMod(tpz.mod.SDT_THUNDER, 5)
        mob:setMod(tpz.mod.SDT_WATER, 5)
        mob:setMod(tpz.mod.SDT_LIGHT, 5)
        mob:setMod(tpz.mod.SDT_DARK, 100)
    elseif currentElement == 8 then -- dark
        mob:setMod(tpz.mod.SDT_FIRE, 5)
        mob:setMod(tpz.mod.SDT_ICE, 5)
        mob:setMod(tpz.mod.SDT_WIND, 5)
        mob:setMod(tpz.mod.SDT_EARTH, 5)
        mob:setMod(tpz.mod.SDT_THUNDER, 5)
        mob:setMod(tpz.mod.SDT_WATER, 5)
        mob:setMod(tpz.mod.SDT_LIGHT, 100)
        mob:setMod(tpz.mod.SDT_DARK, 5)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.annm.SpawnChest(mob, player, isKiller)
end

function onMobDespawn(mob)
end
