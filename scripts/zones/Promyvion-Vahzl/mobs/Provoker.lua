-----------------------------------
-- Area: Promyvion - Vahzl
--   NM: Provoker
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/promyvion")
require("scripts/globals/mobs")
require("scripts/zones/Promyvion-Vahzl/globals")
mixins = {require("scripts/mixins/families/empty")}
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 50)
    mob:addMod(tpz.mod.ATTP, 50)
    mob:setMod(tpz.mod.REGAIN, 100)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
    tpz.promyvion.setEmptyModel(mob)
end

function onMobEngaged(mob, target)
    ApplyEmptyAbsorbMods(mob)    
end

function onMobFight(mob, target)
    local BattleTime = mob:getBattleTime()
    local elementChangeTimer = mob:getLocalVar("elementChangeTimer")

    if elementChangeTimer == 0 then
        mob:setLocalVar("elementChangeTimer", BattleTime + 45)
    elseif BattleTime >= elementChangeTimer then
        mob:useMobAbility(624) -- 2hr  cloud animation

        -- Change model and element
        tpz.promyvion.setEmptyModel(mob)

        local element = mob:getLocalVar("element")
        ApplyEmptyAbsorbMods(mob)

        -- Reset timer
        mob:setLocalVar("elementChangeTimer", BattleTime + 45)
    end
end

function onAdditionalEffect(mob, target, damage)
    local ElementToAdditionalEffect =
    {
        [tpz.magic.ele.FIRE]      = tpz.mob.ae.ENFIRE,
        [tpz.magic.ele.ICE]       = tpz.mob.ae.ENBLIZZARD,
        [tpz.magic.ele.WIND]      = tpz.mob.ae.ENAERO,
        [tpz.magic.ele.EARTH]     = tpz.mob.ae.ENSTONE,
        [tpz.magic.ele.LIGHTNING] = tpz.mob.ae.ENTHUNDER,
        [tpz.magic.ele.WATER]     = tpz.mob.ae.ENWATER,
        [tpz.magic.ele.LIGHT]     = tpz.mob.ae.ENLIGHT,
        [tpz.magic.ele.DARK]      = tpz.mob.ae.ENDARK,
    }
    local element = mob:getLocalVar("element")
    local aeEffect = ElementToAdditionalEffect[element]

    if aeEffect then
        return tpz.mob.onAddEffect(mob, target, damage, aeEffect, {power = math.random(40, 50), chance = 100})
    else
        return 0, 0, 0 -- no effect if unset or invalid
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
	tpz.promyvion.onEmptyDeath(mob)
end
