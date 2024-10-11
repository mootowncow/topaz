-----------------------------------
-- Area: Garlaige Citadel [S]
--   ANNM
--   NM: Khadem Quemquoma
--  !addkeyitem GREEN_LABELED_CRATE
-----------------------------------
require("scripts/globals/annm")
require("scripts/globals/status")
-----------------------------------
function onMobSpawn(mob)
    mob:SetMagicCastingEnabled(false)
    mob:setModelSize(4)
    mob:setLocalVar("hellScissors", 0)
    tpz.annm.NMMods(mob) 
end

function onMobFight(mob, target)
    local hellScissors = mob:getLocalVar("hellScissors")
    local recover = mob:getLocalVar("recover")
    local BattleTime = mob:getBattleTime()

    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)

    -- Enable casting after 45s so it won't open with a spell immediately
    if (BattleTime > 20) then
        mob:SetMagicCastingEnabled(true)
    end

    if (hellScissors == 1) then
        mob:useMobAbility(2221) -- Hell Scissors
        mob:setLocalVar("hellScissors", 0)
    end
    
    -- After using Poisonga II, he will use Hell Scissors 3 times in a row
    mob:addListener("MAGIC_USE", "KHADEM_MAGIC", function(mob, target, spell, action)
        mob:setLocalVar("hellScissors", 1)
    end)
    tpz.annm.PetShield(mob, 17449033, 17449038)
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 2221 then -- Uses hell Scissors 3 times in a row
        local tpMove = mob:getLocalVar("tpMove")

        tpMove = tpMove +1 -- Count number of times TP move was used
        mob:setLocalVar("tpMove", tpMove)

        if (tpMove > 2) then -- Use 3 times
            mob:setLocalVar("tpMove", 0)
        else
            mob:useMobAbility(2221) -- Re-use same TP move
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.annm.SpawnChest(mob, player, isKiller)
end

function onMobDespawn(mob)
end
