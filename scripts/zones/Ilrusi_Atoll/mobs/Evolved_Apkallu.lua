-----------------------------------
-- Area: Ilrusi Atoll (Golden Salvage)
--  Mob: Evolved_Apkallu
-- WAR/MNK
-----------------------------------
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
-----------------------------------
function onMobSpawn(mob)
    mob:setMod(tpz.mod.MDEF, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setMod(tpz.mod.COUNTER, 25)
    mob:setMod(tpz.mod.HTHRES, 500)
    mob:setMod(tpz.mod.SLASHRES, 500)
    mob:setMod(tpz.mod.PIERCERES, 500)
    mob:setMod(tpz.mod.RANGEDRES, 500)
    mob:setMod(tpz.mod.IMPACTRES, 500)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
end

function onMobRoam(mob)
    local Turn = mob:getLocalVar("Turn")
    local Time = os.time()
    if Time > Turn then
        mob:setPos(340.0535,-15.5933,-140.5788, math.random(-255, 255))
        mob:setLocalVar("Turn", Time + 10)
    end
    if mob:getTP() > 1000 then
        mob:setTP(1000)
    end
end

function onMobEngaged(mob)
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

function onMobWeaponSkill(target, mob, skill)
    local forcedYawn = mob:getLocalVar("forcedYawn")

    if (os.time() >= forcedYawn) then -- So that it won't spam Yawn after using a TP move that hits multiple targets
        for v = 1714,1717,1 do
            if skill:getID() == v then 
                mob:useMobAbility(1713) -- Yawn
                mob:setLocalVar("forcedYawn", os.time() + 5)
            end
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end