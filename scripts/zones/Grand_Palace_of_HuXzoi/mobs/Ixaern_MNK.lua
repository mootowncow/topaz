-----------------------------------
-- Area: Grand Palace of HuXzoi
--  Mob: Ix'aern MNK
-----------------------------------
local ID = require("scripts/zones/Grand_Palace_of_HuXzoi/IDs")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    -- adjust drops based on number of HQ Aern Organs traded to QM
    local qm = GetNPCByID(ID.npc.IXAERN_MNK_QM)
    local chance = qm:getLocalVar("[SEA]IxAern_DropRate")
    SetDropRate(2845, 1851, chance * 10) -- Deed Of Placidity
    qm:setLocalVar("[SEA]IxAern_DropRate", 0)
	
	mob:setDamage(70)
    mob:setDelay(8000)
    mob:addMod(tpz.mod.DEFP, 15) 
    mob:addMod(tpz.mod.ATTP, 15)
    mob:setMod(tpz.mod.REFRESH, 50)
	mob:AnimationSub(1) -- Reset the subanim - otherwise it will respawn with bracers on. Note that Aerns are never actually supposed to be in subanim 0.
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 120)
end

function onMobFight(mob, target)
    -- The mob gains a huge boost when it 2hours to attack speed and attack.
    -- It forces the minions to 2hour as well. Wiki says 50% but all videos show 60%.
    if (mob:getLocalVar("BracerMode") == 0) then
        if (mob:getHPP() < 50) then
            -- Go into bracer mode
            mob:setLocalVar("BracerMode", 1)
            mob:AnimationSub(2)
			mob:setDelay(4000)
			mob:addMod(tpz.mod.ATTP, 30)
            mob:addMod(tpz.mod.ACC, 40)
			mob:addMod(tpz.mod.MATT, 48)
            mob:useMobAbility(690) -- Hundred Fists
		
			-- Force minions to 2hour
            for i = 1, 2 do
                local minion = GetMobByID(mob:getID() + i)
                if (minion:getCurrentAction() ~= tpz.act.NONE) then
                    minion:useMobAbility(3411 + i) -- Chainspell or Benediction
                end
            end
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    DespawnMob(mob:getID()+1)
    DespawnMob(mob:getID()+2)
end

function onMobDespawn(mob)
    DespawnMob(mob:getID()+1)
    DespawnMob(mob:getID()+2)

    local qm = GetNPCByID(ID.npc.IXAERN_MNK_QM)
    if (math.random(0, 1) == 1) then
        qm:setPos(380, 0, 540, 0) -- G-7
    else
        qm:setPos(460, 0, 540, 0) -- I-7
    end
    qm:updateNPCHideTime(FORCE_SPAWN_QM_RESET_TIME)
end
