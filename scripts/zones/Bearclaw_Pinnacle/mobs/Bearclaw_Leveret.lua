-----------------------------------
-- Area: Bearclaw Pinnacle
--  Mob: Bearclaw Leveret
--  ENM: Follow The White Rabbit
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Bearclaw_Pinnacle/IDs")
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.EEM_DARK_SLEEP, 25)
    mob:setMod(tpz.mod.EEM_LIGHT_SLEEP, 5)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.SUPERLINK , 0)
end

function onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    local battlefield = mob:getBattlefield()
    local RandomRabit = battlefield:getLocalVar("RandomRabit")
    if mob:getID() == RandomRabit then
        mob:showText(mob, ID.text.MORNING_MIST)
        for v = 16801797, 16801801, 1 do
            DespawnMob(v)
        end
    end

    local Rabbit = GetMobByID(16801796)
    if not Rabbit:isDead() then
        Rabbit:setMod(tpz.mod.REGEN, 300)
    end
end
