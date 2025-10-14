---------------------------------------------------------------------------------------------------
-- func: exportraiddrops
-- desc: Exports raid drop items with their mod data, weapon stats, and job/level info for wiki posting
---------------------------------------------------------------------------------------------------

require("scripts/globals/status") -- includes tpz.mod, tpz.items, tpz.job, tpz.skill, tpz.slot

cmdprops =
{
    permission = 1,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!exportraiddrops")
end

function onTrigger(player)
    -- === CONFIGURATION ===
    local inputItemMods      = [[C:\Server and Notepad Files\FFXI\Topaz\Moos Pserver\sql\item_mods.sql]]
    local inputItemWeapons   = [[C:\Server and Notepad Files\FFXI\Topaz\Moos Pserver\sql\item_weapon.sql]]
    local inputItemEquipment = [[C:\Server and Notepad Files\FFXI\Topaz\Moos Pserver\sql\item_equipment.sql]]
    local outputFile         = [[C:\Server and Notepad Files\FFXI\Topaz\Moos Pserver\documentation\RAIDDrops.txt]]

    -- === RAID BOSSES AND THEIR LOOT ===
    local mobData =
    {
        { Name = 'Promathia',    Loot = { tpz.items.GYVE_TROUSERS, tpz.items.GYVE_DOUBLET, tpz.items.LAIC_MANTLE, tpz.items.LATRIA_SASH } },
        { Name = 'Omega',        Loot = { tpz.items.TERMINAL_HELM, tpz.items.TERMINAL_PLATE, tpz.items.CESSANCE_EARRING, tpz.items.CONSUMMATION_TORQUE } },
        { Name = 'Bahamut',      Loot = { tpz.items.VANIR_BOOTS, tpz.items.BESTAS_BANE, tpz.items.LENTUS_GRIP, tpz.items.KYUJUTSUGI } },
        { Name = 'Ultima',       Loot = { tpz.items.CULMINUS, tpz.items.DENOUEMENTS, tpz.items.DOMESTICATORS_EARRING, tpz.items.TENGU_NO_HANE } },
        { Name = 'Ealdnarche',   Loot = { tpz.items.VANIR_COTEHARDIE, tpz.items.VANIR_BATTERY, tpz.items.VANIR_KNIFE, tpz.items.DIVINATOR } },
        { Name = 'Kamlanaut',    Loot = { tpz.items.MESYOHI_HAUBERGEON, tpz.items.MESYOHI_ROD, tpz.items.MESYOHI_SLACKS , tpz.items.KAMLANAUTS_SHIELD } },
        { Name = 'Shadow Lord',  Loot = { tpz.items.DREAD_JUPON, tpz.items.PERDITION_SLOPS, tpz.items.ONIMUSHA_NO_KOTE, tpz.items.TREPIDITY_MANTLE } },
        { Name = 'Ark Angel HM', Loot = { tpz.items.LITHELIMB_CAP, tpz.items.BLOODRAIN_STRAP, tpz.items.MANABYSS_PIGACHES, tpz.items.ANAHERA_SABER } },
        { Name = 'Ark Angel MR', Loot = { tpz.items.REGIMEN_MITTENS, tpz.items.FELISTRIS_MASK, tpz.items.SEKHMET_CORSET, tpz.items.ANAHERA_TABAR } },
        { Name = 'Ark Angel EV', Loot = { tpz.items.PATRICIUS_RING, tpz.items.OSMIUM_CUISSES, tpz.items.DYNASTY_MITTS, tpz.items.ANAHERA_SWORD } },
        { Name = 'Ark Angel TT', Loot = { tpz.items.FRAVASHI_MANTLE, tpz.items.THEURGISTS_SLACKS, tpz.items.SCAMPS_SOLLERETS, tpz.items.ANAHERA_SCYTHE } },
        { Name = 'Ark Angel GK', Loot = { tpz.items.LURID_MITTS, tpz.items.AGITATORS_COLLAR, tpz.items.DAIHANSHI_HABAKI, tpz.items.ANAHERA_BLADE } },
    }

    -- === Reverse lookup for mod names ===
    local modNames = {}
    for k, v in pairs(tpz.mod) do
        modNames[v] = k
    end

    local bit = require("bit")

    local function properCase(str)
        str = str:gsub("_", " ")
        return (str:gsub("(%a)([%w_']*)", function(first, rest)
            return first:upper() .. rest:lower()
        end))
    end

    local function decodeJobs(bits)
        if not bits or bits == 0 then
            return "None"
        end
        local fullMask = bit.lshift(1, tpz.MAX_JOB_TYPE - 1) - 1
        if bits == fullMask then
            return "All Jobs"
        end
        local jobs = {}
        for jobName, jobId in pairs(tpz.job) do
            if jobId and jobId > 0 and jobId < tpz.MAX_JOB_TYPE then
                local mask = bit.lshift(1, jobId - 1)
                if bit.band(bits, mask) ~= 0 then
                    table.insert(jobs, jobName)
                end
            end
        end
        table.sort(jobs, function(a, b)
            return tpz.job[a] < tpz.job[b]
        end)
        return table.concat(jobs, " ")
    end

    local function decodeSlots(bits)
        if not bits or bits == 0 then
            return "None"
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
            [tpz.slot.EAR1]   = "Ear",
            [tpz.slot.RING1]  = "Ring",
            [tpz.slot.BACK]   = "Back",
        }
        local slots = {}
        for id, name in pairs(slotNames) do
            local mask = bit.lshift(1, id)
            if bit.band(bits, mask) ~= 0 then
                table.insert(slots, name)
            end
        end
        return table.concat(slots, ", ")
    end

    -- === Parse item_mods.sql ===
    local function loadItemMods(path)
        local mods = {}
        local file = io.open(path, "r")
        if not file then
            player:PrintToPlayer("ERROR: Could not open " .. path)
            return mods
        end
        for line in file:lines() do
            for itemId, modId, value in line:gmatch("%((%d+),(%d+),([%-]?%d+)%)") do
                itemId, modId, value = tonumber(itemId), tonumber(modId), tonumber(value)
                mods[itemId] = mods[itemId] or {}
                table.insert(mods[itemId], { modId = modId, value = value })
            end
        end
        file:close()
        return mods
    end

    -- === Parse item_weapon.sql (with skill extraction) ===
    local function loadWeaponData(path)
        local weapons = {}
        local file = io.open(path, "r")
        if not file then
            player:PrintToPlayer("ERROR: Could not open " .. path)
            return weapons
        end
        for line in file:lines() do
            -- (itemId, 'name', skill, subskill, ilvl_skill, ilvl_parry, ilvl_macc, dmgType, hit, delay, dmg, unlock_points)
            local itemId, skill, hit, delay, dmg =
                line:match("%((%d+),.-,(%d+),%d+,%d+,%d+,%d+,%d+,(%d+),(%d+),(%d+),")
            if itemId then
                itemId = tonumber(itemId)
                skill = tonumber(skill)
                hit, delay, dmg = tonumber(hit), tonumber(delay), tonumber(dmg)
                local hitText = nil
                if hit == 2 then hitText = "Occasionally attacks twice"
                elseif hit == 3 then hitText = "Occasionally attacks 2–3 times"
                elseif hit == 4 then hitText = "Occasionally attacks 2–4 times"
                elseif hit and hit > 4 then hitText = "Occasionally attacks multiple times"
                end
                weapons[itemId] = { skill = skill, hit = hitText, delay = delay, dmg = dmg }
            end
        end
        file:close()
        return weapons
    end

    local function loadEquipmentData(path)
        local equip = {}
        local file = io.open(path, "r")
        if not file then
            player:PrintToPlayer("ERROR: Could not open " .. path)
            return equip
        end
        for line in file:lines() do
            local itemId, level, ilevel, jobs, slot =
                line:match("%((%d+),.-,(%d+),(%-?%d+),(%d+),%d+,%d+,%d+,(%d+),")
            if itemId then
                equip[tonumber(itemId)] = {
                    level = tonumber(level),
                    ilevel = tonumber(ilevel),
                    jobs = decodeJobs(tonumber(jobs)),
                    slot = decodeSlots(tonumber(slot))
                }
            end
        end
        file:close()
        return equip
    end

    -- === Load all data ===
    local itemMods = loadItemMods(inputItemMods)
    local weaponData = loadWeaponData(inputItemWeapons)
    local equipData = loadEquipmentData(inputItemEquipment)

    -- === Export ===
    local file = assert(io.open(outputFile, "w"))

    for _, mob in ipairs(mobData) do
        file:write(string.format("=== %s ===\n", properCase(mob.Name)))

        for _, itemId in ipairs(mob.Loot) do
            local itemName
            for name, id in pairs(tpz.items) do
                if id == itemId then
                    itemName = properCase(name)
                    break
                end
            end
            itemName = itemName or ("Item " .. itemId)

            local e = equipData[itemId]
            local w = weaponData[itemId]
            local itemSlot = "Unknown"

            -- If weapon and has skill, use that instead of slot
            if w and w.skill and w.skill ~= 0 then
                for skillName, skillId in pairs(tpz.skill) do
                    if skillId == w.skill then
                        itemSlot = properCase(skillName)
                        break
                    end
                end
            elseif e then
                itemSlot = e.slot
            end

            file:write(string.format("  * %s [%s]\n", itemName, itemSlot))

            if e then
                local levelText = string.format("      - Lv.%d", e.level)
                if e.ilevel and e.ilevel > 0 then
                    levelText = levelText .. string.format(" (iLvl %d)", e.ilevel)
                end
                file:write(string.format("%s %s\n", levelText, e.jobs))
            end

            if w then
                if w.hit then file:write(string.format("      - %s\n", w.hit)) end
                file:write(string.format("      - DMG: %d\n", w.dmg))
                file:write(string.format("      - Delay: %d\n", w.delay))
            end

            local mods = itemMods[itemId]
            if mods then
                for _, mod in ipairs(mods) do
                    local modName = properCase(modNames[mod.modId] or ("MOD_" .. tostring(mod.modId)))
                    file:write(string.format("      - %s %+d\n", modName, mod.value))
                end
            else
                file:write("      - No mods found\n")
            end
        end
        file:write("\n")
    end

    file:close()
    player:PrintToPlayer("RAID drops export complete! Saved to " .. outputFile)
end
