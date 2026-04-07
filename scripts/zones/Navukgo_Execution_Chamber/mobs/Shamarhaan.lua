-----------------------------------
-- Area: Navukgo Execution Chamber
-- MOB: Shamarhaan
-----------------------------------
local ID = require("scripts/zones/Navukgo_Execution_Chamber/IDs")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobInitialize(mob)
    mob:addListener("WEAPONSKILL_TAKE", "SHAMARHAAN_WEAPONSKILL_TAKE", function(target, attacker, skillId, tp, action)
        target:messageText(target, ID.text.SHAMARHAAN_UNDERESTIMATED)
    end)

    mob:addListener("WEAPONSKILL_USE", "SHAMARHAAN_WEAPONSKILL_USE", function(mob, target, wsid, tp, action)
        mob:messageText(mob, ID.text.SHAMARHAAN_TRICKS)
    end)
end

function onMobSpawn(mob)
    mob:addMod(tpz.mod.DEFP, 20) 
    mob:addMod(tpz.mod.ATTP, 10)
    mob:addMod(tpz.mod.ACC, 10) 
    mob:addMod(tpz.mod.EVA, 10)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {
                id = tpz.jsa.OVERDRIVE_SHAMARHAAN, hpp = 90,
                begCode = function(mob)
                    mob:messageText(mob, ID.text.SHAMARHAAN_FULL_STEAM)
                end,
            },
        },
    })
end

function onMobRoam(mob)
    if mob:getLocalVar("engaged") == 0 then
        for _, player in pairs(mob:getBattlefield():getPlayers()) do
            if player:checkDistance(mob) < 15 then
                mob:messageText(mob, ID.text.SHAMARHAAN_LET_US_BEGIN)
                mob:setLocalVar("engaged", player:getID())
            end
        end
    end
end

function onMobEngaged(mob, target)
    if mob:getLocalVar("engaged") == 0 then
        mob:messageText(mob, ID.text.SHAMARHAAN_LET_US_BEGIN)
        mob:setLocalVar("engaged", target:getID())
    end
end

function onMobDisengage(mob)
    engagedID = mob:getLocalVar("engaged")
    if engagedID ~= 0 then
        player = GetPlayerByID(engagedID)
        if player:getHP() == 0 then
            mob:showText(mob, ID.text.SHAMARHAAN_NOT_READY)
        end
    end
end

function onMobFight(mob,target)
    -- TODO: Shamarhaan regularly (roughly once a minute) does Maneuvers which appear to slightly change Valkeng's behavior

    if mob:getHPP() < 20 then
        mob:showText(mob, ID.text.SHAMARHAAN_MAGNIFICENT)
        mob:getBattlefield():win()
    end

    local hitTrigger = mob:getLocalVar("TriggerHit")

    if mob:getHPP() <= 100 and hitTrigger == 0 then
        mob:setMod(tpz.mod.REGAIN, 250)
        mob:setLocalVar("TriggerHit", 1)
    end
    if mob:getHPP() <= 50 and hitTrigger == 1 then
        mob:setMod(tpz.mod.REGAIN, 500)
        mob:setLocalVar("TriggerHit", 2)
    end
    if mob:getHPP() <= 30 and hitTrigger == 2 then
        mob:setMod(tpz.mod.REGAIN, 1000)
        mob:setLocalVar("TriggerHit", 3)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    mob:messageText(mob, ID.text.SHAMARHAAN_MAGNIFICENT)
end
