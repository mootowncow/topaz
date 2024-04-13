-----------------------------------
-- Area: Castle Oztroja [S]
--   NM: Vee Ladu the Titterer
-- NIN/NIN with dual wield(100% DA)
-- Immune to Silence, Paralyze, Sleep, Bind, Gravity, Break
-- Cannot miss Ninja enfeebles(capped MACC)
-- Double Attacks 100% of the time
-- Casts: Dokumori: Ni, Hojo: Ni, Kurayami: Ni, Jubaku: Ni, Utsusemi: Ni
-- Cast Timer: 10s
-- Ranged Attack Timer(In melee range also): 10s
-- Summons clones when using Utsusemi: Ni. 
-- 100-77%: 1 Clone
-- 77%-60%: 2 Clones
-- 60%-40%: 3 Clones
-- 0%-39% 4 Clones
-- Clones have exact same stats/immunities/spellcasting/ra AI etc as main boss except ~200 HP
-- Clones sit at 1 HP then despawn after a few seconds
-- Used Mijin Gakure at 1%, died and dropped loot from it.
-- Uses: Double Kick, Sweep, Feathered Furore
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/wotg")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 10)
    mob:setMobMod(tpz.mobMod.SPECIAL_COOL, 10)
end

function onMobSpawn(mob)
    if mob:getID() == 17183035 then
        tpz.wotg.NMMods(mob)
        mob:setDamage(70)
    else
        mob:setMod(tpz.mod.HTHRES, 1000)
        mob:setMod(tpz.mod.SLASHRES, 1000)
        mob:setMod(tpz.mod.PIERCERES, 1000)
        mob:setMod(tpz.mod.RANGEDRES, 1000)
        mob:setMod(tpz.mod.IMPACTRES, 1000)
    end
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 100)
    mob:setMod(tpz.mod.NINJUTSU_NEVER_MISS, 1)
    mob:setLocalVar("utsuTimer", 0)
    mob:setUnkillable(true)
end

function onMobFight(mob, target)
    local hp = mob:getHPP()

    mob:addListener("MAGIC_STATE_EXIT", "Ladu_MAGIC_STATE_EXIT", function(mob, spell)
        if spell:getID() == 339 and mob:getID() == 17183035 then -- Main NM only, Utsusemi: Ni

            local hp = mob:getHPP()
            local target = mob:getTarget()

            -- Summons clones when using Utsusemi: Ni. 
            -- 100-77%: 1 Clone
            -- 77%-60%: 2 Clones
            -- 60%-40%: 3 Clones
            -- 40-1%:   4 Clones

            if (hp < 41) then
                for v = 17183039, 17183042 do
                    local currentClone = GetMobByID(v)
                    if not currentClone:isSpawned() then
                        currentClone:setSpawn(mob:getXPos() + math.random(1, 3), mob:getYPos(), mob:getZPos() + math.random(1, 3))
                        currentClone:spawn()
                        currentClone:updateEnmity(target)
                    end
                end
            elseif (hp < 61) then
                for v = 17183039, 17183041 do
                    local currentClone = GetMobByID(v)
                    if not currentClone:isSpawned() then
                        currentClone:setSpawn(mob:getXPos() + math.random(1, 3), mob:getYPos(), mob:getZPos() + math.random(1, 3))
                        currentClone:spawn()
                        currentClone:updateEnmity(target)
                    end
                end
            elseif (hp < 78) then
                for v = 17183039, 17183040 do
                    local currentClone = GetMobByID(v)
                    if not currentClone:isSpawned() then
                        currentClone:setSpawn(mob:getXPos() + math.random(1, 3), mob:getYPos(), mob:getZPos() + math.random(1, 3))
                        currentClone:spawn()
                        currentClone:updateEnmity(target)
                    end
                end
            else
                local currentClone = GetMobByID(17183039)
                if not currentClone:isSpawned() then
                    currentClone:setSpawn(mob:getXPos() + math.random(1, 3), mob:getYPos(), mob:getZPos() + math.random(1, 3))
                    currentClone:spawn()
                    currentClone:updateEnmity(target)
                end
            end
            mob:setLocalVar("utsuTimer", os.time() + 45)
        end
    end)

    -- Uses Mijin Gakure at 1% then falls to the ground
    if (hp <= 1) then
        if mob:getID() == 17183035 then -- Main NM
            mob:useMobAbility(731)
        else -- Clones despawn at 1 hp instead
            DespawnMob(mob:getID())
        end
    end
end

function onMonsterMagicPrepare(mob,target)
    local spellList =
    {
        [1] = 345, -- Hojo: Ni
        [2] = 342, -- Kurayami: Ni
        [3] = 348,  -- Jubaku: Ni
        [4] = 351, -- Dokumori: Ni
    }
    -- Only casts Ususemi when no shadows are active, every 45 seconds
    local utsuTimer = mob:getLocalVar("utsuTimer")
    local time = os.time()
    print(time)
    print(utsuTimer)
    if os.time() > utsuTimer then
        return 339 -- Utsusemi: Ni
    end

    if GetShadowCount(mob) > 0 or os.time() < utsuTimer then
        return spellList[math.random(#spellList)]
    end
end

function onMobWeaponSkillPrepare(mob, target)
   local tpMoves = {618, 620, 2205}
   --  Double Kick, Sweep, Feathered Furore
   return tpMoves[math.random(#tpMoves)]
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.MagianT4(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    if mob:getID() == 17183035 then
        UpdateNMSpawnPoint(mob:getID())
        mob:setRespawnTime(7200) -- 2 hours
    end
end

function GetShadowCount(mob)
    local shadows = {
    [66] = 1,
    [444] = 2,
    [445] = 3,
    [446] = 4
    }

    for buffId,shadowCount in pairs(shadows) do
        if mob:hasStatusEffect(buffId) then
            return shadowCount
        end
    end
  return 0
end
