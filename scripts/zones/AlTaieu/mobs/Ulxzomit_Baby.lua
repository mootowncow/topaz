-----------------------------------
-- Area: Al'Taieu
--   NM: Ulxzomit Baby
-- Note: Follows around mother Ulxzomits
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/pathfind")
-----------------------------------
function onMobSpawn(mob)
    mob:addMod(tpz.mod.MOVE_SPEED_STACKABLE, 45)
    onPath(mob)
end

function onPath(mob)
    local MotherOne = GetMobByID(16912394)
    local MotherTwo = GetMobByID(16912409)
    local MotherThree = GetMobByID(16912422)
    local MotherFour = GetMobByID(16912426)
    local MotherFive = GetMobByID(16912443)
    local MotherSix = GetMobByID(16912449)
    local MotherSeven = GetMobByID(16912455)
    local MotherEight = GetMobByID(16912468)
    local MotherNine = GetMobByID(16912545)
	local mobId = mob:getID()
	switch (mobId): caseof {
		[16912395] = function() mob:pathTo(MotherOne:getXPos(), MotherOne:getYPos(), MotherOne:getZPos()) end,
		[16912396] = function() mob:pathTo(MotherOne:getXPos(), MotherOne:getYPos(), MotherOne:getZPos()) end,
		
		[16912410] = function() mob:pathTo(MotherTwo:getXPos(), MotherTwo:getYPos(), MotherTwo:getZPos()) end,
		[16912411] = function() mob:pathTo(MotherTwo:getXPos(), MotherTwo:getYPos(), MotherTwo:getZPos()) end,
		
		[16912423] = function() mob:pathTo(MotherThree:getXPos(), MotherThree:getYPos(), MotherThree:getZPos()) end,
		[16912424] = function() mob:pathTo(MotherThree:getXPos(), MotherThree:getYPos(), MotherThree:getZPos()) end,

		[16912427] = function() mob:pathTo(MotherFour:getXPos(), MotherFour:getYPos(), MotherFour:getZPos()) end,
		[16912428] = function() mob:pathTo(MotherFour:getXPos(), MotherFour:getYPos(), MotherFour:getZPos()) end,

		[16912444] = function() mob:pathTo(MotherFive:getXPos(), MotherFive:getYPos(), MotherFive:getZPos()) end,
		[16912445] = function() mob:pathTo(MotherFive:getXPos(), MotherFive:getYPos(), MotherFive:getZPos()) end,
		
		[16912450] = function() mob:pathTo(MotherSix:getXPos(), MotherSix:getYPos(), MotherSix:getZPos()) end,
		[16912451] = function() mob:pathTo(MotherSix:getXPos(), MotherSix:getYPos(), MotherSix:getZPos()) end,
		
		[16912456] = function() mob:pathTo(MotherSeven:getXPos(), MotherSeven:getYPos(), MotherSeven:getZPos()) end,
		[16912457] = function() mob:pathTo(MotherSeven:getXPos(), MotherSeven:getYPos(), MotherSeven:getZPos()) end,
		
		[16912469] = function() mob:pathTo(MotherEight:getXPos(), MotherEight:getYPos(), MotherEight:getZPos()) end,
		[16912470] = function() mob:pathTo(MotherEight:getXPos(), MotherEight:getYPos(), MotherEight:getZPos()) end,

		[16912546] = function() mob:pathTo(MotherSeven:getXPos(), MotherSeven:getYPos(), MotherSeven:getZPos()) end,
		[16912547] = function() mob:pathTo(MotherSeven:getXPos(), MotherSeven:getYPos(), MotherSeven:getZPos()) end,
	}
end


function onMobDeath(mob, player, isKiller, noKiller)
end

