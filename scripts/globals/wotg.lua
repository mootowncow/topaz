-----------------------------------
--
--  WotG utilities
--
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
require("scripts/globals/utils")
require("scripts/globals/status")
require("scripts/globals/zone")
require("scripts/globals/items")
require("scripts/globals/keyitems")
-----------------------------------
-- TODO:
-- Meta progress increase based on event done (i.e. bosses give 10%, waves give 5%)
-- tpz.wotg.RandomEvent need the forced spawn removed (randomEventWaves(player)) and should only spawn at 10% of time
--  weather related event (during weather only)
--  undead related event (night only)
-- regions to be set where an event can pop (like 5 up at a time?) then reset once an event is active
-- rewards (dynamis type currency / literal currency in currency menu? craft mats? trade ins to a vendor for items?)
-- mobFamily table based on zone or passable arg (zone prob easier? the first key could be zone name via tpz enum?)
-- meta boss based on zone, can use a table like mobFamily and first key can be zone name via tpz enum
tpz = tpz or {}
tpz.wotg = tpz.wotg or {}

tpz.wotg.events = {
    Waves = 1,
    Defense = 2,
    Boss = 3,
    Special = 4
}

tpz.wotg.NMMods = function(mob)
    if mob:getMainJob() == tpz.job.MNK then
        mob:setDamage(35)
    else
	    mob:setDamage(140)
    end
    mob:addMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.DEFP, 25) 
    mob:addMod(tpz.mod.ACC, 25) 
    mob:addMod(tpz.mod.EVA, 25)
    mob:setMobMod(tpz.mobMod.GA_CHANCE, 60)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
end

