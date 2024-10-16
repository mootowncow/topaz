-----------------------------------
-- Area: La Vaule [S]
--   NM: Coinbiter Cjaknokk
-- Perma dreadspikes
-- Uses TP moves every 10s at high HP then 5s at low HP
-- Immune to Silence Sleep Bind Gravity Paralyze
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/magic")
require("scripts/globals/wotg")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    tpz.wotg.NMMods(mob)
    mob:setMod(tpz.mod.REGAIN, 1000)
    mob:setMobMod(tpz.mobMod.SKILL_LIST, 1205)
end

function onMobEngaged(mob)
    mob:setLocalVar("dreadSpikes", 0)
end

function onMobFight(mob, target)
    local dreadSpikes = mob:getLocalVar("dreadSpikes")
    local hp = mob:getHPP()

    -- Uses TP moves every 10 seconds at 50-100% HP, then every 5 seconds below 50.
    if (hp < 25) then
        mob:setMod(tpz.mod.REGAIN, 500)
    elseif (hp < 50) then
        mob:setMod(tpz.mod.REGAIN, 1500)
    else
        mob:setMod(tpz.mod.REGAIN, 1000)
    end

    if not mob:hasStatusEffect(tpz.effect.DREAD_SPIKES) then
        if (dreadSpikes == 0) then
            mob:setLocalVar("dreadSpikes", 1)
            mob:castSpell(tpz.magic.spell.DREAD_SPIKES, mob)
        end
    end

    mob:addListener("MAGIC_STATE_EXIT", "CJAK_MAGIC_STATE_EXIT", function(mob, spell)
        mob:setLocalVar("dreadSpikes", 0)
    end)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.MagianT4(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(7200) -- 2 hours
end
