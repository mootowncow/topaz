-----------------------------------
--  PET: Avatars / Elementals
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/ability")
require("scripts/globals/msg")
require("scripts/globals/pets")
require("scripts/globals/summon")
-----------------------------------
local castFinished = 0
local resMod = {
    { tpz.pet.id.FIRESPIRIT, tpz.mod.FIRERES },       
    { tpz.pet.id.ICESPIRIT, tpz.mod.ICERES },        
    { tpz.pet.id.AIRSPIRIT, tpz.mod.WINDRES },          
    { tpz.pet.id.EARTHSPIRIT, tpz.mod.EARTHRES },        
    { tpz.pet.id.THUNDERSPIRIT, tpz.mod.THUNDERRES },      
    { tpz.pet.id.WATERSPIRIT, tpz.mod.WATERRES },        
    { tpz.pet.id.LIGHTSPIRIT, tpz.mod.LIGHTRES },        
    { tpz.pet.id.DARKSPIRIT, tpz.mod.DARKRES },         
    { tpz.pet.id.CARBUNCLE, tpz.mod.LIGHTRES },          
    { tpz.pet.id.FENRIR, tpz.mod.DARKRES },           
    { tpz.pet.id.IFRIT, tpz.mod.FIRERES },            
    { tpz.pet.id.TITAN, tpz.mod.EARTHRES },       
    { tpz.pet.id.LEVIATHAN, tpz.mod.WATERRES },          
    { tpz.pet.id.GARUDA, tpz.mod.WINDRES },            
    { tpz.pet.id.SHIVA, tpz.mod.ICERES },           
    { tpz.pet.id.RAMUH, tpz.mod.THUNDERRES },         
    { tpz.pet.id.DIABOLOS, tpz.mod.DARKRES },           
    { tpz.pet.id.ATOMOS, tpz.mod.DARKRES },      
    { tpz.pet.id.CAIT_SITH, tpz.mod.LIGHTRES },         
}

local absorbMod = {
    { tpz.pet.id.FIRESPIRIT, tpz.mod.FIRE_ABSORB_TO_MP },       
    { tpz.pet.id.ICESPIRIT, tpz.mod.ICE_ABSORB_TO_MP },        
    { tpz.pet.id.AIRSPIRIT, tpz.mod.WIND_ABSORB_TO_MP },          
    { tpz.pet.id.EARTHSPIRIT, tpz.mod.EARTH_ABSORB_TO_MP },        
    { tpz.pet.id.THUNDERSPIRIT, tpz.mod.THUNDER_ABSORB_TO_MP },      
    { tpz.pet.id.WATERSPIRIT, tpz.mod.WATER_ABSORB_TO_MP },        
    { tpz.pet.id.LIGHTSPIRIT, tpz.mod.LIGHT_ABSORB_TO_MP },        
    { tpz.pet.id.DARKSPIRIT, tpz.mod.DARK_ABSORB_TO_MP },         
    { tpz.pet.id.CARBUNCLE, tpz.mod.LIGHT_ABSORB_TO_MP },          
    { tpz.pet.id.FENRIR, tpz.mod.DARK_ABSORB_TO_MP },           
    { tpz.pet.id.IFRIT, tpz.mod.FIRE_ABSORB_TO_MP },            
    { tpz.pet.id.TITAN, tpz.mod.EARTH_ABSORB_TO_MP },       
    { tpz.pet.id.LEVIATHAN, tpz.mod.WATER_ABSORB_TO_MP },          
    { tpz.pet.id.GARUDA, tpz.mod.WIND_ABSORB_TO_MP },            
    { tpz.pet.id.SHIVA, tpz.mod.ICE_ABSORB_TO_MP },           
    { tpz.pet.id.RAMUH, tpz.mod.THUNDER_ABSORB_TO_MP },         
    { tpz.pet.id.DIABOLOS, tpz.mod.DARK_ABSORB_TO_MP },           
    { tpz.pet.id.ATOMOS, tpz.mod.DARK_ABSORB_TO_MP },      
    { tpz.pet.id.CAIT_SITH, tpz.mod.LIGHT_ABSORB_TO_MP },         
}

local spells =
{
    [1] = {235,146, 147, 204},               -- Fire
    [2] = {58, 151, 152, 206},               -- Ice
    [3] = {59, 156, 157, 208},               -- Wind
    [4] = {56, 161, 162, 210},               -- Earth
    [5] = {239, 166, 167, 212},              -- Thunder
    [6] = {221, 171, 172, 214},              -- Water
    [7] = {112, 28, 29, 30, 21},             -- Light
    [8] = {252, 270, 271, 273, 274, 275},    -- Dark
}

