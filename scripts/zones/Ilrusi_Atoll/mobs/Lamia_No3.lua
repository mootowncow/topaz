-----------------------------------
-- Area: Ilrusi Atoll (Golden Salvage)
--  Mob: Lamia_No3
-- 
-----------------------------------
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
function onMobSpawn(mob)
	mob:setDamage(120)
    mob:setMod(tpz.mod.MDEF, 0)
    mob:setMod(tpz.mod.UDMGPHYS, -50)
    mob:setMod(tpz.mod.UDMGRANGE, -50)
    mob:setMod(tpz.mod.UDMGMAGIC, -50)
    mob:setMod(tpz.mod.UDMGBREATH, -50)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 30)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 20)
    mob:setMod(tpz.mod.QUAD_ATTACK, 10)
    mob:setMod(tpz.mod.HTHRES, 500)
    mob:setMod(tpz.mod.SLASHRES, 500)
    mob:setMod(tpz.mod.PIERCERES, 500)
    mob:setMod(tpz.mod.RANGEDRES, 500)
    mob:setMod(tpz.mod.IMPACTRES, 500)
	mob:setMod(tpz.mod.HASTE_MAGIC, 5000)
    mob:setMod(tpz.mod.STORETP, 50)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
	mob:setLocalVar("Message", 0)
	mob:setLocalVar("DT", 0)
	mob:setLocalVar("Haste", 0)

    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.MEIKYO_SHISUI, hpp = 75},
            {id = tpz.jsa.MEIKYO_SHISUI, hpp = 50},
            {id = tpz.jsa.MEIKYO_SHISUI, hpp = 25},
        },
    })
end

function onMobRoam(mob)
	mob:setLocalVar("Message", 0)
    if mob:getTP() > 1000 then
        mob:setTP(1000)
    end
    --mob:setPos(435.7197,-7.0001,-123.3230,95)
end

function onMobEngaged(mob)
	local Message = mob:getLocalVar("Message")
	local DT = mob:getLocalVar("DT")
	local Haste = mob:getLocalVar("Haste")
        if Message == 0 then
            local zonePlayers = mob:getZone():getPlayers()
            for _, zonePlayer in pairs(zonePlayers) do
                if DT == 0 then
                    zonePlayer:PrintToPlayer("The Lamia No.3 scales shine.",0,"Lamia No.3")
                end
                if Haste == 0 then
                    zonePlayer:PrintToPlayer("The Lamia No.3 moves rapidly.",0,"Lamia No.3")
                end
            end
		    mob:setLocalVar("Message", 1)
        end
    if DT == 1 then
        mob:setMod(tpz.mod.UDMGPHYS, 0)
        mob:setMod(tpz.mod.UDMGRANGE, 0)
        mob:setMod(tpz.mod.UDMGMAGIC, 0)
        mob:setMod(tpz.mod.UDMGBREATH, 0)
    end
    if Haste == 1 then
	    mob:setMod(tpz.mod.HASTE_MAGIC, 0)
    end
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobFight(mob, target)
	local StunTime = mob:getLocalVar("StunTime")
	local DreadSpikesTime = mob:getLocalVar("DreadSpikesTime")
	local DrainTime = mob:getLocalVar("DrainTime")
	local BattleTime = mob:getBattleTime()
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end

function onMobDespawn(mob)
end
