-----------------------------------
-- Area: Ilrusi Atoll (Golden Salvage)
--  Mob: Evolved Orobon
-- RNG
-----------------------------------
mixins = 
{
    require("scripts/mixins/families/orobon"),
    require("scripts/mixins/job_special")
}
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
-----------------------------------
function onMobSpawn(mob)
    mob:setMod(tpz.mod.MDEF, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setMod(tpz.mod.HTHRES, 500)
    mob:setMod(tpz.mod.SLASHRES, 500)
    mob:setMod(tpz.mod.PIERCERES, 500)
    mob:setMod(tpz.mod.RANGEDRES, 500)
    mob:setMod(tpz.mod.IMPACTRES, 500)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:AnimationSub(0)
	mob:setLocalVar("Message", 0)
    mob:setLocalVar("FeelersBreakChance", 5)
end

function onMobRoam(mob)
    local Turn = mob:getLocalVar("Turn")
    local Time = os.time()
    if mob:getID(instance) == 17002772 then
        if Time > Turn then
            mob:setPos(558.6038,-15.6880,139.2372, math.random(90, 160))
            mob:setLocalVar("Turn", Time + 5)
        end
    end
    if mob:getTP() > 1000 then
        mob:setTP(1000)
    end
    if mob:getID(instance) == 17002772 then
        --mob:setPos(558.6038,-15.6880,139.2372,160)
    end
end

function onMobEngaged(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobFight(mob, target)
	local Message = mob:getLocalVar("Message")
	local MessageTwo = mob:getLocalVar("MessageTwo")
	local FrenzyTime = mob:getLocalVar("FrenzyTime")
	local BattleTime = mob:getBattleTime()
    if mob:AnimationSub() == 1 then
        mob:setMod(tpz.mod.REGAIN, 150)
		mob:setMod(tpz.mod.HASTE_MAGIC, 5000)
        if Message == 0 then
            local zonePlayers = mob:getZone():getPlayers()
            for _, zonePlayer in pairs(zonePlayers) do
                zonePlayer:PrintToPlayer("The Evolved Orobon goes into a frenzy!",0,"Evolved Orobon")
            end
		    mob:setLocalVar("Message", 1)
		    mob:setLocalVar("MessageTwo", 0)
            mob:setLocalVar("FrenzyTime", BattleTime + 90)
        end
    end
    if BattleTime >= FrenzyTime and Message == 1 then
        if MessageTwo == 0 then
            local zonePlayers = mob:getZone():getPlayers()
            for _, zonePlayer in pairs(zonePlayers) do
                zonePlayer:PrintToPlayer("The Evolved Orobons seems to have calmed down.",0,"Evolved Orobon")
            end
		    mob:setLocalVar("MessageTwo", 1)
        end
        mob:setMod(tpz.mod.REGAIN, 50)
		mob:setMod(tpz.mod.HASTE_MAGIC, 0)
        mob:AnimationSub(0)
		mob:setLocalVar("Message", 0)
    end
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobDeath(mob, player, isKiller, noKiller)
end