-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Memory Receptacle Red
-- Pulling the Plug
-- !addkeyitem CENSER_OF_ACRIMONY
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/promyvion")
-----------------------------------
function onMobSpawn(mob)
    mob:addMod(tpz.mod.ATTP, 10)
    mob:addMod(tpz.mod.DEFP, 20)
    mob:setMod(tpz.mod.MDEF, 40)
    mob:setMod(tpz.mod.UDMGMAGIC, -50)
    mob:setMod(tpz.mod.REGAIN, 250)
    mob:addStatusEffect(tpz.effect.PHYSICAL_SHIELD, 0, 0, 3600)
    mob:addStatusEffect(tpz.effect.ARROW_SHIELD, 0, 0, 3600)
    mob:addStatusEffect(tpz.effect.MAGIC_SHIELD, 0, 0, 3600)
    mob:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):unsetFlag(tpz.effectFlag.DISPELABLE)
    mob:getStatusEffect(tpz.effect.ARROW_SHIELD):unsetFlag(tpz.effectFlag.DISPELABLE)
    mob:getStatusEffect(tpz.effect.MAGIC_SHIELD):unsetFlag(tpz.effectFlag.DISPELABLE)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:SetAutoAttackEnabled(false)
    tpz.promyvion.receptacleOnSpawn(mob)
end

function onMobInitialize(mob)
end

function onMobFight(mob, target)
    local drawinTime = mob:getLocalVar("Drawin")
    local Receptacle = GetMobByID(mob:getID()+1)
    local ReceptacleTwo = GetMobByID(mob:getID()+2)
    local ReceptacleThree = GetMobByID(mob:getID()+3)
    local Spawn = mob:getLocalVar("Spawn")
    if Spawn == 0 then
        Receptacle:spawn()
        Receptacle:updateEnmity(target)
        ReceptacleTwo:spawn()
        ReceptacleTwo:updateEnmity(target)
        ReceptacleThree:spawn()
        ReceptacleThree:updateEnmity(target)
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
    local mimicEmptySeed = mob:getLocalVar("mimicEmptySeed")

    -- All Memory Receptacles use Empty Seed at the same time
    if (os.time() >= mimicEmptySeed) then -- So that it won't spam Yawn after using a TP move that hits multiple targets
        if skill:getID() == 542 then
            for v = 16871447, 16871449 do
                GetMobByID(v):useMobAbility(542)
            end
            mob:setLocalVar("mimicEmptySeed", os.time() + 5)
        end
    end
end




function onMobDeath(mob, player, isKiller, noKiller)
    for v = 16871447, 16871454 do
        DespawnMob(v)
    end
end