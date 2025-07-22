-----------------------------------
-- Area: Sauromugue_Champaign [S]
--  Mob: Gouger Beetle
-- Note: JP camp
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------
function onMobInitialize(mob)
    mob:setMod(tpz.mod.DMGMAGIC, 25)
    mob:setMobMod(tpz.mobMod.CAPACITY_BONUS, 200)
end

function onMobSpawn(mob)
    -- 5% chance to fulll restore MP/HP or party members at 1% HP(basically death)
    if (math.random(100) <= 5) then
        mob:setLocalVar("restoreProc", 1)
    end

    SetJPMobStats(mob)
end

function onMobFight(mob, target)
    local restoreProc = mob:getLocalVar("restoreProc")

    if (restoreProc == 1) then -- Var randomed on spawn
        mob:setUnkillable(true) -- Removed after restoring players HP or MP
    end

    if (mob:getHPP() < 2) and (restoreProc == 1) then
        if (mob:checkDistance(target) <= 30) then
            mob:useMobAbility(math.random(1124, 1125)) -- Heal MP or HP
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end
