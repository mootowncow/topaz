-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--   NM: Doomed Pilgrims
-----------------------------------
local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------
local auraParams = {
    radius = 10,
    effect = tpz.effect.GEO_POISON,
    power = 20,
    duration = 60,
    auraNumber = 1
}
function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobFight(mob, target)
    local battletime = mob:getBattleTime()
    local twohourTime = mob:getLocalVar("twohourTime")
    local wingsTime = mob:getLocalVar("wingsTime")
    local wingsDown = mob:getLocalVar("wingsDown")
    local auraTimer = mob:getLocalVar("auraTimer")

    if twohourTime == 0 then
        printf("Setting forced Stinking Gas time");
        mob:setLocalVar("twohourTime", math.random(60, 120))
    elseif battletime >= twohourTime and wingsDown == 0 then
        printf("Aura on");
        mob:useMobAbility(489) -- stinking gas
        mob:setLocalVar("wingsTime", battletime + 10)
        mob:setLocalVar("wingsDown", 1)
    end

    if battletime >= wingsTime and wingsDown == 1 then
        printf("Reset forced Stinking Gas time");
        mob:setLocalVar("twohourTime", battletime + math.random(50, 110))
        mob:setLocalVar("wingsTime", 0)
        mob:setLocalVar("wingsDown", 0)
    end

    TickMobAura(mob, target, auraParams)
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 489 then -- stinking gas
        AddMobAura(mob, target, auraParams)
    end
end


function onMobDisengage(mob)
    DespawnMob(mob:getID(), 120)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller then
        GetNPCByID(ID.npc.CERMET_HEADSTONE):setLocalVar("cooldown", os.time() + 900)
    end
end
