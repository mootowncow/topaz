-----------------------------------
-- Area: La Vaule [S]
--   NM: Darkheir Grradhod
-- BCNM: Plucking Wings
-- SAM/SAM
-----------------------------------
local ID = require("scripts/zones/La_Vaule_[S]/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/wotg")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
function onMobSpawn(mob)
    tpz.wotg.NMMods(mob)
    mob:setMod(tpz.mod.COUNTER, 25)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE , 20)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 20)
end

function onMobEngaged(mob, target)
    -- Spawn adds on engage
    for v = mob:getID() +2, mob:getID() +4 do
        local adds = GetMobByID(v)
        adds:spawn()
        adds:updateEnmity(target)
    end
end

function onMobFight(mob, target)
    local addsData = 
    {
        { Id = GetMobByID(mob:getID() +2), Mods = { {tpz.mod.MDEF, 70}, {tpz.mod.DMGMAGIC, -33} } }, -- Slitherword
        { Id = GetMobByID(mob:getID() +3), Mods = { {tpz.mod.ATT, 100}, {tpz.mod.STORETP, 100} } }, -- Malicearm
        { Id = GetMobByID(mob:getID() +4), Mods = { {tpz.mod.DEFP, 50}, {tpz.mod.DMGPHYS, -33} } }  -- Gorepledge
    }

    -- If Slitherword Razghogg is alive, Grradhod will have heavy magic resistance.
    -- If Malicearm Razbhobb is alive, Grradhod will have a heavy Attack Bonus and will weaponskill with greater frequency.
    -- If Gorepledge Rozzbrezz is alive, Grradhod will have a heavy Defense Bonus. 
    for _, add in ipairs(addsData) do
        local isAlive = add.Id:isAlive()

        for _, modPair in ipairs(add.Mods) do
            local modType  = modPair[1]
            local modValue = isAlive and modPair[2] or 0 -- Remove if add is dead

            mob:setMod(modType, modValue)
        end
    end

    -- Adds spawn ~1m after they are dead
    for addID = mob:getID() + 2, mob:getID() + 4 do
        local deathTime = mob:getLocalVar("Add_" .. addID)

        if deathTime > 0 and os.time() >= deathTime + 60 then
            local add = GetMobByID(addID)
            if not add:isSpawned() then
                printf("Spawning %s", add:getName())
                add:spawn()
                add:updateEnmity(target)
                mob:setLocalVar("Add_" .. addID, 0) -- reset timer
            end
        end
    end
end

function onMobWeaponSkillPrepare(mob, target)
   local tpMoves = { 609, 2202, 2263, 2264}
   --  Battle Dance, Berserker Dance, Tornado Dance, Shoulder Charge
   return tpMoves[math.random(#tpMoves)]
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller, noKiller)
    -- Despawn adds on death
    for v = mob:getID() +2, mob:getID() +4 do
        DespawnMob(v)
    end
end
