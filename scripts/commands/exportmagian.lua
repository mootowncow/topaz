---------------------------------------------------------------------------------------------------
-- func: magianexporter
-- desc: Exports and converts magian data to be pasted into BG wiki
-- TODO: Branches with Clusters Crystals sorted properly
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

    -- Build readable skill names from tpz.skill
    local skillNames = {}
    for name, id in pairs(tpz.skill) do
        local display = name:gsub("_", " "):gsub("(%a)([%w']*)", function(first, rest)
            return first:upper() .. rest:lower()
        end)
        skillNames[id] = display
    end

    local slotNames = {
        [tpz.slot.MAIN]   = "Main",
        [tpz.slot.SUB]    = "Sub",
        [tpz.slot.RANGED] = "Ranged",
        [tpz.slot.AMMO]   = "Ammo",
        [tpz.slot.HEAD]   = "Head",
        [tpz.slot.BODY]   = "Body",
        [tpz.slot.HANDS]  = "Hands",
        [tpz.slot.LEGS]   = "Legs",
        [tpz.slot.FEET]   = "Feet",
        [tpz.slot.NECK]   = "Neck",
        [tpz.slot.WAIST]  = "Waist",
        [tpz.slot.EAR1]   = "Ear1",
        [tpz.slot.EAR2]   = "Ear2",
        [tpz.slot.RING1]  = "Ring1",
        [tpz.slot.RING2]  = "Ring2",
        [tpz.slot.BACK]   = "Back",
    }

    local elementIcons = {
        [tpz.magic.ele.FIRE]      = "{{Fire}}",
        [tpz.magic.ele.ICE]       = "{{Ice}}",
        [tpz.magic.ele.WIND]      = "{{Wind}}",
        [tpz.magic.ele.EARTH]     = "{{Earth}}",
        [tpz.magic.ele.LIGHTNING] = "{{Lightning}}",
        [tpz.magic.ele.WATER]     = "{{Water}}",
        [tpz.magic.ele.LIGHT]     = "{{Light}}",
        [tpz.magic.ele.DARK]      = "{{Dark}}",
    }

    local function formatElementIcon(element)
        return elementIcons[element] or "–"
    end

    local function itemLink(itemId)
        if not itemId or itemId == tpz.items.NONE then
            return "–"
        end

        local name = itemNames[itemId] or ("Unknown("..itemId..")")
        local displayName = name:gsub("_", " ")

        -- Exceptions for display name and icon
        local exceptions = {
            ["dagger"]           = "Dagger_(Weapon)",
            ["lumberjack"]       = "Lumberjack_(Item)",
            ["side sword"]       = "Side-sword",
            ["eye of verthandi"] = "Eye of Verthandi",
            ["brand darcon"]     = "Brand d'Arcon",
            ["orcus mandible"]   = "Orcus Mandible",
        }

        local key = displayName:lower()
        if exceptions[key] then
            displayName = exceptions[key]
        else
            -- Capitalize normally
            displayName = displayName:gsub("(%a)([%w']*)", function(first, rest)
                return first:upper() .. rest:lower()
            end)

            -- Add apostrophe to any word ending in 's'
            displayName = displayName:gsub("(%f[%w]%a+)s(%s)", "%1's%2")
        end

        -- Icon name uses same exceptions
        local iconName = displayName:gsub(" ", "_")
        local icon = "[[File:" .. iconName .. " icon.png|25px]]"

        return icon .. " [[" .. displayName .. "]]"
    end

    local function formatAugments(augments)
        if not augments or #augments == 0 then return "" end
        local parts = {}
        for _, aug in ipairs(augments) do
            if type(aug) == "table" and aug[1] and aug[2] then
                local augName
                if aug[1] == tpz.augments.SPECIAL then
                    for name, id in pairs(tpz.augments.special) do
                        if id == aug[2] then
                            augName = name
                            break
                        end
                    end
                    if not augName then
                        augName = "Unknown Special"
                    end
                else
                    augName = augmentNames[aug[1]] or ("Unknown("..aug[1]..")")
                    augName = augName .. " +" .. aug[2]
                end

                -- Format: remove underscores, capitalize properly
                augName = augName:gsub("_", " ")
                augName = augName:gsub("(%a)([%w']*)", function(first, rest)
                    return first:upper() .. rest:lower()
                end)

                table.insert(parts, augName)
            elseif type(aug) == "string" then
                -- If augment is just a string
                local augName = aug:gsub("_", " ")
                augName = augName:gsub("(%a)([%w']*)", function(first, rest)
                    return first:upper() .. rest:lower()
                end)
                table.insert(parts, augName)
            end
        end

        -- Return each augment on its own line
        return table.concat(parts, "<br />")
    end

    local function formatRequirements(trial)
        local req = ""
        if trial.numRequired then req = req .. "Required: " .. trial.numRequired .. "<br />" end
        if trial.killType then req = req .. "Kill Type: " .. trial.killType .. "<br />" end
        if trial.subType then req = req .. "Sub Type: " .. trial.subType .. "<br />" end
        if trial.specialType then req = req .. "Special Type: " .. trial.specialType .. "<br />" end

        if trial.mob then
            local mobNames = {}
            if trial.killType == "Family" then
                local familyNames = utils.generateEnumNameMap(tpz.mob.family)
                for _, id in ipairs(trial.mob) do table.insert(mobNames, familyNames[id] or ("#" .. id)) end
            elseif trial.killType == "Specific" then
                local poolNames = utils.generateEnumNameMap(tpz.mob.pool)
                for _, id in ipairs(trial.mob) do table.insert(mobNames, poolNames[id] or ("#" .. id)) end
            elseif trial.killType == "Species" then
                local speciesNames = utils.generateEnumNameMap(tpz.eco)
                for _, id in ipairs(trial.mob) do table.insert(mobNames, speciesNames[id] or ("#" .. id)) end
            end
            if #mobNames > 0 then req = req .. "Mob(s): " .. table.concat(mobNames, ", ") .. "<br />" end
        end

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

        if trial.element then
            req = req .. "Element: " .. formatElementIcon(trial.element) .. "<br />"
        end

        if trial.effect then
            local effectNames = utils.generateEnumNameMap(tpz.effect)
            req = req .. "Effect: " .. (effectNames[trial.effect] or ("#" .. trial.effect)) .. "<br />"
        end

        if trial.effectElement then
            req = req .. "Effect Element: " .. formatElementIcon(trial.effectElement) .. "<br />"
        end

        if trial.region then
            local regionNames = utils.generateEnumNameMap(tpz.region)
            local regions = {}
            for _, id in ipairs(trial.region) do table.insert(regions, regionNames[id] or ("#" .. id)) end
            req = req .. "Region(s): " .. table.concat(regions, ", ") .. "<br />"
        end
        if trial.zone then
            local zoneNames = utils.generateEnumNameMap(tpz.zone)
            local zones = {}
            for _, id in ipairs(trial.zone) do table.insert(zones, zoneNames[id] or ("#" .. id)) end
            req = req .. "Zone(s): " .. table.concat(zones, ", ") .. "<br />"
        end
        if trial.day then
            local dayNames = utils.generateEnumNameMap(tpz.day)
            req = req .. "Day: " .. (dayNames[trial.day] or ("#" .. trial.day)) .. "<br />"
        end
        if trial.wsId then
            local wsNames = {}
            local wsEnum = utils.generateEnumNameMap(tpz.ws)
            for _, id in ipairs(trial.wsId) do table.insert(wsNames, wsEnum[id] or ("#" .. id)) end
            req = req .. "Required WS: " .. table.concat(wsNames, ", ") .. "<br />"
        end
        if trial.wsDmg then req = req .. "Minimum WS Damage: " .. trial.wsDmg .. "<br />" end

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

    local function bitflagToSlot(bitflag)
        local slot = 0
        while bitflag > 1 do
            bitflag = bitflag / 2
            slot = slot + 1
        end
        return slot
    end

    local function exportTrialTableRow(trialId, trial)
        local reward = "–"
        if trial.rewardItem then
            reward = itemLink(trial.rewardItem.itemId)
            if trial.rewardItem.itemAugments then
                reward = reward .. "<br />" .. formatAugments(trial.rewardItem.itemAugments)
            end
        end

        local itemObject = GetItem(trial.mainItem)
        local skillType = itemObject and itemObject:getSkillType() or tpz.skill.NONE
        local skillDisplay

        if skillType >= 0 and skillType <= tpz.skill.SHIELD then
            skillDisplay = skillNames[skillType] or "Unknown"
        else
            local slotID = bitflagToSlot(itemObject:getEquipSlotID())
            skillDisplay = slotNames[slotID] or "Unknown Slot"
        end

        return "| " .. trialId
            .. " || " .. itemLink(trial.mainItem)
            .. " || " .. itemLink(trial.tradeItem)
            .. " || " .. skillDisplay
            .. " || " .. (trial.type or "–")
            .. " || " .. formatRequirements(trial)
            .. " || " .. reward
            .. " || " .. formatBranches(trial)
    end

    -- Collect all trials
    local allTrials = {}
    for id, trial in pairs(tpz.magian.trials) do
        table.insert(allTrials, { id = id, data = trial })
    end

    -- Group trials by skill/slot
    local trialsBySkill = {}
    for _, entry in ipairs(allTrials) do
        local itemObject = GetItem(entry.data.mainItem)
        local skillType = itemObject and itemObject:getSkillType() or tpz.skill.NONE
        local skillDisplay
        if skillType >= 0 and skillType <= tpz.skill.SHIELD then
            skillDisplay = skillNames[skillType] or "Unknown"
        else
            skillDisplay = slotNames[bitflagToSlot(itemObject:getEquipSlotID())] or "Unknown Slot"
        end
        trialsBySkill[skillDisplay] = trialsBySkill[skillDisplay] or {}
        table.insert(trialsBySkill[skillDisplay], entry)
    end

    -- Export to file
    local outputFile = [[C:\Server and Notepad Files\FFXI\Topaz\Moos Pserver\documentation\MagianTrials.txt]]
    local file = assert(io.open(outputFile, "w"))

    -- Add private server header
    file:write("{{Private Server|Shiyo Server|Shiyo}}\n\n")

    -- Define custom weapon/skill order
    local skillOrder = {
        ["Hand To Hand"] = 1,
        ["Dagger"] = 2,
        ["Sword"] = 3,
        ["Great Sword"] = 4,
        ["Axe"] = 5,
        ["Great Axe"] = 6,
        ["Scythe"] = 7,
        ["Polearm"] = 8,
        ["Katana"] = 9,
        ["Great Katana"] = 10,
        ["Club"] = 11,
        ["Staff"] = 12,
        ["Archery"] = 25,
        ["Marksmanship"] = 26,
        ["MAIN"]   = 27,
        ["SUB"]    = 28,
        ["RANGED"] = 29,
        ["AMMO"]   = 30,
        ["HEAD"]   = 31,
        ["BODY"]   = 32,
        ["HANDS"]  = 33,
        ["LEGS"]   = 34,
        ["FEET"]   = 35,
        ["NECK"]   = 36,
        ["WAIST"]  = 37,
        ["EAR1"]   = 38,
        ["EAR2"]   = 39,
        ["RING1"]  = 40,
        ["RING2"]  = 41,
        ["BACK"]   = 42,
    }

    -- Build Contents
    local content = {}
    for skillDisplay, _ in pairs(trialsBySkill) do
        table.insert(content, skillDisplay)
    end

    -- Sort content by custom order
    table.sort(content, function(a, b)
        local orderA = skillOrder[a] or 100
        local orderB = skillOrder[b] or 100
        return orderA < orderB
    end)


    file:write("\n")

    -- Write tables per skill/slot
    -- First, sort each skill group by trialId
    for _, skillDisplay in ipairs(content) do
        local trials = trialsBySkill[skillDisplay]
        table.sort(trials, function(a, b) return a.id < b.id end)  -- sort by trial #
    
        file:write("== " .. skillDisplay .. " ==\n")
        file:write("{| class=\"wikitable sortable\"\n")
        file:write("|+ Trial\n")
        file:write("! Trial # !! Main Item !! Trade Item !! Skill/Slot !! Type !! Requirements !! Reward !! Branches\n")
        for _, entry in ipairs(trials) do
            file:write("|-\n")
            file:write(exportTrialTableRow(entry.id, entry.data) .. "\n")
        end
        file:write("|}\n\n")
    end


    file:close()
    player:PrintToPlayer("Magian Trials export complete! Saved to " .. outputFile)
end
