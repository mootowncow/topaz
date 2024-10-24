-----------------------------------
-- Area: Stellar Fulcrum
--  Mob: Kam'lanaut
-- Zilart Mission 8 BCNM Fight
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/mobs")
-----------------------------------

local skillToAbsorb =
{
    [823] = tpz.mod.FIRE_ABSORB,  -- fire_blade
    [824] = tpz.mod.ICE_ABSORB,   -- frost_blade
    [825] = tpz.mod.WIND_ABSORB,  -- wind_blade2
    [826] = tpz.mod.EARTH_ABSORB, -- earth_blade
    [827] = tpz.mod.LTNG_ABSORB,  -- lightning_blade
    [828] = tpz.mod.WATER_ABSORB, -- water_blade
}

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobEngaged(mob, target)
    mob:setLocalVar("nextEnSkill", os.time() + 10)
end

function onMobFight(mob, target)
    if os.time() > mob:getLocalVar("nextEnSkill") then
        local skill = math.random(823, 828)
        mob:setLocalVar("currentTP", mob:getTP())
        mob:useMobAbility(skill)
        mob:setLocalVar("nextEnSkill", os.time() + 20)
    end
end

function onMobWeaponSkill(target, mob, skill)
    local skillId = skill:getID()
    local absorbId = skillToAbsorb[skillId]

    if absorbId then
        -- ----------------------------------------------------------------------
        -- when using en-spell weapon skill, absorb damage of that element type
        -- ----------------------------------------------------------------------

        -- remove previous absorb mod, if set
        local previousAbsorb = mob:getLocalVar("currentAbsorb")

        if previousAbsorb > 0 then
            mob:setMod(previousAbsorb, 0)
        end

        -- add new absorb mod
        mob:setLocalVar("currentAbsorb", absorbId)
        mob:setMod(absorbId, 100)

        -- return TP
        mob:setTP(mob:getLocalVar("currentTP"))
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addTitle(tpz.title.DESTROYER_OF_ANTIQUITY)
end
