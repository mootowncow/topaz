-----------------------------------
-- Area: Upper Delkfutt's Tower
--   NM: Alkyoneus
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    -- Starts jobless
    mob:setDamage(75)
    mob:setDelay(4000)
    mob:setModelId(643) -- Black
    mob:setMod(tpz.mod.ATTP, 25)
    mob:setMod(tpz.mod.DEFP, 25) 
    mob:addMod(tpz.mod.ACC, 50) 
    mob:addMod(tpz.mod.EVA, 20)
    mob:setMobMod(tpz.mobMod.SKILL_LIST, 126)
    mob:setMobMod(tpz.mobMod.SPECIAL_SKILL, 0)
    mob:setMobMod(tpz.mobMod.SPECIAL_COOL, 16)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.MIGHTY_STRIKES, cooldown = 0, hpp = 5},
        },
    })
    mob:setUnkillable(true)
end

function onMobEngaged(mob, target)
    -- Despawn all Gigas on the Tweltch Floor and disable them respawning
    for v = 17424452, 17424478, 1 do
        DespawnMob(v)
        DisallowRespawn(v, true)
    end
    for v = 17424483, 17424508, 1 do
        DespawnMob(v)
        DisallowRespawn(v, true)
    end
end

function onMobFight(mob, target)
    local phase = mob:getLocalVar("phase")
    local hp = mob:getHPP()

    if (hp <= 75) and (phase) == 0 then -- WAR
        mob:setDamage(145)
        mob:setDelay(4000)
        mob:addMod(tpz.mod.ATTP, 50)
        mob:addMod(tpz.mod.DEFP, 50) 
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 25)
        mob:setMod(tpz.mod.COUNTER, 0)
        mob:useMobAbility(688) -- Mighty Strikes        
        mob:setModelId(640) -- Gaxe
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 6003)
        mob:setLocalVar("phase", 1)
    end
    if (hp <= 50) and (phase == 1) and not mob:hasStatusEffect(tpz.effect.MIGHTY_STRIKES) then -- MNK
        mob:setDamage(75)
        mob:setDelay(2200)
        mob:delMod(tpz.mod.ATTP, 50)
        mob:delMod(tpz.mod.DEFP, 50) 
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 100)
        mob:setMod(tpz.mod.COUNTER, 10)
        mob:useMobAbility(690)  -- Hundred Fists
        mob:setModelId(642) -- H2H
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 6004)
        mob:setLocalVar("phase", 2)
    end
    if (hp <= 25) and (phase == 2) and not mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS) then -- RNG
        mob:setDamage(145)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 0)
        mob:setMod(tpz.mod.COUNTER, 0)
        mob:useMobAbility(739) -- EES
        mob:setModelId(711) --  Ranger
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 6005)
        mob:setMobMod(tpz.mobMod.SPECIAL_SKILL, 658)
        mob:setLocalVar("phase", 3)
    end
    if (hp <= 10) and (phase == 3) and not mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS)
    and not mob:hasStatusEffect(tpz.effect.MIGHTY_STRIKES) then -- WAR + MNK + RNG
        tpz.mix.jobSpecial.config(mob, {
            between = 120,
            specials =
            {
                {id = tpz.jsa.MIGHTY_STRIKES, cooldown = 0, hpp = 90},
                {id = tpz.jsa.HUNDRED_FISTS, cooldown = 0, hpp = 90},
                {id = tpz.jsa.EES_GIGA, cooldown = 0, hpp = 90},
            },
        })
        mob:setDamage(145)
        mob:setDelay(3000)
        mob:delMod(tpz.mod.ATTP, 50)
        mob:delMod(tpz.mod.DEFP, 50)
        mob:setMod(tpz.mod.COUNTER, 10)
        mob:useMobAbility(689) -- Benediction
        mob:setModelId(275) -- WOTG
        mob:setMobMod(tpz.mobMod.SPECIAL_SKILL, 658)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 6006)
        mob:setUnkillable(false)
        mob:setLocalVar("phase", 4)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    -- Allow Gigas on the Tweltch Floor to respawn
    for v = 17424452, 17424478, 1 do
        DisallowRespawn(v, false)
    end
    for v = 17424483, 17424508, 1 do
        DisallowRespawn(v, false)
    end
end


local function SetPhaseStats(phase)
    if (phase == 1) then
    elseif (phase == 2) then
    elseif (phase == 3) then
    elseif (phase == 4) then
    end
end