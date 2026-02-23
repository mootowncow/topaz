-----------------------------------
-- Area: King Ranperre's Tomb
--   NM: Vrtra
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
	mob:setDamage(250)
    mob:setMod(tpz.mod.ATT, 870)
    mob:setMod(tpz.mod.DEF, 536)
    mob:setMod(tpz.mod.EVA, 356)
    mob:setMod(tpz.mod.UDMGMAGIC, -40)
    mob:setMod(tpz.mod.UDMGBREATH, -40)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 25)
    mob:setMod(tpz.mod.REGEN, 30)
    mob:setMod(tpz.mod.UFASTCAST, 50) 
    mob:setMod(tpz.mod.REFRESH, 400)
    mob:addMod(tpz.mod.MATT, 100)
	mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
	mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 30)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
end

local offsets = {1, 3, 5, 2, 4, 6}

function onMobEngaged(mob, target)
    mob:resetLocalVars()
end

function onMobFight(mob, target)
    local spawnTime = mob:getLocalVar("spawnTime")
    local twohourTime = mob:getLocalVar("twohourTime")
    local fifteenBlock = mob:getBattleTime() / 15

    if twohourTime == 0 then
        twohourTime = math.random(4, 6)
        mob:setLocalVar("twohourTime", twohourTime)
    end

    if spawnTime == 0 then
        spawnTime = math.random(3, 5)
        mob:setLocalVar("spawnTime", spawnTime)
    end

    if fifteenBlock > twohourTime then
        mob:useMobAbility(710)
        mob:setLocalVar("twohourTime", fifteenBlock + math.random(4, 6))
    elseif fifteenBlock > spawnTime then
        local mobId = mob:getID()

        for i, offset in ipairs(offsets) do
            local pet = GetMobByID(mobId + offset)

            if not pet:isSpawned() then
                pet:spawn(60)
                local pos = mob:getPos()
                pet:setPos(pos.x, pos.y, pos.z)
                pet:updateEnmity(target)
                break
            end
        end
        mob:setLocalVar("spawnTime", fifteenBlock + 4)
    end
end

function onMobDisengage(mob, weather)
    for i, offset in ipairs(offsets) do
        DespawnMob(mob:getID()+offset)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addTitle(tpz.title.VRTRA_VANQUISHER)
end

function onMobDespawn(mob)
    -- Set Vrtra's spawnpoint and respawn time (3-5 days)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(259200, 432000))
end