tpz.wotg.QuadavTrashDrops = function(mob, player, isKiller, noKiller)
	if isKiller or noKiller then
        if  math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            player:addTreasure(tpz.items.CONDENSED_EMPTYNESS, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            player:addTreasure(tpz.items.CONDENSED_EMPTYNESS, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 1500) then
            player:addTreasure(tpz.items.CONDENSED_EMPTYNESS, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 1000) then
            player:addTreasure(tpz.items.CONDENSED_EMPTYNESS, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 500) then
            player:addTreasure(tpz.items.CONDENSED_EMPTYNESS, mob)
        end
        -- Campaign Ops KI
        if  math.random(1,10000) <= 1 then
            utils.givePartyKeyItem(player, tpz.ki.DIAMOND_SEAL)
        end
    end
end

tpz.wotg.YagudoTrashDrops = function(mob, player, isKiller, noKiller)
	if isKiller or noKiller then
        if  math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            player:addTreasure(tpz.items.ZILARTIAN_ORB, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            player:addTreasure(tpz.items.ZILARTIAN_ORB, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 1500) then
            player:addTreasure(tpz.items.ZILARTIAN_ORB, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 1000) then
            player:addTreasure(tpz.items.ZILARTIAN_ORB, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 500) then
            player:addTreasure(tpz.items.ZILARTIAN_ORB, mob)
        end
        -- Campaign Ops KI
        if  math.random(1,10000) <= 1 then
            utils.givePartyKeyItem(player, tpz.ki.XICUS_ROSARY)
        end
    end
end

tpz.wotg.OrcTrashDrops = function(mob, player, isKiller, noKiller)
	if isKiller or noKiller then
        if  math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            player:addTreasure(tpz.items.KULUU_SPHERE, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            player:addTreasure(tpz.items.KULUU_SPHERE, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 1500) then
            player:addTreasure(tpz.items.KULUU_SPHERE, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 1000) then
            player:addTreasure(tpz.items.KULUU_SPHERE, mob)
        end
        if  math.random(1,10000) <= utils.getDropRate(mob, 500) then
            player:addTreasure(tpz.items.KULUU_SPHERE, mob)
        end
        -- Campaign Ops KI
        if  math.random(1,10000) <= 1 then
            utils.givePartyKeyItem(player, tpz.ki.TIGRIS_STONE)
        end
    end
end

tpz.wotg.MagianT1 = function(mob, player, isKiller, noKiller)
    player:addCurrency("allied_notes", 200)
	if isKiller or noKiller then
        if math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            if math.random(2) == 2 then
		        player:addTreasure(tpz.items.DAYBREAK_SOUL, mob)
            else
                player:addTreasure(tpz.items.TWILIGHT_SOUL, mob)
            end
	    end
    end
end

tpz.wotg.MagianT2 = function(mob, player, isKiller, noKiller)
    player:addCurrency("allied_notes", 300)
	if isKiller or noKiller then
        if math.random(1,10000) <= utils.getDropRate(mob, 2400) then
            if math.random(2) == 2 then
		        player:addTreasure(tpz.items.INCRESCENT_SHADE, mob)
            else
                player:addTreasure(tpz.items.DECRESCENT_SHADE, mob)
            end
	    end
    end
end

tpz.wotg.MagianT3 = function(mob, player, isKiller, noKiller)
    player:addCurrency("allied_notes", 400)
	if isKiller or noKiller then 
        if math.random(1,10000) <= utils.getDropRate(mob, 2400) then 
		    player:addTreasure(tpz.items.SILVER_MIRROR, mob)
	    end
    end
end

tpz.wotg.MagianT4 = function(mob, player, isKiller, noKiller)
    player:addCurrency("allied_notes", 500)
	if isKiller or noKiller then
        if math.random(1,10000) <= utils.getDropRate(mob, 2400) then 
		    player:addTreasure(tpz.items.CHUNK_OF_RIFTSAND, mob)
	    end
    end
end

local waves = {}
local currentWave = 1
local mobFamily = {
    [tpz.zone.CRAWLERS_NEST_S] = {
        Scorpids = { 17478169, 17478170, 17478171, 17478172, 17478173, 17478174, 17478175, 17478176, 17478177, 17478178 },
        Funguars = { 17478179, 17478180, 17478181, 17478182, 17478183, 17478184, 17478185, 17478186, 17478187, 17478188 },
        Wespe = { 17478189, 17478190, 17478191, 17478192, 17478193, 17478194, 17478195, 17478196, 17478197, 17478198 },
        Saplings = { 17478199, 17478200, 17478201, 17478202, 17478203, 17478204, 17478205, 17478206, 17478207, 17478208 },
        Crawlers = { 17478209, 17478210, 17478211, 17478212, 17478213, 17478214, 17478215, 17478216, 17478217, 17478218 },
        Flies = { 17478219, 17478220, 17478221, 17478222, 17478223, 17478224, 17478225, 17478226, 17478227, 17478228 },
        Peistes = { 17478229, 17478230, 17478231, 17478232, 17478233, 17478234, 17478235, 17478236, 17478237, 17478238 }
    }
}

local bosses = {
    -- Scorpion(Gold), Rafflesia, Gnat, Ladybug, Slug, Peiste
    [tpz.zone.CRAWLERS_NEST_S] = { 17478239, 17478240, 17478241, 17478242, 17478243, 17478244 },
}
local metaBosses = {
    [tpz.zone.CRAWLERS_NEST_S] = { 17477708 }, -- Lugh
}

local function pickRandom(t)
    return t[math.random(1, #t)]
end

local function pickRandomKey(t)
    local keys = {}
    for key in pairs(t) do
        table.insert(keys, key)
    end
    return keys[math.random(1, #keys)]
end

local function generateWave(player, usedMobs)
    local wave = {}
    local waveSize = math.random(1, 5)
    local zone = player:getZone()
    local zoneId = player:getZoneID()
    local wavesMsg = zone:getLocalVar("wavesMsg")
    local currentWave = zone:getLocalVar("wave") -- Ensure currentWave is defined

    if not mobFamily[zoneId] then
        print("No mob family defined for zone ID: " .. zoneId)
        return wave
    end

    for i = 1, waveSize do
        local family = pickRandomKey(mobFamily[zoneId]) -- Pick a random family from this zone
        local mobID = pickRandom(mobFamily[zoneId][family]) -- Pick a random mob from that family

        -- Ensure the mobID hasn't been used in previous waves
        while usedMobs[mobID] do
            mobID = pickRandom(mobFamily[zoneId][family]) -- Pick a new mobID if it's already used
        end
        
        -- Add the mobID to the usedMobs tracker and the wave
        usedMobs[mobID] = true
        table.insert(wave, mobID)
        
        -- Print the current mobID of the mobs in the current wave
        print("Current mobID in wave " .. currentWave .. ": " .. mobID)
    end

    if (wavesMsg == 0) then
        utils.MessageParty(player, 'CODE: Waves START', 0xD, none)
        zone:setLocalVar("wavesMsg", 1)
    end

    return wave
end

local function randomEventWaves(player)
    waves = {} -- Reset waves for a new event
    currentWave = 1  -- Reset wave tracker
    local numWaves = math.random(1, 5)
    local zone = player:getZone()
    
    local usedMobs = {}  -- Table to track mobs already used
    
    for i = 1, numWaves do
        local wave = generateWave(player, usedMobs)  -- Pass the usedMobs tracker to each wave
        table.insert(waves, wave)  
    end

    zone:setLocalVar("eventActive", 1)
    zone:setLocalVar("wave", 1)
    zone:setLocalVar("maxWaves", numWaves)
end

local function randomEventDefense(player)
end

local function randomEventBoss(player)
end

local function randomEventSpecial(player)
end

local function ClearMsgVars(zone)
    zone:setLocalVar("wavesMsg", 0)
end

local function RandomEventComplete(player)
    local zone = player:getZone()
    local metaProgress = zone:getLocalVar("metaProgress")
    if metaProgress < 100 then
        zone:setLocalVar("metaProgress", math.min(metaProgress + 5, 100))
        utils.MessageParty(player, 'Meta progress: ' .. zone:getLocalVar("metaProgress") .. '%', 0xD, none)
        ClearMsgVars(zone)
    end
end

local function SpawnMetaBoss(player, zone)
end

local modByMobName =
{
    ['Selket'] = function(mob)
        mob:setDamage(150)
        mob:setDelay(4000)
        mob:addMod(tpz.mod.REGAIN, 50)
        mob:setMod(tpz.mod.MDEF, 60)
        -- Perma undispellable Ice Spikes
        mob:addStatusEffect(tpz.effect.CLOD_SPIKES, 25, 0, 0)
        local clodSpikes = mob:getStatusEffect(tpz.effect.CLOD_SPIKES)
        clodSpikes:unsetFlag(tpz.effectFlag.DISPELABLE)

        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.MIGHTY_STRIKES, cooldown = 90, hpp = 90},
            },
        })
    end,

    ['Witchweed'] = function(mob)
        mob:setDamage(150)
        mob:setMod(tpz.mod.MDEF, 60)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 207)
        mob:setMobMod(tpz.mobMod.FRIENDLY_FIRE, 1)
    end,

    ['Honey_Wespe'] = function(mob)
        local witchweed = GetMobByID(17478240)
        local pos = witchweed:getPos()
        if witchweed:isAlive() then
            mob:pathTo(pos.x, pos.y, pos.z)
        end
        mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
        mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
        mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
        mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
        mob:setMobMod(tpz.mobMod.CHECK_AS_NM, 1)
    end,

    ['Sciaridae'] = function(mob)
        mob:setDamage(75)
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 50)
        mob:setMod(tpz.mod.MDEF, 60)
        mob:addMod(tpz.mod.EVA, 50)

        tpz.mix.jobSpecial.config(mob, {
            between = 120,
            specials =
            {
                {id = tpz.jsa.PERFECT_DODGE, cooldown = 360, hpp = 90},
                {id = tpz.jsa.ELEMENTAL_SFORZO, cooldown = 360, hpp = 90},
            },
        })
    end,

    ['Coccineus'] = function(mob)
        mob:setDamage(150)
        mob:setMod(tpz.mod.MDEF, 60)
        mob:setMod(tpz.mod.LTNG_ABSORB, 100)

        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.CHAINSPELL, cooldown = 120, hpp = 90},
            },
        })
    end,

    ['Gastropoda'] = function(mob)
        mob:setDamage(125)
        mob:setMod(tpz.mod.MDEF, 24)
        mob:setMod(tpz.mod.UDMGPHYS, -25)

        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.MEIKYO_SHISUI, cooldown = 90, hpp = 90},
            },
        })
    end,

    ['Wadjet'] = function(mob)
        mob:setDamage(150)
        mob:setMod(tpz.mod.MDEF, 60)
        mob:setMod(tpz.mod.EEM_TERROR, 5)
        mob:AnimationSub(1) -- Gaze petrification
    end,
}

