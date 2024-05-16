-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  Mob: Ob
-------------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
-------------------------------------
local harlequinFrameModelId = 1977
local valoredgeFrameModelId = 1983
local sharpshotFrameModelId = 1990
local stormwalkerFrameModelId = 1994
-------------------------------------

-- used to remove rage following an overload
local function overloadRageDisengage(mob)
    -- Dont allow an un-rage from actual rage
    if mob:getLocalVar("[rage]started") == 0 then
        mob:setDelay(700)
        mob:setMod(tpz.mod.MAIN_DMG_RATING, 0)
        mob:setMod(tpz.mod.ATTP, 0)
        mob:setMod(tpz.mod.ACC, 319)
        mob:setMod(tpz.mod.CRITHITRATE, 0)
        mob:setMod(tpz.mod.EVA, 322)
        mob:setMod(tpz.mod.MEVA, 0)
        mob:setMod(tpz.mod.REGAIN, 0)
    end
end

-- used to begin rage due to overload
local function overloadRageEngage(mob)
    mob:setDelay(700)
    mob:setMod(tpz.mod.MAIN_DMG_RATING, 100)
    mob:setMod(tpz.mod.ATTP, 100)
    mob:setMod(tpz.mod.ACC, 1000)
    mob:setMod(tpz.mod.CRITHITRATE, 100)
    mob:setMod(tpz.mod.EVA, 1000)
    mob:setMod(tpz.mod.MEVA, 500)
    -- per capture, will tp quickly, but its not chain tp at 70%+ hp
    mob:setMod(tpz.mod.REGAIN, 700)
end

local function changeToValoredge(mob, percent)
    if(mob:getLocalVar("CurrentFrame") == valoredgeFrameModelId) then
        return
    end

    mob:setLocalVar("CurrentFrame", valoredgeFrameModelId)
        mob:setDamage(30)
        mob:setDelay(1500)
        mob:setMod(tpz.mod.ATTP, 10)
        mob:setMod(tpz.mod.DEFP, 60)
        mob:setMod(tpz.mod.RATTP, 0)
        mob:setMod(tpz.mod.ACC, 319)
        mob:setMod(tpz.mod.EVA, 322)
        mob:setMod(tpz.mod.MATT, 0)
        mob:setMod(tpz.mod.UDMGPHYS, -50)
        mob:setMod(tpz.mod.UDMGRANGE, -50)
        mob:setMod(tpz.mod.UDMGBREATH, -50)
        mob:setMod(tpz.mod.UDMGMAGIC, -50)
        mob:setMod(tpz.mod.REGEN, 10)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 1200)
        mob:SetMagicCastingEnabled(false)
        mob:setModelId(mob:getLocalVar("CurrentFrame"))

    mob:SetMagicCastingEnabled(false)
    -- mob:useMobAbility(2018) TODO: Missing animation
end

local function changeToStormwaker(mob)
    if(mob:getLocalVar("CurrentFrame") == stormwalkerFrameModelId) then
        return
    end

    mob:setLocalVar("CurrentFrame", stormwalkerFrameModelId)
        mob:setDamage(100)
        mob:setDelay(4000)
        mob:setMod(tpz.mod.ATTP, 0)
        mob:setMod(tpz.mod.DEFP, 0)
        mob:setMod(tpz.mod.RATTP, 0)
        mob:setMod(tpz.mod.ACC, 319)
        mob:setMod(tpz.mod.EVA, 322)
        mob:setMod(tpz.mod.MATT, 0)
        mob:setMod(tpz.mod.UDMGPHYS, 0)
        mob:setMod(tpz.mod.UDMGRANGE, 0)
        mob:setMod(tpz.mod.UDMGBREATH, 0)
        mob:setMod(tpz.mod.UDMGMAGIC, 00)
        mob:setMod(tpz.mod.REGEN, 0)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 366)
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 20)
        mob:setSpellList(511) -- T4, -GA, AM, Enfeebles
        mob:SetMagicCastingEnabled(true)
        mob:setModelId(mob:getLocalVar("CurrentFrame"))

    mob:SetMagicCastingEnabled(false)
    -- mob:useMobAbility(2018) TODO: Missing animation
