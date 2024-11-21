addon.name      = 'TrustProgression';
addon.author    = 'Shiyo';
addon.version   = '1.0.0.0';
addon.desc      = 'Prints out mob animation IDs to a log file.';
addon.link      = 'https://ashitaxi.com/';
-- TODO: Close on X / A Button
-- print(string.format('Button:%u state:%u', e.button, e.state));
require('common');
require ('shiyolibs')
require('logmanager');
gLogManager:SetDirectory('AnimationIDs');
local chat = require('chat');
local imgui = require('imgui');       -- v4's gui lib
local settings = require('settings')
local statusEffect = require('statuseffect')
local job = require('job')

-------------------------------------------------------------------------------
-- Globals
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- States
-------------------------------------------------------------------------------
local shouldCloseWindow = false
-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------
---
-------------------------------------------------------------------------------
-- local state
-------------------------------------------------------------------------------
local default_settings = T{
    --[[ this table contains all of your settings with their default values.
    --   it is used to create initial settings and to update existing ones
    --   in case you ever add more values in here
    --   SETTINGS WILL NOT BE SAVED IF NOT PUT IN HERE!
    --]]
    fancy_flags = T{
      distancesSlider = 16, 
      EnemyMinHP = 1, 
      EnemyMaxHP = 100,

      assist_index = T{ 1 },
      assist_active = 'Shiyo',

      ws_index = T{ 1 },
      ws_active = 'AutoWS',

      ws_name_index = T{ 1 },
      ws_name_active = 'Evisceration',

      food_index = T{ 1 },
      food_active = 'Meat Mithkabob',

      followToggle = false,
      SetCamp = false, -- Probably unneeded?
      AutoFood = false,
      SASpam = false,
      CollabSpam = false,
      wsEnabled = false,
      Utusemi = false,
      perfectDodge = false,
    },
  };
  
  local st = T {
    --[[ the next line will load your saved settings and populate anything 
    --   that's missing from `default_settings`.
    --]]
    settings = settings.load(default_settings),
    -- just a state variable so we can open an close the UI
    -- tables need to go here or they wont be updated!
    ui = T{
        is_open = T{ false, }, -- this has to be in a table to work with imGUI
        assist_target = T{'Shiyo', 'Miyu', 'Kitori', 'Kozumi', 'Sayaki', 'Yukiko' },
        ws_type = T{'AutoWS', 'SoloWS', 'OpenForMiyu', 'OpenForShiyo', 'ClosingSCEnabled', 'StunWS'},
        ws_name = T{'Evisceration', 'Shark Bite', 'Mandalic Stab', 'Dancing Edge', 'Viper Bite', 'Mercy Stroke', 'Exenterator', 'Rudra\'s storm', 'Cyclone', 'Aeolian Edge', 'Fast Blade'},
        food = 
        T{
          'Meat Mithkabob', 'Meat Chiefkabob', 'Crab Sushi', 'Squid Sushi', 'Sole Sushi', 'Ylw. Curry Bun', 'Marinara Slice', 'Marinara Slice +1', 'Marinara Pizza', 'Marinara Pizza +1', 'Eel Kabob', 
          'Broiled Eel', 'Sausage', 'Meat Jerky', 'Dhalmel Steak', 'Wild Steak'
        },
        movementMode = 'Follow'
    }
  };

  st.ui.showDetails = st.ui.showDetails or {}

  local toggle_settings = function()
    st.ui.is_open[1] = true;
  end

  local render_settings_ui = function()
    if (not st.ui.is_open[1]) then
        -- don't do anything if is_open is false
        return;
    end

    local header_color = { 1.0, 0.75, 0.55, 1.0 };
    local settingsChanged = false

    imgui.SetNextWindowContentSize({ 250, 250 }); -- controls the size of the window

    if (imgui.Begin(('Trust Progress'):fmt(addon.version), st.ui.is_open)) then
        imgui.BeginGroup()
        
        local trustProgressionData = GetTrustProgressionData()
        local levelBonuses = {
            ['Melee'] = {
                ['Lvl1'] = { Mod = 'Attack',           Power = 10 },
                ['Lvl2'] = { Mod = 'Accuracy',         Power = 5 },
                ['Lvl3'] = { Mod = 'Store TP',         Power = 3 },
                ['Lvl4'] = { Mod = 'STR (During WS)',  Power = 6 },
                ['Lvl5'] = { Mod = 'Gear Haste',       Power = 5 },
            },
            ['Ranged'] = {
                ['Lvl1'] = { Mod = 'Ranged Attack',    Power = 10 },
                ['Lvl2'] = { Mod = 'Ranged Accuracy',  Power = 5 },
                ['Lvl3'] = { Mod = 'Store TP',         Power = 3 },
                ['Lvl4'] = { Mod = 'STR (During WS)',  Power = 6 },
                ['Lvl5'] = { Mod = 'Snapshot',         Power = 5 },
            },
            ['Tank'] = {
                ['Lvl1'] = { Mod = 'HP',               Power = 25 },
                ['Lvl2'] = { Mod = 'VIT',              Power = 15 },
                ['Lvl3'] = { Mod = 'Enemy Crit Rate',  Power = -1 },
                ['Lvl4'] = { Mod = 'Enmity',           Power = 5 },
                ['Lvl5'] = { Mod = 'Damage Taken',     Power = -2 },
            },
            ['Caster'] = {
                ['Lvl1'] = { Mod = 'INT',              Power = 2 },
                ['Lvl2'] = { Mod = 'Fast Cast',        Power = 2 },
                ['Lvl3'] = { Mod = 'Magic Atk. Bonus', Power = 4 },
                ['Lvl4'] = { Mod = 'Conserve MP',      Power = 5 },
                ['Lvl5'] = { Mod = 'Magic Accuracy',   Power = 5 },
            },
            ['Healer'] = {
                ['Lvl1'] = { Mod = 'MP',               Power = 35 },
                ['Lvl2'] = { Mod = 'Enmity',           Power = -3 },
                ['Lvl3'] = { Mod = 'Fast Cast',        Power = 4 },
                ['Lvl4'] = { Mod = 'Cure Potency',     Power = 4 },
                ['Lvl5'] = { Mod = 'Refresh',          Power = 1 },
            },
            ['Support'] = {
                ['Lvl1'] = { Mod = 'Singing',           Power = 5  },
                ['Lvl2'] = { Mod = 'Accuracy',          Power = 10 },
                ['Lvl3'] = { Mod = 'Regain',            Power = 5  },
                ['Lvl4'] = { Mod = 'Geomancy',          Power = 5  },
                ['Lvl5'] = { Mod = 'Song Cast Reduction', Power = 5  },
            },
        }
      
        local requiredMaterials = {
            ['Melee'] = {
                { name = "Brass Ingot", contribution = 1 },
                { name = "Iron Ingot", contribution = 2 },
                { name = "Steel Ingot", contribution = 2 },
                { name = "Mythril Ingot", contribution = 3 },
                { name = "Darksteel Ingot", contribution = 3 },
                { name = "Adaman Ingot", contribution = 4 }
            },
            ['Ranged'] = {
                { name = "Beech Lumber", contribution = 1 },
                { name = "Chestnut Lumber", contribution = 2 },
                { name = "Holly Lumber", contribution = 2 },
                { name = "Oak Lumber", contribution = 3 },
                { name = "Mahogany Lumber", contribution = 3 },
                { name = "Rosewood Lumber", contribution = 3 },
                { name = "Ebony Lumber", contribution = 3 },
                { name = "Ancient Lumber", contribution = 4 },
                { name = "Rattan Lumber", contribution = 4 }
            },
            ['Tank'] = {
                { name = "Dhalmel Leather", contribution = 1 },
                { name = "Ram Leather", contribution = 2 },
                { name = "Black Tiger Leather", contribution = 2 },
                { name = "Smilodon Leather", contribution = 2 },
                { name = "Karakul Leather", contribution = 2 },
                { name = "Manta Leather", contribution = 2 },
                { name = "Coeurl Leather", contribution = 3 },
                { name = "Lynx Leather", contribution = 3 },
                { name = "Manticore Leather", contribution = 4 },
                { name = "Ruszor Leather", contribution = 5 }
            },
            ['Caster'] = {
                { name = "Linen Cloth", contribution = 1 },
                { name = "Wool Cloth", contribution = 2 },
                { name = "Velvet Cloth", contribution = 2 },
                { name = "Silk Cloth", contribution = 3 },
                { name = "Gold Thread", contribution = 3 },
                { name = "Rainbow Cloth", contribution = 4 },
            },
            ['Healer'] = {
                { name = "Poison Potion", contribution = 1 },
                { name = "Sleeping Potion", contribution = 1 },
                { name = "Silencing Potion", contribution = 1 },
                { name = "Blinding Potion", contribution = 1 },
                { name = "Vitriol", contribution = 1 },
                { name = "Firesand", contribution = 2 },
                { name = "Venom Potion", contribution = 3 },
                { name = "Paralyze Potion", contribution = 4 },
            },
            ['Support'] = {
                { name = "Shell Powder", contribution = 1 },
                { name = "Armored Arrowheads", contribution = 1 },
                { name = "Carapace Powder", contribution = 2 },
                { name = "Demon Arrowheads", contribution = 2 },
                { name = "Marid Tusk Arrowheads", contribution = 2 },
                { name = "Gargouille Arrowheads", contribution = 3 }
            }
        }
        
        local roles = { "melee", "ranged", "tank", "caster", "healer", "support" }
        -- Color mapping for different roles
        local roleColors = {
            ['melee'] = { 1.0, 0.0, 0.0, 1.0 },    -- Red for Melee
            ['ranged'] = { 0.0, 1.0, 0.0, 1.0 },   -- Green for Ranged
            ['tank'] = { 0.6, 0.3, 0.1, 1.0 },     -- Brown for Tank
            ['caster'] = { 0.6, 0.2, 1.0, 1.0 },   -- Purple for Caster
            ['healer'] = { 1.0, 0.75, 1.0, 1.0 },  -- Pink for Healer
            ['support'] = { 1.0, 1.0, 0.0, 1.0 },  -- Yellow for Support
        }
        
        for _, role in ipairs(roles) do
            local roleFormatted = role:gsub("^%l", string.upper)
            local rawProgress = trustProgressionData[role] or 0
            
            local level = math.floor(rawProgress / 100)
            local currentProgress = rawProgress % 100
            local normalizedProgress = currentProgress / 100

            if (level >= 25) then
                level = 25
                normalizedProgress = 100
            end
            
            -- Set color for the role name
            imgui.PushStyleColor(ImGuiCol_Text, roleColors[role])  -- Set the color based on role
        
            -- Display the role with the formatted name
            imgui.Text(string.format("%s (Level %d):", roleFormatted, level))
            
            -- Reset color after the role name
            imgui.PopStyleColor()
        
            -- Set color for the progress bar based on the progress percentage
            local progressColor = { 1.0, 0.0, 0.0, 1.0 }  -- Default to Red
            if normalizedProgress > 0.5 then
                progressColor = { 0.0, 1.0, 0.0, 1.0 }  -- Green if progress > 50%
            elseif normalizedProgress > 0.25 then
                progressColor = { 1.0, 1.0, 0.0, 1.0 }  -- Yellow if progress > 25%
            end
        
            -- Apply the color to the progress bar
            imgui.PushStyleColor(ImGuiCol_Text, progressColor)
            imgui.ProgressBar(normalizedProgress, -1, 0, string.format("%d", currentProgress))
            imgui.PopStyleColor()  -- Reset progress bar color

            -- Progress Bar hover tooltip
            if imgui.IsItemHovered() then
                -- Display the tooltip with required materials for the role
                imgui.BeginTooltip()
                -- Set the header color (Cyan)
                imgui.PushStyleColor(ImGuiCol_Text, { 0.0, 1.0, 1.0, 1.0 })
                imgui.Text("Required Materials")
                imgui.PopStyleColor()  -- Reset the color


                -- Header for the tooltip
                imgui.Text("Item")
                imgui.SameLine(150)  -- Adjust the position for "Contribution" text to align
                imgui.Text("Contribution")

                -- Loop through the list of materials and display each in the tooltip
                for _, material in ipairs(requiredMaterials[roleFormatted] or {}) do
                    -- Set color for item name (light blue)
                    imgui.PushStyleColor(ImGuiCol_Text, { 0.6, 0.8, 1.0, 1.0 })
                    imgui.Text(string.format("%s", material.name))
                    imgui.PopStyleColor()  -- Reset color for the item name

                    -- Adjust the position for the contribution value
                    imgui.SameLine(200)  -- Same line, but move the "Contribution" text to the right

                    -- Set color for contribution number (gold/yellow)
                    imgui.PushStyleColor(ImGuiCol_Text, { 1.0, 0.8, 0.2, 1.0 })
                    imgui.Text(string.format("%d%%", material.contribution))
                    imgui.PopStyleColor()  -- Reset color for the contribution number
                end

                imgui.EndTooltip()
            end


            -- Determine the next level
            local nextLevel = level + 1

            -- Check if the level is capped
            if nextLevel > 25 then
                imgui.PushStyleColor(ImGuiCol_Text, { 1.0, 0.84, 0.0, 1.0 })  -- Gold
                imgui.Text("LEVEL CAPPED!")
                imgui.PopStyleColor()
                imgui.NewLine()
            else
                -- Determine which bonus applies to the next level
                local nextBonusLevel = "Lvl" .. (nextLevel % 5 == 0 and 5 or nextLevel % 5)  -- Maps level to Lvl1, Lvl2, etc.
                local nextBonus = levelBonuses[roleFormatted][nextBonusLevel]

                -- Level up stat boosts text
                if nextBonus then
                    -- Set color for "Next Level gives:" text (Soft Blue)
                    imgui.PushStyleColor(ImGuiCol_Text, { 0.6, 0.8, 1.0, 1.0 })
                    imgui.Text(string.format("Next Level (%d):", nextLevel))
                    imgui.PopStyleColor()

                    -- Set color for bonus text (Green for positive bonuses)
                    imgui.SameLine()
                    imgui.PushStyleColor(ImGuiCol_Text, { 0.2, 1.0, 0.2, 1.0 })
                    imgui.Text(string.format("%s %+d", nextBonus.Mod, nextBonus.Power))
                    imgui.PopStyleColor()
                    
                    -- Display the "?" button to the far right
                    imgui.SameLine()
                    if imgui.Button("?##"..roleFormatted) then
                        -- Optional: Toggle code can be kept if needed for another purpose
                    end

                    -- Create an ordered list of level keys
                    local orderedLevels = { "Lvl1", "Lvl2", "Lvl3", "Lvl4", "Lvl5" }

                    -- Level up stat boosts ? tooltip
                    if imgui.IsItemHovered() then
                        imgui.BeginTooltip()
                        -- Set the header color (Cyan)
                        imgui.PushStyleColor(ImGuiCol_Text, { 0.0, 1.0, 1.0, 1.0 })
                        imgui.Text("Next Level Bonuses")
                        imgui.PopStyleColor()  -- Reset the color
                        imgui.Text("Bonuses repeat every 5 levels")
                        imgui.Text("For example, 'Lvl1' bonuses are applied at levels 1, 6, 11, 16, and 21.")
                        imgui.Text("Each bonus tier (Lvl1, Lvl2, Lvl3, Lvl4, Lvl5) repeats every 5 levels.")
                        imgui.NewLine()
                        
                        for _, levelKey in ipairs(orderedLevels) do
                            local bonus = levelBonuses[roleFormatted][levelKey]
                            if bonus then
                                -- Set color for the modifier (Light Blue or White)
                                imgui.PushStyleColor(ImGuiCol_Text, { 0.6, 0.8, 1.0, 1.0 })
                                imgui.Text(string.format("%s:", levelKey))  -- Display Modifier
                                imgui.PopStyleColor()
                                
                                -- Display Mod Name
                                imgui.SameLine()
                                imgui.Text(string.format("%s", bonus.Mod))

                                -- Set color for the power value (Green for positive)
                                imgui.SameLine()
                                imgui.PushStyleColor(ImGuiCol_Text, { 0.2, 1.0, 0.2, 1.0 })
                                imgui.Text(string.format("%+d", bonus.Power))
                                imgui.PopStyleColor()
                            end
                        end
                        imgui.EndTooltip()
                    end
                    imgui.NewLine()
                end
            end
        end
    
        imgui.EndGroup()
    end
    imgui.End()
    
    if settingsChanged then
      settings.save()
    end
