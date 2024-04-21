-- RNG/RNG
-- Stands back and shoots arrows, does not come in to melee at high HP
-- Immune to Paralyze, Sleep, Bind, Gravity, Break
-- 3s delay on ranged attacks at range
-- 10s delay on ranged attacks in melee range
-- Slght Store TP bonus
-- Uses Goblin Rush and Bomb Toss
-- Summons up to 5 goblin mines after bomb toss
-- Bomb toss is faster than normal bomb toss, unstunnable
-- Pets / Trusts can set off the mines
-- Runs into melee range at 70%
-----------------------------------
-- Area: Beadeaux [S]
--   NM: Ba'Tho Mercifulheart
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/wotg")
require("scripts/globals/utils")
-----------------------------------

function onMobSpawn(mob)
    tpz.wotg.NMMods(mob)
    mob:setMod(tpz.mod.STORETP, 25)
    mob:setMobMod(tpz.mobMod.STANDBACK_COOL, 5)
    mob:setMobMod(tpz.mobMod.SPECIAL_COOL, 10)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, 71)
end

function onMobFight(mob, target)
    local summonMines = mob:getLocalVar("summonMines")
    local firstMineID = mob:getID()+1
    local minesplaced = 0

    if (summonMines > 0) then
        while minesplaced < summonMines do
            local currentMine = GetMobByID(firstMineID + minesplaced)
            currentMine:spawn()
            currentMine:setPos(mob:getXPos() + math.random(1, 3), mob:getYPos(), mob:getZPos() + math.random(1, 3))
            currentMine:addStatusEffect(tpz.effect.STUN, 1, 0, 10)
            currentMine:updateEnmity(target)
            minesplaced = minesplaced +1
        end
        mob:setLocalVar("summonMines", 0)
    end
end


function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 591 then -- Bomb toss
        mob:setLocalVar("summonMines", math.random(1, 5))
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.MagianT4(mob, player, isKiller, noKiller)
    for v = 17154365, 17154369, 1 do
        DespawnMob(v)
    end
end
