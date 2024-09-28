-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  Mob: Armed Gears
-- !pos -19 -4 -153
-----------------------------------
-- todo
-- add add random elemental magic absorb to elements its casting
-----------------------------------
mixins =
{
require("scripts/mixins/job_special"),
require("scripts/mixins/families/gears"),
require("scripts/mixins/rage")
}
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

function onMobSpawn(mob)
    mob:setDamage(130)
    mob:setMod(tpz.mod.ATT, 522)
    mob:setMod(tpz.mod.DEF, 522)
    mob:setMod(tpz.mod.EVA, 320)
    mob:setMod(tpz.mod.UDMGMAGIC, -50)
    mob:setMod(tpz.mod.HTHRES, 100)
    mob:setMod(tpz.mod.SLASHRES, 100)
    mob:setMod(tpz.mod.PIERCERES, 100)
    mob:setMod(tpz.mod.RANGEDRES, 100)
    mob:setMod(tpz.mod.IMPACTRES, 100)
	mob:setMobMod(tpz.mobMod.MAGIC_COOL, 15)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 8000) -- 9k Gil
    mob:setMobMod(tpz.mobMod.GIL_MAX, 9000) 
    mob:setMobMod(tpz.mobMod.GIL_BONUS, 0) 
    mob:AnimationSub(0)
    mob:SetMobSkillAttack(0)
    mob:setLocalVar("element",math.random(1,8))
    mob:setLocalVar("Phase", 1)
    mob:setLocalVar("shift", os.time() + math.random(60, 75))
    mob:setLocalVar("[rage]timer", 4200) -- 70 minutes
end

function onMobEngaged(mob, target)
    mob:setLocalVar("shift", os.time() + math.random(60, 75))
    mob:setLocalVar("element", math.random(1, 8)) -- pick a random element to absorb after engaging
    mob:setMod(tpz.mod.FIRE_ABSORB + mob:getLocalVar("element") - 1, 100)
end

