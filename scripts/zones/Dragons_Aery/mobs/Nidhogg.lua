-----------------------------------
-- Area: Dragons Aery
--  HNM: Nidhogg
-----------------------------------
local ID = require("scripts/zones/Dragons_Aery/IDs")
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

function onMobSpawn(mob)
    mob:addMod(tpz.mod.ATTP, 17)
    mob:addMod(tpz.mod.EVA, 4)
    mob:addMod(tpz.mod.ACC, 25)
	mob:setDamage(140)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 20000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 20000) 
    mob:setMobMod(tpz.mobMod.GIL_BONUS, 0)
	mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
    if LandKingSystem_NQ > 0 or LandKingSystem_HQ > 0 then
        GetNPCByID(ID.npc.FAFNIR_QM):setStatus(tpz.status.DISAPPEAR)
    end
    mob:AnimationSub(0)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
end

function onMobFight(mob, target)
    local battletime = mob:getBattleTime()
    local twohourTime = mob:getLocalVar("twohourTime")
    local wingsTime = mob:getLocalVar("wingsTime")
    local wingsDown = mob:getLocalVar("wingsDown")

    if twohourTime == 0 then
        mob:setLocalVar("twohourTime", math.random(30, 90))
    elseif battletime >= twohourTime and wingsDown == 0 then
        mob:addMod(tpz.mod.ATT, 400)
        mob:addMod(tpz.mod.EVA, 378)
        mob:addMod(tpz.mod.MATT, 25)
        mob:setMod(tpz.mod.UDMGPHYS, -50)
        mob:setMod(tpz.mod.UDMGMAGIC, -5)
        mob:SetMobAbilityEnabled(false)
        mob:AnimationSub(2)
        mob:useMobAbility(1053) -- Legitimately captured super_buff ID
        mob:setLocalVar("wingsTime", battletime + math.random(20, 30))
        mob:setLocalVar("wingsDown", 1)
    end

    if battletime >= wingsTime and wingsDown == 1 then
        mob:addMod(tpz.mod.ATT, -400)
        mob:addMod(tpz.mod.EVA, -378)
        mob:addMod(tpz.mod.MATT, -25)
        mob:setMod(tpz.mod.UDMGPHYS, 0)
        mob:setMod(tpz.mod.UDMGMAGIC, 0)
        mob:SetMobAbilityEnabled(true)
        mob:AnimationSub(0)
        mob:setLocalVar("twohourTime", battletime + math.random(60, 120))
        mob:setLocalVar("wingsTime", 0)
        mob:setLocalVar("wingsDown", 0)
    end
end

function onMobDisengage(mob)
    mob:AnimationSub(0)
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addTitle(tpz.title.NIDHOGG_SLAYER)
end

function onMobDespawn(mob)
    -- Set Nidhogg's Window Open Time
    if LandKingSystem_HQ ~= 1 then
        local wait = 72 * 3600
        SetServerVariable("[POP]Nidhogg", os.time() + wait) -- 3 days
        if LandKingSystem_HQ == 0 then -- Is time spawn only
            DisallowRespawn(mob:getID(), true)
        end
    end

    -- Set Fafnir's spawnpoint and respawn time (21-24 hours)
    if LandKingSystem_NQ ~= 1 then
        SetServerVariable("[PH]Nidhogg", 0)
        DisallowRespawn(ID.mob.FAFNIR, false)
        UpdateNMSpawnPoint(ID.mob.FAFNIR)
        GetMobByID(ID.mob.FAFNIR):setRespawnTime(36000 + math.random(0, 6) * 1800) -- 21 - 24 hours with half hour windows
    end
end
