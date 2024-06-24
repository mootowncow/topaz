-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--   NM: Jailer of Temperance
-----------------------------------
local ID = require("scripts/zones/Grand_Palace_of_HuXzoi/IDs")
require("scripts/zones/Grand_Palace_of_HuXzoi/globals")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onMobSpawn(mob)
	mob:setDamage(100)
    mob:setMod(tpz.mod.ATT, 560) -- 620
    mob:setMod(tpz.mod.DEF, 253) -- 300
    mob:setMod(tpz.mod.EVA, 324) -- 360
    mob:setMod(tpz.mod.REFRESH, 50)
    -- Set AnimationSub to 0, put it in pot form
    -- Change it's damage resists. Pot for take

    -- Change animation to pot
    mob:AnimationSub(0)
    -- Set the damage resists
    mob:setMod(tpz.mod.HTHRES, 1000)
    mob:setMod(tpz.mod.SLASHRES, 0)
    mob:setMod(tpz.mod.PIERCERES, 0)
    mob:setMod(tpz.mod.RANGEDRES, 0)
    mob:setMod(tpz.mod.IMPACTRES, 1000)
    -- Set the magic resists. It always takes no damage from direct magic
    mob:setMod(tpz.mod.UDMGBREATH, -100)
    mob:setMod(tpz.mod.UDMGMAGIC, -100)
    --150% move speed
    mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 50)

    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.MEIKYO_SHISUI, cooldown = 180, hpp = math.random(90, 95)}, -- "Has access to Meikyo Shisui, which it may use several times."
        },
    })
end

function onMobFight(mob)
    -- Forms: 0 = Pot  1 = Pot  2 = Poles  3 = Rings
    local randomTime = math.random(30, 180)
    local changeTime = mob:getLocalVar("changeTime")

    -- If we're in a pot form, but going to change to either Rings/Poles
    if mob:AnimationSub() == 0 or mob:AnimationSub() == 4 or mob:AnimationSub() == 1 and mob:getBattleTime() - changeTime > randomTime then
        local aniChange = math.random(2, 3)
        mob:AnimationSub(aniChange)

        -- We changed to Poles. Make it only take piercing.
        if (aniChange == 2) then
            mob:setMod(tpz.mod.HTHRES, 0)
            mob:setMod(tpz.mod.SLASHRES, 0)
            mob:setMod(tpz.mod.PIERCERES, 1000)
            mob:setMod(tpz.mod.RANGEDRES, 1000)
            mob:setMod(tpz.mod.IMPACTRES, 0)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        else -- We changed to Rings. Make it only take slashing.
            mob:setMod(tpz.mod.HTHRES, 0)
            mob:setMod(tpz.mod.SLASHRES, 1000)
            mob:setMod(tpz.mod.PIERCERES, 0)
            mob:setMod(tpz.mod.IMPACTRES, 0)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        end
    -- We're in poles, but changing
    elseif (mob:AnimationSub() == 2 and mob:getBattleTime() - changeTime > randomTime) then
        local aniChange = math.random(0, 1)

        -- Changing to Pot, only take Blunt damage
        if (aniChange == 0) then
            mob:AnimationSub(0)
            mob:setMod(tpz.mod.HTHRES, 1000)
            mob:setMod(tpz.mod.SLASHRES, 0)
            mob:setMod(tpz.mod.PIERCERES, 0)
            mob:setMod(tpz.mod.RANGEDRES, 0)
            mob:setMod(tpz.mod.IMPACTRES, 1000)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        else -- Going to Rings, only take slashing
            mob:AnimationSub(3)
            mob:setMod(tpz.mod.HTHRES, 0)
            mob:setMod(tpz.mod.SLASHRES, 1000)
            mob:setMod(tpz.mod.PIERCERES, 0)
            mob:setMod(tpz.mod.RANGEDRES, 0)
            mob:setMod(tpz.mod.IMPACTRES, 0)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        end
    -- We're in rings, but going to change to pot or poles
    elseif (mob:AnimationSub() == 3 and mob:getBattleTime() - changeTime > randomTime) then
        local aniChange = math.random(0, 2)
        mob:AnimationSub(aniChange)

        -- We're changing to pot form, only take blunt damage.
        if (aniChange == 0 or aniChange == 1) then
            mob:setMod(tpz.mod.HTHRES, 1000)
            mob:setMod(tpz.mod.SLASHRES, 0)
            mob:setMod(tpz.mod.PIERCERES, 0)
            mob:setMod(tpz.mod.RANGEDRES, 0)
            mob:setMod(tpz.mod.IMPACTRES, 1000)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        else -- Changing to poles, only take piercing
            mob:setMod(tpz.mod.HTHRES, 0)
            mob:setMod(tpz.mod.SLASHRES, 0)
            mob:setMod(tpz.mod.PIERCERES, 1000)
            mob:setMod(tpz.mod.RANGEDRES, 1000)
            mob:setMod(tpz.mod.IMPACTRES, 0)
            mob:setLocalVar("changeTime", mob:getBattleTime())
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    DisallowRespawn(mob:getID(), true)
    for _, mobID in pairs(ID.mob.JAILER_OF_TEMPERANCE_PH) do
        DisallowRespawn(mobID, false)
    end

    mob:setLocalVar("pop", os.time() + 900) -- 15 mins
    GRAND_PALACE_OF_HUXZOI.pickTemperancePH()
end
