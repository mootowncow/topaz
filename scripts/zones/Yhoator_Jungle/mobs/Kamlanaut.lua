-----------------------------------
-- Area: Yhoator Jungle
--  Mob: Kamlanaut
-- RAID NM
-----------------------------------
require("scripts/globals/raid")
-----------------------------------
function onMobSpawn(mob)
    tpz.raid.onMobSpawn(mob)
end

function onMobEngaged(mob, target)
    mob:setLocalVar("nextEnSkill", os.time() + 10)
end

function onMobFight(mob, target)
    tpz.raid.onMobFight(mob)
end

function onMobWeaponSkill(target, mob, skill)
    local skillToAbsorb =
    {
        [823] = tpz.mod.FIRE_ABSORB,  -- fire_blade
        [824] = tpz.mod.ICE_ABSORB,   -- frost_blade
        [825] = tpz.mod.WIND_ABSORB,  -- wind_blade2
        [826] = tpz.mod.EARTH_ABSORB, -- earth_blade
        [827] = tpz.mod.LTNG_ABSORB,  -- lightning_blade
        [828] = tpz.mod.WATER_ABSORB, -- water_blade
    }
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

    else
        -- ----------------------------------------------------------------------
        -- when using Light Blade or Great Wheel, can do up to three WS in a row
        -- ----------------------------------------------------------------------

        local wsCount = mob:getLocalVar("wsCount")
        local wsMax = mob:getLocalVar("wsMax")

        if wsCount == 0 then
            wsMax = math.random(0, 2)
            mob:setLocalVar("wsMax", wsMax)
        end

        if wsCount < wsMax then
            mob:setLocalVar("wsCount", wsCount + 1)
            mob:setTP(3000)
        else
            mob:setLocalVar("wsCount", 0)
        end
    end
end

function onSpellPrecast(mob, spell)
    tpz.raid.onSpellPrecast(mob, spell)
end

function onMobDespawn(mob)
    tpz.raid.onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.raid.onMobDeath(mob)
end