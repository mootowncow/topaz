-----------------------------------
--
-- tpz.effect.CONFRONTATION
-- Duration must be divisable by 5 or this will not work properly!
-----------------------------------

function onEffectGain(target,effect)
    local duration = math.ceil((effect:getTimeRemaining()) / 1000)
    local ID = zones[target:getZoneID()]
    if (target:isPC()) then
        target:messageSpecial(ID.text.CONF_BATTLE_BEGIN, duration / 60, 0, 0, 0) 
    end
end

function onEffectTick(target, effect)
    local timeRemaining = math.ceil((effect:getTimeRemaining()) / 1000)
    local fiveMinutes = 300
    local thirtySeconds = 30
    local zoneId = target:getZoneID()
    local ID = zones[zoneId]

    if (target:isPC()) then
        if (timeRemaining <= 0) then
            target:messageSpecial(ID.text.CONF_TIME_UP)
            target:messageSpecial(ID.text.MONSTER_FADES)
            target:delPartyEffect(tpz.effect.CONFRONTATION)
        elseif (timeRemaining <= thirtySeconds) then
            if (timeRemaining % 10 == 0) then
                target:messageSpecial(ID.text.CONF_SEC_REMAINING, timeRemaining, 0, 0, 0)
            end
        elseif (timeRemaining <= fiveMinutes) then
            if (timeRemaining % 60 == 0) then
                target:messageSpecial(ID.text.CONF_MIN_REMAINING, timeRemaining / 60, 0, 0, 0)
            end
        end
    end

    local confrontationStart = GetMobByID(effect:getSubPower())
    if (confrontationStart == nil) then
        target:delStatusEffect(tpz.effect.CONFRONTATION)
        return
    end

    local confrontationStartPos = confrontationStart:getSpawnPos()
    -- Display a warning if vendoring too far from where the mob spawns
    if (target:isPC()) then
        if (target:checkDistance(confrontationStartPos) >= 30) then
            target:messageSpecial(ID.text.CONF_TOO_FAR)
        end
    end

    -- Delete effect if 50 yards from the spawn pos
    if (target:isPC()) then
        if (target:checkDistance(confrontationStartPos) >= 50) then
            target:messageSpecial(ID.text.CONF_DISENAGED)
            target:delStatusEffect(tpz.effect.CONFRONTATION)
        end
    end

    -- If an engaged mob, and someone without confrontation ventured too far away, re-enable their confrontation status
    if (target:isMob() and target:getAllegiance() == tpz.allegiance.MOB) then
        local NearbyEntities = target:getNearbyEntities(25)
        if NearbyEntities == nil then return end
        if NearbyEntities then
            for _,entity in pairs(NearbyEntities) do
                if (entity:getAllegiance() ~= target:getAllegiance()) then
                    if not entity:hasStatusEffect(tpz.effect.CONFRONTATION) then
                        local power = effect:getPower()
                        local tick = effect:getTick() / 1000
                        local duration = math.ceil((effect:getTimeRemaining()) / 1000)
                        local subId = 0
                        local subPower = effect:getSubPower()
                        local tier = 0
                        entity:addStatusEffect(tpz.effect.CONFRONTATION, power, tick, duration, subId, subPower, tier)
                        if (entity:isPC()) then
                            entity:messageSpecial(ID.text.CONF_REENGAGED)
                        end
                    end
                end
            end
        end
    end
end

function onEffectLose(target,effect)
    if (target:isMob()) then
        DespawnMob(target:getID())
    end
end
