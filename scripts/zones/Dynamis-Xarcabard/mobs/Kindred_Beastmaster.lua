-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Kindred Beastmaster
-----------------------------------
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
require("scripts/globals/mobs")
-----------------------------------
function onMobFight(mob, target)
    local pet = mob:getID()+1
    if GetMobByID(pet):isDead() then
        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.CHARM, hpp = 50},
            },
        })
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.MARQUIS_ANDRAS_PH, 5, 3600) -- 1 hour
end