local mobRoamByMobName =
{
    ['Honey_Wespe'] = function(mob)
        local witchweed = GetMobByID(17478240)
        local pos = witchweed:getPos()
        if witchweed:isAlive() then
            mob:pathTo(pos.x, pos.y, pos.z)
        end
    end,
}

local mixinByMobName =
{
}

local mobFightByMobName =
{
    ['Selket'] = function(mob, target)
        local maxHP = mob:getMaxHP()
        local currentHP = mob:getHP()
        local hpPercent = (currentHP / maxHP) * 100

        -- Delay scaling: Starts at 4000ms, decreases as HP gets lower
        --[[
        HP %	Delay (ms)
        100%	4000
        75%	    3250
        50%	    2500
        25%	    1750
        1%	    1500
        ]]
        local newDelay = 4000 - ((100 - hpPercent) * 30) -- Adjust factor as needed

        -- Ensure delay doesn't go below a minimum value (e.g., 1500ms)
        newDelay = math.max(newDelay, 1500)

        mob:setDelay(newDelay)
    end,

    ['Witchweed'] = function(mob, target)
        local bee = GetMobByID(17478245)
	    local beeTimer = mob:getLocalVar("beeTimer")
        -- Spawns a bee next to it that it will attack until the bee is dead.
        -- If the bee dies, levels up and gains access to AoE charm
        if not bee:isSpawned() then
            if (beeTimer == 0) then
                mob:setLocalVar("beeTimer", os.time() + 15)
            elseif (os.time() >= beeTimer) then
                bee:setSpawn(mob:getXPos() + math.random(2, 5), mob:getYPos(), mob:getZPos() + math.random(1, 3))
                utils.spawnPetInBattle(mob, bee)
                mob:setLocalVar("beeTimer", os.time() + 60)
            end
        end

        -- Does not attack or cast while the bee is alive
        if bee:isAlive() and (mob:checkDistance(bee) <= 5) then
            mob:SetAutoAttackEnabled(false)
            mob:SetMagicCastingEnabled(false)
            mob:useMobAbility(tpz.mob.skills.BLOODY_CARESS, bee)
        else
            mob:SetAutoAttackEnabled(true)
            mob:SetMagicCastingEnabled(true)
        end
    end,

    ['Honey_Wespe'] = function(mob, target)
        local Allegiance = mob:getAllegiance()
        local witchweed = GetMobByID(17478240)
        local pos = witchweed:getPos()
        if witchweed:isAlive() then
        mob:pathTo(pos.x, pos.y, pos.z)
        end
    end,

    ['Sciaridae'] = function(mob, target)
    end,

    ['Coccineus'] = function(mob, target)
        -- 1k+ Earth damage magic bursts procs (silence) and removes Chainspell
        mob:addListener("SPELL_DMG_TAKEN", "COCCINEUS_SPELL_DMG_TAKEN", function(mob, caster, spell, amount, msg)
            local element = spell:getElement()

            if (element == tpz.magic.ele.EARTH) and (amount >= 1000) then
                if (msg == tpz.msg.basic.MAGIC_BURST_BLACK) or (msg == tpz.msg.MAGIC_BURST_BREATH) then
                    local duration = 30
                    BreakMob(mob, caster, tpz.procEffect.NONE, duration, tpz.procType.SILENCE)
                    mob:delStatusEffect(tpz.effect.CHAINSPELL)
                end
            end
        end)
    end,

    ['Gastropoda'] = function(mob, target)
        local auraParams = {
            radius = 10,
            corrupt = true,
            power = 1,
            duration = 30,
            auraNumber = 1
        }

        local sdtWeaknesses = {
            [1] = tpz.mod.SDT_EARTH,
            [2] = tpz.mod.SDT_WATER,
            [3] = tpz.mod.SDT_WIND,
            [4] = tpz.mod.SDT_FIRE,
            [5] = tpz.mod.SDT_ICE,
            [6] = tpz.mod.SDT_THUNDER,
        }

        local defaultSDT = 20
        local highSDT = 100
        local battleTime = mob:getBattleTime()
        local resChangeTimer = mob:getLocalVar("resChangeTimer")
        local resistance = mob:getLocalVar("resistance")

        if (resChangeTimer == 0) then
            mob:setLocalVar("resChangeTimer", math.random(60, 90))
        end

        if (battleTime >= resChangeTimer) then
            mob:setLocalVar("resChangeTimer", battleTime + math.random(60, 90))
            mob:setLocalVar("resistance", math.random(6))
        end

        -- Rotates elemental resistances every 60-90s
        if sdtWeaknesses[resistance] then
            for _, mod in ipairs({
                tpz.mod.SDT_FIRE, tpz.mod.SDT_ICE, tpz.mod.SDT_WIND, tpz.mod.SDT_EARTH,
                tpz.mod.SDT_THUNDER, tpz.mod.SDT_WATER, tpz.mod.SDT_LIGHT, tpz.mod.SDT_DARK
            }) do
                mob:setMod(mod, (mod == sdtWeaknesses[resistance]) and highSDT or defaultSDT)
            end
        end

        -- Corrupts a buff on nearby players every 3 seconds
        AddMobAura(mob, target, auraParams)
        TickMobAura(mob, target, auraParams)
    end,

    ['Wadjet'] = function(mob, target)
        local animationSub = mob:AnimationSub()
        mob:AnimationSub(1) -- Perma gaze petrification (unless procced)

        if target:hasStatusEffect(tpz.effect.FEALTY) then -- Fealty blocks all status effects
		    return
	    end
		if animationSub == 1 then
			if (target:isFacing(mob)) then
				if target:hasStatusEffect(tpz.effect.BLINDNESS) then --Can't gaze debuff them if they can't see!
					return
				end
                if not target:hasStatusEffect(tpz.effect.PETRIFICATION) then
				    target:addStatusEffect(tpz.effect.PETRIFICATION, 1, 0, 5)
                end
			end
		end

    -- 1k+ Fire damage magic bursts procs (terror) and removes gaze petrification
    mob:addListener("SPELL_DMG_TAKEN", "WADJET_SPELL_DMG_TAKEN", function(mob, caster, spell, amount, msg)
        local element = spell:getElement()

        if (element == tpz.magic.ele.FIRE) and (amount >= 1000) then
            if (msg == tpz.msg.basic.MAGIC_BURST_BLACK) or (msg == tpz.msg.MAGIC_BURST_BREATH) then
                local duration = 60
                BreakMob(mob, caster, tpz.procEffect.NONE, duration, tpz.procType.TERROR)
            end
        end
    end)

        -- Gaze petrification is removed while terrored
        if mob:hasStatusEffect(tpz.effect.TERROR) then
            mob:AnimationSub(0)
        else
            mob:AnimationSub(1)
        end
        
        -- Resets enmity on auto-attacks
        mob:addListener("ATTACK","WADJET_ATTACK", function(mob)
            local target = mob:getTarget()
            mob:resetEnmity(target)
        end)
    end,
}

