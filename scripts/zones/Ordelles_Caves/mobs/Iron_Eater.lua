-----------------------------------
-- Area: Ordelle's Caves
--   NM: Zeid
-- !additem 474
-- Mythic weapon fight
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/hunts")
require("scripts/globals/mobs")
require("scripts/globals/status")
------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobSpawn(mob)
	mob:setDamage(50)
	mob:setMod(tpz.mod.ATTP, 0)
	mob:setMod(tpz.mod.DEFP, 0)
	mob:setMod(tpz.mod.MDEF, 0)
	mob:setMod(tpz.mod.UDMGPHYS, 0) 
	mob:setMod(tpz.mod.UDMGRANGE, 0)
	mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setMod(tpz.mod.REFRESH, 400)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 25)
	mob:setMobMod(tpz.mobMod.SKILL_LIST, 6065)
	mob:setLocalVar("TwoHourUsed", 0)
end

function onMobFight(mob, target)
	local BerserkTime = mob:getLocalVar("BerserkTime")
	local DefenderTime = mob:getLocalVar("DefenderTime")
	local Stance = mob:getLocalVar("Stance")
	local BattleTime = mob:getBattleTime()
	
	if BerserkTime == 0 then
		mob:setLocalVar("BerserkTime", BattleTime + 30)
	elseif BattleTime >= BerserkTime and Stance == 0 then
		mob:useMobAbility(697) -- Berserk
		mob:setDamage(100)
		mob:setMod(tpz.mod.ATTP, 25)
		mob:setMod(tpz.mod.DEFP, -50)
		mob:setMod(tpz.mod.MDEF, 0)
		mob:setMod(tpz.mod.UDMGPHYS, 12) 
		mob:setMod(tpz.mod.UDMGRANGE, 12)
		mob:setMod(tpz.mod.UDMGMAGIC, 12)
		mob:setLocalVar("DefenderTime", BattleTime + 60)
		mob:setLocalVar("Stance", 1)
        local zonePlayers = mob:getZone():getPlayers()
        for _, zonePlayer in pairs(zonePlayers) do
            zonePlayer:PrintToPlayer("Sometimes, one must step back from the trees in order to see the forest.",0,"Iron Eater")
        end
	end

	if DefenderTime > 0 and BattleTime >= DefenderTime and Stance == 1 then
		mob:useMobAbility(698) -- Defender
		mob:setDamage(50)
		mob:setMod(tpz.mod.DEFP, 150)
		mob:setMod(tpz.mod.MDEF, 24)
		mob:setMod(tpz.mod.UDMGPHYS, -12) 
		mob:setMod(tpz.mod.UDMGRANGE, -12)
		mob:setMod(tpz.mod.UDMGMAGIC, -12)
		mob:setLocalVar("BerserkTime", BattleTime + 60)
		mob:setLocalVar("Stance", 0)
        local zonePlayers = mob:getZone():getPlayers()
        for _, zonePlayer in pairs(zonePlayers) do
            zonePlayer:PrintToPlayer("Eyes open, always be learning.",0,"Iron Eater")
        end
	end
end


function onMobDeath(mob, player, isKiller, noKiller)
    local zonePlayers = mob:getZone():getPlayers()
    for _, zonePlayer in pairs(zonePlayers) do
        player:PrintToPlayer("All rivers eventually lead out to sea... May we meet again.",0,"Iron Eater")
        break
    end
end
