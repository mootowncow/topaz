-----------------------------------
-- Area: Xarcabard
--   NM: Biast
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/status")
mixins =
{
    require("scripts/mixins/job_special")
}
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
end

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:addMod(tpz.mod.MDEF, 24) 
    mob:setMod(tpz.mod.SDT_WATER, 5)
    mob:setMod(tpz.mod.SDT_LIGHT, 100)
    mob:setMod(tpz.mod.SDT_EARTH, 85)
    mob:setMod(tpz.mod.SDT_WIND, 70)
    mob:setMod(tpz.mod.SDT_THUNDER, 150)
    mob:setMod(tpz.mod.SDT_DARK, 100)
    mob:setMod(tpz.mod.SDT_FIRE, 50)
    mob:setMod(tpz.mod.SDT_ICE, 85)
    mob:setMod(tpz.mod.REFRESH, 300)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000) 
    mob:setMobMod(tpz.mobMod.GIL_BONUS, 0)
end

function onMobFight(mob, target)
    if (mob:hasStatusEffect(tpz.effect.MIGHTY_STRIKES) == true) then
        mob:setMod(tpz.mod.REGAIN, 500)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 5999)
    elseif (mob:hasStatusEffect(tpz.effect.MANAFONT) == true) then
        mob:setMod(tpz.mod.UFASTCAST, 50)
    elseif (mob:hasStatusEffect(tpz.effect.INVINCIBLE) == true) then
        mob:setMod(tpz.mod.REGEN, 300)
    else
        mob:setMod(tpz.mod.REGAIN, 0)
        mob:setMod(tpz.mod.UFASTCAST, 0)
        mob:setMod(tpz.mod.REGEN, 0)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 6009)
    end

    tpz.mix.jobSpecial.config(mob, {
        between = 120,
        specials =
        {
            {id = tpz.jsa.MIGHTY_STRIKES, cooldown = 0, hpp = 75},
            {id = tpz.jsa.INVINCIBLE, cooldown = 0, hpp = 75},
            {id = tpz.jsa.MANAFONT, cooldown = 0, hpp = 75},
        },
    })
end

function onMobWeaponSkill(target, mob, skill)
    local buffone = tpz.effect.ICE_SPIKES

    if skill:getID() == 2437 then -- Aqua Blast
        mob:addStatusEffect(tpz.effect.ICE_SPIKES, 20, 0, 30)
        mob:getStatusEffect(buffone):unsetFlag(tpz.effectFlag.DISPELABLE)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    SetServerVariable("[POP]Biast", os.time() + math.random(36000, 43200)) -- 21 to 23 hours
    DisallowRespawn(mob:getID()-1, false)
    GetMobByID(mob:getID()-1):setRespawnTime(GetMobRespawnTime(mob:getID()-1))
end
