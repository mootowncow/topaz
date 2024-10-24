-----------------------------------
-- Area: Boneyard Gully
--  Mob: Race Runner
--  ENM: Like the Wind
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/titles")
-----------------------------------

local path =
{
    -539, 0, -481,
    -556, 0, -478,
    -581, 0, -475,
    -579, -3, -460,
    -572, 2, -433,
    -545, 1, -440,
    -532, 0, -466
}

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.MDEF, 70)
    mob:setMod(tpz.mod.UDMGMAGIC, -25)
    mob:addImmunity(tpz.immunity.SLEEP)
    mob:addImmunity(tpz.immunity.SILENCE)
    mob:addImmunity(tpz.immunity.GRAVITY)
    mob:addImmunity(tpz.immunity.BIND)
    mob:addImmunity(tpz.immunity.LIGHTSLEEP)
    mob:addImmunity(tpz.immunity.ELEGY)
    onMobRoam(mob)
end

function onMobRoamAction(mob)
    tpz.path.patrol(mob, path, tpz.path.flag.REVERSE)
end

function onMobRoam(mob)
    if not mob:isFollowingPath() then
        mob:pathThrough(tpz.path.first(path))
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end
