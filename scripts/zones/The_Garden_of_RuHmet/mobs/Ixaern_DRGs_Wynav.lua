-----------------------------------
-- Area: The Garden of Ru'Hmet
--  MOB: Ix'Aern (DRK)'s Wynav
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    local partyWithIxDrg = 19236
    mob:setMobMod(tpz.mobMod.CUSTOMLINK, partyWithIxDrg)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 14)
    mob:addImmunity(tpz.immunity.SLEEP)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {
                id = tpz.jsa.SOUL_VOICE,
                hpp = math.random(20, 30),
                begCode = function(mob)
                    -- Once the Wynav does Soul Voice it will continue to only cast Maiden's Virelai until it dies
                    mob:setLocalVar("soul_voiced", 1)
                end,
            },
        },
    })
end

function onMonsterMagicPrepare(mob,target)
    if mob:getLocalVar("soul_voiced") == 1 then
        return 466 -- Maiden's Virelai
    end

    local spellList =
    {
        [1] = 382,
        [2] = 376,
        [3] = 372,
        [4] = 392,
        [5] = 397,
        [6] = 400,
        [7] = 422,
        [8] = 462,
    }
    return spellList[math.random(#spellList)]
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    mob:setLocalVar("repop", os.time() + 10)
end
