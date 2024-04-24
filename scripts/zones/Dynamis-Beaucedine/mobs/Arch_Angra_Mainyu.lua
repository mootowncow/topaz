-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Arch Angra Mainyu
-- Note: Mega Boss
-- ID: 17326081
-- TODO: Not coded
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/dynamis")
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
     mob:addMod(tpz.mod.DEFP, 25) 
     mob:addMod(tpz.mod.ATTP, 25)
     mob:addMod(tpz.mod.ACC, 50) 
     mob:addMod(tpz.mod.EVA, 15)
     mob:setMod(tpz.mod.REFRESH, 300)
     
end

function onMobEngaged(mob, target)
    mob:setLocalVar("teleport", 0)
end

function onMobFight(mob, target)
    -- If gravity was just cast, teleport away
    if mob:getLocalVar("teleport") > 0 and mob:getCurrentAction() ~= tpz.action.MAGIC_CASTING then 
        mob:setLocalVar("teleport", 0)
        TeleportMob(mob, 2000)
        mob:timer(2000, function(mob)
		    mob:setPos(mob:getXPos() + positions[math.random(#positions)][1], mob:getYPos(), mob:getZPos() + positions[math.random(#positions)][2])
        end)
    end

    -- If he casted graviga, enable teleporting
    mob:addListener("MAGIC_STATE_EXIT", "ANGRA_MAGIC_STATE_EXIT", function(mob, spell)
        local spell = spell:getID()
        if (spell == 366) then -- Graviga
            mob:setLocalVar("teleport", 1)
        end
    end)
end

function onMonsterMagicPrepare(mob, target)
    if mob:getHPP() <= 25 then
        return 367 -- Death
    else
        -- Can cast Blindga, Slowga, Dispelga, Graviga, Silencega, and Sleepga II and Death.
        -- Casts Graviga every time before he teleports.
        local rnd = math.random()

        if rnd < 0.2 then
            return 361 -- Blindga
        elseif rnd < 0.3 then
            return 366 -- Graviga
        elseif rnd < 0.4 then
            return 359 -- Silencega
        elseif rnd < 0.6 then
            return 360 -- Dispelga
        elseif rnd < 0.8 then
            return 357 -- Slowga
        elseif rnd < 0.9 then
            return 274 -- Sleepga II
        else
            return 367 -- Death
        end
    end
end

function onMobDespawn(mob)
    OnBattleEndConfrontation(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    dynamis.megaBossOnDeath(mob, player, isKiller)
    OnBattleEndConfrontation(mob)
end
