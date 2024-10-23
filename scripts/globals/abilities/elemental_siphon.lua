-----------------------------------
-- Ability: Elemental Siphon
-- Drains MP from your summoned spirit.
-- Obtained: Summoner level 50
-- Recast Time: 5:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/pets")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player,target,ability)
    local spiritEle = player:getPetID() + 1 -- get the spirit's ID, it is already aligned in proper element order
    -- element order: fire, ice, wind, earth, thunder, water, light, dark

    -- The formula for MP recovery = floor( floor( Summoning Magic Skill × 1.05 - 55 + Elemental Siphon Equipment ) × ( 1.0 ± Weather and Day factors ) ) + Elemental Siphon Effect Job Points.
    local pEquipMods = player:getMod(tpz.mod.ENHANCES_ELEMENTAL_SIPHON)
    local skill = player:getSkillLevel(tpz.skill.SUMMONING_MAGIC)

    -- Ensure skill doesn't go negative
    skill = math.max(0, skill)

    -- Calculate base power without clamping the skill
    local basePower = skill * 1.05 + pEquipMods - 55

    -- Clamp the final basePower to be at least 50 but not more than max MP
    basePower = math.max(50, math.min(basePower, player:getMaxMP()))

    -- Custom x3 multiplier
    basePower = basePower * 3

    -- Add JP bonus
    local jpValue = player:getJobPointLevel(tpz.jp.ELEMENTAL_SIPHON_EFFECT) * 3
    basePower = basePower + jpValue

    local weatherDayBonus = 1
    local dayElement = VanadielDayElement() -1
    local weather = player:getWeather()
    

    -- Day bonus/penalty
    if (dayElement == tpz.magic.dayStrong[spiritEle]) then
        weatherDayBonus = weatherDayBonus + 0.1
    elseif (dayElement == tpz.magic.dayWeak[spiritEle]) then
        weatherDayBonus = weatherDayBonus - 0.1
    end
    -- Weather bonus/penalty
    if (weather == tpz.magic.singleWeatherStrong[spiritEle]) then
        weatherDayBonus = weatherDayBonus + 0.1
    elseif (weather == tpz.magic.singleWeatherWeak[spiritEle]) then
        weatherDayBonus = weatherDayBonus - 0.1
    elseif (weather == tpz.magic.doubleWeatherStrong[spiritEle]) then
        weatherDayBonus = weatherDayBonus + 0.25
    elseif (weather == tpz.magic.doubleWeatherWeak[spiritEle]) then
        weatherDayBonus = weatherDayBonus - 0.25
    end

    local power = math.floor(basePower * weatherDayBonus)
    local spirit = player:getPet()
    power = utils.clamp(power, 0, spirit:getMP()) -- cap MP drained at spirit's MP
    power = utils.clamp(power, 0, player:getMaxMP() - player:getMP()) -- cap MP drained at the max MP - current MP

    spirit:delMP(power)
    return player:addMP(power)
end
