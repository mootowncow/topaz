---------------------------------------------------------------------------------------------------
-- func: magianexporter
-- desc: Exports and converts magian data to be pasted into BG wiki
---------------------------------------------------------------------------------------------------
require("scripts/globals/magian_data")

cmdprops =
{
    permission = 1,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!magianexporter")
end

function onTrigger(player, target)
-- Build reverse lookups
local itemNames, augmentNames = {}, {}
for name, id in pairs(tpz.items) do itemNames[id] = name end
for name, id in pairs(tpz.augments) do augmentNames[id] = name end

-- Helper functions
local function itemLink(itemId)
    if not itemId or itemId == tpz.items.NONE then
        return "–"
    end

    local name = itemNames[itemId] or ("Unknown("..itemId..")")

    -- Replace underscores with spaces
    local displayName = name:gsub("_", " ")

    -- Handle exceptions (BG Wiki naming quirks)
    local exceptions = {
        ["DAGGER"]           = "Dagger_(Weapon)",
        ["Lumberjack"]       = "Lumberjack_(Item)",
        ["Side Sword"]       = "Side-sword",
        ["Eye Of Verthandi"] = "Eye of Verthandi",   -- lowercase "of"
        ["Brand Darcon"]     = "Brand d'Arcon",      -- special apostrophe
    }


    if exceptions[displayName] then
        displayName = exceptions[displayName]
    else
        -- Add apostrophe for possessive S
        displayName = displayName:gsub("(%a)S(%s)", function(letter, space)
            return letter .. "'s" .. space
        end)

        -- Capitalize each word
        displayName = displayName:gsub("(%a)([%w']*)", function(first, rest)
            return first:upper() .. rest:lower()
        end)
    end

    -- Wiki format: icon + link
    local cleanName = displayName:gsub("%(.*%)", "") -- strip (Weapon)/(Item) for the icon filename
    local icon = "[[File:" .. cleanName .. " icon.png|25px]]"
    return icon .. " [[" .. displayName .. "]]"
end

local function formatAugments(augments)
    if not augments or #augments == 0 then return "" end
    local parts = {}
    for _, aug in ipairs(augments) do
        if type(aug) == "table" and aug[1] and aug[2] then
            local augName
            if aug[1] == tpz.augments.SPECIAL then
                -- Lookup special sub-types
                for name, id in pairs(tpz.augments.special) do
                    if id == aug[2] then
                        augName = name
                        break
                    end
                end
                if not augName then
                    augName = "UnknownSpecial"
                end
            else
                augName = augmentNames[aug[1]] or ("Unknown("..aug[1]..")")
                augName = augName .. " +" .. aug[2]
            end
            table.insert(parts, augName)
        end
    end
    return table.concat(parts, ", ")
end

local function formatRequirements(trial)
    local req = ""

    -- Base requirement
    if trial.numRequired then
        req = req .. "Required: " .. trial.numRequired .. "<br />"
    end

    if trial.killType then
        req = req .. "Kill Type: " .. trial.killType .. "<br />"
    end

    -- SubType
    if trial.subType then
        req = req .. "Sub Type: " .. trial.subType .. "<br />"
    end

    -- SpecialType
    if trial.specialType then
        req = req .. "Special Type: " .. trial.specialType .. "<br />"
    end

    -- Mobs
    if trial.mob then
        local mobNames = {}
        if trial.killType == "Family" then
            local familyNames = utils.generateEnumNameMap(tpz.mob.family)
            for _, id in ipairs(trial.mob) do
                table.insert(mobNames, familyNames[id] or ("#" .. id))
            end
        elseif trial.killType == "Specific" then
            local poolNames = utils.generateEnumNameMap(tpz.mob.pool)
            for _, id in ipairs(trial.mob) do
                table.insert(mobNames, poolNames[id] or ("#" .. id))
            end
        elseif trial.killType == "Species" then
            local speciesNames = utils.generateEnumNameMap(tpz.eco)
            for _, id in ipairs(trial.mob) do
                table.insert(mobNames, speciesNames[id] or ("#" .. id))
            end
        end
        if #mobNames > 0 then
            req = req .. "Mob(s): " .. table.concat(mobNames, ", ") .. "<br />"
        end
    end

    -- Weather
    if trial.weather then
        local weatherNames = {}
        if trial.weather == "Any" then
            table.insert(weatherNames, "Any active weather")
        else
            for _, w in ipairs(trial.weather) do
                table.insert(weatherNames, tpz.weatherToElement[w] or ("#" .. w))
            end
        end
        req = req .. "Weather: " .. table.concat(weatherNames, ", ") .. "<br />"
    end

    -- Element
    if trial.element then
        local elementNames = utils.generateEnumNameMap(tpz.magic.ele)
        req = req .. "Element: " .. (elementNames[trial.element] or ("#" .. trial.element)) .. "<br />"
    end

    -- Status effect
    if trial.effect then
        local effectNames = utils.generateEnumNameMap(tpz.effect)
        req = req .. "Effect: " .. (effectNames[trial.effect] or ("#" .. trial.effect)) .. "<br />"
    end

    -- Status effect element
    if trial.effectElement then
        local elementNames = utils.generateEnumNameMap(tpz.magic.ele)
        req = req .. "Effect Element: " .. (elementNames[trial.effectElement] or ("#" .. trial.effectElement)) .. "<br />"
    end

    -- Region
    if trial.region then
        local regionNames = utils.generateEnumNameMap(tpz.region)
        local regions = {}
        for _, id in ipairs(trial.region) do
            table.insert(regions, regionNames[id] or ("#" .. id))
        end
        req = req .. "Region(s): " .. table.concat(regions, ", ") .. "<br />"
    end

    -- Zone
    if trial.zone then
        local zoneNames = utils.generateEnumNameMap(tpz.zone)
        local zones = {}
        for _, id in ipairs(trial.zone) do
            table.insert(zones, zoneNames[id] or ("#" .. id))
        end
        req = req .. "Zone(s): " .. table.concat(zones, ", ") .. "<br />"
    end

    -- Day
    if trial.day then
        local dayNames = utils.generateEnumNameMap(tpz.day)
        req = req .. "Day: " .. (dayNames[trial.day] or ("#" .. trial.day)) .. "<br />"
    end

    -- Weapon skill requirements
    if trial.wsId then
        local wsNames = {}
        local wsEnum = utils.generateEnumNameMap(tpz.ws) -- assuming tpz.ws has WS IDs
        for _, id in ipairs(trial.wsId) do
            table.insert(wsNames, wsEnum[id] or ("#" .. id))
        end
        req = req .. "Required WS: " .. table.concat(wsNames, ", ") .. "<br />"
    end

    if trial.wsDmg then
        req = req .. "Minimum WS Damage: " .. trial.wsDmg .. "<br />"
    end

    return req
end

local function formatBranches(trial)
    if not trial.branches then return "–" end
    local b = {}
    for item, tId in pairs(trial.branches) do
        table.insert(b, itemLink(item) .. " → Trial " .. tId)
    end
    return table.concat(b, "<br />")
end

local function exportTrialTableRow(trialId, trial)
    local reward = "–"
    if trial.rewardItem then
        reward = itemLink(trial.rewardItem.itemId)
        if trial.rewardItem.itemAugments then
            reward = reward .. "<br />" .. formatAugments(trial.rewardItem.itemAugments)
        end
    end

    return "| " .. trialId
        .. " || " .. itemLink(trial.mainItem)
        .. " || " .. itemLink(trial.tradeItem)
        .. " || " .. (trial.type or "–")
        .. " || " .. formatRequirements(trial)
        .. " || " .. reward
        .. " || " .. formatBranches(trial)
end

    -- Export all trials to text file
    local outputFile = [[C:\Server and Notepad Files\FFXI\Topaz\Moos Pserver\documentation\MagianTrials.txt]]
    local file = assert(io.open(outputFile, "w"))

    -- Group by mainItem
    local grouped = {}
    for id, trial in pairs(tpz.magian.trials) do
        local mainId = trial.mainItem or tpz.items.NONE
        grouped[mainId] = grouped[mainId] or {}
        table.insert(grouped[mainId], { id = id, data = trial })
    end

    local mainItemIds = {}
    for mainId in pairs(grouped) do table.insert(mainItemIds, mainId) end
    table.sort(mainItemIds)

    for _, mainId in ipairs(mainItemIds) do
        local trials = grouped[mainId]
        file:write("== " .. itemLink(mainId) .. " ==\n\n")

        for _, entry in ipairs(trials) do
            local trialId = entry.id
            local trial   = entry.data

            file:write("{| class=\"wikitable sortable\"\n")
            file:write("|+ Trial\n")
            file:write("! Trial # !! Main Item !! Trade Item !! Type !! Requirements !! Reward !! Branches\n")
            file:write("|-\n")
            file:write(exportTrialTableRow(trialId, trial) .. "\n")
            file:write("|}\n\n")
        end
    end

    file:close()
    player:PrintToPlayer("Magian Trials export complete! Saved to " .. outputFile)
end
