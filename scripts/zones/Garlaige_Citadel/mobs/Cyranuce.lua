-----------------------------------
-- Area: Garlaige Citadel
--   NM: Cyranuce
-- DRG Mythic weapon fight
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.SKILL_LIST, 1014)
    mob:setUnkillable(true)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.MIGHTY_STRIKES, cooldown = math.random(60, 90), hpp = 90},
        },
    })
end

function onMobFight(mob, target)
    local dragonForm = mob:getLocalVar("dragonForm")

    if not IsMobBusy(mob) and not mob:hasPreventActionEffect() then
        if mob:getHPP() <= 10 and dragonForm == 0 then
            SetGenericNMStats(mob)
            mob:useMobAbility(689) -- Benediction
            MessageGroup(mob, target, "I shall show you the real power of a Dragoon!", 0, "Cyranuce")
            mob:setLocalVar("dragonForm", 1)
        end
    end

    mob:addListener("WEAPONSKILL_STATE_EXIT", "CYRANUCE_WS_EXIT", function(mob, skill)
        if (skill == 689) then
            mob:setMod(tpz.mod.REGAIN, 25)
            mob:setMobMod(tpz.mobMod.SKILL_LIST, 6016)
            mob:setModelId(318) -- Guivre Wyvern
            mob:setUnkillable(false)
        end
    end)
end

function onMobWeaponSkill(target, mob, skill)
    local buffs = { tpz.effect.ICE_SPIKES, tpz.effect.SHOCK_SPIKES, tpz.effect.DREAD_SPIKES }

    if skill:getID() == 819 then -- Blizzard Breath
        mob:addStatusEffect(tpz.effect.ICE_SPIKES, 20, 0, 30)
        mob:getStatusEffect(buffs[1]):unsetFlag(tpz.effectFlag.DISPELABLE)
    end
    if skill:getID() == 820 then -- Thunder Breath
        mob:addStatusEffect(tpz.effect.SHOCK_SPIKES, 20, 0, 30)
        mob:getStatusEffect(buffs[2]):unsetFlag(tpz.effectFlag.DISPELABLE)
    end
    if skill:getID() == 822 then -- Chaos Breath
        mob:addStatusEffect(tpz.effect.DREAD_SPIKES, 0, 0, 30, 0, 2000, 1)
        mob:getStatusEffect(buffs[3]):unsetFlag(tpz.effectFlag.DISPELABLE)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    OnDeathMessage(mob, player, isKiller, noKiller, "Hear my last wish! You must again believe in dragons, as we did long ago. Surely somewhere there is one of holy will!", 0, "Cyranuce")
end