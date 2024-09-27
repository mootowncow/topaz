-----------------------------------
-- Area: Meriphataud Mountains [S]
--   ANNM
--   NM: Brummbar
--  !addkeyitem GREEN_LABELED_CRATE
-----------------------------------
require("scripts/globals/annm")
require("scripts/globals/status")
-----------------------------------
function onMobSpawn(mob)
    mob:setLocalVar("DischargeTime", 45)
    tpz.annm.NMMods(mob)
    mob:setDamage(70)
end

function onMobFight(mob, target)
	local DischargeTime = mob:getLocalVar("DischargeTime")
	local BattleTime = mob:getBattleTime()

    -- So he can transfer these debuffs back
    mob:delImmunity(tpz.immunity.GRAVITY)
    mob:delImmunity(tpz.immunity.SILENCE) 
    mob:delImmunity(tpz.immunity.POISON)

    -- Applies status effects to itself and transfers to nearby targets every 45 seconds
    if BattleTime >= DischargeTime then
        mob:useMobAbility(626) -- 2 hr cloud (Light / White)
        mob:addStatusEffect(tpz.effect.POISON, 33, 3, 120)
        mob:addStatusEffect(tpz.effect.PARALYSIS, 33, 0, 120)
        mob:addStatusEffect(tpz.effect.BLINDNESS, 80, 0, 120)
        mob:addStatusEffect(tpz.effect.SILENCE, 1, 0, 120)
        mob:addStatusEffect(tpz.effect.WEIGHT, 20, 0, 120)
        mob:addStatusEffect(tpz.effect.SLOW, 2550, 0, 120)
        mob:addStatusEffect(tpz.effect.PLAGUE, 3, 3, 120)
		mob:useMobAbility(2162) -- Emetic Discharge
		mob:setLocalVar("DischargeTime", BattleTime + math.random(60,90))
	end

    -- Handle Emetic Discharge being interrupted
    mob:addListener("WEAPONSKILL_STATE_INTERRUPTED", "ES_WS_INTERRUPTED", function(mob, skill)
        if skill == 2162 then
            mob:setLocalVar("DischargeTime", 0)
        end
    end)

    tpz.annm.PetShield(mob, 17174894, 17174899)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.annm.SpawnChest(mob, player, isKiller)
end

function onMobDespawn(mob)
end
