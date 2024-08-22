-----------------------------------
-- Area: La Vaule [S]
--   NM: Draketrader Zlodgodd
-- Spams jump every 3s
-- Uses two Jumps. ID 733 and ID 1064
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/wotg")
-----------------------------------

function onMobSpawn(mob)
    tpz.wotg.NMMods(mob)
    mob:setMod(tpz.mod.REGAIN, 1000)
end

function onMobFight(mob, target)
    local hp = mob:getHPP()

    -- Uses Jump every 10 seconds at 50-100% HP, then every 5 seconds below 50.
    if (hp < 25) then
        mob:setMod(tpz.mod.REGAIN, 500)
    elseif (hp < 50) then
        mob:setMod(tpz.mod.REGAIN, 1500)
    else
        mob:setMod(tpz.mod.REGAIN, 1000)
    end

    mob:addListener("WEAPONSKILL_STATE_EXIT", "ZLOD_WS_STATE_EXIT", function(mob, skill)
        local lastSkillTime = mob:getLocalVar("lastSkillTime")
        local currentTime = os.time()

        -- Ensure at least 3 seconds has passed since the last skill was processed
        if (currentTime - lastSkillTime >= 3) then
            if skill == tpz.mob.skills.JUMP then
                mob:setLocalVar("jumps", mob:getLocalVar("jumps") + 1)
            elseif skill == tpz.mob.skills.JUMP_LONG_CAST then
                mob:setLocalVar("jumps", 0)
            end

            -- Apply the "Fly high" status effect
            mob:addStatusEffectEx(tpz.effect.TOO_HIGH, 0, 1, 0, 5)
        
            -- Update the last skill time
            mob:setLocalVar("lastSkillTime", currentTime)
        end
    end)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.MagianT4(mob, player, isKiller, noKiller)
end

function onMobWeaponSkillPrepare(mob, target)
    local jumps = mob:getLocalVar("jumps")

    if (jumps >= 2) then
        return tpz.mob.skills.JUMP_LONG_CAST
    else
        return tpz.mob.skills.JUMP
    end
end

function onMobDespawn(mob)
    mob:setRespawnTime(7200) -- 2 hours
end
