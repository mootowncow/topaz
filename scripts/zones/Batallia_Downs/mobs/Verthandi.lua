-----------------------------------
-- Area: Batallia Downs
--  VNM: Verthandi
-----------------------------------
require("scripts/globals/voidwalker")
-----------------------------------

function onMobInitialize(mob)
    tpz.voidwalker.onMobInitialize(mob)
end

function onMobSpawn(mob)
    tpz.voidwalker.onMobSpawn(mob)
end

function onMobFight(mob, target)
    tpz.voidwalker.onMobFight(mob, target)
end

function onMobWeaponSkillPrepare(mob, target)
    -- After using Summer Breeze: Cyclonic Turmoil and Lethe Arrows
    -- After using Autumn Breeze: Cyclonic Torrent and Zephyr Arrow.
    -- After using Winter Breeze: Norn Arrows and Cyclonic Torrent.
    -- After using Spring Breeze: Lethe Arrows and Zephyr Arrow.
    local lastTPMove = mob:getLocalVar("lastTPMove")
    local moveList =
    {
        { last = tpz.mob.skills.SPRING_BREEZE, tpMoveList = { tpz.mob.skills.CYCLONIC_TURMOIL, tpz.mob.skills.LETHE_ARROWS } },
        { last = tpz.mob.skills.SUMMER_BREEZE, tpMoveList = { tpz.mob.skills.CYCLONIC_TORRENT, tpz.mob.skills.ZEPHYR_ARROW } },
        { last = tpz.mob.skills.AUTUMN_BREEZE, tpMoveList = { tpz.mob.skills.NORN_ARROWS, tpz.mob.skills.CYCLONIC_TORRENT } },
        { last = tpz.mob.skills.WINTER_BREEZE, tpMoveList = { tpz.mob.skills.LETHE_ARROWS, tpz.mob.skills.ZEPHYR_ARROW } },
    }
    for _, tpMoves in pairs(moveList) do
        if (lastTPMove == tpMoves.last) then
            local list = tpmoves.tpMoveList;
            return list[math.random(#list)];
        end
    end
end

function onMobDisengage(mob)
    tpz.voidwalker.onMobDisengage(mob)
end

function onMobDespawn(mob)
    tpz.voidwalker.onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addTitle(tpz.title.VERTHANDI_ENSNARER)
    tpz.voidwalker.onMobDeath(mob, player, isKiller, tpz.keyItem.BLACK_ABYSSITE)
end