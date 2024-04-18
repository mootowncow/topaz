-----------------------------------
-- Area: Beadeaux [S] (92)
--   ZaDha Adamantking
-- BCNM: The Buried God
-- Za’Dha Adamantking
-- WAR/WAR
-- Immune to Gravity / Bind / Paralyze / Sleep / Break / Stun
-- 20% MDT
-- +50 Store TP(or more)
-- Additional effect: Enstone (~30 dmg? 100% proc)
--Slow aura while his shell is shining. (40% slow)
-- Uses Torment of Gu'Dha, Ore Lob, Skull Smash, Ore Toss
-- Torment of Gu'Dha resets hate and petrifies
-- Mighty strikes timer: 03:46 - > 08:16 - > 12:50  - > 17:18 EXACTLY every 4:30 minutes

-----------------------------------
local ID = require("scripts/zones/Beadeaux_[S]/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/wotg")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local auraParams = {
    radius = 10,
    effect = tpz.effect.GEO_SLOW,
    power = 4000,
    duration = 3,
    auraNumber = 1
}

function onMobSpawn(mob)
    tpz.wotg.NMMods(mob)
    mob:addMod(tpz.mod.STORETP, 50)
    mob:addMod(tpz.mod.UDMGMAGIC, -20)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE , 20)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 20)
    mob:setModelId(2152)
    mob:AnimationSub(1)
    tpz.mix.jobSpecial.config(mob, {
        between = 270,
        specials =
        {
            {id = tpz.jsa.MIGHTY_STRIKES, hpp = 90},
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
        mob:showText(mob, ID.text.FOSSILIZED_CORPSE)
    end
end

function onMobWeaponSkillPrepare(mob, target)
   local tpMoves = {611, 2234, 2265, 2374}
   --  Ore Toss, Ore Lob, Skull Smash, Torment of Gudha
   return tpMoves[math.random(#tpMoves)]
end

function onMobWeaponSkill(target, mob, skill)
    -- Says “I shall feast on your fear!” when he uses Veil of Chaos
    if skill:getID() == 2374 then
        mob:setLocalVar("msg", 1)
    end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENSTONE, {chance = 100, power = math.random(30, 50)})
end

function onMobDeath(mob, player, isKiller, noKiller)
end
