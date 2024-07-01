-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Kanoloa(Kraken NM)
-- ID: 17081057
-----------------------------------
local ID = require("scripts/zones/Arrapago_Remnants/IDs")
require("scripts/globals/instance")
require("scripts/globals/status")
require("scripts/globals/salvage")
require("scripts/globals/items")
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.DMG, -50)
    mob:setMod(tpz.mod.SILENCERESTRAIT, 100)
    mob:delImmunity(tpz.immunity.SILENCE) 
end
function onMobEngaged(mob, target)
    PeriodicInstanceMessage(mob, target, "A whirlpool rages around the " .. MobName(mob) .. ", damaging nearby players!", 0xD, none, 45)
end

function onMobFight(mob, target)
    mob:addListener("SKILLCHAIN_TAKE", "KANOLOA_SC_TAKE", function(mob, target, element)
        if element == 7 or element == 10 or element == 14 or element == 16 then -- Ice damage skillchains
            BreakMob(mob, target, 1, 30, 1)
        end
    end)
    if not mob:hasStatusEffect(tpz.effect.SILENCE) then
        if not mob:hasStatusEffect(tpz.effect.SILENCE) then
            PeriodicInstanceMessage(mob, target, "The " .. MobName(mob) .. " seems weak to skillchains...", 0xD, none, 30)
        end
        TickDamageAura(mob, target, 12, 50, tpz.attackType.MAGICAL, tpz.damageType.WATER, 3)
    end
end

function onMobWeaponSkillPrepare(mob, target)
    -- Only uses Maelstrom and Whirlwind
    return math.random(462, 463)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        -- If final boss, spawn next boss in line
        if salvageUtil.TrySpawnChariotBoss(mob, player, 17081058) then
        else
            -- Nearby door opens
            mob:getEntity(bit.band(ID.npc[1][3].DOOR3, 0xFFF), tpz.objType.NPC):setAnimation(8)
            mob:getEntity(bit.band(ID.npc[1][3].DOOR3, 0xFFF), tpz.objType.NPC):untargetable(true)
            salvageUtil.msgGroup(player, "The way forward is now open.", 0xD, none)
        end
    end
end

function onMobDespawn(mob)
end