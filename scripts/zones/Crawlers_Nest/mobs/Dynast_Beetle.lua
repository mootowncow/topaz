-----------------------------------
-- Area: Crawlers' Nest (197)
--   NM: Dynast Beetle
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
require("scripts/globals/raid")
------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
    mob:setMobMod(tpz.mobMod.CAN_PARRY, 1)
end

function onMobSpawn(mob)
	mob:setDamage(140)
    mob:setMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.DEFP, 25) 
    mob:addMod(tpz.mod.EVA, 15)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 50)
    mob:setMod(tpz.mod.STORETP, 100)
    mob:setMod(tpz.mod.ENEMYCRITRATE, -33)
    mob:setMod(tpz.mod.CRIT_DEF_BONUS, 8)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)

    for elementResist = tpz.mod.FIRERES, tpz.mod.DARKRES do
        mob:addMod(elementResist, 100)
    end
end

function onMobFight(mob, target)
    local currentHP = mob:getHPP()
    local phaseData = {
        { HP = 10,     Var = 'randomItem_10'   },
        { HP = 20,     Var = 'randomItem_20'   },
        { HP = 30,     Var = 'randomItem_30'   },
        { HP = 40,     Var = 'randomItem_40'   },
        { HP = 50,     Var = 'randomItem_50'   },
        { HP = 60,     Var = 'randomItem_60'   },
        { HP = 70,     Var = 'randomItem_70'   },
        { HP = 80,     Var = 'randomItem_80'   },
        { HP = 90,     Var = 'randomItem_90'   },
    }
    local items =
    {
        tpz.items.LUCID_POTION_I, tpz.items.LUCID_POTION_II, tpz.items.LUCID_POTION_III,
        tpz.items.LUCID_ELIXIR_I, tpz.items.LUCID_ELIXIR_II, tpz.items.DUSTY_ELIXIR,
        tpz.items.BOTTLE_OF_STALWARTS_TONIC, tpz.items.BOTTLE_OF_STALWARTS_GAMBIR,
        tpz.items.BOTTLE_OF_ASCETICS_TONIC, tpz.items.BOTTLE_OF_ASCETICS_GAMBIR,
        tpz.items.BOTTLE_OF_CHAMPIONS_TONIC, tpz.items.BOTTLE_OF_CHAMPIONS_GAMBIR,
        tpz.items.BOTTLE_OF_FANATICS_DRINK, tpz.items.BOTTLE_OF_FOOLS_DRINK,
        tpz.items.BOTTLE_OF_FANATICS_TONIC, tpz.items.BOTTLE_OF_FOOLS_TONIC,
        tpz.items.PINCH_OF_FANATICS_POWDER, tpz.items.PINCH_OF_FOOLS_POWDER,
        tpz.items.BOTTLE_OF_BERSERKERS_DRINK,tpz.items.BOTTLE_OF_BERSERKERS_TONIC,
        tpz.items.BOTTLE_OF_BARBARIANS_DRINK, tpz.items.BOTTLE_OF_FIGHTERS_DRINK, tpz.items.BOTTLE_OF_ORACLES_DRINK,
        tpz.items.BOTTLE_OF_ASSASSINS_DRINK, tpz.items.BOTTLE_OF_SPYS_DRINK, tpz.items.BOTTLE_OF_BRAVERS_DRINK,
        tpz.items.BOTTLE_OF_SOLDIERS_DRINK, tpz.items.BOTTLE_OF_CHAMPIONS_DRINK, tpz.items.BOTTLE_OF_MONARCHS_DRINK,
        tpz.items.BOTTLE_OF_GNOSTICS_DRINK, tpz.items.BOTTLE_OF_CLERICS_DRINK,
        tpz.items.BOTTLE_OF_VICARS_DRINK,
        tpz.items.DAEDALUS_WING, tpz.items.PAIR_OF_LUCID_WINGS_I, tpz.items.PAIR_OF_LUCID_WINGS_II,
        tpz.items.DUSTY_WING
    }

    local auraParams = {
        radius = 10,
        effect = tpz.effect.MUDDLE,
        power = 1,
        duration = 60,
        auraNumber = 1
    }

    -- Perma Muddle aura below 90% HP
    if (mob:getHPP() < 90) then
        AddMobAura(mob, target, auraParams)
        TickMobAura(mob, target, auraParams)
    end

    -- Uses a random item every 10%
    for _, phase in ipairs(phaseData) do
        if (currentHP <= phase.HP) and (mob:getLocalVar(phase.Var) == 0) then
            if CanUseItem(mob) then
                mob:setLocalVar(phase.Var, 1)
                mob:useItem(items[math.random(#items)], mob)
                break
            end
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 237)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(5400, 7200)) -- 90 to 120 minutes
end
