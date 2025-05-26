-----------------------------------
-- Area: Walk of Echoes
--  Mob: Cait Sith
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Walk_of_Echoes/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/utils")
-----------------------------------
local function MsgSpecial(mob, target, msgId)
    local NearbyPlayers = mob:getPlayersInRange(50)
    if NearbyPlayers then
        for _, player in ipairs(NearbyPlayers) do
            if player:isPC() then
                player:messageSpecial(msgId)
            end
        end
    end
end

function onMobInitialize(mob)
end

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.UDMGMAGIC, -50)
    mob:setMod(tpz.mod.UDMGBREATH, -50)
    mob:setMod(tpz.mod.LIGHT_ABSORB, 100)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)

    tpz.mix.jobSpecial.config(mob, {
        chance = 100,
        specials =
        {
            { id = tpz.jsa.CHAINSPELL, hpp = math.random(25, 50) },
        },
    })
end

function onMobEngaged(mob, target)
    mob:getLocalVar("tauntMsgTimer", os.time() + 45)
    if target then
        MsgSpecial(mob, target, ID.text.CAIT_ENGAGE)
    end
end

function onMobFight(mob, target)
    local tauntMsgs = { ID.text.CAIT_TAUNT1, ID.text.CAIT_TAUNT2 }
    local tauntMsgTimer = mob:getLocalVar("tauntMsgTimer")
    local lowHPMsgSeen = mob:getLocalVar("lowHPMsgSeen")
    local divineFavorTimer = mob:getLocalVar("divineFavorTimer")
    local hpp = mob:getHPP()

    -- Uses Divine Favor to cleanse it's debuffs off every 30 seconds
    if (os.time() >= divineFavorTimer) and utils.hasDispellableEffect(mob) then
        mob:useMobAbility(tpz.mob.skills.DIVINE_FAVOR, mob)
        mob:setLocalVar("divineFavorTimer", os.time() + 30)
    end

    -- Tauts the players every ~90s
    if os.time() >= tauntMsgTimer then
        if target then
            MsgSpecial(mob, target, tauntMsgs[math.random(#tauntMsgs)])
        end
        mob:setLocalVar("tauntMsgTimer", os.time() + 90)
    end

    -- Displays a message at low HP
    if (hpp < 10) and (lowHPMsgSeen == 0) then
        if target then
            MsgSpecial(mob, target, ID.text.CAIT_LOWHP)
        end
        mob:setLocalVar("lowHPMsgSeen", 1)
    end

    -- Displays a message when activating Chainspell
    mob:addListener("WEAPONSKILL_STATE_EXIT", "CAITSITH_MOBSKILL_FINISHED", function(mob, skillId)
        local target = mob:getTarget()
        if target and (skillId == tpz.jsa.CHAINSPELL) then
            MsgSpecial(mob, target, ID.text.CAIT_CHAINSPELL)
        end
    end)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        MsgSpecial(mob, target, ID.text.CAIT_DEAD)
    end
end