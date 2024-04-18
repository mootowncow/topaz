-----------------------------------
-- Area: La Vaule [S]
--   Bloodcrown Brradhod
--   BCNM: The Bloodbathed Crown
-- Immune to Silence / Gravity / Bind / Paralyze / Sleep / Break
-- PLD/PLD
-- 0% MDT
-- +50 Store TP(or more)
-- Cast: 01 - > 34 - > 19 - > 05 - > 51
-- Spells: Shell IV, Protect IV, Banish II, Flash Cure IV(only uses at 33% and lower)
-- TP moves: Battle Dance, Tornado Dance, Shoulder Charge, Berserker Dance, Veil of Chaos
-- Says “I shall feast on your fear!” when he uses Veil of Chaos
-- Glows super Light/Rainbow/Paladinish  while Flash Aura is active. Flash aura is -104 ACC
-- Aura removed @ 70%ish hp. Came back at 55%sh, never went away again. Must be on a very long timer?
-- Uses invincible EXACTLY every 3 minutes
--  Uses Battle Dance, Berserker Dance, Tornado Dance, Shoulder Charge, Veil of Chaos
-----------------------------------
local ID = require("scripts/zones/La_Vaule_[S]/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/wotg")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local auraParams = {
    radius = 10,
    effect = tpz.effect.FLASH,
    power = 104,
    duration = 3,
    auraNumber = 1
}

function onMobSpawn(mob)
    tpz.wotg.NMMods(mob)
    mob:addMod(tpz.mod.STORETP, 50)
    mob:addMod(tpz.mod.DIVINE_NEVER_MISS, 1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE , 20)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 20)
    mob:setMobMod(tpz.mobMod.HP_HEAL_CHANCE , 33)
    mob:AnimationSub(1)
    tpz.mix.jobSpecial.config(mob, {
        between = 180,
        specials =
        {
            {id = tpz.jsa.INVINCIBLE, hpp = 90},
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
    -- Glows when his flash aura is active. Aura is -104 ACC
    if mob:AnimationSub() == 1 then
        TickMobAura(mob, target, auraParams)
        AddMobAura(mob, target, auraParams)
    end

    -- Says “I shall feast on your fear!” when he uses Veil of Chaos
    if (msg > 0) then
        mob:setLocalVar("msg", 0)
        mob:showText(mob, ID.text.FEAST_ON_FEAR)
    end
end

function onMobWeaponSkillPrepare(mob, target)
   local tpMoves = { 609, 2202, 2263, 2264, 2373}
   --  Battle Dance, Berserker Dance, Tornado Dance, Shoulder Charge, Veil of Chaos
   return tpMoves[math.random(#tpMoves)]
end

function onMobWeaponSkill(target, mob, skill)
    -- Says “I shall feast on your fear!” when he uses Veil of Chaos
    if skill:getID() == 2373 then
        mob:setLocalVar("msg", 1)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end