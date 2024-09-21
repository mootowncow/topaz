------------------------------
-- Area: The Eldieme Necropolis
--   Raubahn
--  !additem 475 
--	!pos 105.9537 0.4000 -179.0539
-- Mythic weapon fight
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/titles")
require("scripts/globals/mobs")
require("scripts/globals/status")
------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobSpawn(mob)
    SetGenericNMStats(mob)
	mob:setMod(tpz.mod.ATTP, 0)
	mob:setMod(tpz.mod.DEFP, 0) 
	mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
	mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setUnkillable(true)
end

function onMobFight(mob, target)
    local Phase = mob:getLocalVar("Phase")
	local HP = mob:getHPP()
    if HP < 25 and Phase == 0 then
		mob:setHP(35000)
		mob:setLocalVar("Phase", 1)
		mob:addMod(tpz.mod.ATTP, 20)
		mob:addMod(tpz.mod.DEFP, 20) 
        mob:setModelId(1799) -- Yellow Flan
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 112)
        MessageGroup(mob, target, "This power...I cannot contain it much longer...",0,"Raubahn")
	end
    if HP < 25 and Phase == 1 then
		mob:setHP(35000)
		mob:setLocalVar("Phase", 2)
		mob:addMod(tpz.mod.ATTP, 20)
		mob:addMod(tpz.mod.DEFP, 20) 
		mob:setModelId(1774) -- Qutrub
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 203)
        MessageGroup(mob, target, "It's...too....powerful.....",0,"Raubahn")
	end
    if HP < 25 and Phase == 2 then
        mob:useMobAbility(tpz.jsa.AZURE_LORE)
		mob:setHP(35000)
		mob:setLocalVar("Phase", 3)
		mob:addMod(tpz.mod.ATTP, 20)
		mob:addMod(tpz.mod.DEFP, 20) 
		mob:setModelId(1775) -- Soulflayer
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 233)
        MessageGroup(mob, target, "...All will succumb to the void....",0,"Soulflayer")
		mob:setUnkillable(false)
	end
end


function onMobDeath(mob, player, isKiller, noKiller)
    OnDeathMessage(mob, player, isKiller, noKiller, "...and you too shall succumb.",0,"Soulflayer")
end


