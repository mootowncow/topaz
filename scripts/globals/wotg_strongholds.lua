-----------------------------------
--
--  WotG Strongholds utilities
--
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/zone")
require("scripts/globals/items")
-----------------------------------

tpz = tpz or {}
tpz.wotg_strongholds = tpz.wotg_strongholds or {}

tpz.wotg_strongholds.TrashMods = function(mob)
end

tpz.wotg_strongholds.NMMods = function(mob)
	mob:setDamage(120)
    mob:addMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.DEFP, 25) 
    mob:addMod(tpz.mod.ACC, 25) 
    mob:addMod(tpz.mod.EVA, 25)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
end