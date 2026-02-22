-----------------------------------
-- Area: Wajaom Woodlands
--  ZNM: Tinnin
-- !pos 276 0 -694
-- Spawned with Monkey Wine: @additem 2573
-- Wiki: http://ffxiclopedia.wikia.com/wiki/Tinnin
-----------------------------------
mixins =
{
    require("scripts/mixins/job_special"),
    require("scripts/mixins/rage")
}
require("scripts/globals/magic")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

function onMobSpawn(mob)
	mob:setDamage(130)
    mob:setMod(tpz.mod.ATT, 975)
    mob:setMod(tpz.mod.DEF, 300)
    mob:setMod(tpz.mod.EVA, 457) --Hydra family * 1.15
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setMod(tpz.mod.UDMGBREATH, -100)
    mob:setMod(tpz.mod.DMGSPIRITS, -100) 
    mob:setMod(tpz.mod.SDT_FIRE, 60)
    mob:setMod(tpz.mod.SDT_ICE, 60)
    mob:setMod(tpz.mod.SDT_WIND, 60)
    mob:setMod(tpz.mod.SDT_EARTH, 100)
    mob:setMod(tpz.mod.SDT_THUNDER, 100)
    mob:setMod(tpz.mod.SDT_WATER, 100)
    mob:setMod(tpz.mod.SDT_LIGHT, 100)
    mob:setMod(tpz.mod.SDT_DARK, 100)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 15)
    mob:setMod(tpz.mod.REGEN, 50)
    mob:setMod(tpz.mod.REGAIN, 50)
    --ADD mod
    mob:addMod(tpz.mod.ACC, 50)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 12000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 14000)
    mob:setMobMod(tpz.mobMod.MUG_GIL, 8000)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:setHP(mob:getMaxHP()/2)
    mob:setUnkillable(true)
	mob:addTP(3000)
        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.MIGHTY_STRIKES, hpp = 0},
            },
        })
    -- Regen Head every 1.5-4 minutes 90-240
    mob:setLocalVar("headTimer", os.time() + math.random(60, 190))

    -- Number of crits to lose a head
    mob:setLocalVar("CritToTheFace", math.random(50, 100))
    mob:setLocalVar("crits", 0)
end

function onMobRoam(mob)
    -- Regen head
    local headTimer = mob:getLocalVar("headTimer")
    if (mob:AnimationSub() == 2 and os.time() > headTimer) then
        mob:AnimationSub(1)
        mob:setLocalVar("headTimer", os.time() + math.random(60, 190))

        -- First time it regens second head, 25%. Reduced afterwards.
        if (mob:getLocalVar("secondHead") == 0) then
            mob:addHP(mob:getMaxHP() * .25)
            mob:setLocalVar("secondHead", 1)
        else
            mob:addHP(mob:getMaxHP() * .05)
        end

    elseif (mob:AnimationSub() == 1 and os.time() > headTimer) then
        mob:AnimationSub(0)
        mob:setLocalVar("headTimer", os.time() + math.random(60, 190))

        -- First time it regens third head, 25%. Reduced afterwards.
        if (mob:getLocalVar("thirdHead") == 0) then
            mob:addHP(mob:getMaxHP() * .25)
            mob:setMod(tpz.mod.REGEN, 10)
            mob:setLocalVar("thirdHead", 1)
            mob:setUnkillable(false) -- It can be killed now that has all his heads
            tpz.mix.jobSpecial.config(mob, { -- It can now use Mighty Strikes
                specials =
                {
                    {id = tpz.jsa.MIGHTY_STRIKES, hpp = math.random(5, 40)},
                },
            })
        else
            mob:addHP(mob:getMaxHP() * .05)
        end
    end
end

function onMobFight(mob, target)
    local headTimer = mob:getLocalVar("headTimer")
    if (mob:AnimationSub() == 2 and os.time() > headTimer) then
        mob:AnimationSub(1)
        mob:setLocalVar("headTimer", os.time() + math.random(60, 190))

        -- First time it regens second head, 25%. Reduced afterwards.
        if (mob:getLocalVar("secondHead") == 0) then
            mob:addHP(mob:getMaxHP() * .25)
            mob:setLocalVar("secondHead", 1)
        else
            mob:addHP(mob:getMaxHP() * .05)
        end
        if (bit.band(mob:getBehaviour(), tpz.behavior.NO_TURN) > 0) then -- disable no turning for the forced mobskills upon head growth
            mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
        end
        -- These need to be listed in reverse order as forced moves are added to the top of the queue.
        mob:useMobAbility(1830) -- Polar Blast
        mob:useMobAbility(1832) -- Barofield

    elseif (mob:AnimationSub() == 1 and os.time() > headTimer) then
        mob:AnimationSub(0)
        mob:setLocalVar("headTimer", os.time() + math.random(60, 190))

        -- First time it regens third head, 25%. Reduced afterwards.
        if (mob:getLocalVar("thirdHead") == 0) then
            mob:setMod(tpz.mod.REGEN, 10)
            mob:addHP(mob:getMaxHP() * .25)
            mob:setLocalVar("thirdHead", 1)
            mob:setUnkillable(false) -- It can be killed now that has all his heads
            tpz.mix.jobSpecial.config(mob, { -- It can now use Mighty Strikes
                specials =
                {
                    {id = tpz.jsa.MIGHTY_STRIKES, hpp = math.random(5, 40)},
                },
            })
        else
            mob:addHP(mob:getMaxHP() * .05)
        end
        if (bit.band(mob:getBehaviour(), tpz.behavior.NO_TURN) > 0) then -- disable no turning for the forced mobskills upon head growth
            mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
        end
        -- Reverse order, same deal.
        mob:useMobAbility(1828) -- Pyric Blast
        mob:useMobAbility(1830) -- Polar Blast
        mob:useMobAbility(1832) -- Barofield
    end
end

function onCriticalHit(mob)
    local critNum = mob:getLocalVar("crits")

    if ((critNum+1) > mob:getLocalVar("CritToTheFace")) then  -- Lose a head
        if (mob:AnimationSub() == 0) then
            mob:AnimationSub(1)
            mob:setLocalVar("headTimer", os.time() + math.random(60, 190))
        elseif (mob:AnimationSub() == 1) then
            mob:AnimationSub(2)
            mob:setLocalVar("headTimer", os.time() + math.random(60, 190))
        else
            -- Meh
        end

        -- Number of crits to lose a head, re-randoming
        mob:setLocalVar("CritToTheFace", math.random(50, 100))

        critNum = 0 -- reset the crits on the NM
    else
        critNum = critNum + 1
    end
    mob:setLocalVar("crits", critNum)
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
    -- Nerve Gas will only and always be used after immediately after Pyric Bulwark or Polar Bulwark.
    if skill:getID() == 1829 or skill:getID() == 1831 then 
        mob:useMobAbility(1836) -- Nerve Gas
    end
end

function onMobDrawIn(mob, target)
    mob:addTP(3000) -- Uses a mobskill upon drawing in a player. Not necessarily on the person drawn in.
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
