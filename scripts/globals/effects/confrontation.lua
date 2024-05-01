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
    if target:getPet() then
        target:getPet():addStatusEffect(effect)
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
    local confrontationStartPos = confrontationStart:getSpawnPos()
    -- Display a warning if vendoring too far from where
    if (target:isPC()) then
        if target:checkDistance(confrontationStartPos) >= 25 then
            target:messageSpecial(ID.text.CONF_TOO_FAR)
        end
    end

    -- Delete effect if 50 yards from the spawn pos
    if (target:isPC()) then
        if target:checkDistance(confrontationStartPos) >= 50 then
            target:messageSpecial(ID.text.CONF_DISENAGED)
            target:delStatusEffect(tpz.effect.CONFRONTATION)
        end
    end

    -- If an engaged mob, and someone without confrontation ventured too far away, re-enable their confrontation status
    if (target:isMob()) then
        local NearbyPlayers = target:getPlayersInRange(25)
        if NearbyPlayers == nil then return end
        if NearbyPlayers then
            for _,v in ipairs(NearbyPlayers) do
                if not v:hasStatusEffect(tpz.effect.CONFRONTATION) then
                    local power = effect:getPower()
                    local tick = effect:getTick() / 1000
                    local duration = math.ceil((effect:getTimeRemaining()) / 1000)
                    local subId = 0
                    local subPower = effect:getSubPower()
                    local tier = 0
                    v:addStatusEffect(tpz.effect.CONFRONTATION, power, tick, duration, subId, subPower, tier)
                    v:messageSpecial(ID.text.CONF_REENGAGED)
                end
            end
        end
    end
end

function onEffectLose(target,effect)
    if target:getPet() then
        target:getPet():delStatusEffect(tpz.effect.CONFRONTATION)
    end
    if (target:isMob()) then
        DespawnMob(target:getID())
    end
end
