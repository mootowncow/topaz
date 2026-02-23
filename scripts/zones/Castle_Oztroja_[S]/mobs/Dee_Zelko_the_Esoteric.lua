-----------------------------------
-- Area: Castle Oztroja [S]
--   NM: Dee Zelko the Esoteric
-- BLM/BLM
-- Immune to Silence, Paralyze, Sleep, Bind, Gravity, Break
-- 100% Fast Cast
-- Cast Timer 8s
-- Casts Aero spells, Sleepga II, Stun and Bio III
-- Sleepga II and Stun never misses and always lands full duration.
-- Tier-1 Aero and Aeroga, but gradually increases magic tier as its HP declines, until it starts spamming insta-cast Tornado II.
-- Aero II at 84%
-- Aero III and Aeroga II at 64%
-- Aero IV at 44%
-- Tornado and Aeroga III at 34%
-- Tornado II and Aeroga III at 14%
-- Uses Manafont below 50%
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/wotg")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 8)
end

function onMobSpawn(mob)
    tpz.wotg.NMMods(mob)
    mob:addMod(tpz.mod.MATT, 50)
    mob:setMod(tpz.mod.UFASTCAST, 100)
    mob:setMod(tpz.mod.ENFEEBLE_NEVER_MISS, 1)
    mob:setMod(tpz.mod.DARK_NEVER_MISS, 1)
end

function onMobFight(mob, target)
    -- Starts out with tier-1 Aero and Aeroga, but gradually increases magic tier
    -- as its HP declines, until it starts spamming insta-cast Tornado II.
    local hpp = mob:getHPP()

    if hpp < 15 then
        mob:setSpellList(244)
    elseif hpp < 35 then
        mob:setSpellList(243)
    elseif hpp < 45 then
        mob:setSpellList(242)
    elseif hpp < 65 then
        mob:setSpellList(241)
    elseif hpp < 85 then
        mob:setSpellList(240)
    else
        mob:setSpellList(239)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.MagianT4(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(7200) -- 2 hours
end
