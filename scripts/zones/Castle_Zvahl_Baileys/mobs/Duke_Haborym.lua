-----------------------------------
-- Area: Castle Zvahl Baileys (161)
--   NM: Duke Haborym
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.UDMGPHYS, 200)
    mob:setMod(tpz.mod.UDMGRANGE, 200)
    mob:setMod(tpz.mod.UDMGMAGIC, 200)
    mob:setMod(tpz.mod.DMGBREATH, 200)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
    mob:addImmunity(tpz.immunity.SLEEP)
    mob:addImmunity(tpz.immunity.GRAVITY)
    mob:addImmunity(tpz.immunity.BIND)
    mob:addImmunity(tpz.immunity.SILENCE)
end

function onMobFight(mob, target)
    local hitTrigger = mob:getLocalVar("TriggerHit")

    if mob:getHPP() <= 10 and hitTrigger == 0 then
        local zonePlayers = mob:getZone():getPlayers()
        for _, zonePlayer in pairs(zonePlayers) do
            zonePlayer:PrintToPlayer("I'm done playing games with you.",0,"Haborym")
        end
        mob:useMobAbility(2110) -- Wings Of Gehenna
        mob:setHP(30000)
        mob:setModelId(1845) -- Vampyr
        mob:setDamage(25)
        mob:setMod(tpz.mod.MDEF, 20)
        mob:setMod(tpz.mod.UDMGPHYS, -50)
        mob:setMod(tpz.mod.UDMGRANGE, 0)
        mob:setMod(tpz.mod.UDMGMAGIC, -38)
        mob:setMod(tpz.mod.DMGBREATH, -50)
        mob:setMod(tpz.mod.SDT_FIRE, 85)
        mob:setMod(tpz.mod.SDT_ICE, 50)
        mob:setMod(tpz.mod.SDT_WIND, 60)
        mob:setMod(tpz.mod.SDT_EARTH, 60)
        mob:setMod(tpz.mod.SDT_THUNDER, 85)
        mob:setMod(tpz.mod.SDT_WATER, 85)
        mob:setMod(tpz.mod.SDT_LIGHT, 115)
        mob:setMod(tpz.mod.SDT_DARK, 5)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 6027)
        mob:setLocalVar("TriggerHit", 1)
    end
    if hitTrigger == 1 then
        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.BLOOD_WEAPON, cooldown = math.random(60, 90), hpp = 90},
            },
        })
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)

    -- Set Duke_Haborym's spawnpoint and respawn time (21-23 hours)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(36000, 43200))
end
