-----------------------------------
-- Area: Caedarva Mire (79)
--  ZNM: Experimental Lamia
-- !pos -773.369 -11.824 322.298 79
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
require("scripts/globals/mobs")
-----------------------------------

local function spawnMinions(mob, target)
    mob:setLocalVar("spawnedMinions", 1)

    local x = mob:getXPos()
    local y = mob:getYPos()
    local z = mob:getZPos()

    for i = ID.mob.EXPERIMENTAL_LAMIA + 1, ID.mob.EXPERIMENTAL_LAMIA + 3 do
        local minion = GetMobByID(i)
        minion:setSpawn(x + math.random(-2, 2), y, z + math.random(-2, 2))
        minion:spawn()
        minion:updateEnmity(target)
    end
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

function onMobSpawn(mob)
    mob:setDamage(130)
    mob:setMod(tpz.mod.ATT, 522)
    mob:setMod(tpz.mod.DEF, 422)
    mob:setMod(tpz.mod.EVA, 278)
    mob:setMod(tpz.mod.MDEF, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, -13)
    mob:setMod(tpz.mod.UDMGBREATH, 0) 
    mob:setMod(tpz.mod.SDT_FIRE, 85)
    mob:setMod(tpz.mod.SDT_ICE, 100)
    mob:setMod(tpz.mod.SDT_WIND, 85)
    mob:setMod(tpz.mod.SDT_EARTH, 85)
    mob:setMod(tpz.mod.SDT_THUNDER, 100)
    mob:setMod(tpz.mod.SDT_WATER, 40)
    mob:setMod(tpz.mod.SDT_LIGHT, 100)
    mob:setMod(tpz.mod.SDT_DARK, 50)
    mob:setMod(tpz.mod.REGAIN, 0)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 8000) -- 9k Gil
    mob:setMobMod(tpz.mobMod.GIL_MAX, 9000) 
    mob:setMobMod(tpz.mobMod.GIL_BONUS, 0) 
    mob:AnimationSub(0)
    mob:setLocalVar("SummonAddsHPP", math.random(75, 99))
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
end

function onMobFight(mob, target)
    local SummonAddsHPP = mob:getLocalVar("SummonAddsHPP")
    -- Summon adds at random HP amount between 75 and 99%
    if mob:getHPP() < SummonAddsHPP and mob:getLocalVar("spawnedMinions") == 0 then
        spawnMinions(mob, target)
    end

    -- make sure minions have a target
    for i = ID.mob.EXPERIMENTAL_LAMIA + 1, ID.mob.EXPERIMENTAL_LAMIA + 3 do
        local minion = GetMobByID(i)
        if minion:getCurrentAction() == tpz.act.ROAMING then
            minion:updateEnmity(target)
        end
    end
    -- Spams TP moves below 25% HP
    if mob:getHPP() < 25 then
    mob:setMod(tpz.mod.REGAIN, 200)
    end
end

function onMobWeaponSkill(target, mob, skill)
    local forcedArrowDeluge = mob:getLocalVar("forcedArrowDeluge")

    -- Uses Arrow Deluge immediately after using Tail Slap
    if skill:getID() == 1758 then -- Tail Slap
        if (os.time() >= forcedArrowDeluge) then -- So that it won't spam Arrow Deluge after using a TP move that hits multiple targets
            mob:useMobAbility(1761) -- Arrow Deluge
            mob:setLocalVar("forcedArrowDeluge", os.time() + 5)
        end
    end
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addCurrency("zeni_point", 300)
	if isKiller  then 
		player:addTreasure(5735, mob)--Cotton Coin Purse
	end
	if isKiller and math.random(1,100) <= 24 then 
		player:addTreasure(5735, mob)--Cotton Coin Purse
	end
	if isKiller and math.random(1,100) <= 15 then 
		player:addTreasure(5735, mob)--Cotton Coin Purse
	end
end
