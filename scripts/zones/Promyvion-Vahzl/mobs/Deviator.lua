-----------------------------------
-- Area: Promyvion vahzl
--  MOB: Deviator
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/promyvion")
require("scripts/globals/mobs")
require("scripts/zones/Promyvion-Vahzl/globals")
mixins = {require("scripts/mixins/families/empty")}
-----------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:addMod(tpz.mod.MATT, 100)
    mob:setMod(tpz.mod.REGAIN, 100)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 120)
    tpz.promyvion.setEmptyModel(mob)
end

function onMobEngaged(mob, target)
    ApplyEmptyAbsorbMods(mob)    
end

function onMobFight(mob, target)
    local ElementGaSpells =
    {
        [1] = tpz.magic.spell.FIRAGA_II,
        [2] = tpz.magic.spell.BLIZZAGA_II,
        [3] = tpz.magic.spell.AEROGA_II,
        [4] = tpz.magic.spell.STONEGA_II,
        [5] = tpz.magic.spell.THUNDAGA_II,
        [6] = tpz.magic.spell.WATERGA_II,
        [7] = tpz.magic.spell.BANISHGA_II,
        [8] = tpz.magic.spell.SLEEPGA
    }

    local BattleTime = mob:getBattleTime()
    local elementChangeTimer = mob:getLocalVar("elementChangeTimer")

    if elementChangeTimer == 0 then
        mob:setLocalVar("elementChangeTimer", BattleTime + 45)
    elseif BattleTime >= elementChangeTimer then
        mob:useMobAbility(624) -- 2hr  cloud animation

        -- Change model and element
        tpz.promyvion.setEmptyModel(mob)

        local element = mob:getLocalVar("element")
        local spell   = ElementGaSpells[element]

        ApplyEmptyAbsorbMods(mob)

        -- Cast spell if valid
        if spell then
            mob:castSpell(spell)
        else
            printf("Mob has invalid spell for element value: %i", element)
        end

        -- Reset timer
        mob:setLocalVar("elementChangeTimer", BattleTime + 45)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.promyvion.onEmptyDeath(mob)
end