function onMobFight(mob, target)
	local Phase = mob:getLocalVar("Phase")
    local AnimationSub = mob:AnimationSub()
	local BattleTime = mob:getBattleTime()

    -- Set spell list based on current element Armed gears is using(opposites)
    -- Enhancing(haste/blink if wind), T3 nukes, enfeebles, enspells
    local currentAbsorb = mob:getLocalVar("element")
    if currentAbsorb == 1 then -- fire
        mob:setSpellList(2048)
        mob:setMod(tpz.mod.FIREDEF, 256)
        mob:setMod(tpz.mod.ICEDEF, 256)
        mob:setMod(tpz.mod.WINDDEF, 256)
        mob:setMod(tpz.mod.EARTHDEF, 256)
        mob:setMod(tpz.mod.THUNDERDEF, 256)
        mob:setMod(tpz.mod.WATERDEF, 0)
        mob:setMod(tpz.mod.LIGHTDEF, 256)
        mob:setMod(tpz.mod.DARKDEF, 256)
    elseif currentAbsorb == 2 then -- ice
        mob:setSpellList(2049)
        mob:setMod(tpz.mod.FIREDEF, 0)
        mob:setMod(tpz.mod.ICEDEF, 256)
        mob:setMod(tpz.mod.WINDDEF, 256)
        mob:setMod(tpz.mod.EARTHDEF, 256)
        mob:setMod(tpz.mod.THUNDERDEF, 256)
        mob:setMod(tpz.mod.WATERDEF, 256)
        mob:setMod(tpz.mod.LIGHTDEF, 256)
        mob:setMod(tpz.mod.DARKDEF, 256)
    elseif currentAbsorb == 3 then -- wind
        mob:setSpellList(2050)
        mob:setMod(tpz.mod.FIREDEF, 256)
        mob:setMod(tpz.mod.ICEDEF, 0)
        mob:setMod(tpz.mod.WINDDEF, 256)
        mob:setMod(tpz.mod.EARTHDEF, 256)
        mob:setMod(tpz.mod.THUNDERDEF, 256)
        mob:setMod(tpz.mod.WATERDEF, 256)
        mob:setMod(tpz.mod.LIGHTDEF, 256)
        mob:setMod(tpz.mod.DARKDEF, 256)
    elseif currentAbsorb == 4 then -- earth
        mob:setSpellList(2051)
        mob:setMod(tpz.mod.FIREDEF, 256)
        mob:setMod(tpz.mod.ICEDEF, 256)
        mob:setMod(tpz.mod.WINDDEF, 0)
        mob:setMod(tpz.mod.EARTHDEF, 256)
        mob:setMod(tpz.mod.THUNDERDEF, 256)
        mob:setMod(tpz.mod.WATERDEF, 256)
        mob:setMod(tpz.mod.LIGHTDEF, 256)
        mob:setMod(tpz.mod.DARKDEF, 256)
    elseif currentAbsorb == 5 then -- lightning
        mob:setSpellList(2052)
        mob:setMod(tpz.mod.FIREDEF, 256)
        mob:setMod(tpz.mod.ICEDEF, 256)
        mob:setMod(tpz.mod.WINDDEF, 256)
        mob:setMod(tpz.mod.EARTHDEF, 0)
        mob:setMod(tpz.mod.THUNDERDEF, 256)
        mob:setMod(tpz.mod.WATERDEF, 256)
        mob:setMod(tpz.mod.LIGHTDEF, 256)
        mob:setMod(tpz.mod.DARKDEF, 256)
    elseif currentAbsorb == 6 then -- water
        mob:setSpellList(2053)
        mob:setMod(tpz.mod.FIREDEF, 256)
        mob:setMod(tpz.mod.ICEDEF, 256)
        mob:setMod(tpz.mod.WINDDEF, 256)
        mob:setMod(tpz.mod.EARTHDEF, 256)
        mob:setMod(tpz.mod.THUNDERDEF, 0)
        mob:setMod(tpz.mod.WATERDEF, 256)
        mob:setMod(tpz.mod.LIGHTDEF, 256)
        mob:setMod(tpz.mod.DARKDEF, 256)
    elseif currentAbsorb == 7 then -- light
        mob:setSpellList(2054)
        mob:setMod(tpz.mod.FIREDEF, 256)
        mob:setMod(tpz.mod.ICEDEF, 256)
        mob:setMod(tpz.mod.WINDDEF, 256)
        mob:setMod(tpz.mod.EARTHDEF, 256)
        mob:setMod(tpz.mod.THUNDERDEF, 256)
        mob:setMod(tpz.mod.WATERDEF, 256)
        mob:setMod(tpz.mod.LIGHTDEF, 256)
        mob:setMod(tpz.mod.DARKDEF, 0)
    elseif currentAbsorb == 8 then -- dark
        mob:setSpellList(2055)
        mob:setMod(tpz.mod.FIREDEF, 256)
        mob:setMod(tpz.mod.ICEDEF, 256)
        mob:setMod(tpz.mod.WINDDEF, 256)
        mob:setMod(tpz.mod.EARTHDEF, 256)
        mob:setMod(tpz.mod.THUNDERDEF, 256)
        mob:setMod(tpz.mod.WATERDEF, 256)
        mob:setMod(tpz.mod.LIGHTDEF, 0)
        mob:setMod(tpz.mod.DARKDEF, 256)
    end
    -- change elements
    if os.time() >= mob:getLocalVar("shift") then
        -- Remove previous absorb mod
        local previousAbsorb = mob:getLocalVar("element")
        mob:setMod(tpz.mod.FIRE_ABSORB + mob:getLocalVar("element") - 1, 0)

        mob:setLocalVar("shift", os.time() + math.random(60, 75))
        mob:setLocalVar("element", math.random(1, 8)) -- pick a random element to absorb
        -- Add current absorb
        mob:setMod(tpz.mod.FIRE_ABSORB + mob:getLocalVar("element") - 1, 100)
    end
    -- Resistances based on number of gears active
    if AnimationSub == 0 then -- 3 gears
        mob:setMod(tpz.mod.UDMGMAGIC, -50)
        mob:setMod(tpz.mod.HTHRES, 100)
        mob:setMod(tpz.mod.SLASHRES, 100)
        mob:setMod(tpz.mod.PIERCERES, 100)
        mob:setMod(tpz.mod.RANGEDRES, 100)
        mob:setMod(tpz.mod.IMPACTRES, 100)
    end
    if AnimationSub == 1 then -- 2 gears
        mob:setMod(tpz.mod.UDMGMAGIC, -25)
        mob:setMod(tpz.mod.HTHRES, 300)
        mob:setMod(tpz.mod.SLASHRES, 300)
        mob:setMod(tpz.mod.PIERCERES, 300)
        mob:setMod(tpz.mod.RANGEDRES, 300)
        mob:setMod(tpz.mod.IMPACTRES, 300)
    end
    if AnimationSub == 2 then -- 1 gear
        mob:setMod(tpz.mod.UDMGMAGIC, 0)
        mob:setMod(tpz.mod.HTHRES, 600)
        mob:setMod(tpz.mod.SLASHRES, 600)
        mob:setMod(tpz.mod.PIERCERES, 600)
        mob:setMod(tpz.mod.RANGEDRES, 600)
        mob:setMod(tpz.mod.IMPACTRES, 600)
    end
    -- Phase change logic(Loses a gear at 49% and a 2nd at 24%)
    if mob:getHPP() < 50 and Phase == 1 then
        mob:setLocalVar("Phase", 2)
        mob:setLocalVar("GearNumber", 2)
        mob:AnimationSub(1)
    end
    if mob:getHPP() < 25 and Phase == 2 then
        mob:setLocalVar("Phase", 3)
        mob:setLocalVar("GearNumber", 1)
        mob:AnimationSub(2)
    end
end

function onMobWeaponSkillPrepare(mob, target)
    return 2052
end

function onMobWeaponSkill(target, mob, skill)
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