-----------------------------------
-- Area: Sacrarium
--   NM: Keremet
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setDamage(75)
    mob:addMod(tpz.mod.MATT, 100)
    mob:addMod(tpz.mod.DEFP, 20) 
    mob:addMod(tpz.mod.ATTP, 25)
    mob:setMod(tpz.mod.REFRESH, 40)
end

function onMobFight(mob, target)

    local Keremet = mob:getID()

    -- Send spawned skeleton "pets" to Keremet's target

    for i = Keremet+1, Keremet+12 do
        local m = GetMobByID(i)
        if m:getCurrentAction() == tpz.act.ROAMING then
            m:updateEnmity(target)
        end
    end

end

function onMobDeath(mob, player, isKiller, noKiller)
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.THE_SECRETS_OF_WORSHIP and player:getCharVar("PromathiaStatus") == 3 and  player:hasKeyItem(tpz.ki.RELIQUIARIUM_KEY)==false) then
        player:setCharVar("PromathiaStatus", 4)
    end
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(1200, 1800)) -- 20 to 30 minutes
end
