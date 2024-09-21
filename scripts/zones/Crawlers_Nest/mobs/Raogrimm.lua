-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Raogrimm
-- Note: Monk mythic weapon fight
-- !spawnmob 17584514
-----------------------------------
local ID = require("scripts/zones/Crawlers_Nest/IDs")
require("scripts/globals/mobs")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/magic")
require("scripts/globals/utils")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobSpawn(mob)
    SetGenericNMStats(mob)
end

function onMobEngaged(mob, target)
    mob:setLocalVar("KOTimer", os.time() + 45)
end

function onMobFight(mob, target)
    local tp = mob:getTP()
    local KOTimer = mob:getLocalVar("KOTimer")
    local enmityList = mob:getEnmityList()
    local KOTarget

    -- Picks a target target, draws them in, then sets their HP to 1 and gives them weakness for 30 seconds
    for _, enmity in ipairs(enmityList) do
        if enmityList and #enmityList > 0 then
            if mob:getCurrentAction() ~= tpz.action.MOBABILITY_START and mob:getCurrentAction() ~= tpz.action.MOBABILITY_USING and
                mob:actionQueueEmpty() and (tp < 1000) then 
                if (os.time() >= KOTimer) then
                    local randomTarget = enmityList[math.random(1,#enmityList)];
                    entityId = randomTarget.entity:getID();
                    if (entityId > 10000) then -- ID is a mob(pet) then
                        KOTarget = GetMobByID(entityId)
                    else
                        KOTarget = GetPlayerByID(entityId)
                    end
                    if not GetPlayerByID(KOTarget):isDead() then
                        mob:setLocalVar("KOTimer", os.time() + 60)
                        ForceDrawIn(mob, KOTarget)
                        GetPlayerByID(KOTarget):addStatusEffect(tpz.effect.BIND, 1, 0, 10)
                        mob:useMobAbility(3, GetPlayerByID(KOTarget)) -- One Inch Punch
                        utils.MessageParty(target, "You got knocked the $^(!@*^ out!", 0, "Raogrimm")
                    end
                end
            end
        end
    end

    -- Handle One Inch Punch being interrupted
    mob:addListener("WEAPONSKILL_STATE_INTERRUPTED", "RAOGRIMM_WS_INTERRUPTED", function(mob, skill)
        if skill == 3 then
            mob:setLocalVar("KOTimer", 1)
        end
    end)
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller, noKiller)
    OnDeathMessage(mob, player, isKiller, noKiller, "I...return....to...the...crystal...once...again.....", 0, "Raogrimm")
end

function onMobDespawn(mob)
end