require("scripts/globals/mixins")
require("scripts/globals/status")
require("scripts/globals/dynamis")
require("scripts/globals/utils")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.empty = function(mob)

    mob:addListener("DEATH", "DYNAMIS_ITEM_DISTRIBUTION", function(mob, killer)
        local element = mob:getLocalVar("element")
        local dropRate = 0

        -- printf("Drop Rate: %s", dropRate)
        if element == 8  then
		if math.random(1,10000) <= mob:getDropRate(240) then 
            killer:addTreasure(1613, mob) -- Malevolent Memory (darkness)
		end
        elseif element == 6 then
			if math.random(1,10000) <= mob:getDropRate(240) then 
				killer:addTreasure(1611, mob) -- Somber Memory (water)
			end
            if math.random(1,10000) <= mob:getDropRate(240) then
                killer:addTreasure(1613) -- Malevolent Memory (darkness)
            end
        elseif element == 5 then
			if math.random(1,10000) <= mob:getDropRate(240) then 
				killer:addTreasure(1610, mob) -- Startling Memory (lightning)
			end
            if math.random(1,10000) <= mob:getDropRate(240) then 
                killer:addTreasure(1612, mob) -- Radiant Memory (light)
            end
        elseif element == 4  then
			if math.random(1,10000) <= mob:getDropRate(240) then 
				killer:addTreasure(1609, mob) -- Profane Memory (earth)
			end
			if math.random(1,10000) <= mob:getDropRate(240) then 
				killer:addTreasure(1613, mob) -- Malevolent Memory (darkness)
			end
        elseif element == 7 then
			if math.random(1,10000) <= mob:getDropRate(240) then 
				killer:addTreasure(1612, mob) -- Radiant Memory (light)
			end
        elseif element == 1  then
			if math.random(1,10000) <= mob:getDropRate(240) then 
				killer:addTreasure(1606, mob) -- Burning Memory (fire)
			end
			if math.random(1,10000) <= mob:getDropRate(240) then 
				killer:addTreasure(1612, mob) -- Radiant Memory (light)
			end
        elseif element == 2 then
			if math.random(1,10000) <= mob:getDropRate(240) then 
				killer:addTreasure(1607, mob) -- Bitter Memory (ice)
			end
			if math.random(1,10000) <= mob:getDropRate(240) then 
				killer:addTreasure(1613, mob) -- Malevolent Memory (darkness)
			end
        elseif element == 3 then
			if math.random(1,10000) <= mob:getDropRate(240) then 
				killer:addTreasure(1608, mob) -- Fleeting Memory (wind)
			end
			if math.random(1,10000) <= mob:getDropRate(240) then 
				killer:addTreasure(1612, mob) -- Radiant Memory (light)
			end
        end
        if math.random(1,10000) <= mob:getDropRate(150) then
            killer:addTreasure(math.random(1687, 1689), mob) -- Recolection of x(Anima items)
        end
    end)
end

return g_mixins.families.empty
