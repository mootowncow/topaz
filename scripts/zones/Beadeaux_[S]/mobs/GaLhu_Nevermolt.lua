-- PLD/PLD
-- Immune to Paralyze, Silence, Sleep, Bind, Gravity, Break
-- Casts: Flash, Banish II, Protect IV, Shell IV, Cure IV below 33%
-- Diamond Shell has Reprisal effect
-- Occasionally (every 30-45s?) turns and faces away putting his back to face you for ~10 seconds
-- Uses Ore Toss, Ore Lob, Diamond Shell, Shell Bash, Shell Charge, Head Butt
-- Uses Invincible around 5% and gains reprisal during it on all sides
-- No damage cap on his reprisal
-----------------------------------
-- Area: Beadeaux [S]
--   NM: Ba'Tho Mercifulheart
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/wotg")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    tpz.wotg.NMMods(mob)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
    mob:setMobMod(tpz.mobMod.HP_HEAL_CHANCE, 33) 
    mob:addStatusEffect(tpz.effect.REPRISAL, 33, 0, 7200, 0, mob:getMaxHP())
end

function onMobFight(mob, target)
    if not mob:hasStatusEffect(tpz.effect.REPRISAL) then
        mob:addStatusEffect(tpz.effect.REPRISAL, 33, 0, 7200, 0, mob:getMaxHP())
    end
end

function onMobWeaponSkillPrepare(mob, target)
   local tpMoves = { 2204, 2223, 2224, 2225, 2268, 2378}
   --  Ore Lob, Ore Toss, Head Butt, Shell Bash, Shell Charge, Diamond Shell

   return tpMoves[math.random(#tpMoves)]
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.MagianT4(mob, player, isKiller, noKiller)
end