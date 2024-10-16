-- THF/THF
-- Immune to Paralyze, Sleep, Bind, Gravity, Break
-- Does not RA in melee range
-- Runs away and stays at range using Ore Toss every 10 seconds
-- Runs away to ~23.5 yalms then runs back to ~13.5 if you run to him, but if you chase again after he won't run away again for a while
-- Run Timer 01;53 - > 02:27 - > 03:04 - > 03:38 - > 04:14 - > 04:46 - > 05:29 - > 06:43
-- Summons (summoning animation) a random tube that uses a random TP move then despawns.
-- Summon Timer: 54:41 - > 55:46 - > 56:31 - > 57:12 - > 58:29 - > 59:24 -> 00:22 - > 01:15 1m?
-- Summoner Timer (49% HP): 07:34 - > 08:08 - > 08:33 - > 08:54 - > 09:23 - > 09:46 - 10:12 30s?
-- Summoner Timer (24% HP): 12:46 - > 12:58 - > 13:13 - > 13:26 - > 13:43 - > 13:57 - > 14:12 15s
-- Summoner Timer (9% HP): 16:42 - > 16:53 -> 17:03 -> 17:13 - > 17:23 - > 17:33 - > 17:43 10s
-- Uses Diamond Shell, Ore Lob, Head Butt, Shell Guard, Howl
-- Used Pefect Dodge at 70%ish
-----------------------------------
-- Area: Beadeaux [S]
--   NM: Mu'Nhi Thimbletail
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/wotg")
require("scripts/globals/utils")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
function onMobInitialize(mob)
end

function onMobSpawn(mob)
    tpz.wotg.NMMods(mob)
    mob:setMobMod(tpz.mobMod.SPECIAL_SKILL, 1123)
    mob:setMobMod(tpz.mobMod.SPECIAL_COOL, 18) 
    mob:setMobMod(tpz.mobMod.STANDBACK_COOL, 10)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, 1)
end

function onMobEngaged(mob, target)
    mob:setLocalVar("tubeTime", os.time() + 60)
end

function onMobFight(mob, target)
    local runAwayTimer = mob:getLocalVar("runAwayTimer")
    local tubeTime = mob:getLocalVar("tubeTime")
    local tube = GetMobByID(mob:getID() + math.random(3))

    -- Does not Ore Toss in melee range
    if mob:checkDistance(target) <= 5 then
        mob:setMobMod(tpz.mobMod.SPECIAL_SKILL, 0)
    else
        mob:setMobMod(tpz.mobMod.SPECIAL_SKILL, 1123)
    end

    -- Runs away to ~23.5 yalms then runs back to ~13.5 if you run to him, but if you chase again after he won't run away again for a while
    if mob:checkDistance(target) <= 5 and (os.time() >= runAwayTimer) then
        mob:SetMobAbilityEnabled(false)
		--mob:pathTo(target:getXPos() + 24, target:getYPos(), target:getZPos() +24)
        mob:setLocalVar("runAwayTimer", os.time() + math.random(30, 45))
        mob:timer(5000, function(mob)
		    mob:SetMobAbilityEnabled(true)
        end)
	end

    -- Summons a random tube that uses a random TP move then despawns.
    if os.time() >= tubeTime then
        if not tube:isSpawned() then
            mob:setLocalVar("tubeTime", os.time() + math.random(30, 60))
            utils.spawnPetInBattle(mob, tube, true, false, true)
        end
    end
end

function onMobWeaponSkillPrepare(mob, target)
   local tpMoves = { 612, 614, 762, 2233, 2234 }
   --  Headbutt, Shell Guard, Howl, Diamond Shell, Ore Lob

   return tpMoves[math.random(#tpMoves)]
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.MagianT4(mob, player, isKiller, noKiller)
end

function getVialTimer(mob)
    local hp = mob:getHPP()
    local timer = 60

    if (hp < 10) then
        timer = 10
    elseif (hp < 25) then
        timer = 15
    elseif (hp < 50) then
        timer = 30
    end

    return timer
end
