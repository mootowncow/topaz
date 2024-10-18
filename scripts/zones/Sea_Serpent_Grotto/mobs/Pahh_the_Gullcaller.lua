-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Pahh the Gullcaller
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.SKILL_LIST, 6015)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
    mob:setModelId(1301) -- Sahagin (Dragoon)
    mob:setUnkillable(true)
end

function onMobFight(mob, target)
    local hitTrigger = mob:getLocalVar("TriggerHit")

    if mob:getHPP() <= 10 and hitTrigger == 0 then
        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.MIGHTY_STRIKES, cooldown = math.random(60, 90), hpp = 90},
            },
        })
        mob:useMobAbility(689) -- Benediction
        mob:setModelId(318) -- Guivre Wyvern
        mob:addMod(tpz.mod.ATTP, 50)
        mob:addMod(tpz.mod.DEFP, 35)
        mob:addMod(tpz.mod.ACC, 50) 
        mob:addMod(tpz.mod.EVA, 20)
        mob:setMod(tpz.mod.REGAIN, 150)
        mob:setMod(tpz.mod.SDT_FIRE, 50)
        mob:setMod(tpz.mod.SDT_ICE, 90)
        mob:setMod(tpz.mod.SDT_EARTH, 100)
        mob:setMod(tpz.mod.SDT_WIND, 100)
        mob:setMod(tpz.mod.SDT_THUNDER, 130)
        mob:setMod(tpz.mod.SDT_WATER, 130)
        mob:setMod(tpz.mod.SDT_LIGHT, 130)
        mob:setMod(tpz.mod.SDT_DARK, 150)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 6016)
        mob:setLocalVar("TriggerHit", 1)
        mob:setUnkillable(false)
    end
end

function onMobWeaponSkill(target, mob, skill)
    local buffone = tpz.effect.ICE_SPIKES
    local bufftwo = tpz.effect.SHOCK_SPIKES
    local buffthree = tpz.effect.DREAD_SPIKES

    if skill:getID() == 819 then -- Blizzard Breath
        mob:addStatusEffect(tpz.effect.ICE_SPIKES, 20, 0, 30)
        mob:getStatusEffect(buffone):unsetFlag(tpz.effectFlag.DISPELABLE)
    end
    if skill:getID() == 820 then -- Thunder Breath
        mob:addStatusEffect(tpz.effect.SHOCK_SPIKES, 20, 0, 30)
        mob:getStatusEffect(bufftwo):unsetFlag(tpz.effectFlag.DISPELABLE)
    end
    if skill:getID() == 822 then -- Chaos Breath
        mob:addStatusEffect(tpz.effect.DREAD_SPIKES, 0, 0, 30, 0, 2000, 1)
        mob:getStatusEffect(buffthree):unsetFlag(tpz.effectFlag.DISPELABLE)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 375)
end
