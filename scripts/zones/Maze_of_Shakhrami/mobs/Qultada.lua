-----------------------------------
-- Area: Maze of Shakhrami
-- Mob: Qultada
-- !spawnmob 17588801
-- Note: COR mythic weapon fight
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------
local qultada = 17588801
local engageMsg = {
    "The cards have been dealt. Now let us begin our little gamble of luck and skill.",
    "You need not go easy on me... I certainly will not go easy on you.",
    "Oho... That was a quick start.,"
}
local swordWsMsg = {
    "Ante up!",
    "Looks like things are beginning to heat up!",
}
local marksmanshipWsMsg = {
    "Let's try your luck!",
    "The luck of the corsair is a wonderful thing!",
}
local dmgTakenMsg = {
    "As luck would have it...",
    "Luck, do not fail me again...",
    "Sometimes the chips are down...",
}

function onMobInitialize(mob)
    mob:addListener("WEAPONSKILL_TAKE", "QULTADA_WEAPONSKILL_TAKE", function(target, attacker, skillId, tp, action)
        if (attacker:getID() ~= qultada) then
            utils.MessageParty(attacker, dmgTakenMsg[math.random(#dmgTakenMsg)], 0, "Qultada")
        end 
    end)

    mob:addListener("WEAPONSKILL_USE", "QULTADA_WEAPONSKILL_USE", function(mob, target, wsid, tp, action)
        if wsid == 39 or wsid == 42 then -- Sword WS
            utils.MessageParty(target, swordWsMsg[math.random(#swordWsMsg)], 0, "Qultada")
        end
        if wsid == 212 or wsid == 3253 then -- Marksmanship WS
            utils.MessageParty(target, marksmanshipWsMsg[math.random(#marksmanshipWsMsg)], 0, "Qultada")
        end
    end)
end

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setLocalVar("special_threshold", math.random(50,60))
end

function onMobRoam(mob)
end

function onMobEngaged(mob, target)
    utils.MessageParty(target, engageMsg[math.random(#engageMsg)], 0, "Qultada")
    mob:setLocalVar("engaged", target:getID())
    mob:setLocalVar("quick_draw", os.time() + math.random(5, 10))
    mob:setLocalVar("wild_card", os.time() + math.random(45, 60))
end

function onMobDisengaged(mob)
    engagedID = mob:getLocalVar("engaged")
    if engagedID ~= 0 then
        player = GetPlayerByID(engagedID)
        if player:getHP() == 0 then
            mob:showText(mob, ID.text.QULTADA_DENT_MY_TRICORNE)
            utils.MessageParty(player, "You could not put a dent in my tricorne with attacks like that. Better luck next time.", 0, "Qultada")
        end
    end
end

function onMobFight(mob, target)
    if mob:getLocalVar("quick_draw") <= os.time() and not IsMobBusy(mob) then
        -- Randomly use one of the Quick Draw shots
        mob:useMobAbility(2009 + math.random(0, 7), target)
        utils.MessageParty(target, "Think you can get away?", 0, "Qultada")
        mob:setLocalVar("quick_draw", os.time() + math.random(30, 40))
    end

    if (mob:getHPP() < 95) then
        -- Uses Wild Card every 45-60s
        if mob:getLocalVar("wild_card") <= os.time() and not IsMobBusy(mob) then
            utils.MessageParty(target, "Behold my trump card... Time for you to fold!", 0, "Qultada")
            mob:useMobAbility(tpz.jsa.WILD_CARD_QULTADA)
            mob:setLocalVar("wild_card", os.time() + math.random(45, 60))
        end
    end

    if mob:getLocalVar("dialog") == 1 and mob:getBattleTime() >= 120 then
        utils.MessageParty(target, "Too bad. I was hoping for a bit more excitement.", 0, "Qultada")
        mob:setLocalVar("dialog", 2)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    utils.MessageParty(player, "Not bad...", 0, "Qultada")
end

function onMobWeaponSkill(target, mob, skill, action)
    if skill:getID() == 114 then -- Doesn't work
        -- Currently only made to be used with Qultada in Breaking the Bonds of Fate (COR Limit Break)
        -- It is unclear if this has any effect whatsoever so for now it is just used for animations and speech
        local roll = math.random(1, 6)
        local previousRoll = mob:getLocalVar("corsairRollTotal")
        action:speceffect(mob:getID(), roll)
        roll = roll + previousRoll
        mob:setLocalVar("corsairRollTotal", roll)
        return roll
    elseif skill:getID() == tpz.jsa.WILD_CARD_QULTADA then
        -- It appears that Qultada always rolls a 4 which grants 3000TP and resets Job Abilities
        engagedID = mob:getLocalVar("engaged")
        if engagedID ~= 0 then
            player = GetPlayerByID(engagedID)
            utils.MessageParty(player, "Ha! Lady Luck, stay with me!", 0, "Qultada")
        end
        mob:addTP(3000)
        mob:setLocalVar("quick_draw", os.time() + 3)
        return 0
    end
end
