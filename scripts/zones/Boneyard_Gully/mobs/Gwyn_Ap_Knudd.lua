------------------------------
-- Area: Boneyard Gully
--   NM: Gwyn Ap Knudd
--  ENM: Totentanz
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
require("scripts/globals/mobs")
------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.MATT, 272)
    mob:setMod(tpz.mod.MDEF, 140)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 25)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 25)
    mob:addImmunity(tpz.immunity.SLEEP)
    mob:addImmunity(tpz.immunity.GRAVITY)
    mob:addImmunity(tpz.immunity.BIND)
    mob:addImmunity(tpz.immunity.LIGHTSLEEP)
end

function onMobFight(mob, target)
    local SummonTime = mob:getLocalVar("SummonTime")
    local BattleTime = mob:getBattleTime()

    if SummonTime == 0 then
        mob:setLocalVar("SummonTime", BattleTime + math.random(10, 25))
        return
    end

    if BattleTime >= SummonTime then
        for i = 1, 10 do -- Roll 10 times, summon first available pet not currently spawned
            local pet = GetMobByID(mob:getID() + math.random(1, 9))
            if not pet:isSpawned() then
                pet:setSpawn(
                    mob:getXPos() + math.random(3, 6),
                    mob:getYPos(),
                    mob:getZPos() + math.random(3, 6)
                )
                pet:spawn()
                pet:updateEnmity(mob:getTarget())
                break
            end
        end

        mob:setLocalVar("SummonTime", BattleTime + 45)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    for v = mob:getID()+1, mob:getID()+9, 1 do
        DespawnMob(v)
    end
end
