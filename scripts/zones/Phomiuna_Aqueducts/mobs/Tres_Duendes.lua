-----------------------------------
-- Area: Phomiuna_Aqueducts
--  MOB: Tres Duendes
-- !pos -140 0 166 27
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    SetGenericNMStats(mob)
end

function onMobFight(mob)
    if mob:getBattleTime() > mob:getLocalVar("changeTime") + math.random(55,65) then
        changeStance(mob)
    end
end

-- stance 1: (cluster form) delay(2400) damage(100) triple_att(0)
-- stance 2: (horizontal form) delay(4800) damage(100) triple_att(0)
-- stance 3: (vertical form) delay(2400) damage(50) triple_att(100)

function changeStance(mob)
    if mob:AnimationSub() > 1 then
        mob:AnimationSub(1)
        mob:setDamage(100)
        mob:setDelay(2400)
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 0)
    else
        local stance = math.random(2,3)
        mob:AnimationSub(stance)

        if stance == 2 then
            mob:setDamage(100)
            mob:setDelay(4000)
            mob:setMod(tpz.mod.TRIPLE_ATTACK, 0)
        else
            mob:setDamage(33)
            mob:setDelay(2500)
            mob:setMod(tpz.mod.TRIPLE_ATTACK, 100)
        end
    end
    mob:setLocalVar("changeTime", mob:getBattleTime())
end

function onMobEngaged(mob)
    mob:AnimationSub(1)
    mob:setDelay(4000)
    mob:setDamage(100)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 0)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(36000, 43200)) -- 11 to 12 hours
    mob:AnimationSub(1)
    DisallowRespawn(mob:getID()-1, false)
end