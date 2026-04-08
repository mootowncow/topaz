-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
--  Mob: Red Pineapple
-- 
-----------------------------------
mixins = {require("scripts/mixins/families/growing_bomb")}
local ID = require("scripts/zones/Lebros_Cavern/IDs")
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
    mob:setMod(tpz.mod.MDEF, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 2) 
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
	mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 20)
    mob:AnimationSub(0)
    mob:setSpellList(2045) -- Fire through Fire III, Firaga, and Blaze Spikes
end

function onMobRoam(mob)
    if mob:getTP() > 1000 then
        mob:setTP(1000)
    end
    --if mob:getID(instance) == 17035597 then
        --mob:setPos(301.0785,-29.9443,378.5287,130)
    --end
end

function onMobEngaged(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobFight(mob, target)
    local animationSub = mob:AnimationSub()
    if mob:getHPP() <= 75 then
	    if animationSub == 0 then
		    mob:AnimationSub(1)
		    mob:setDamage(125)
		    mob:setMod(tpz.mod.UFASTCAST, 12)
		    mob:setMod(tpz.mod.MATT, 34)
	    elseif animationSub == 1 then
		    mob:AnimationSub(2)
		    mob:setDamage(150)
		    mob:setMod(tpz.mod.UFASTCAST, 25)
		    mob:setMod(tpz.mod.MATT, 36)
            mob:setSpellList(2045) -- Fire through Fire III, Firaga, and Blaze Spikes
	    elseif animationSub == 2 then
		    mob:AnimationSub(3)
		    mob:setDamage(175)
		    mob:setMod(tpz.mod.UFASTCAST, 50)
		    mob:setMod(tpz.mod.MATT, 40)
            mob:setSpellList(2046) -- Fire III and Fire IV, Firaga III, and Flare II.
	    end
    end
    if mob:getHPP() <= 50 then
        if animationSub == 1 then
		    mob:AnimationSub(2)
		    mob:setDamage(150)
		    mob:setMod(tpz.mod.UFASTCAST, 25)
		    mob:setMod(tpz.mod.MATT, 36)
            mob:setSpellList(2045) -- Fire through Fire III, Firaga, and Blaze Spikes
	    elseif animationSub == 2 then
		    mob:AnimationSub(3)
		    mob:setDamage(175)
		    mob:setMod(tpz.mod.UFASTCAST, 50)
		    mob:setMod(tpz.mod.MATT, 40)
            mob:setSpellList(2046) -- Fire III and Fire IV, Firaga III, and Flare II.
	    end
    end
    if mob:getHPP() <= 25 then
        if animationSub == 2 then
		    mob:AnimationSub(3)
		    mob:setDamage(175)
		    mob:setMod(tpz.mod.UFASTCAST, 50)
		    mob:setMod(tpz.mod.MATT, 40)
            mob:setSpellList(2046) -- Fire III and Fire IV, Firaga III, and Flare II.
	    end
    end
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller, noKiller)
    local instance = mob:getInstance()
    if isKiller or noKiller then
        SpawnMob(17035613, instance)
        local zonePlayers = mob:getZone():getPlayers()
        for _, zonePlayer in pairs(zonePlayers) do
            zonePlayer:PrintToPlayer("You hear a terrifying echo through the cavern...",0,"???")
        end
    end
end