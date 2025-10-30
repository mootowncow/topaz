-- Gold Scorpion(WotG) family mixin

require("scripts/globals/mixins")
require("scripts/globals/world")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.scorpion_gold = function(mob)

    mob:addListener("ROAM_TICK", "SCORPION_GOLD_ROAM", function(mob)
        if (mob:getWeather() == tpz.weather.DUST_STORM or mob:getWeather() == tpz.weather.SAND_STORM) then
			mob:setMod(tpz.mod.REGAIN, 100) -- Retail tested
		else
			mob:setMod(tpz.mod.REGAIN, 0)
		end
	end)

    mob:addListener("COMBAT_TICK", "SCORPION_GOLD_COMBAT", function(mob)
        if (mob:getWeather() == tpz.weather.DUST_STORM or mob:getWeather() == tpz.weather.SAND_STORM) then
			mob:setMod(tpz.mod.REGAIN, 100) -- Retail tested
		else
			mob:setMod(tpz.mod.REGAIN, 0)
		end
	end)
end

return g_mixins.families.scorpion_gold
