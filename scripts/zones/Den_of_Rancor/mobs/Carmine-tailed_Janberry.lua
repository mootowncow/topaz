-----------------------------------
-- Area: Den of Rancor
--   NM: Carmine-tailed Janberry
-----------------------------------
mixins =
{
    require("scripts/mixins/families/tonberry"),
}
-----------------------------------
function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.SKILL_LIST, 243)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
end

function onMobFight(mob, target)
    local hitTrigger = mob:getLocalVar("TriggerHit")

    if mob:getHPP() <= 50 and hitTrigger == 0 then
        mob:useMobAbility(624) -- 2 hour "cloud" animation
        mob:setModelId(795) -- Leviathan Prime
        mob:addMod(tpz.mod.ATTP, 50)
        mob:addMod(tpz.mod.DEFP, 35)
        mob:addMod(tpz.mod.ACC, 25) 
        mob:addMod(tpz.mod.EVA, 25)
        mob:setMod(tpz.mod.UDMGPHYS, -50)
        mob:setMod(tpz.mod.UDMGMAGIC, -50)
        mob:setMod(tpz.mod.UDMGRANGE, -50)
        mob:setMod(tpz.mod.SDT_WATER, 150)
        mob:setMod(tpz.mod.SDT_LIGHT, 50)
        mob:setMod(tpz.mod.SDT_EARTH, 50)
        mob:setMod(tpz.mod.SDT_WIND, 50)
        mob:setMod(tpz.mod.SDT_THUNDER, 150)
        mob:setMod(tpz.mod.SDT_DARK, 50)
        mob:setMod(tpz.mod.SDT_FIRE, 5)
        mob:setMod(tpz.mod.SDT_ICE, 50)
        mob:setMod(tpz.mod.WATER_ABSORB, 100)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 6018)
        mob:setLocalVar("TriggerHit", 1)
    end
    if mob:getHPP() <= 25 and hitTrigger == 1 then
        mob:useMobAbility(866) -- Tidal Wave
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 6019)
        mob:setLocalVar("TriggerHit", 2)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end
