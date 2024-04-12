--[[
Mobs that enter rage mode after a specified amount of time in combat. Controlled by following vars that can be set onMobSpawn:

localVar    default     description
--------    -------     -----------
rageTimer   1200        seconds into combat at which point the mob will rage.

https://ffxiclopedia.fandom.com/wiki/Rage
--]]

require("scripts/globals/mixins")
require("scripts/globals/status")

g_mixins = g_mixins or {}

local rageStats = {
    "STR","DEX","VIT","AGI","INT","MND","CHR",
    "ATT","DEF","EVA","MACC","MATT","MEVA","MDEF",
}

local baseIncrease = 10
local statIncrease = 10
local hasteIncrease = 50
local dmgIncrease = 5

g_mixins.rage = function(mob)

    mob:addListener("SPAWN", "RAGE_SPAWN", function(mob)
        -- If no rage timer is set, default to 20m
        if (mob:getLocalVar("[rage]timer") == nil) or (mob:getLocalVar("[rage]timer") == 0) then
            mob:setLocalVar("[rage]timer", 1200) -- 20 minutes
        end
    end)

    mob:addListener("ENGAGE", "RAGE_ENGAGE", function(mob)
        mob:setLocalVar("[rage]at", os.time() + mob:getLocalVar("[rage]timer"))
    end)

    mob:addListener("COMBAT_TICK", "RAGE_CTICK", function(mob)
        if os.time() > mob:getLocalVar("[rage]at") then
            -- Save default values
            if mob:getLocalVar("[rage]started") == 0 then
                mob:setLocalVar("[rage]started", 1)

                for i = 1,#rageStats do
                    mob:setLocalVar("[rage]mod_" .. rageStats[i], mob:getMod(tpz.mod[rageStats[i]]))
                end

                mob:setLocalVar("[rage]mod_haste", mob:getMod(tpz.mod.HASTE_MAGIC))
                mob:setLocalVar("[rage]mod_dmg", mob:getMod(tpz.mod.MAIN_DMG_RATING))

            -- Apply rage and increase every 30 seconds (Up to 30 times)
            elseif os.time() > mob:getLocalVar("[rage]tick") and mob:getLocalVar("[rage]counter") < 30 then
                mob:setLocalVar("[rage]tick", os.time() + 30)
                mob:setLocalVar("[rage]counter", mob:getLocalVar("[rage]counter") + 1)

                for i = 1,#rageStats do
                    if i < 8 then mob:setMod(tpz.mod[rageStats[i]], mob:getMod(tpz.mod[rageStats[i]]) + baseIncrease)
                    else mob:setMod(tpz.mod[rageStats[i]], mob:getMod(tpz.mod[rageStats[i]]) + statIncrease) end
                end

                mob:setMod(tpz.mod.HASTE_MAGIC, mob:getMod(tpz.mod.HASTE_MAGIC) + hasteIncrease)
                mob:setMod(tpz.mod.MAIN_DMG_RATING, mob:getMod(tpz.mod.MAIN_DMG_RATING) + dmgIncrease)
            end
        end
    end)

    -- Todo: should happen when mob begins to regen while unclaimed. If 1st healing tick hasn't happened, retail mob is stil raged.
    mob:addListener("DISENGAGE", "RAGE_DISENGAGE", function(mob)
        if mob:getLocalVar("[rage]started") == 1 then
            mob:setLocalVar("[rage]started", 0)
            mob:setLocalVar("[rage]tick", 0)
            mob:setLocalVar("[rage]counter", 0)

            -- Debug only
            local mobName = mob:getName()

            -- Revert mods to default values
            for i = 1,#rageStats do
                local var = "[rage]mod_" .. rageStats[i]
                mob:setMod(tpz.mod[rageStats[i]], mob:getLocalVar(var))
            end

            mob:setMod(tpz.mod.HASTE_MAGIC, mob:getLocalVar("[rage]mod_haste"))
            mob:setMod(tpz.mod.MAIN_DMG_RATING, mob:getLocalVar("[rage]mod_dmg"))
        end
    end)

end

return g_mixins.rage