------------------------------
-- Area: Xarcabard [S]
--   NM: Zirnitra
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/pathfind")
require("scripts/globals/wotg")
mixins = {require("scripts/mixins/families/amphiptere")}
------------------------------
local path1 = {
    {x = 38, y = -36, z = 162},
    {x = 308, y = -27, z = 195},
    {x = 341, y = -28, z = 294},
    {x = 284, y = -27, z = 153},
}

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 2)
end

function onMobSpawn(mob)
	mob:setDamage(140)
    mob:addMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.DEFP, 25) 
    mob:addMod(tpz.mod.ACC, 25)
	mob:setMod(tpz.mod.VIT, 68)
    mob:setMod(tpz.mod.REFRESH, 400)
    mob:addMod(tpz.mod.MOVE, 20)
    mob:addMod(tpz.mod.WIND_ABSORB, 100)
    mob:addImmunity(tpz.immunity.SLEEP)
    mob:addImmunity(tpz.immunity.GRAVITY)
    mob:addImmunity(tpz.immunity.BIND)
    mob:addImmunity(tpz.immunity.SILENCE)
    mob:addImmunity(tpz.immunity.PARALYZE)
    mob:addImmunity(tpz.immunity.BLIND)
    mob:addImmunity(tpz.immunity.SLOW)
    mob:addImmunity(tpz.immunity.ELEGY)
    mob:addImmunity(tpz.immunity.REQUIEM)
    mob:setLocalVar("ComboTime", 0)
    onPath(mob)
end

function onMobRoam(mob)
    onPath(mob)
end

function onMobFight(mob, target)
	local HP = mob:getHPP()
	local ReavingWindTime = mob:getLocalVar("ReavingWindTime")
	local ReavingWindMax = mob:getLocalVar("ReavingWindMax")
	local CalamitousWindMax = mob:getLocalVar("CalamitousWindMax")
	local CalamitousWindTime = mob:getLocalVar("CalamitousWindTime")
    local ComboTime = mob:getLocalVar("ComboTime")
    local BattleTime = mob:getBattleTime()

    -- Use Reaving Wind 3-5 times in a row below 25% HP then uses Calamitous Wind that many times after
    if (HP <= 25) and (BattleTime >= ComboTime) then
        mob:setLocalVar("ReavingWindTime", 1)
        mob:setLocalVar("ReavingWindMax", math.random(2, 5))
        mob:setLocalVar("ComboTime", BattleTime + math.random(90, 120))
    end
    if (ReavingWindTime == 1) then
        UseMultipleTPMoves(mob, ReavingWindMax, 2431)
        mob:setLocalVar("ReavingWindTime", 0)
        mob:setLocalVar("CalamitousWindMax", ReavingWindMax)
        mob:setLocalVar("CalamitousWindTime", 1)
    end
    if (CalamitousWindTime == 1) then
        UseMultipleTPMoves(mob, CalamitousWindMax, 2433)
        mob:setLocalVar("CalamitousWindTime", 0)
        mob:setLocalVar("ReavingWindMax", 0)
        mob:setLocalVar("CalamitousWindMax", 0)
    end
end

function onMobWeaponSkill(target, mob, skill)
    -- All TP moves reset hate
    if skill:getID() > 0 then
        mob:resetEnmity(target)        
    end
end

function onMonsterMagicPrepare(mob, target)
    return 359 -- Silencega
end


function onMobRoam(mob)
    tpz.path.loop(mob, path1, tpz.path.flag.RUN)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(14400, 18000)) -- 4 to 5 hours
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addTitle(tpz.title.ZIRNITRA_WINGCLIPPER)
    tpz.hunts.checkHunt(mob, player, 543)
    tpz.wotg.MagianT4(mob, player, isKiller)
end


