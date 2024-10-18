------------------------------
-- Area: Bearclaw Pinnacle
--   Mob: Snow Devil
--   Job: WAR
-- ENM:  When Hell Freezes Over
------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/hunts")
require("scripts/globals/status")
require("scripts/globals/mobs")
------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.EEM_LIGHT_SLEEP, 25)
    mob:setMod(tpz.mod.EEM_DARK_SLEEP, 25)
    mob:setMobMod(tpz.mobMod.AGGRO_SOUND, 1)
	mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 40)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 40)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:addImmunity(tpz.immunity.SILENCE)
    if mob:getID() == 16801826 then -- Don't let the mob holding the chest closed move or try to attack
        mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
        mob:SetAutoAttackEnabled(false)
        mob:SetMobAbilityEnabled(false)
    end
end

function onMobFight(mob, target)
    local battlefield = mob:getBattlefield()
    local bfmobs = battlefield:getMobs(true, true)
    for _, mobs in pairs(bfmobs) do
        if mobs:getID() ~= 16801826 then -- Holds the chest
            mobs:updateEnmity(target)
        end
    end
end

function onMobEngaged(mob, target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    local battlefield = mob:getBattlefield()
    local SnowDevilWaves = battlefield:getLocalVar("SnowDevilWaves")
    -- Despawn mob holding chest closed until all waves are cleared
    if isKiller or noKiller then
        if SnowDevilWaves >= 4 and GetMobByID(16801834):isDead() and GetMobByID(16801835):isDead() and GetMobByID(16801836):isDead() and
        GetMobByID(16801837):isDead() then
            DespawnMob(16801826)
        end
        if mob:getID() == 16801834 then -- "Main" wave Snoll only increases wave counter
            -- Increase wave counter
            battlefield:setLocalVar("SnowDevilWaves", SnowDevilWaves + 1)
            --printf("%u", SnowDevilWaves)
        end
    end
end

function onMobDespawn(mob)
    local battlefield = mob:getBattlefield()
    local SnowDevilWaves = battlefield:getLocalVar("SnowDevilWaves")
    -- Despawn mob holding chest closed until all waves are cleared
    if SnowDevilWaves >= 4 and GetMobByID(16801834):isDead() and GetMobByID(16801835):isDead() and GetMobByID(16801836):isDead() and
    GetMobByID(16801837):isDead() then
        DespawnMob(16801826)
    end
    if SnowDevilWaves == 4 then return end -- Don't spawn anymore mobs after 4 waves
    -- Spawn next wave of snolls
    if GetMobByID(16801834):isDead() and GetMobByID(16801835):isDead() and GetMobByID(16801836):isDead() and
    GetMobByID(16801837):isDead() then
        battlefield:setLocalVar("SnowDevilSpawns", math.random(0,3))
        local SnowDevilSpawns = battlefield:getLocalVar("SnowDevilSpawns")
        for v = 16801818, 16801818 + SnowDevilSpawns, 1 do
            GetMobByID(v):spawn()
        end
    end
end