local mobDeathByMobName =
{
    ['Honey_Wespe'] = function(mob, player, isKiller, noKiller)
        local witchweed = GetMobByID(17478240)
        local level = witchweed:getMainLvl()

        if (player == nil) then -- Was killed by Witchweed and not a player
            -- Level up Witchweed on death
            witchweed:setLocalVar("beeTimer", os.time() + 45)
            witchweed:useMobAbility(tpz.mob.skills.LEVEL_UP, witchweed)
            witchweed:setMobLevel(level +1)

            -- Mods and Mobmods are cleared on leveling up, need to readd them
            tpz.wotg.onMobSpawn(witchweed)
            witchweed:setMobMod(tpz.mobMod.SKILL_LIST, 1208)
            end
    end,
}

tpz.wotg.onMobSpawn = function(mob)
    mob:setDamage(150)
    mob:setMod(tpz.mod.ATTP, 25)
    mob:setMod(tpz.mod.DEFP, 25)
    mob:setMod(tpz.mod.EEM_SILENCE, 5)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)

    local mobName = mob:getName()
    local mods = modByMobName[mobName]

    if mods then
        mods(mob)
    end
end

tpz.wotg.onMobRoam = function(mob, target)
    local mobName  = mob:getName()
    local mobRoam = mobRoamByMobName[mobName]

    if mobRoam then
        mobRoam(mob, target)
    end
