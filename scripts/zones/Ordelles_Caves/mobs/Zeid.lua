-----------------------------------
-- Area: Ordelle's Caves
--   NM: Zeid
-- !additem 481
-- Mythic weapon fight
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
require("scripts/globals/status")
------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobSpawn(mob)
    SetGenericNMStats(mob)
	mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMod(tpz.mod.REFRESH, 400)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 0)
	mob:setMobMod(tpz.mobMod.SKILL_LIST, 6063)
end

function onMobEngaged(mob, target)
	mob:setLocalVar("TwoHourUsed", 0)
    mob:setLocalVar("StunTime", 0)
    mob:setLocalVar("DreadSpikesTime", 0)
    mob:setLocalVar("DrainTime", 0)
end

function onMobFight(mob, target)
	local StunTime = mob:getLocalVar("StunTime")
	local DreadSpikesTime = mob:getLocalVar("DreadSpikesTime")
	local DrainTime = mob:getLocalVar("DrainTime")
	local BattleTime = mob:getBattleTime()
	
	if mob:getHPP() >= 50 then
		if StunTime == 0 then
			mob:setLocalVar("StunTime", BattleTime + 45)
		elseif BattleTime >= StunTime then
			mob:castSpell(252) -- Stun
            MessageGroup(mob, target, "No, pay closer attention and copy my technique.",0,"Zeid")
			mob:setLocalVar("StunTime", BattleTime + 45)
		end
	end
	
	if mob:getHPP() <= 50 and mob:getHPP() > 25 then
		if DreadSpikesTime == 0 then
			mob:setLocalVar("DreadSpikesTime", BattleTime)
		elseif BattleTime >= DreadSpikesTime then
			local typeEffect = tpz.effect.DREAD_SPIKES
			mob:addStatusEffect(typeEffect, 0, 0, 60, 0, 1000, 1)
            MessageGroup(mob, target, "Give me all you've got!",0,"Zeid")
			mob:setLocalVar("DreadSpikesTime", BattleTime + 45)
		end
	end
	
	if mob:getHPP() <= 25 then
		if DrainTime == 0 then
			mob:setLocalVar("DrainTime", BattleTime)
		elseif BattleTime >= DrainTime then
			mob:castSpell(246) -- Drain II
            MessageGroup(mob, target, "I feed off your rage!",0,"Zeid")
			mob:setLocalVar("DrainTime", BattleTime + 45)
		end
	end
	
	local TwoHourUsed = mob:getLocalVar("TwoHourUsed")
	if mob:getHPP() <= 50 and TwoHourUsed == 0 then
		mob:useMobAbility(695) -- Blood weapon
		mob:setMobMod(tpz.mobMod.SKILL_LIST, 6064)
        MessageGroup(mob, target, "I must fight with you longer!",0,"Zeid")
		mob:setLocalVar("TwoHourUsed", 1)
	end
end

function onSpellPrecast(mob, spell)
    if spell:getID() == 252 then -- Stun
        spell:setAoE(tpz.magic.aoe.RADIAL)
        spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
        spell:setRadius(30)
	end
    if spell:getID() == 246 then -- Drain II
        spell:setAoE(tpz.magic.aoe.RADIAL)
        spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
        spell:setRadius(30)
	end
end

function onMobDisengage(mob)
	mob:setLocalVar("TwoHourUsed", 0)
    mob:setLocalVar("StunTime", 0)
    mob:setLocalVar("DreadSpikesTime", 0)
    mob:setLocalVar("DrainTime", 0)
end

function onMobDeath(mob, player, isKiller, noKiller)
    OnDeathMessage(mob, player, isKiller, noKiller, "You have learned well.",0,"Zeid")
end
