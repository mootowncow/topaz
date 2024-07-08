-----------------------------------
-- Area: The Ashu Talif
--  Mob: Windjammer Imp
-- Instance: Targeting the Captain
-----------------------------------
function onMobSpawn(mob)
	mob:setDamage(140)
    mob:addMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.DEFP, 25) 
    mob:addMod(tpz.mod.ACC, 25) 
    mob:addMod(tpz.mod.EVA, 25)
    mob:setMod(tpz.mod.REGAIN, 25)
    mob:setMod(tpz.mod.MDEF, 13)
    mob:setMod(tpz.mod.UDMGMAGIC, -13)
end