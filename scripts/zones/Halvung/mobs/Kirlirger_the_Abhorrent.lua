-----------------------------------
-- Area: Halvung
--  Mob: Kirlirger the Abhorrent
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
	mob:setDamage(250)
    mob:addMod(tpz.mod.ACC, 100)
    mob:setMod(tpz.mod.UFASTCAST, 50)
    mob:setMod(tpz.mod.REFRESH, 40)
end

function onMobFight(mob, target)
    -- Gains bonuses from certain absorbs
    if mob:hasStatusEffect(tpz.effect.STR_BOOST) then
        mob:setDamage(350)
    else
        mob:setDamage(250)
    end

    if mob:hasStatusEffect(tpz.effect.INT_BOOST) then
        mob:setMod(tpz.mod.MATT, 124)
        mob:setMod(tpz.mod.ENH_DRAIN_ASPIR, 200)
    else
        mob:setMod(tpz.mod.MATT, 24)
        mob:setMod(tpz.mod.ENH_DRAIN_ASPIR, 0)
    end

    if mob:hasStatusEffect(tpz.effect.VIT_BOOST) then
        mob:setMod(tpz.mod.UDMGPHYS, -75)
    else
        mob:setMod(tpz.mod.UDMGPHYS, 0)
    end

    if mob:hasStatusEffect(tpz.effect.MND_BOOST) then
        mob:setMod(tpz.mod.UDMGMAGIC, -75)
    else
        mob:setMod(tpz.mod.UDMGMAGIC, 0)
    end

    -- Weapon breaks at 49% HP
    if
        mob:getHPP() < 50 and
        not IsMobBusy(mob) and
        (mob:getLocalVar("bloodWeapon") == 0)
    then
        mob:useMobAbility(tpz.jsa.BLOOD_WEAPON)
        mob:AnimationSub(1)
        mob:setMod(tpz.mod.CRITHITRATE, 100)
        mob:setLocalVar("bloodWeapon", 1)
    end
end

function onAdditionalEffect(mob, target, damage)
    local animationSub = mob:AnimationSub()
    if animationSub == 0 or animationSub == 4 then -- Has weapon
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.STUN, {chance = 100, duration = 5})
    else
        return 0
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
	if isKiller  then 
		player:addTreasure(5736, mob)--Linen Coin Purse
	end
	if isKiller and math.random(1,100) <= 24 then 
		player:addTreasure(5736, mob)--Linen Coin Purse
	end
	if isKiller and math.random(1,100) <= 15 then 
		player:addTreasure(5736, mob)--Linen Coin Purse
	end
end
