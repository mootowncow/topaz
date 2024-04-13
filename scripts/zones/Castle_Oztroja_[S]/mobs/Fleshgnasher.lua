-----------------------------------
-- Area: Castle Oztroja [S]
--   NM: Fleshgnasher
-- THF/THF
-- Immune to Sleep, Bind, Gravity, Break
-- 150 Regain
-- 2s delay(half normal mobs)
-- 100% - > 33% HP uses
-- Uses: Pandemic Nip, Insipid Nip, Cimicine Discharge, Bombilation
-- Uses(Below 33%): Emetic Discharge and the above.
-- Uses Perfect Dodge sometime below 50% HP
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/wotg")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    tpz.wotg.NMMods(mob)
end

function onMobFight(mob, target)
    --mob:setMod(tpz.mod.REGAIN, 150)
end

function onMobWeaponSkillPrepare(mob, target)
    local tpMoves = {2158, 2159, 2160, 2161}
    --   Insipid Nip, Pandemic Nip, Bombilation, Cimicine Discharge
    local tpMoves2 = {2158, 2159, 2160, 2161, 2162}
    --   Insipid Nip, Pandemic Nip, Bombilation, Cimicine Discharge, Emetic Discharge
    local hp = mob:getHPP()

    if (hp < 33) then
        return tpMoves2[math.random(#tpMoves2)]
    else
        return tpMoves[math.random(#tpMoves)]
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.MagianT4(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(7200) -- 2 hours
end
