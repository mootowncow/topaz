-----------------------------------
-- Area: Sacrarium
--  Mob: Lobais
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/mobs")
require("scripts/globals/status")
require("scripts/globals/spell_data")
-----------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.EEM_SILENCE, 5)

    mob:addListener("MAGIC_STATE_EXIT", "LOBAIS_MAGIC_STATE_EXIT", function(mob, spell)
        local spellId = spell:getID()
        if (spellId >= tpz.magic.spell.FIRE_SPIRIT) and (spellId <= tpz.magic.spell.DARK_SPIRIT) then
            mob:setLocalVar("Elemental", spellId)
        end
    end)

    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.ASTRAL_FLOW},
        },
    })
end

function onMobFight(mob, target)
    -- Force summon a Spirit if one is not active
    if
        (mob:getBattleTime() > 30) and
        not mob:hasPet() and
        not IsMobBusy(mob) and
        not mob:hasPreventActionEffect()
    then
        local randomSpirit = math.random(tpz.magic.spell.FIRE_SPIRIT, tpz.magic.spell.DARK_SPIRIT)
        mob:castSpell(randomSpirit, mob)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    -- Kill elemental pet
    GetMobByID(mob:getID() +1):setHP(0)
end