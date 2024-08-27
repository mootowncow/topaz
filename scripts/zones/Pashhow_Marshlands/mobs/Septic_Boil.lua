-----------------------------------
-- Area: Pashhow Marshlands
--  VNM: Septic Boil (Summoned by Blobdingnag after using Cytokinesis)
-- Auto-attacks apply random status effects
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------
local addEffects = {
    tpz.mob.ae.BLIND,
    tpz.mob.ae.PARALYZE,
    tpz.mob.ae.PLAGUE,
    tpz.mob.ae.SILENCE,
    tpz.mob.ae.AMNESIA,
}

function onMobSpawn(mob)
    mob:setDamage(40)
    mob:setMod(tpz.mod.DARKDEF, 256)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, addEffects[math.random(#addEffects)], {duration = 10})
end