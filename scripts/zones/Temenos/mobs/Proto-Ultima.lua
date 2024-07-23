-----------------------------------
-- Area: Temenos
--  Mob: Proto-Ultima
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/limbus")
require("scripts/globals/mobs")
local ID = require("scripts/zones/Temenos/IDs")
-----------------------------------

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
        local ID = zones[mob:getZoneID()]
        local phase = mob:getLocalVar("battlePhase")
        local citadelBusterTimer = mob:getLocalVar("citadelBusterTimer")
        local holyEnabled = mob:getLocalVar("holyEnabled")
        local enmityList = mob:getEnmityList()
        local holyTarget = nil

        if not IsMobBusy(mob) then
            if mob:getLocalVar("nuclearWaste") == 1 then
                local ability = math.random(1262,1267)
                mob:useMobAbility(ability)
            end
        end

        -- Holy IIs a random target after using certain TP moves in Phase 2
        if not IsMobBusy(mob) then
            if enmityList and #enmityList > 0 and (holyEnabled > 0) then
                local randomTarget = enmityList[math.random(1, #enmityList)]
                local entityId = randomTarget.entity:getID()
        
                if (entityId > 10000) then -- ID is a mob (pet)
                    holyTarget = GetMobByID(entityId)
                else
                    holyTarget = GetPlayerByID(entityId)
                end
        
                mob:setLocalVar("holyEnabled", 0)
                mob:castSpell(22, holyTarget) -- Holy II
            end
        end

        if not IsMobBusy(mob) then
            if mob:getHPP() < (80 - (phase * 20)) then
                mob:useMobAbility(1524) -- use Dissipation on phase change
                phase = phase + 1
                mob:setLocalVar("battlePhase", phase) -- incrementing the phase here instead of in the Dissipation skill because stunning it prevents use.
            end

            -- Citadel Buster
            if phase == 4 then
                mob:setMod(tpz.mod.REGAIN, 50)

                if (os.time() >= citadelBusterTimer) and (citadelBuster == 0) then
                    mob:setLocalVar("citadelBuster", 1)
                    mob:SetMobAbilityEnabled(false)
                    mob:SetMagicCastingEnabled(false)
                    mob:SetAutoAttackEnabled(false)
                    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
                    local NearbyPlayers = mob:getPlayersInRange(50)
                    if NearbyPlayers == nil then return end
                    if NearbyPlayers then
                        for _,players in ipairs(NearbyPlayers) do
                            players:messageSpecial(ID.text.CITADEL_BASE)
                        end
                        mob:timer(10000, function(mob)
                            for _,players in ipairs(NearbyPlayers) do
                                players:messageSpecial(ID.text.CITADEL_BASE+1)
                            end
                            mob:timer(10000, function(mob)
                                for _,players in ipairs(NearbyPlayers) do
                                    players:messageSpecial(ID.text.CITADEL_BASE+2)
                                end
                                mob:timer(5000, function(mob)
                                    for _,players in ipairs(NearbyPlayers) do
                                        players:messageSpecial(ID.text.CITADEL_BASE+3)
                                    end
                                    mob:timer(1000, function(mob)
                                        for _,players in ipairs(NearbyPlayers) do
                                            players:messageSpecial(ID.text.CITADEL_BASE+4)
                                        end
                                        mob:timer(1000, function(mob)
                                            for _,players in ipairs(NearbyPlayers) do
                                                players:messageSpecial(ID.text.CITADEL_BASE+5)
                                            end
                                            mob:timer(1000, function(mob)
                                                for _,players in ipairs(NearbyPlayers) do
                                                    players:messageSpecial(ID.text.CITADEL_BASE+6)
                                                end
                                                mob:timer(1000, function(mob)
                                                    for _,players in ipairs(NearbyPlayers) do
                                                        players:messageSpecial(ID.text.CITADEL_BASE+7)
                                                    end
                                                    mob:timer(1000, function(mob)
                                                        mob:useMobAbility(1540)
                                                        mob:timer(500, function(mob)
                                                            mob:setLocalVar("citadelBusterTimer", os.time() +70)
                                                            mob:setLocalVar("citadelBuster", 0)
                                                            mob:SetMagicCastingEnabled(true)
                                                            mob:SetAutoAttackEnabled(true)
                                                            mob:SetMobAbilityEnabled(true)
                                                            mob:setMobMod(tpz.mobMod.DRAW_IN, 0)
                                                        end)
                                                    end)
                                                end)
                                            end)
                                        end)
                                    end)
                                end)
                            end)
                        end)
                    end
                end
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