end

ashita.events.register('key_data', 'key_data_callback1', function (e)
    --[[ Valid Arguments

        e.key        - (ReadOnly) The DirectInput key id.
        e.down       - (ReadOnly) The down state of the key.
        e.blocked    - Flag that states if the key has been, or should be, blocked.

    --]]

    -- Block Escape key presses.. (Blocks game input; initial press.)
    if (e.key == 1) then
        shouldCloseWindow = true;
    end
end);

ashita.events.register('xinput_button', 'xinput_button_callback1', function (e)
    --[[ Valid Arguments

        e.button    - The controller button id.
        e.state     - The controller button state value.
        e.blocked   - Flag that states if the button has been, or should be, blocked.
        e.injected  - (ReadOnly) Flag that states if the button was injected by Ashita or an addon/plugin.
    --]]
end);


ashita.events.register('d3d_present', 'present_cb', function ()
    if isZoning or shouldCloseWindow then
        st.ui.is_open[1] = false;
        openTrustProgressionUI = false;
        shouldCloseWindow = false;
    end

    if openTrustProgressionUI then
        toggle_settings();
        render_settings_ui();
        if not st.ui.is_open[1] then
            openTrustProgressionUI = false;
        end
    end
end)

ashita.events.register('unload', 'fancy_unload', function ()
    --this line is important, it saves your settings when the addon unloads
    settings.save();
end)