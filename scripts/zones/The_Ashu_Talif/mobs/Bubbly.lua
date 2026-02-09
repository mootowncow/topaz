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
    { x=-9.58, y=-27.25, z=-69.31 },
    { x=-4.00, y=-27.25, z=-68.89 },
    { x=-1.23, y=-27.25, z=-66.43 },
    { x=3.48, y=-27.25, z=-68.77 },
    { x=9.75, y=-27.25, z=-68.69 },
};

function onMobSpawn(mob)
	mob:setDamage(125)
    mob:addMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.DEFP, 25) 
    mob:addMod(tpz.mod.ACC, 25) 
    mob:addMod(tpz.mod.EVA, 25)
    mob:setMod(tpz.mod.REGAIN, 25)
    mob:setMod(tpz.mod.MDEF, 13)
    mob:setMod(tpz.mod.UDMGMAGIC, -13)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobEngaged(mob, target)
    local instance = mob:getInstance()
    if not GetMobByID(ID.mob[57].CUTTHROAT_KABSALAH, instance):isEngaged() then
        instance:setLocalVar("detected", 1)
    end
end

function onMobFight(mob, target)
    if tpz.path.CheckIfStuck(mob) then
        if mob:checkDistance(target) > 15 then
            local pos = target:getPos()
            mob:setPos(pos.x, pos.y, pos.z)
        end
    end
end

function onMobRoam(mob)
    tpz.path.loop(mob, pathNodes, tpz.path.flag.RUN)
end

function onMobDeath(mob, player, isKiller, noKiller)
    local instance = mob:getInstance()
    instance:setLocalVar("bubbly_Defeated", 1)
end