end

local function changeToSharpshot(mob)
    if(mob:getLocalVar("CurrentFrame") == sharpshotFrameModelId) then
        return
    end

    mob:setLocalVar("CurrentFrame", sharpshotFrameModelId)
        mob:setDamage(100)
        mob:setDelay(4000)
        mob:setMod(tpz.mod.ATTP, 0)
        mob:setMod(tpz.mod.DEFP, 30)
        mob:setMod(tpz.mod.RATTP, 0)
        mob:setMod(tpz.mod.ACC, 369)
        mob:setMod(tpz.mod.EVA, 372)
        mob:setMod(tpz.mod.MATT, 0)
        mob:setMod(tpz.mod.UDMGPHYS, 0)
        mob:setMod(tpz.mod.UDMGRANGE, 0)
        mob:setMod(tpz.mod.UDMGBREATH, 0)
        mob:setMod(tpz.mod.UDMGMAGIC, 0)
        mob:setMod(tpz.mod.REGEN, 0)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 1201)
        mob:SetMagicCastingEnabled(false)
        mob:setModelId(mob:getLocalVar("CurrentFrame"))

    mob:SetMagicCastingEnabled(false)
    -- mob:useMobAbility(2018) TODO: Missing animation
end

local function setupHarlequin(mob)
    mob:setLocalVar("CurrentFrame", harlequinFrameModelId)
    mob:setDamage(100)
    mob:setDelay(3200)
    mob:setMod(tpz.mod.ATTP, 0)
    mob:setMod(tpz.mod.DEFP, 0)
    mob:setMod(tpz.mod.RATTP, 0)
    mob:setMod(tpz.mod.MATT, 0)
    mob:setMod(tpz.mod.UDMGPHYS, 0)
    mob:setMod(tpz.mod.UDMGRANGE, 0)
    mob:setMod(tpz.mod.UDMGBREATH, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setMobMod(tpz.mobMod.SKILL_LIST, 363)
    mob:setSpellList(530)
    mob:SetMagicCastingEnabled(true)
    mob:setModelId(mob:getLocalVar("CurrentFrame"))
end

local function scanForManeuvers(mob, target)
    local sharpshotCount = 0
    local valoredgeCount = 0
    local stormwalkerCount = 0
    local currentFrame = mob:getLocalVar("CurrentFrame")

    local overloadCount = 0
    local largestOverloadDuration = 0

    local zoneID = mob:getZoneID()
    local enmityList = mob:getEnmityList()
    for _, member in pairs(target:getAlliance()) do
        if (member:getMainJob() == tpz.job.PUP or member:getSubJob() == tpz.job.PUP) then -- filter by Puppetmasters
            if (member:getZoneID() == zoneID and mob:checkDistance(member) < 50) then -- filter by zone and distance

                -- Different number of maneuversRequired for main vs sub pup
                local maneuversRequired = 3
                if member:getMainJob() == tpz.job.PUP then
                    maneuversRequired = 2
                end

                -- Determine the player's "vote"
                if (member:countEffect(tpz.effect.WIND_MANEUVER) + member:countEffect(tpz.effect.THUNDER_MANEUVER)) >= maneuversRequired then
                    sharpshotCount = sharpshotCount + 1
                elseif (member:countEffect(tpz.effect.FIRE_MANEUVER) + member:countEffect(tpz.effect.EARTH_MANEUVER) + member:countEffect(tpz.effect.LIGHT_MANEUVER)) >= maneuversRequired then
                    valoredgeCount = valoredgeCount + 1
                elseif (member:countEffect(tpz.effect.ICE_MANEUVER) + member:countEffect(tpz.effect.WATER_MANEUVER) + member:countEffect(tpz.effect.DARK_MANEUVER)) >= maneuversRequired then
                    stormwalkerCount = stormwalkerCount + 1
                end

                -- Catch overloads
                local overloadStatus = member:getStatusEffect(tpz.effect.OVERLOAD)
                if (overloadStatus ~= nil) then
                    overloadCount = overloadCount + 1
                    local duration = overloadStatus:getDuration()
                    if (duration > largestOverloadDuration) then
                        largestOverloadDuration = duration
                    end
                end
            end
        end
    end

    -- [rage]started is from rage.lua - we dont need to overload rage when actually raging
    if (overloadCount > 0 and mob:getLocalVar("OverloadRage") == 0 and mob:getLocalVar("[rage]started") == 0) then
         -- ya done goofed
        mob:setLocalVar("OverloadRage", os.time() + largestOverloadDuration) -- per capture, appears to match overload time on puppetmaster.
        mob:useMobAbility(627) -- per capture
        overloadRageEngage(mob)
    end

    if (sharpshotCount > valoredgeCount) and (sharpshotCount > stormwalkerCount) and (sharpshotCount > 0) then
        changeToSharpshot(mob)
        -- printf("Changing to Sharpshot")
    elseif (valoredgeCount > sharpshotCount) and (valoredgeCount > stormwalkerCount) and (valoredgeCount > 0) then
        changeToValoredge(mob)
        -- printf("Changing to Valoredge")
    elseif (stormwalkerCount > sharpshotCount) and (stormwalkerCount > valoredgeCount) and (stormwalkerCount > 0) then
        changeToStormwaker(mob)
        -- printf("Changing to Stormwaker")
    end
    -- does not change back to Harlequin see https://www.youtube.com/watch?v=12nNGdEicUE for a scenario with 0 manuevers up after setting valor

end

function onMobWeaponSkill(target, mob, skill)
    -- 2018 is the puppet frame change dance
    if(skill:getID()==2018) then
        mob:timer(2000, function(mob)
            if mob:isAlive() then
                mob:setModelId(mob:getLocalVar("CurrentFrame"))
                mob:sendUpdateToZoneCharsInRange()
                if(mob:getLocalVar("CurrentFrame") == stormwalkerFrameModelId) then
                    mob:SetMagicCastingEnabled(true)
                end
            end
        end)
    end
end

function onMobEngaged(mob, target)
    scanForManeuvers(mob, target)
    mob:setLocalVar("ScanTime", os.time() + 5)
end

function onMobFight(mob, target)
    local now = os.time()

    if (os.time() > mob:getLocalVar("ScanTime")) then
        mob:setLocalVar("ScanTime", os.time() + 3)
        scanForManeuvers(mob, target)
    end

    if (mob:getLocalVar("OverloadRage") > 0 and mob:getLocalVar("OverloadRage") < os.time()) then
        mob:setLocalVar("OverloadRage", 0)
        overloadRageDisengage(mob)
    end

    if not IsMobBusy(mob) then
        if (mob:getLocalVar("CurrentFrame") == sharpshotFrameModelId) and mob:getLocalVar("ranged") <= now then
            mob:useMobAbility(272, target) -- Ranged Attack
            mob:setLocalVar("ranged", now + 5)
        elseif (mob:getLocalVar("CurrentFrame") == valoredgeFrameModelId) and mob:getLocalVar("shieldBash") <= now then
            mob:useMobAbility(1944, target) -- Shield Bash
            mob:setLocalVar("shieldBash", now + 30)
        end
    end
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3000) -- 5k Gil
    mob:setMobMod(tpz.mobMod.GIL_MAX, 5000) 
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 10)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, 65)
    setupHarlequin(mob)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    setupHarlequin(mob)
end


function onMobDeath(mob, player, isKiller, noKiller)
    player:addCurrency("zeni_point", 100)
	if isKiller  then 
		player:addTreasure(5735, mob)--Cotton Coin Purse
	end
	if isKiller and math.random(1,100) <= 24 then 
		player:addTreasure(5735, mob)--Cotton Coin Purse
	end
	if isKiller and math.random(1,100) <= 15 then 
		player:addTreasure(5735, mob)--Cotton Coin Purse
	end
end
