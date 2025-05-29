-----------------------------------
-- Area: Mount Zhayolm
--   NM: Sarameya
-- !pos 322 -14 -581 61
-- Spawned with Buffalo Corpse: !additem 2583
-- Wiki: http://ffxiclopedia.wikia.com/wiki/Sarameya
-- TODO: PostAIRewrite: Code the Howl effect and gradual resists.
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.GA_CHANCE, 50)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

function onMobSpawn(mob)
	mob:setDamage(90)
    mob:setMod(tpz.mod.ATT, 450)
    mob:setMod(tpz.mod.DEF, 536)
    mob:setMod(tpz.mod.EVA, 356)
    mob:setMod(tpz.mod.MDEF, 12)
    mob:setMod(tpz.mod.UDMGMAGIC, -50)
    mob:setMod(tpz.mod.UDMGBREATH, 25) 
    mob:setMod(tpz.mod.SDT_FIRE, 100)
    mob:setMod(tpz.mod.SDT_ICE, 100)
    mob:setMod(tpz.mod.SDT_WIND, 100)
    mob:setMod(tpz.mod.SDT_EARTH, 100)
    mob:setMod(tpz.mod.SDT_THUNDER, 100)
    mob:setMod(tpz.mod.SDT_WATER, 100)
    mob:setMod(tpz.mod.SDT_LIGHT, 100)
    mob:setMod(tpz.mod.SDT_DARK, 100)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 12000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 14000)
    mob:setMobMod(tpz.mobMod.MUG_GIL, 8000)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
    mob:delImmunity(tpz.immunity.STUN)
    mob:SetMagicCastingEnabled(true)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
end

function onMobRoam(mob)
end

function onMobFight(mob, target)
	local HowlTime = mob:getLocalVar("HowlTime")
    local hpp = mob:getHPP()
    local useChainspell = false
	local BattleTime = mob:getBattleTime()

    if hpp < 90 and mob:getLocalVar("chainspell89") == 0 then
        mob:setLocalVar("chainspell89", 1)
        useChainspell = true
        --printf("chainspell 89")
    elseif hpp < 70 and mob:getLocalVar("chainspell69") == 0 then
        mob:setLocalVar("chainspell69", 1)
        useChainspell = true
        --printf("chainspell 69")
    elseif hpp < 50 and mob:getLocalVar("chainspell49") == 0 then
        mob:setLocalVar("chainspell49", 1)
        useChainspell = true
        --printf("chainspell 49")
    elseif hpp < 30 and mob:getLocalVar("chainspell29") == 0 then
        mob:setLocalVar("chainspell29", 1)
        useChainspell = true
        --printf("chainspell 29")
    elseif hpp < 10 and mob:getLocalVar("chainspell9") == 0 then
        mob:setLocalVar("chainspell9", 1)
        useChainspell = true
        --printf("chainspell 9")
    end

    if useChainspell then
        mob:useMobAbility(692) -- Chainspell
        mob:setMobMod(tpz.mobMod.GA_CHANCE, 100)
    end

    -- Spams TP moves and -ga spells
    if mob:hasStatusEffect(tpz.effect.CHAINSPELL) then
    else
        if mob:getMobMod(tpz.mobMod.GA_CHANCE) == 100 then
            mob:setMobMod(tpz.mobMod.GA_CHANCE, 50)
        end
    end

    -- Throughout the battle (but not during Chainspell), Sarameya will let out a Howl, then use Ululation, Firaga III and Magma Hoplon.
	if HowlTime == 0 then
		mob:setLocalVar("HowlTime", BattleTime + 180)
	elseif (BattleTime >= HowlTime and mob:hasStatusEffect(tpz.effect.CHAINSPELL) == false and mob:actionQueueEmpty()) then
        --printf("setting immunity")
        mob:SetMagicCastingEnabled(false)
        mob:addImmunity(tpz.immunity.STUN) -- Can't be stunned during howl Phase
        mob:useMobAbility(1796) -- First howl
        mob:useMobAbility(1788) -- Ululation
        if hpp < 25 then -- Gains access to Gates of Hades in howl sequence bleow 25%
            mob:useMobAbility(1790) -- Gates of Hades
            mob:useMobAbility(1789) -- Magma Hoplon
            mob:useMobAbility(1796) -- 2nd Howl
            mob:SetMagicCastingEnabled(true)
            mob:timer(18000, function(mob) -- Final howl resets enmity on all players
	            local zonePlayers = mob:getZone():getPlayers()
	            for _, zonePlayer in pairs(zonePlayers) do
                    mob:resetEnmity(zonePlayer)
                    --printf("resetting enmity")
	            end
                mob:setLocalVar("HowlTime", BattleTime + 180)
            end)
            mob:timer(18000, function(mob)
                mob:delImmunity(tpz.immunity.STUN) -- Remove immunity once howl phase is over
                --printf("removing immunity")
            end)
        else
            mob:SetMagicCastingEnabled(true)
		    mob:castSpell(176) -- Firaga III
            mob:useMobAbility(1789) -- Magma Hoplon
            mob:useMobAbility(1796) -- 2nd Howl
            mob:timer(23000, function(mob) -- Final howl resets enmity on all players
	            local zonePlayers = mob:getZone():getPlayers()
	            for _, zonePlayer in pairs(zonePlayers) do
                    mob:resetEnmity(zonePlayer)
                    --printf("resetting enmity")
	            end
                mob:setLocalVar("HowlTime", BattleTime + 180)
            end)
            mob:timer(23000, function(mob)
                mob:delImmunity(tpz.immunity.STUN) -- Remove immunity once howl phase is over
                --printf("removing immunity")
            end)
        end
    end

    -- Regens 1% of his HP a tick with Blaze Spikes on
    if mob:hasStatusEffect(tpz.effect.BLAZE_SPIKES) then
        mob:setMod(tpz.mod.REGEN, math.floor(mob:getMaxHP()/100))
    else
        if mob:getMod(tpz.mod.REGEN) > 0 then
            mob:setMod(tpz.mod.REGEN, 0)
        end
    end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.POISON, {chance = 25, power = 80})
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addCurrency("zeni_point", 400)
	if isKiller  then 
		player:addTreasure(5735, mob)--Cotton Coin Purse
	end
	if isKiller and math.random(1,100) <= 24 then 
		player:addTreasure(5735, mob)--Cotton Coin Purse
	end
	if isKiller and math.random(1,100) <= 15 then 
		player:addTreasure(5735, mob)--Cotton Coin Purse
	end
end
