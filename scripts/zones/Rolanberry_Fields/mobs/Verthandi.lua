-----------------------------------
-- Area: Rolanberry Fields
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
    local lastTPMove = mob:getLocalVar("lastTPMove")
    -- TODO: on
    local moveList = {
        { last = tpz.mob.skills.SPRING_BREEZE, tpMoveList = { tpz.mob.skills.CYCLONIC_TURMOIL, tpz.mob.skills.LETHE_ARROWS } },
        { last = tpz.mob.skills.SUMMER_BREEZE, tpMoveList = { tpz.mob.skills.CYCLONIC_TORRENT, tpz.mob.skills.ZEPHYR_ARROW } },
        { last = tpz.mob.skills.AUTUMN_BREEZE, tpMoveList = { tpz.mob.skills.NORN_ARROWS, tpz.mob.skills.CYCLONIC_TORRENT } },
        { last = tpz.mob.skills.WINTER_BREEZE, tpMoveList = { tpz.mob.skills.LETHE_ARROWS, tpz.mob.skills.ZEPHYR_ARROW } },
        { last = tpz.mob.skills.NORN_ARROWS,   tpMoveList = { tpz.mob.skills.CYCLONIC_TURMOIL, tpz.mob.skills.CYCLONIC_TORRENT } },
    }

    for _, tpMoves in pairs(moveList) do
        if lastTPMove == tpMoves.last then
            local list = tpMoves.tpMoveList
            local randomMove = list[math.random(#list)]
            return randomMove
        end
    end
end

function onMonsterMagicPrepare(mob, target)
    -- Casts Holy II, Protect V, Shell V, Erase and Stoneskin
    local rng = math.random()
    if (rng < 0.5) then
        return tpz.magic.spell.HOLY_II
    end

    if (rng < 0.7) then
        if utils.hasDispellableEffect(mob) then
            return tpz.magic.spell.ERASE
        end
     end

    if not mob:hasStatusEffect(tpz.effect.PROTECT) then
        return tpz.magic.spell.PROTECT_V
    elseif not mob:hasStatusEffect(tpz.effect.SHELL) then
        return tpz.magic.spell.SHELL_V
    elseif not mob:hasStatusEffect(tpz.effect.STONESKIN) then
        return tpz.magic.spell.STONESKIN
    end

    return 0 -- Still need a return, so use 0 when not casting
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