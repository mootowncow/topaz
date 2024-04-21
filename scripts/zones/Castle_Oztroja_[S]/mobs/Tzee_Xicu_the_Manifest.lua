-----------------------------------
-- Area: Castle Oztroja [S]
--   NM: Tzee Xicu The Manifest
-- BCNM: A Malicious Manifest
-- SMN/SMN
-- Immune to Gravity / Bind / Paralyze / Sleep / Break / Stun
-- -50% PDT
-- -33% MDT
-- +50 Store TP(or more)
-- 70% weight aura while glowing.
-- Uses: Double Kick, Vorticose Sands, Dark Invocation, Sweep 
-- Below 50% Kamaitachi replaces Sweep
-- Says “The time is come. I shall release you from the pain of your earth existence” when he uses Vorticose Sands
-- Vorticose Sands Full gear strip + silence + enmity reset
-- Kamaitachi is heavy AoE damage, knockback, and full dispel. Full dispel can be resisted
-- Astral Flowed at 79%(Did nothing if no elementals up)
-- Uses Astral Flow EXACTLY every 3 minutes below 95% HP?
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja_[S]/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/wotg")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local auraParams = {
    radius = 10,
    effect = tpz.effect.GEO_WEIGHT,
    power = 70,
    duration = 3,
    auraNumber = 1
}

function onMobSpawn(mob)
    tpz.wotg.NMMods(mob)
    mob:addMod(tpz.mod.STORETP, 50)
    mob:addMod(tpz.mod.UDMGMAGIC, -33)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE , 20)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 20)
    mob:setModelId(2112)
    mob:AnimationSub(1)
    tpz.mix.jobSpecial.config(mob, {
        between = 180,
        specials =
        {
            {id = tpz.jsa.ASTRAL_FLOW, hpp = 90},
        },
    })
end

function onMobEngaged(mob, target)
    -- Force adds to link when aggrod
    for v = mob:getID() +1, mob:getID() +4 do
        GetMobByID(v):updateEnmity(target)
    end
    mob:AnimationSub(1)
    mob:setLocalVar("msg", 0)
end

function onMobFight(mob, target)
    local msg = mob:getLocalVar("msg")
    -- Glows when his weight aura is active. Aura is -70% move speed
    if mob:AnimationSub() == 1 then
        TickMobAura(mob, target, auraParams)
        AddMobAura(mob, target, auraParams)
    end

    -- Says “I shall feast on your fear!” when he uses Vorticose Sands
    if (msg > 0) then
        mob:setLocalVar("msg", 0)
        mob:showText(mob, ID.text.TIME_IS_COME)
    end
end

function onMobWeaponSkillPrepare(mob, target)
   local hp = mob:getHPP()
   local tpMoves1 = { 620, 2206, 2381, 2375 }
   --  Sweep, Dark Invocation, Double Kick, Vorticose Sands
   local tpMoves2 = { 2206, 2269, 2381, 2375 }
   --  Dark Invocation, Kamaitachi, Double Kick, Vorticose Sands

   if (hp > 50) then
        return tpMoves1[math.random(#tpMoves1)]
   else
        return tpMoves2[math.random(#tpMoves2)]
   end
end

function onMobWeaponSkill(target, mob, skill)
    -- Says “I shall feast on your fear!” when he uses Vorticose Sands
    if skill:getID() == 2375 then
        mob:setLocalVar("msg", 1)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end
