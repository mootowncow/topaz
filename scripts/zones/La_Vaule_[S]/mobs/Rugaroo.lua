-----------------------------------
-- Area: La Vaule [S]
--   NM: Rugaroo
-- Para/Bind/Grav/Sleep immunity
-- Hits twice(Like a MNK)
-- Kick Attacks
-- Five call to the moons into Asuran Fists
-- Perma 20%+ humanoid killer after call of the moon.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/wotg")
require("scripts/globals/utils")
-----------------------------------

function onMobSpawn(mob)
    local moon = utils.getMoonPhase()
    
    tpz.wotg.NMMods(mob)
    -- Gnole moon phase based stats
    if (moon == 'Full') then
        mob:setMod(tpz.mod.MARTIAL_ARTS, 280)
        mob:addMod(tpz.mod.EVA, 60)
    elseif (moon == 'Gibbeus') then
        mob:setMod(tpz.mod.MARTIAL_ARTS, 200)
        mob:addMod(tpz.mod.EVA, 30)
    elseif (moon == 'Quarter') then
            mob:setMod(tpz.mod.MARTIAL_ARTS, 150)
    elseif (moon == 'Cresecent') then
        mob:setMod(tpz.mod.MARTIAL_ARTS, 70)
        mob:addMod(tpz.mod.EVA, -30)
    elseif (moon == 'New') then
        mob:setMod(tpz.mod.MARTIAL_ARTS, 20)
        mob:addMod(tpz.mod.EVA, -60)
    end
end

function onMobEngaged(mob)
    mob:setLocalVar("callOfTheMoonTimer", os.time() + 30)
end

function onMobFight(mob, target)
    local callOfTheMoonTimer = mob:getLocalVar("callOfTheMoonTimer")

    -- Uses five call to the moons into Asuran Fists
    if os.time() >= callOfTheMoonTimer then
        mob:setLocalVar("callOfTheMoonTimer", os.time() + 50)
        UseMultipleTPMoves(mob, 5, 2171)
        mob:useMobAbility(2176) -- Asuran Claws
    end
end


function onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.MagianT4(mob, player, isKiller, noKiller)
end