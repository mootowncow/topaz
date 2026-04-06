-----------------------------------
-- Area: Dynamis - San d'Oria
--  Mob: Arch Overlord Tombstone
-----------------------------------
mixins =
{
    require("scripts/mixins/job_special")
}
require("scripts/globals/dynamis")
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
    mob:setDamage(250)
    mob:setMod(tpz.mod.ATTP, 25)
    mob:setMod(tpz.mod.DEFP, 25)
    mob:setMod(tpz.mod.ACC, 25)
    mob:setMod(tpz.mod.EVA, 25)
    mob:setMod(tpz.mod.MATT, 50)
    mob:setMod(tpz.mod.UFASTCAST, 50)

    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 30)
    
    mob:addImmunity(tpz.immunity.SLEEP)
    mob:addImmunity(tpz.immunity.SILENCE)
    mob:addImmunity(tpz.immunity.PETRIFY)
    mob:addImmunity(tpz.immunity.PARALYZE)
    mob:addImmunity(tpz.immunity.ELEGY)
end

function onMobFight(mob, target)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.HUNDRED_FISTS, cooldown = 60, hpp = 90},
        },
    })
end

function onMobWeaponSkill(target, mob, skill)
    -- Always uses twice in a row
    if os.time() >= mob:getLocalVar("doubleSeismoStomp") and skill:getID() == 1110 then  -- seismostomp
        mob:useMobAbility(1110)
        mob:setLocalVar("doubleSeismoStomp", os.time() + 10) -- prevent infinite loop
    end
end

function onMobDespawn(mob)
    OnBattleEndConfrontation(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    OnBattleEndConfrontation(mob)
end