end

tpz.wotg.onMobFight = function(mob, target)
    local mobName  = mob:getName()
    local mixin    = mixinByMobName[mobName]
    local mobFight = mobFightByMobName[mobName]

    if mixin then
        mixin(mob, target)
    end

    if mobFight then
        mobFight(mob, target)
    end
end

tpz.wotg.onMobDeath = function (mob, player, isKiller, noKiller, event)
    local mobName  = mob:getName()
    local mobDeath = mobDeathByMobName[mobName]

    if mobDeath then
        mobDeath(mob, player, isKiller, noKiller)
    end

    if (event ~= nil) then
        for eventName, eventID in pairs(tpz.wotg.events) do
            if event == eventID and eventOnMobDeath[eventName] then
                eventOnMobDeath[eventName](mob, player)
                return
            end
        end
    end
end


local eventList = {
    [1] = randomEventWaves,
    [2] = randomEventDefense,
    [3] = randomEventBoss,
    [4] = randomEventSpecial,
}

tpz.wotg.RandomEvent = function(player, spawnChance)
    local zone = player:getZone()
    randomEventWaves(player) -- TODO: Remove after done testing
    if (math.random(100) <= spawnChance) and (zone:getLocalVar("eventActive") == 0) then
        eventList[math.random(#eventList)](player)
    end
end

tpz.wotg.spawnWave = function(player, waveIndex)
    local zone = player:getZone()
    if waveIndex < 1 or waveIndex > #waves then
        print("Invalid wave index: " .. waveIndex)
        return
    end

    local wave = waves[waveIndex]
    local waveSize = #wave  -- Get the number of mobs in this wave
    print("Spawning Wave " .. waveIndex)

    -- Reset wave progress for the new wave
    zone:setLocalVar("waveProgress", 0)

    for _, mobID in ipairs(wave) do
        print("Spawning Mob ID:", mobID)
        local mob = GetMobByID(mobID)
        if not mob:isSpawned() then
            mob:setSpawn(player:getXPos(), player:getYPos(), player:getZPos())
            SpawnMob(mobID)
            mob:updateEnmity(player)
            mob:addStatusEffect(tpz.effect.TERROR, 1, 0, 3)
        end
    end

    -- Set wave size as a local variable in the zone
    zone:setLocalVar("waveActive", 1)
    zone:setLocalVar("waveSize", waveSize)
    zone:setLocalVar("eventCompleted", 0)
    utils.MessageParty(player, 'Enemies appear around you!', 0xD, none)
end

tpz.wotg.progressCheck = function(player, zone)
    local currentWave = zone:getLocalVar("wave")
    local waveProgress = zone:getLocalVar("waveProgress")
    local waveSize = zone:getLocalVar("waveSize")
    local maxWaves = zone:getLocalVar("maxWaves")
    local eventCompleted = zone:getLocalVar("eventCompleted")
    local metaProgress = zone:getLocalVar("metaProgress")

    -- Print the current wave details for debugging
    local debugTimer = zone:getLocalVar("debugTimer")
    if (os.time() >= debugTimer) then
        -- print(string.format("Wave: %d, Progress: %d, Size: %d, Max Waves: %d", currentWave, waveProgress, waveSize, maxWaves))
        zone:setLocalVar("debugTimer", os.time() + 10)
    end

    if (waveSize > 0) and (waveProgress >= waveSize) then
        if (currentWave +1 <= maxWaves) then
            printf("Increasing wave by 1")
            zone:setLocalVar("wave", currentWave +1)
            zone:setLocalVar("waveActive", 0)
        else
            -- All waves completed, end the event
            if (eventCompleted == 0) then
                RandomEventComplete(player)
                zone:setLocalVar("eventActive", 0)
                zone:setLocalVar("waveActive", 0)
                zone:setLocalVar("eventCompleted", 1)
            end
        end
    end

    if (metaProgress >= 100) then
        SpawnMetaBoss(player, zone)
    end
end

local eventOnMobDeath = {}
function eventOnMobDeath.Waves(mob, player)
    local zone = mob:getZone()
    local waveProgress = zone:getLocalVar("waveProgress")

    -- printf("Mob dead, incrementing wave progress by 1")
    zone:setLocalVar("waveProgress", waveProgress + 1)
end

function eventOnMobDeath.Boss(mob, player)
    if not player then return end

    local zone = player:getZone()
    local metaProgress = zone:getLocalVar("metaProgress")

    if metaProgress < 100 then
        zone:setLocalVar("metaProgress", math.min(metaProgress + 5, 100))
        utils.MessageParty(player, 'Meta progress: ' .. zone:getLocalVar("metaProgress") .. '%', 0xD, nil)
        ClearMsgVars(zone)
    end
end


tpz.wotg.WaveonMobDeath = function(mob)
    local zone = mob:getZone()
    local waveProgress = zone:getLocalVar("waveProgress")

    -- printf("Mob dead, incrimenting wave progress by 1")
    zone:setLocalVar("waveProgress", waveProgress +1)
end