function onMobSpawn(mob)
    mob:setMod(tpz.mod.REFRESH, 300)
    local master = mob:getMaster()
    local body = master:getEquipID(tpz.slot.BODY)
    local hands = master:getEquipID(tpz.slot.HANDS)
    -- Cast cast timer for Elementals
    mob:setLocalVar("castTimer", 10)

    -- Store mobs stats as a variable for equipement bonuses
    local Att = mob:setLocalVar("Att", mob:getMod(tpz.mod.ATT))
    local Acc = mob:setLocalVar("Acc", mob:getMod(tpz.mod.ACC))
    local Ratt = mob:setLocalVar("Ratt", mob:getMod(tpz.mod.RATT))
    local Racc = mob:setLocalVar("Racc", mob:getMod(tpz.mod.RACC))
    local Macc = mob:setLocalVar("Macc", mob:getMod(tpz.mod.MACC))
    local Def = mob:setLocalVar("Def", mob:getMod(tpz.mod.DEF))
    local Eva = mob:setLocalVar("Eva", mob:getMod(tpz.mod.EVA))
    local Enmity = mob:setLocalVar("Enmity", mob:getMod(tpz.mod.ENMITY))
    local Crit = mob:setLocalVar("Crit", mob:getMod(tpz.mod.CRITHITRATE))
    local BurstDamage = mob:setLocalVar("BurstDamage", mob:getMod(tpz.mod.BP_BURST_DAMAGE))

    -- Check for Evokers Doublet resist mod
    -- Check if Evoker's Doublet is equipped, if it is then add the correct resist for avatar currently out
    local body = master:getEquipID(tpz.slot.BODY)
    local resist = 0
    for i, element in pairs(resMod) do
        if master:getPetID() == element[1] and master:getPetID() ~= nil then
            resist = element[2]
            if body == 12650 then -- Evoker's Doublet
                master:addMod(resist, 20)
                master:setLocalVar("Element" .. resist, 20)
            end
        end
    end
    -- Check if Evoker's Doublet is equipped, if it is then add the correct resist for avatar currently out
    local body = master:getEquipID(tpz.slot.BODY)
    local resist = 0
    for i, element in pairs(resMod) do
        if master:getPetID() == element[1] and master:getPetID() ~= nil then
            resist = element[2]
            if body == 14487 then -- Evoker's Doublet
                master:addMod(resist, 25)
                master:setLocalVar("Element" .. resist, 25)
            end
        end
    end
    -- Check if Evoker's Bracers is equipped, if it is then add the correct absorb for avatar currently out
    local hands = master:getEquipID(tpz.slot.HANDS)
    local absorb = 0
    for i, element in pairs(absorbMod) do
        if master:getPetID() == element[1] and master:getPetID() ~= nil then
            absorb = element[2]
            if hands == 13975 then -- Evoker's Bracers
                master:addMod(absorb, 25)
                master:setLocalVar("Absorb" .. absorb, 25)
            end
        end
    end
    -- Check if Evoker's Bracers is equipped, if it is then add the correct absorb for avatar currently out
    local hands = master:getEquipID(tpz.slot.HANDS)
    local absorb = 0
    for i, element in pairs(absorbMod) do
        if master:getPetID() == element[1] and master:getPetID() ~= nil then
            absorb = element[2]
            if hands == 14904 then -- Evoker's Bracers
                master:addMod(absorb, 30)
                master:setLocalVar("Absorb" .. absorb, 30)
            end
        end
    end
end

