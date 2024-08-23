-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--   ANNM
--   Involved in: Amaranth
--  !addkeyitem GREEN_LABELED_CRATE
-----------------------------------
require("scripts/globals/annm")
require("scripts/globals/status")
-----------------------------------
function onMobSpawn(mob)
    local amaranth = GetMobByID(17170650)
    local pos = amaranth:getPos()
    mob:pathTo(pos.x, pos.y, pos,z)
end

function onMobFight(mob, target)
    local amaranth = GetMobByID(17170650)
    local pos = amaranth:getPos()
    mob:pathTo(pos.x, pos.y, pos,z)
end

function onMobDeath(mob, player, isKiller, noKiller)
    local amaranth = GetMobByID(17170650)
    local level = amaranth:getMainLvl()
    amaranth:useMobAbility(tpz.mob.skills.LEVEL_UP, amaranth)
    amaranth:setMobLevel(level +1)
end

function onMobDespawn(mob)
end
