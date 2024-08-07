-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Macrocheira Kaempferi (Crab NM)
-- ID: 17081055
-----------------------------------
local ID = require("scripts/zones/Arrapago_Remnants/IDs")
require("scripts/globals/instance")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/salvage")
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.DMG, -50)
    mob:setMod(tpz.mod.DMGMB, 100)
    addSpikes(mob)
end

function onMobEngaged(mob, target)
    PeriodicMessage(mob, target, "The " .. MobName(mob) .. " raises it\'s claws to deflect your attacks!", 0xD, none, 45)
end

function onMobFight(mob, target)
    mob:addListener("SPELL_DMG_TAKEN", "MK_SPELL_DMG_TAKEN", function(mob, caster, spell, amount, msg)
        local element = spell:getElement()

        if (element == tpz.magic.ele.ICE) and (amount >= 500) then
            if (msg == tpz.msg.basic.MAGIC_BURST_BLACK) or (msg == tpz.msg.MAGIC_BURST_BREATH) then
                BreakMob(mob, caster, 1, 60, 2)
                mob:delStatusEffectSilent(tpz.effect.DELUGE_SPIKES)
            end
        end
    end)
    if not mob:hasStatusEffect(tpz.effect.TERROR) then
        PeriodicMessage(mob, target, "The " .. MobName(mob) .. " seems vulnerable to ice magic...", 0xD, none, 30)
        addSpikes(mob)
    end
end

function onMobWeaponSkillPrepare(mob, target)
    -- Only uses Venom Shower and Mega Scissors
    return math.random(2512, 2513)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        -- If final boss, spawn next boss in line
        if salvageUtil.TrySpawnChariotBoss(mob, player, 17081056) then
        else
            -- Nearby door opens
            mob:getEntity(bit.band(ID.npc[1][3].DOOR1, 0xFFF), tpz.objType.NPC):setAnimation(8)
            mob:getEntity(bit.band(ID.npc[1][3].DOOR1, 0xFFF), tpz.objType.NPC):untargetable(true)
            salvageUtil.msgGroup(player, "The way forward is now open.", 0xD, none)
        end
    end
end

function onMobDespawn(mob)
end

function addSpikes(mob)
	if not mob:hasStatusEffect(tpz.effect.DELUGE_SPIKES)and not mob:hasStatusEffect(tpz.effect.TERROR) then
		mob:addStatusEffect(tpz.effect.DELUGE_SPIKES, 25, 0, 3600)
	end
end