function onMobFight(mob, target)
    local master = mob:getMaster()
    local party = master:getParty()
    local castTimer = mob:getLocalVar("castTimer")
    local cureCastTimer = mob:getLocalVar("cureCastTimer")
    local spellCooldown = getSpellCooldown(mob, master)
    local battleTime = mob:getBattleTime()
    --printf("spell cooldown %u", spellCooldown)
    --printf("castTimer %u", castTimer)
    --printf("cureCastTimer %u", cureCastTimer)
    --printf("battleTime %u", battleTime)
    --print(earthSpells[1][math.random(#earthSpells)])

    if os.time() <= castFinished then
        return
    end
    -- Light Elemental curing AI
     -- Don't cast if cureCastTimer isn't up yet!
    if os.time() >= cureCastTimer then
        if master:getPetID() == tpz.pet.id.LIGHT_SPIRIT then
            if party ~= nil then
                for _,v in ipairs(party) do
                    local memberHPP = v:getHPP()
                    if memberHPP < 70 then -- Tries to use highest cure for current level of the Elemental
                        if UseHighestCure(mob, v) then
                            return
                        end
                    end
                end
            end
        end
    end
    -- Elemental offensive casting AI. 
    -- Don't cast if casttimer isn't up yet!
    if battleTime >= castTimer then
        mob:setLocalVar("castTimer", battleTime + (spellCooldown)) 
        for v = tpz.pet.id.FIRE_SPIRIT, tpz.pet.id.DARK_SPIRIT do
            if master:getPetID() == v then
                local currentSpells = spells[v + 1]
                if #currentSpells > 0 then
                    local selectedIndex = math.random(#currentSpells);
                    --printf('Max spells: %u Selected spell index: %u Selected spell: %u', #currentSpells, selectedIndex, currentSpells[selectedIndex]);
                    mob:castSpell(currentSpells[math.random(#currentSpells)])
                    castFinished = os.time() + 4
                end
            end
        end
    end

    -- Add gear mods
    local Att = mob:getLocalVar("Att", mob:getMod(tpz.mod.ATT))
    local Acc = mob:getLocalVar("Acc", mob:getMod(tpz.mod.ACC))
    local Ratt = mob:getLocalVar("Ratt", mob:getMod(tpz.mod.RATT))
    local Racc = mob:getLocalVar("Racc", mob:getMod(tpz.mod.RACC))
    local Macc = mob:getLocalVar("Macc", mob:getMod(tpz.mod.MACC))
    local Def = mob:getLocalVar("Def", mob:getMod(tpz.mod.DEF))
    local Eva = mob:getLocalVar("Eva", mob:getMod(tpz.mod.EVA))
    local Enmity = mob:getLocalVar("Enmity", mob:getMod(tpz.mod.ENMITY))
    local Crit = mob:getLocalVar("Crit", mob:getMod(tpz.mod.CRITHITRATE))
    local BurstDamage = mob:getLocalVar("BurstDamage", mob:getMod(tpz.mod.BP_BURST_DAMAGE))
    local head = master:getEquipID(tpz.slot.HEAD)
    local body = master:getEquipID(tpz.slot.BODY)
    local hands = master:getEquipID(tpz.slot.HANDS)
    local legs = master:getEquipID(tpz.slot.LEGS)
    local feet = master:getEquipID(tpz.slot.FEET)

    -- Fenrirs Crown Acc bonuses
    if head == 11496 and master:getPetID() == tpz.pet.id.FENRIR then 
        mob:setMod(tpz.mod.ACC, Acc + 30)
    else
        mob:setMod(tpz.mod.ACC, Acc)
    end
    -- Karura Hachigane Attack and Defense bonus
    if head == 16154 and master:getPetID() == tpz.pet.id.GARUDA then 
        mob:setMod(tpz.mod.ATT, Att + 10)
        mob:setMod(tpz.mod.DEF, Def + 10)
    else
        mob:setMod(tpz.mod.ATT, Att)
        mob:setMod(tpz.mod.DEF, Def)
    end
    -- Evokers Gages Attack bonuses
    if hands == 14960 and master:getPetID() == tpz.pet.id.LEVIATHAN then 
        mob:setMod(tpz.mod.ATT, Att + 15)
    else
        mob:setMod(tpz.mod.ATT, Att)
    end
    -- Morana Pigaches Macc Bonus
    if feet == 11408 and master:getPetID() == tpz.pet.id.SHIVA then 
        mob:setMod(tpz.mod.MACC, Macc + 15)
    else
        mob:setMod(tpz.mod.MACC, Macc)
    end
end

function onMobDeath(mob, player)
    local master = mob:getMaster()
    local body = master:getEquipID(tpz.slot.BODY)
    local hands = master:getEquipID(tpz.slot.HANDS)

    -- Check for Evokers Doublet resist mod
    if body == 12650 then -- Evoker's Doublet
        for v = tpz.mod.FIRERES, tpz.mod.DARKRES, 1 do
            if master:getLocalVar("Element" .. v) > 0 then
                master:addMod(v, -20)
                master:setLocalVar("Element" .. v, 0)
            end
        end
    elseif body == 14487 then -- Evoker's Doublet +1
        for v = tpz.mod.FIRERES, tpz.mod.DARKRES, 1 do
            if master:getLocalVar("Element" .. v) > 0 then
                master:addMod(v, -25)
                master:setLocalVar("Element" .. v, 0)
            end
        end
    end
    -- Check for Evokers Bracers absorb mod
    if hands == 13975 then -- Evoker's Bracers
        for v = tpz.mod.FIRE_ABSORB_TO_MP, tpz.mod.DARK_ABSORB_TO_MP, 1 do
            if master:getLocalVar("Absorb" .. v) > 0 then
                master:addMod(v, -25)
                master:setLocalVar("Absorb" .. v, 0)
            end
        end
    elseif hands == 14904 then -- Evoker's Bracers +1
        for v = tpz.mod.FIRE_ABSORB_TO_MP, tpz.mod.DARK_ABSORB_TO_MP, 1 do
            if master:getLocalVar("Absorb" .. v) > 0 then
                master:addMod(v, -30)
                master:setLocalVar("Absorb" .. v, 0)
            end
        end
    end
end

function UseHighestCure(mob, target)
    local master = mob:getMaster()
    local eleMagicCoolBonus = master:getMod(tpz.mod.ELEMENTAL_MAGIC_COOL)
    local level = mob:getMainLvl()
    local spellCooldown = getSpellCooldown(mob, master)
    -- Cure LVL1, Cure II LVL11, Cure III LVL 21, Cure IV LVL 41, Cure V LVL 61
    if level >= 61 then
        mob:castSpell(5,target)
        castFinished = os.time() + 4
        mob:setLocalVar("cureCastTimer", os.time() + (spellCooldown)) 
        return true
    elseif level >= 41 then
        mob:castSpell(4,target)
        castFinished = os.time() + 4
        mob:setLocalVar("cureCastTimer", os.time() + (spellCooldown)) 
        return true
    elseif level >= 21 then
        mob:castSpell(3,target)
        castFinished = os.time() + 4
        mob:setLocalVar("cureCastTimer", os.time() + (spellCooldown)) 
        return true
    elseif level >= 11 then
        mob:castSpell(2,target)
        castFinished = os.time() + 4
        mob:setLocalVar("cureCastTimer", os.time() + (spellCooldown)) 
        return true
    elseif level >= 1 then
        mob:castSpell(1,target)
        castFinished = os.time() + 4
        mob:setLocalVar("cureCastTimer", os.time() + (spellCooldown)) 
        return true
    end
    return false
end

function getDayWeatherEffect(mob, master)
    -- Day / Weather bonus and penalty
    local spiritEle = master:getPetID() +1 -- get the spirit's ID, it is already aligned in proper element order
    -- element order: fire, ice, wind, earth, thunder, water, light, dark
    local weatherDayBonus = 0
    local dayElement = VanadielDayElement() -1
    local weather = master:getWeather()

    --printf("ele element %u", spiritEle)
    --printf(" dayStrong table %u", tpz.magic.dayStrong[spiritEle]) 
    -- Day bonus/penalty
    --printf("dayelement %u", dayElement.FIRE)
    if (dayElement == tpz.magic.dayStrong[spiritEle]) then
        weatherDayBonus = weatherDayBonus - 3
    elseif (dayElement == tpz.magic.dayWeak[spiritEle]) then
        weatherDayBonus = weatherDayBonus + 3
    end
    --printf("weatherDayBonus %d", weatherDayBonus)
    -- Weather bonus/penalty
    if (weather == tpz.magic.singleWeatherStrong[spiritEle]) then
        weatherDayBonus = weatherDayBonus - 2
    elseif (weather == tpz.magic.singleWeatherWeak[spiritEle]) then
        weatherDayBonus = weatherDayBonus + 2
    elseif (weather == tpz.magic.doubleWeatherStrong[spiritEle]) then
        weatherDayBonus = weatherDayBonus - 2
    elseif (weather == tpz.magic.doubleWeatherWeak[spiritEle]) then
        weatherDayBonus = weatherDayBonus + 2
    end
    --printf("weatherDayBonus %d", weatherDayBonus)

    return weatherDayBonus
end

function getSpellCooldown(mob, master)
    -- Get cooldown bwteeen spell casts
    local spellCooldown = 20
    local eleMagicCoolBonus = master:getMod(tpz.mod.ELEMENTAL_MAGIC_COOL)
    -- Add relic pants gear mod
    spellCooldown = spellCooldown - eleMagicCoolBonus
    -- Add day/weather bonuses
    spellCooldown = spellCooldown + getDayWeatherEffect(mob, master)
    -- Add Astral Flow bonus
    if master:hasStatusEffect(tpz.effect.ASTRAL_FLOW) then
        spellCooldown = spellCooldown - 5
    end

    return spellCooldown
end