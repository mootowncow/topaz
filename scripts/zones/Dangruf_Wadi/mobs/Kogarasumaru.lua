------------------------------
-- Area: The Eldieme Necropolis
--   Kogarasumaru
--   !additem 18431
-- SAM Mythic weapon fight
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/titles")
require("scripts/globals/mobs")
require("scripts/globals/status")
require("scripts/globals/utils")
------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobSpawn(mob)
    SetGenericNMStats(mob)
	mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
end

function onMobEngaged(mob, target)
    mob:setLocalVar("stanceChangeTime", math.random(10, 15))
end

function onMobFight(mob, target)
    local battletime = mob:getBattleTime()
    local stanceChangeTime = mob:getLocalVar("stanceChangeTime")
    local currentStance = mob:getLocalVar("stance")
    local stance =
    {
        DPS = 1,
        Tank = 2
    }

    mob:addListener("TAKE_DAMAGE", "KOGA_TAKE_DAMAGE", function(mob, damage, attacker, attackType, damageType)
        mob:setLocalVar("damageTaken", mob:getLocalVar("damageTaken") + damage)
        if mob:getLocalVar("damageTaken") >= 2500 then
            mob:setLocalVar("dmgThreshold", 1)
        end
    end)

    -- Stance Logic
    if currentStance == stance.DPS then
        mob:setDamage(200)
        mob:setDelay(2000)
        mob:setMod(tpz.mod.COUNTER, 0)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 50)
        mob:setMod(tpz.mod.ATT, 550)
        mob:setMod(tpz.mod.UDMGPHYS, 75)
        mob:setMod(tpz.mod.UDMGMAGIC, 75)

        mob:useMobAbility(624) -- 2 hour "cloud" animation
        utils.MessageParty(target, "You cannot withstand my might!", 0, "Kogarasumaru")

        mob:setLocalVar("STANCEdps", battletime + math.random(60, 90))
        mob:setLocalVar("STANCEtank", 1)
        mob:setLocalVar("damageTaken", 0)
    elseif currentStance == stance.Tank then
        mob:setDamage(50)
        mob:setDelay(4000)
        mob:setMod(tpz.mod.ATT, 200)
        mob:setMod(tpz.mod.COUNTER, 100)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 0)
        mob:setMod(tpz.mod.UDMGPHYS, -99)
        mob:setMod(tpz.mod.UDMGMAGIC, -99)

        mob:useMobAbility(624)
        utils.MessageParty(target, "Go ahead, try and hit me", 0, "Kogarasumaru")

        mob:setLocalVar("stanceChangeTime", battletime + math.random(25, 35))
        mob:setLocalVar("STANCEdps", 0)
        mob:setLocalVar("STANCEtank", 0)
        mob:setLocalVar("dmgThreshold", 0)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    OnDeathMessage(mob, player, isKiller, noKiller, "Maybe...you...are...worthy...of...my...power...", 0, "Kogarasumaru")
end


