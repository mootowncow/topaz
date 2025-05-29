-----------------------------------
-- Area: La Vaule [S]
--   NM: All-seeing Onyx Eye
-- Spams conal gaze charm every ~10s seconds.
-- Casts SCH helixes spells
-- Ancient Magic AOE's
-- Casts faster as HP is lowered
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/wotg")
require("scripts/globals/wotg_strongholds")
-----------------------------------

function onMobSpawn(mob)
    tpz.wotg.NMMods(mob)
    mob:addMobMod(tpz.mobMod.HP_HEAL_CHANCE, 33)
end

function onMobEngaged(mob)
    mob:setLocalVar("charmTimer", os.time() + 12)
end

function onMobFight(mob, target)
    local charmTimer = mob:getLocalVar("charmTimer")
    local battleTime =  mob:getBattleTime()
    local hp = mob:getHPP()

    -- Uses Charm every 5ish seconds
    if (os.time() >= charmTimer) then
        mob:useMobAbility(2383)
        mob:setLocalVar("charmTimer", os.time() + 12)
    end

    -- Gains fast cast as his HP lowers
    if (hp < 10) then
        mob:setMod(tpz.mod.UFASTCAST, 75)
    elseif (hp < 25) then
        mob:setMod(tpz.mod.UFASTCAST, 50)
    elseif (hp < 50) then
        mob:setMod(tpz.mod.UFASTCAST, 25)
    else
        mob:setMod(tpz.mod.UFASTCAST, 0)
    end
end

function onSpellPrecast(mob, spell)
    local ancientMagic = {204, 206, 208, 210, 212, 214}

    for _, spellID in pairs(ancientMagic) do
        if spell:getID() == spellID then
            spell:setAoE(tpz.magic.aoe.RADIAL)
            spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
            spell:setRadius(10)
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.MagianT4(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(7200) -- 2 hours
end
