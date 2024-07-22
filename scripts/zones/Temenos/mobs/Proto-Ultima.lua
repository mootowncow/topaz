-----------------------------------
-- Area: Temenos
--  Mob: Proto-Ultima
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/limbus")
local ID = require("scripts/zones/Temenos/IDs")

local SkillID =
{
    [1] = 1521, 
    [2] = 1522,
    [3] = 1523,
    [4] = 1269,
}

function onMobSpawn(mob)
	mob:setDamage(140)
    mob:setMod(tpz.mod.ATT, 535)
    mob:setMod(tpz.mod.ATTP, 0)
    mob:setMod(tpz.mod.DEF, 522)
    mob:setMod(tpz.mod.DEFP, 0)
    mob:setMod(tpz.mod.ACC, 300) 
    mob:setMod(tpz.mod.EVA, 300) 
    mob:setMod(tpz.mod.REFRESH, 50)
	mob:setMod(tpz.mod.MDEF, 119)
    mob:setMod(tpz.mod.UDMGMAGIC, -30)
	mob:setMod(tpz.mod.REGEN, 0) 
	mob:setMod(tpz.mod.REGAIN, 0) 
	mob:setMod(tpz.mod.DOUBLE_ATTACK, 0)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:SetMagicCastingEnabled(false)
    mob:SetAutoAttackEnabled(true)
    mob:SetMobAbilityEnabled(true)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 0)
end

function onMobEngaged(mob, target)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
    tpz.limbus.setupArmouryCrates(mob:getBattlefieldID(), true)
end

function onMobFight(mob, target)
    local phase = mob:getLocalVar("battlePhase")
    local holyEnabled = mob:getLocalVar("holyEnabled")
    local enmityList = mob:getEnmityList()
    local holyTarget = nil

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
        mob:useMobAbility(1259) -- dustvoid
        mob:setLocalVar("First", 0)
    end

    if Second ~= 0 then
        mob:useMobAbility(1260) -- slaverous_gale
        mob:setLocalVar("Second", 0)
    end

    if Third ~= 0 then
        mob:useMobAbility(1261) -- aeolian_void
        mob:setLocalVar("Third", 0)
    end

    if Fourth ~= 0 then
        mob:useMobAbility(1262) -- extreme_purgation
        mob:setLocalVar("Fourth", 0)
    end

    if Fifth ~= 0 then
        mob:useMobAbility(1263) -- doomvoid
        mob:setLocalVar("Fifth", 0)
    end

    if Sixth ~= 0 then
        mob:useMobAbility(1264) -- desiccation
        mob:setLocalVar("Sixth", 0)
    end

    if Seventh ~= 0 then
        mob:useMobAbility(1265) -- desiccation
        mob:setLocalVar("Seventh", 0)
    end

    if Eighth ~= 0 then
        mob:useMobAbility(1266) -- desiccation
        mob:setLocalVar("Eighth", 0)
    end

    if Ninth ~= 0 then
        mob:useMobAbility(1267) -- desiccation
        mob:setLocalVar("Ninth", 0)
    end

    if Tenth ~= 0 then
        mob:useMobAbility(1268) -- desiccation
        mob:setLocalVar("Tenth", 0)
    end

    if Eleventh ~= 0 then
        mob:useMobAbility(1269) -- desiccation
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


    if mob:getLocalVar("nuclearWaste") == 1 then
        local ability = math.random(1262,1267)
        mob:useMobAbility(ability)
        mob:setLocalVar("nuclearWaste", 0)
    end

    -- Holy IIs a random target after using certain TP moves in Phase 2
    if mob:getCurrentAction() ~= tpz.action.MOBABILITY_START
    and mob:getCurrentAction() ~= tpz.action.MOBABILITY_USING
    and mob:actionQueueEmpty() then
        for _, enmity in ipairs(enmityList) do
            if enmityList and #enmityList > 0 and (holyEnabled > 0) then
                local randomTarget = enmityList[math.random(1,#enmityList)];
                entityId = randomTarget.entity:getID();
                if (entityId > 10000) then -- ID is a mob(pet) then
                    holyTarget = GetMobByID(entityId)
                else
                    holyTarget = GetPlayerByID(entityId)
                end
                mob:setLocalVar("holyEnabled", 0)
                mob:castSpell(22, GetPlayerByID(holyTarget)) -- Holy II
            end
        end
    end

    if mob:getCurrentAction() ~= tpz.action.MOBABILITY_START
    and mob:getCurrentAction() ~= tpz.action.MOBABILITY_USING
    and mob:actionQueueEmpty() then
        if mob:getHPP() < (80 - (phase * 20)) then
            mob:useMobAbility(1524) -- use Dissipation on phase change
            phase = phase + 1
            if phase == 4 then -- add Regain in final phase
                mob:setMod(tpz.mod.REGAIN, 50)
            end
            mob:setLocalVar("battlePhase", phase) -- incrementing the phase here instead of in the Dissipation skill because stunning it prevents use.
        end
    end
end

function onMobWeaponSkill(target, mob, skill)
    local phase = mob:getLocalVar("battlePhase")
    local HolyTarget = mob:getLocalVar("HolyTarget")
    local BattleTarget = mob:getTarget()

    mob:setLocalVar("HolyTarget", 0)
    if phase > 1 then
        for v = 1259,1267,1 do -- TP move ID
            if skill:getID() == v then
                mob:setLocalVar("holyEnabled", 1)
            end
        end
        for _,v in pairs(SkillID) do
            if skill:getID() == v then
                mob:setLocalVar("holyEnabled", 1)
            end
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if player then
        player:addTitle(tpz.title.TEMENOS_LIBERATOR)
    end
    if isKiller or noKiller then
        GetNPCByID(ID.npc.TEMENOS_C_CRATE[4][1]):setStatus(tpz.status.NORMAL)
    end
end
