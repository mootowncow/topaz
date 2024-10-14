-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Memory Receptacle Red
-- Pulling the Plug
-- !addkeyitem CENSER_OF_ACRIMONY
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onMobSpawn(mob)
    mob:addMod(tpz.mod.ATTP, 10)
    mob:addMod(tpz.mod.DEFP, 33) 
    mob:setMod(tpz.mod.REGAIN, 250)
    mob:addStatusEffect(tpz.effect.PHYSICAL_SHIELD, 0, 0, 3600)
    mob:addStatusEffect(tpz.effect.ARROW_SHIELD, 0, 0, 3600)
    mob:addStatusEffect(tpz.effect.MAGIC_SHIELD, 0, 0, 3600)
    mob:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):unsetFlag(tpz.effectFlag.DISPELABLE)
    mob:getStatusEffect(tpz.effect.ARROW_SHIELD):unsetFlag(tpz.effectFlag.DISPELABLE)
    mob:getStatusEffect(tpz.effect.MAGIC_SHIELD):unsetFlag(tpz.effectFlag.DISPELABLE)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 10)
    mob:SetAutoAttackEnabled(false)
    mob:speed(0)
    --printf("Add Status");
end

function onMobInitialize(mob)
end

function onMobFight(mob, target)
    local drawinTime = mob:getLocalVar("Drawin")
    local ReceptacleOne     = mob:getID()+1
    local ReceptacleTwo     = mob:getID()+2
    local ReceptacleThree   = mob:getID()+3
    local Spawn = mob:getLocalVar("Spawn")
    for receptacles = ReceptacleOne, ReceptacleThree do
        if not GetMobByID(receptacles):isSpawned() then
            GetMobByID(receptacles):spawn()
            GetMobByID(receptacles):updateEnmity(target)
            GetMobByID(receptacles):setLocalVar("rotationTimer", os.time() + 45)
        end
        mob:setLocalVar("Spawn", 1)
    end

    if drawinTime == 0 then
        mob:setLocalVar("Drawin", 20)
        --printf("Set Draw in time");
        return
    elseif mob:getBattleTime() >= drawinTime then
        mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
        mob:setLocalVar("Drawin", mob:getBattleTime() + 20)
        --printf("Drawing in");
    else
        mob:setMobMod(tpz.mobMod.DRAW_IN, 0)
    end
end

function onMobWeaponSkill(target, mob, skill)
    -- All Memory Receptacles use Empty Seed at the same time
    if skill:getID() == 542 then
         for v = 16871447, 16871449 do
            GetMobByID(v):useMobAbility(542)
         end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    for v = 16871447, 16871454 do
        DespawnMob(v)
    end
end