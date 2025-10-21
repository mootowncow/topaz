-----------------------------------
-- Area: Castle Oztroja [S]
--   NM: Soo Luma The Ascended
-- BCNM: Plucking Wings
-- SCH/SCH
-- ID: 17183047
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja_[S]/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/wotg")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
function onMobSpawn(mob)
    tpz.wotg.NMMods(mob)
    mob:setMod(tpz.mod.MATT, 72)
    mob:setMod(tpz.mod.HELIX_EFFECT, 50)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 10)
    mob:setMobMod(tpz.mobMod.BUFF_CHANCE, 5)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE , 20)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 20)
    mob:addStatusEffectEx(tpz.effect.ENHANCED_MANIFESTATION, tpz.effect.ENHANCED_MANIFESTATION, 1, 0, 3600)
end

function onMobEngaged(mob, target)
    -- Spawn adds on engage
    for v = mob:getID() +2, mob:getID() +4 do
        local adds = GetMobByID(v)
        adds:spawn()
        adds:updateEnmity(target)
    end
end

function onMobFight(mob, target)
    -- Spawn adds if they're dead
    for v = mob:getID() +2, mob:getID() +4 do
        local adds = GetMobByID(v)
        if not adds:isSpawned() then
            adds:spawn()
            adds:updateEnmity(target)
        end
    end

	if not mob:hasStatusEffect(tpz.effect.ENHANCED_MANIFESTATION) then
        mob:addStatusEffectEx(tpz.effect.ENHANCED_MANIFESTATION, tpz.effect.ENHANCED_MANIFESTATION, 1, 0, 3600)
	end
end

function onMobWeaponSkillPrepare(mob, target)
   local hp = mob:getHPP()
   local tpMoves = { 619, 620, 2206, 2381 }
   --  Parry, Sweep, Dark Invocation, Double Kick
   return tpMoves[math.random(#tpMoves)]
end

function onMobWeaponSkill(target, mob, skill)
end

function onSpellPrecast(mob, spell)
    SetNukeAnimationsToGa(mob, spell)
end

function onMobDeath(mob, player, isKiller, noKiller)
    -- Despawn adds on death
    for v = mob:getID() +2, mob:getID() +4 do
        DespawnMob(v)
    end
end
