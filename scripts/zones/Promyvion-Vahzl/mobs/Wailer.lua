-----------------------------------
-- Area: Promyvion vahzl
--  MOB: Wailer
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/promyvion")
require("scripts/globals/mobs")
require("scripts/zones/Promyvion-Vahzl/globals")
mixins = {require("scripts/mixins/families/empty")}
-----------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.REGAIN, 100)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 120)
    tpz.promyvion.setEmptyModel(mob)
end

function onMobEngaged(mob, target)
    ApplyEmptyAbsorbMods(mob)    
end

function onMobFight(mob, target)
    local ElementToMemoryAbility =
    {
        [tpz.magic.ele.FIRE]      = tpz.mob.skills.MEMORY_OF_FIRE,
        [tpz.magic.ele.ICE]       = tpz.mob.skills.MEMORY_OF_ICE,
        [tpz.magic.ele.WIND]      = tpz.mob.skills.MEMORY_OF_WIND,
        [tpz.magic.ele.EARTH]     = tpz.mob.skills.MEMORY_OF_EARTH,
        [tpz.magic.ele.LIGHTNING] = tpz.mob.skills.MEMORY_OF_LIGHTNING,
        [tpz.magic.ele.WATER]     = tpz.mob.skills.MEMORY_OF_WATER,
        [tpz.magic.ele.LIGHT]     = tpz.mob.skills.MEMORY_OF_LIGHT,
        [tpz.magic.ele.DARK]      = tpz.mob.skills.MEMORY_OF_DARK
    }
    local MemoryAttackTime = mob:getLocalVar("MemoryAttackTime")
    local BattleTime = mob:getBattleTime()

    if MemoryAttackTime == 0 then
        mob:setLocalVar("MemoryAttackTime", BattleTime + 45)
    elseif BattleTime >= MemoryAttackTime then
        mob:useMobAbility(624) -- cloud animation

        -- Change model and element
        tpz.promyvion.setEmptyModel(mob)

        local element = mob:getLocalVar("element")
        ApplyEmptyAbsorbMods(mob)

        -- Use appropriate Memory skill for current element
        local memorySkill = ElementToMemoryAbility[element]
        if memorySkill then
            mob:useMobAbility(memorySkill)
        else
            printf("Mob has invalid memory skill for element: %i", element)
        end

        mob:setLocalVar("MemoryAttackTime", BattleTime + 45)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end