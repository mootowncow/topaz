-----------------------------------
-- Area: Apollyon (Central)
--  Mob: Proto-Omega
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/mobs")
local ID = require("scripts/zones/Apollyon/IDs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
	mob:setDamage(120)
    mob:setMod(tpz.mod.ATTP, 25)
    mob:setMod(tpz.mod.DEFP, 25)
    mob:addMod(tpz.mod.ACC, 25) 
    mob:setMod(tpz.mod.EVA, 360)
    mob:setMod(tpz.mod.REFRESH, 50)
    mob:setMod(tpz.mod.REGAIN, 0)
    mob:addMod(tpz.mod.MDEF, 68)
	mob:setMod(tpz.mod.DOUBLE_ATTACK, 0)
	mob:setMod(tpz.mod.COUNTER, 25) 
    mob:setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
    mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
    mob:setMod(tpz.mod.UDMGPHYS, -90)
    mob:setMod(tpz.mod.UDMGRANGE, -90)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setMod(tpz.mod.UDMGBREATH, 0)
    mob:setMod(tpz.mod.PARALYZERESTRAIT, 0)
    mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 25) -- "Moves at Flee Speed in Quadrupedal stance and in the Final Form"
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setLocalVar("form", 0)
    mob:setLocalVar("Gunpod", 0)
end

function onMobEngaged(mob, target)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobFight(mob, target)
    -- Only summons 6 Gunpods max
    local mobID = mob:getID()
    local formTime = mob:getLocalVar("formWait")
    local lifePercent = mob:getHPP()
    local currentForm = mob:getLocalVar("form")
    local Gunpod = mob:getLocalVar("Gunpod")
    local forcedPod = mob:getLocalVar("forcedPod")
    local AnimationSub = mob:AnimationSub()

    if lifePercent > 30 then
        if AnimationSub == 1 then
            mob:setMod(tpz.mod.UDMGPHYS, -90)
            mob:setMod(tpz.mod.UDMGRANGE, -90)
            mob:setMod(tpz.mod.UDMGMAGIC, 0)
            mob:setMod(tpz.mod.UDMGBREATH, 0)
            mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 25) -- "Moves at Flee Speed in Quadrupedal stance and in the Final Form"
        elseif AnimationSub == 2 then
            mob:setMod(tpz.mod.UDMGPHYS, 0)
            mob:setMod(tpz.mod.UDMGRANGE, 0)
            mob:setMod(tpz.mod.UDMGMAGIC, -90)
            mob:setMod(tpz.mod.UDMGBREATH, -90)
            mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 0)
        end
    end

    if lifePercent < 70 and currentForm < 1 then
        currentForm = 1
        mob:setLocalVar("form", currentForm)
        formTime = os.time()
    end

        -- Force a pod if Pod Ejection was interrupted
        if (forcedPod > 0) then
            if not IsMobBusy(mob) then
                mob:setLocalVar("forcedPod", 0)
                mob:useMobAbility(tpz.mob.skills.POD_EJECTION)
            end
        end

    if currentForm > 0 then
        if currentForm == 1 then
            if formTime < os.time() then
                if mob:AnimationSub() == 1 then
                    mob:AnimationSub(2)
                    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
                    if not GetMobByID(mobID + 1):isSpawned()then
                        if Gunpod < 6 then
                            Gunpod = Gunpod +1
                            mob:setLocalVar("Gunpod", Gunpod)
                            mob:useMobAbility(tpz.mob.skills.POD_EJECTION)
                        end
                    end 
                else
                    mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
                    mob:AnimationSub(1)
                end
                mob:setLocalVar("formWait", os.time() + 60)
            end
        elseif currentForm == 2 then
            if formTime < os.time() then
                if not GetMobByID(mobID + 1):isSpawned() then
                    if Gunpod < 6 then
                        Gunpod = Gunpod +1
                        mob:setLocalVar("Gunpod", Gunpod)
                        mob:useMobAbility(tpz.mob.skills.POD_EJECTION)
                    end
                end 
            mob:setLocalVar("formWait", os.time() + 60)
            end
        end

        if lifePercent < 30 then
            mob:AnimationSub(2)
            mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
            mob:setMod(tpz.mod.UDMGPHYS, -50)
            mob:setMod(tpz.mod.UDMGRANGE, -50)
            mob:setMod(tpz.mod.UDMGMAGIC, -50)
            mob:setMod(tpz.mod.UDMGBREATH, -50)
            mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 25)
            mob:setMod(tpz.mod.REGAIN, 50)
            currentForm = 2
            mob:setLocalVar("form", currentForm)
        end
    end

        mob:addListener("WEAPONSKILL_STATE_INTERRUPTED", "OMEGA_WS_INTERRUPTED", function(mob, skill)
            if (skill == tpz.mob.skills.POD_EJECTION) then
                if not GetMobByID(mobID +1):isSpawned() then
                    mob:setLocalVar("forcedPod", 1)
                end
            end
        end)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.STUN)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if player then
        player:addTitle(tpz.title.APOLLYON_RAVAGER)
    end
    if isKiller or noKiller then
        GetNPCByID(ID.npc.APOLLYON_CENTRAL_CRATE):setStatus(tpz.status.NORMAL)
    end
end

