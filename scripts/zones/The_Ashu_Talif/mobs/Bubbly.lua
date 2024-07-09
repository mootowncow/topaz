-----------------------------------
-- Area: The Ashu Talif
--  Mob: Bubbly
-- Instance: Targeting the Captain
-----------------------------------
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
mixins = {require("scripts/mixins/targeting_the_captain")}
require("scripts/globals/mobs")
require("scripts/globals/pathfind")
-----------------------------------
local pathNodes = {
    { x=9.75, y=-27.25, z=-68.69 },
    { x=-9.58, y=-27.25, z=-69.31 },
};

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

function onMobEngaged(mob, target)
    local instance = mob:getInstance()
    if not GetMobByID(ID.mob[57].CUTTHROAT_KABSALAH, instance):isEngaged() then
        instance:setLocalVar("detected", 1)
    end
end

function onMobRoam(mob)
     tpz.path.loop(mob, pathNodes, tpz.path.flag.RUN)
end

function onMobDeath(mob, player, isKiller, noKiller)
    local instance = mob:getInstance()
    instance:setLocalVar("bubbly_Defeated", 1)
end