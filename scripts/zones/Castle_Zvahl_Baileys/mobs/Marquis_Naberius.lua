-----------------------------------
-- Area: Castle Zvahl Baileys (161)
--   NM: Marquis Naberius
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:addMod(tpz.mod.MDEF, 24) 
    mob:setMod(tpz.mod.UFASTCAST, 50) 
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
    mob:addImmunity(tpz.immunity.SLEEP)
    mob:addImmunity(tpz.immunity.GRAVITY)
    mob:addImmunity(tpz.immunity.BIND)
    mob:addImmunity(tpz.immunity.SILENCE)
    mob:setLocalVar("PulsingDmgAuraDelay", 45)
    mob:setLocalVar("Msg", 0)
end

function onMobFight(mob, target)
	local PulsingDmgAuraDelay = mob:getLocalVar("PulsingDmgAuraDelay")
    local Msg = mob:getLocalVar("Msg")
    local BattleTime = mob:getBattleTime()
    -- Burn and damage nearby targets
    local nearbyPlayers = mob:getPlayersInRange(8)
    if nearbyPlayers == nil then return end
    if BattleTime >= PulsingDmgAuraDelay then
        for _,v in ipairs(nearbyPlayers) do
            local zonePlayers = mob:getZone():getPlayers()
            for _, zonePlayer in pairs(zonePlayers) do
                zonePlayer:PrintToPlayer("Is engulfed in an aura of flame!",0,"Naberius")
            end
            v:delStatusEffectSilent(tpz.effect.BURN)
            v:addStatusEffectEx(tpz.effect.BURN, tpz.effect.BURN, 3, 3, 60)
            local dmg = 15
            dmg = v:magicDmgTaken(dmg, tpz.magic.ele.FIRE)
            v:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
            mob:useMobAbility(307) -- 2 hour "cloud" animation (Fire / Red)
            mob:setLocalVar("PulsingDmgAuraDelay", BattleTime + 60)
        end
    end
    if mob:getHPP() < 50 then
        if Msg == 0 then
            local zonePlayers = mob:getZone():getPlayers()
            for _, zonePlayer in pairs(zonePlayers) do
                zonePlayer:PrintToPlayer("Roars with rage.",0,"Naberius")
            end
            mob:setLocalVar("Msg", 1)
        end
        mob:setModelId(1793) -- Cerberus
    end
end

function onAdditionalEffect(mob, target, damage)
	return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENFIRE, {chance = 100, power = math.random(15, 25)})
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 350)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(3600, 7200)) -- 1 to 2 hours
end
