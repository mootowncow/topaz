------------------------------
-- Area: Rolanberry Fields
--   NM: Eldritch Edge
--  !gotoid 17228150
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
end

function onMobSpawn(mob)
	mob:setDamage(140)
    mob:setMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.DEFP, 25) 
    mob:addMod(tpz.mod.EVA, 15)
    mob:setMod(tpz.mod.STORETP, 100)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobFight(mob, target)
    local currentHP = mob:getHPP()
    local phaseData = {
        { HP = 20,     Var = 'hundredFists_20'   },
        { HP = 40,     Var = 'hundredFists_40'   },
        { HP = 60,     Var = 'hundredFists_60'   },
        { HP = 80,     Var = 'hundredFists_80'   },
    }

    -- Uses Hundred Fists every 10%
    for _, phase in ipairs(phaseData) do
        if (currentHP <= phase.HP) and (mob:getLocalVar(phase.Var) == 0) then
            if
                not IsMobBusy(mob) and
                not mob:hasPreventActionEffect() and
                not mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS)
            then
                mob:setLocalVar(phase.Var, 1)
                mob:useMobAbility(tpz.jsa.HUNDRED_FISTS)
                break
            end
        end
    end

    -- 100% Counter rate during Hundred Fists
    if mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS) then
        mob:setMod(tpz.mod.COUNTER, 100)
    else
        mob:setMod(tpz.mod.COUNTER, 0)
    end
end

function onAdditionalEffect(mob, target, damage)
    if mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS) then
	    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.CURSE, {chance = 20, power = 50})
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 218)
end
