-----------------------------------
-- Area: Sealions Den
--   NM: Ultima
-----------------------------------
require("scripts/globals/status");
require("scripts/globals/titles");
require("scripts/globals/msg");
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    mob:setDamage(80)
	mob:addMod(tpz.mod.ATTP, 30)
	mob:addMod(tpz.mod.DEFP, 20) 
	mob:addMod(tpz.mod.ACC, 15) 
	mob:addMod(tpz.mod.EVA, 15)
	mob:setMod(tpz.mod.MDEF, 28) 
	mob:setMod(tpz.mod.REGAIN, 100) -- Should use TP move every ~10 seconds
	mob:setMod(tpz.mod.DOUBLE_ATTACK, 25) 
	mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 10)
	mob:addTP(3000)
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
	local order = mob:setLocalVar("order", 0)
end

-- Ultima has a low likelyhood of using particle shield during phase 1 (Compared to his other abilities)
function onMobWeaponSkillPrepare(mob, target)

    if mob:getHPP() < 20 then

        local order = mob:getLocalVar("order")       
        
        if order == 0 then
            mob:setLocalVar("order", 1)
            return 1270
        elseif order == 1 then
            mob:setLocalVar("order", 2)
            return 1260    
        else
            mob:setLocalVar("order", 0)
            return 1260  
        end
    end


end

function onMobFight(mob, target)

    -- +100% Attack bonus below 30% HP
    if mob:getHPP() < 30 then
        mob:setMod(tpz.mod.ATTP, 100)
    end

    -- Spams TP moves < 20% HP
    if mob:getHPP() < 20 then
        mob:setMod(tpz.mod.REGAIN, 500)
    end

    if not IsMobBusy(mob) then
        if mob:getLocalVar("nuclearWaste") == 1 then
            local ability = math.random(1262,1267)
            mob:useMobAbility(ability)
        end
    end
    
end


function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PARALYZE, {duration = 60})
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addTitle(tpz.title.ULTIMA_UNDERTAKER)
    player:setLocalVar("[OTBF]cs", 0)
end
