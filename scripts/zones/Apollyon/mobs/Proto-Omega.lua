-----------------------------------
-- Area: Apollyon (Central)
--  Mob: Proto-Omega
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/mobs")
local ID = require("scripts/zones/Apollyon/IDs")

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
    local mobID = mob:getID()
    local formTime = mob:getLocalVar("formWait")
    local lifePercent = mob:getHPP()
    local currentForm = mob:getLocalVar("form")
    local Gunpod = mob:getLocalVar("Gunpod")
    local AnimationSub = mob:AnimationSub()

    local First = mob:getLocalVar("First")
    local Second = mob:getLocalVar("Second")
    local Third = mob:getLocalVar("Third")
    local Fourth = mob:getLocalVar("Fourth")
    local Fifth = mob:getLocalVar("Fifth")
    local Sixth = mob:getLocalVar("Sixth")
    local Seventh = mob:getLocalVar("Seventh")
    local Eighth = mob:getLocalVar("Eighth")
    local Ninth = mob:getLocalVar("Ninth")
    local Tenth = mob:getLocalVar("Tenth")
    local Eleventh = mob:getLocalVar("Eleventh")
    local Twelth = mob:getLocalVar("Twelth")
    local Thirteenth = mob:getLocalVar("Thirteenth")
    local Fourteenth = mob:getLocalVar("Fourteenth")
    local Fifteenth = mob:getLocalVar("Fifteenth")
    
    if First ~= 0 then
        mob:useMobAbility(1525) -- dustvoid
        mob:setLocalVar("First", 0)
    end

    if Second ~= 0 then
        mob:useMobAbility(1526) -- slaverous_gale
        mob:setLocalVar("Second", 0)
    end

    if Third ~= 0 then
        mob:useMobAbility(1527) -- aeolian_void
        mob:setLocalVar("Third", 0)
    end

    if Fourth ~= 0 then
        mob:useMobAbility(1528) -- extreme_purgation
        mob:setLocalVar("Fourth", 0)
    end

    if Fifth ~= 0 then
        mob:useMobAbility(1529) -- doomvoid
        mob:setLocalVar("Fifth", 0)
    end

    if Sixth ~= 0 then
        mob:useMobAbility(1530) -- desiccation
        mob:setLocalVar("Sixth", 0)
    end

    if Seventh ~= 0 then
        mob:useMobAbility(1533) -- desiccation
        mob:setLocalVar("Seventh", 0)
    end

    if Eighth ~= 0 then
        mob:useMobAbility(1534) -- desiccation
        mob:setLocalVar("Eighth", 0)
    end

    if Ninth ~= 0 then
        mob:useMobAbility(1536) -- desiccation
        mob:setLocalVar("Ninth", 0)
    end

    if Tenth ~= 0 then
        mob:useMobAbility(1538) -- desiccation
        mob:setLocalVar("Tenth", 0)
    end

    if Eleventh ~= 0 then
        mob:useMobAbility(1539) -- desiccation
        mob:setLocalVar("Eleventh", 0)
    end

    if Twelth ~= 0 then
        mob:useMobAbility(1521) -- desiccation
        mob:setLocalVar("Twelth", 0)
    end

    if Thirteenth ~= 0 then
        mob:useMobAbility(1522) -- desiccation
        mob:setLocalVar("Thirteenth", 0)
    end

    if Fourteenth ~= 0 then
        mob:useMobAbility(1523) -- desiccation
        mob:setLocalVar("Fourteenth", 0)
    end

    if Fifteenth ~= 0 then
        mob:useMobAbility(1540) -- desiccation
        mob:setLocalVar("Fifteenth", 0)
    end

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
                            mob:useMobAbility(1532)
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
                        mob:useMobAbility(1532)
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

