-- Ghrah family mixin

require("scripts/globals/magic")
require("scripts/globals/mixins")
require("scripts/globals/utils")
require("scripts/globals/status")
    -- 0:ball - 1:humanoid - 2:spider - 3:bird
g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.ghrah = function(mob)
    mob:addListener("SPAWN", "GHRAH_SPAWN", function(mob)
        -- Set core skin and mob elemental resist/weakness other elements set to 0.
        -- Set to non aggro.
        local kfghrahWHM = mob:getPool() == 2215
        local kfghrahBLM = mob:getPool() == 4659
        mob:AnimationSub(0)
        mob:setAggressive(0)
        mob:setLocalVar("changeTime", os.time())
        mob:setLocalVar("roamTime", os.time() + math.random(45, 60))

        -- Kfghrahs cannot traensform into humanoid form
        if kfghrahWHM or kfghrahBLM then
            mob:setLocalVar("form2", math.random(2, 3))
        else
            mob:setLocalVar("form2", math.random(1, 3))
        end

        local skin = math.random(1161, 1168)
        mob:setModelId(skin)

        if skin == 1161 then -- Fire
            mob:setSpellList(188)
            mob:setLocalVar("element", tpz.magic.ele.FIRE)
        elseif skin == 1164 then --Earth
            mob:setSpellList(190)
            mob:setLocalVar("element", tpz.magic.ele.EARTH)
        elseif skin == 1162 then -- Water
            mob:setSpellList(192)
            mob:setLocalVar("element", tpz.magic.ele.WATER)
        elseif skin == 1163 then -- Wind
            mob:setSpellList(193)
            mob:setLocalVar("element", tpz.magic.ele.WIND)
        elseif skin == 1166 then --Ice
            mob:setSpellList(189)
            mob:setLocalVar("element", tpz.magic.ele.ICE)
        elseif skin == 1165 then --Lightning
            mob:setSpellList(191)
            mob:setLocalVar("element", tpz.magic.ele.LIGHTNING)
        elseif skin == 1167 then --Light
            mob:setSpellList(1015)
            mob:setLocalVar("element", tpz.magic.ele.LIGHT)
        elseif skin == 1168 then --Dark
            mob:setSpellList(194)
            mob:setLocalVar("element", tpz.magic.ele.DARK)
        end
        SetJob(mob)
    end)

    mob:addListener("ROAM_TICK", "GHRAH_RTICK", function(mob)
        local roamTime = mob:getLocalVar("roamTime")
        if (mob:AnimationSub() == 0 and os.time() >= roamTime) then
            mob:AnimationSub(mob:getLocalVar("form2"))
            mob:setAggressive(1)
            SetJob(mob)
            SetSDT(mob)
            SetCasting(mob)
            mob:setLocalVar("roamTime", os.time() + math.random(45, 60))
        elseif (mob:AnimationSub() == mob:getLocalVar("form2") and os.time() >= roamTime) then
            mob:AnimationSub(0)
            mob:setAggressive(0)
            SetJob(mob)
            SetSDT(mob)
            SetCasting(mob)
            mob:setLocalVar("roamTime", os.time() + math.random(45, 60))
        end
    end)

    mob:addListener("ENGAGE", "GHRAH_ENGAGE", function(mob, target)
        SetJob(mob)
        SetSDT(mob)
        mob:setLocalVar("changeTime", 60)
    end)

    mob:addListener("COMBAT_TICK", "GHRAH_CTICK", function(mob)
        local changeTime = mob:getLocalVar("changeTime")

        if not IsMobBusy(mob) then
            if (mob:AnimationSub() == 0 and mob:getBattleTime() >= changeTime) then
                mob:AnimationSub(mob:getLocalVar("form2"))
                mob:setAggressive(1)
                SetJob(mob)
                SetSDT(mob)
                SetCasting(mob)
                SetClusterDrops(mob)
                mob:setLocalVar("changeTime", mob:getBattleTime() + 60)
            elseif (mob:AnimationSub() == mob:getLocalVar("form2") and mob:getBattleTime() >= changeTime) then
                mob:AnimationSub(0)
                mob:setAggressive(0)
                SetJob(mob)
                SetSDT(mob)
                SetCasting(mob)
                SetClusterDrops(mob)
                mob:setLocalVar("changeTime", mob:getBattleTime() + 60)
            end
        end
    end)
end

function SetCasting(mob)
    -- Humanoid does not cast
    if mob:AnimationSub() == 1 then 
        mob:SetMagicCastingEnabled(false)
    else
        mob:SetMagicCastingEnabled(true)
    end
end

function SetJob(mob)
    if mob:AnimationSub() == 0 then -- Ball form
        mob:setDamage(mob:getMainLvl() + 2) -- Normal weapon damage
        mob:delJobTraits(tpz.job.WAR, mob:getMainLvl())
        mob:delJobTraits(tpz.job.PLD, mob:getMainLvl())
        mob:addJobTraits(tpz.job.BLM, mob:getMainLvl())
        mob:delJobTraits(tpz.job.THF, mob:getMainLvl())
        DelDefenseBonus(mob)
    elseif mob:AnimationSub() == 1 then  -- human form gives defense bonus equal to paladin of that level AND 100% defense modifier
        mob:setDamage(mob:getMainLvl() + 2) -- Normal weapon damage
        mob:addJobTraits(tpz.job.PLD, mob:getMainLvl())
        mob:delJobTraits(tpz.job.WAR, mob:getMainLvl())
        mob:delJobTraits(tpz.job.THF, mob:getMainLvl())
        mob:delJobTraits(tpz.job.BLM, mob:getMainLvl())
        AddDefenseBonus(mob, 100)
    elseif mob:AnimationSub() == 2 then  -- spider form gives defense bonus equal to warrior of that level
        mob:setDamage(math.floor(mob:getWeaponDmg() * 2)) -- Weapon damage * 2
        mob:addJobTraits(tpz.job.WAR, mob:getMainLvl())
        mob:delJobTraits(tpz.job.PLD, mob:getMainLvl())
        mob:delJobTraits(tpz.job.THF, mob:getMainLvl())
        mob:delJobTraits(tpz.job.BLM, mob:getMainLvl())
        AddDefenseBonus(mob, 10)
    elseif mob:AnimationSub() == 3 then  -- Bird form grants evasion and triple attack equal to appropriate level thief
        mob:setDamage(mob:getMainLvl() + 2) -- Normal weapon damage
        mob:delJobTraits(tpz.job.WAR, mob:getMainLvl())
        mob:delJobTraits(tpz.job.PLD, mob:getMainLvl())
        mob:addJobTraits(tpz.job.THF, mob:getMainLvl())
        mob:delJobTraits(tpz.job.BLM, mob:getMainLvl())
        DelDefenseBonus(mob)
    end
end

function AddDefenseBonus(mob, amount)
    if mob:getLocalVar("defBonus") == 0 then
        mob:setLocalVar("defBonus", amount)
        mob:addMod(tpz.mod.DEFP, amount)
    end
end

function DelDefenseBonus(mob)
    local defBonus = mob:getLocalVar("defBonus")
    if mob:getLocalVar("defBonus") > 0 then
        mob:delMod(tpz.mod.DEFP, defBonus)
        mob:setLocalVar("defBonus", 0)
    end
end

function SetSDT(mob)
    local element = mob:getLocalVar("element")
    if element == 1 then -- Fire
        mob:setMod(tpz.mod.SDT_FIRE, 5)
        mob:setMod(tpz.mod.EEM_AMNESIA, 5)
        mob:setMod(tpz.mod.EEM_VIRUS, 5)
        mob:setMod(tpz.mod.SDT_ICE, 5)
        mob:setMod(tpz.mod.EEM_PARALYZE, 5)
        mob:setMod(tpz.mod.EEM_BIND, 5)
        mob:setMod(tpz.mod.SDT_WATER, 150)
        mob:setMod(tpz.mod.EEM_POISON, 150)
    elseif element == 2 then --Ice
        mob:setMod(tpz.mod.SDT_ICE, 5)
        mob:setMod(tpz.mod.EEM_PARALYZE, 5)
        mob:setMod(tpz.mod.EEM_BIND, 5)
        mob:setMod(tpz.mod.SDT_WIND, 5)
        mob:setMod(tpz.mod.EEM_SILENCE, 5)
        mob:setMod(tpz.mod.EEM_GRAVITY, 5)
        mob:setMod(tpz.mod.SDT_FIRE, 150)
        mob:setMod(tpz.mod.EEM_AMNESIA, 150)
        mob:setMod(tpz.mod.EEM_VIRUS, 150)
    elseif element == 3 then -- Wind
        mob:setMod(tpz.mod.SDT_WIND, 5)
        mob:setMod(tpz.mod.EEM_SILENCE, 5)
        mob:setMod(tpz.mod.EEM_GRAVITY, 5)
        mob:setMod(tpz.mod.SDT_EARTH, 5)
        mob:setMod(tpz.mod.EEM_SLOW, 5)
        mob:setMod(tpz.mod.EEM_PETRIFY, 5)
        mob:setMod(tpz.mod.EEM_TERROR, 5)
        mob:setMod(tpz.mod.SDT_ICE, 150)
        mob:setMod(tpz.mod.EEM_PARALYZE, 150)
        mob:setMod(tpz.mod.EEM_BIND, 150)
    elseif element == 4 then --Earth
        mob:setMod(tpz.mod.SDT_EARTH, 5)
        mob:setMod(tpz.mod.EEM_SLOW, 5)
        mob:setMod(tpz.mod.EEM_PETRIFY, 5)
        mob:setMod(tpz.mod.EEM_TERROR, 5)
        mob:setMod(tpz.mod.SDT_THUNDER, 5)
        mob:setMod(tpz.mod.EEM_STUN, 5)
        mob:setMod(tpz.mod.SDT_WIND, 150)
        mob:setMod(tpz.mod.EEM_SILENCE, 150)
        mob:setMod(tpz.mod.EEM_GRAVITY, 150)
    elseif element == 5 then --Lightning
        mob:setMod(tpz.mod.SDT_THUNDER, 5)
        mob:setMod(tpz.mod.EEM_STUN, 5)
        mob:setMod(tpz.mod.SDT_WATER, 5)
        mob:setMod(tpz.mod.EEM_POISON, 5)
        mob:setMod(tpz.mod.SDT_EARTH, 150)
        mob:setMod(tpz.mod.EEM_SLOW, 150)
        mob:setMod(tpz.mod.EEM_PETRIFY, 150)
        mob:setMod(tpz.mod.EEM_TERROR, 150)
    elseif element == 6 then -- Water
        mob:setMod(tpz.mod.SDT_WATER, 5)
        mob:setMod(tpz.mod.EEM_POISON, 5)
        mob:setMod(tpz.mod.SDT_FIRE, 5)
        mob:setMod(tpz.mod.EEM_AMNESIA, 5)
        mob:setMod(tpz.mod.EEM_VIRUS, 5)
        mob:setMod(tpz.mod.SDT_THUNDER, 150)
        mob:setMod(tpz.mod.EEM_STUN, 150)
    elseif element == 7 then --Light
        mob:setMod(tpz.mod.SDT_LIGHT, 5)
        mob:setMod(tpz.mod.EEM_LIGHT_SLEEP, 5)
        mob:setMod(tpz.mod.EEM_CHARM, 5)
        mob:setMod(tpz.mod.SDT_DARK, 150)
        mob:setMod(tpz.mod.EEM_DARK_SLEEP, 150)
        mob:setMod(tpz.mod.EEM_BLIND, 150)
    elseif element == 8 then --Dark
        mob:setMod(tpz.mod.SDT_DARK, 5)
        mob:setMod(tpz.mod.EEM_DARK_SLEEP, 5)
        mob:setMod(tpz.mod.EEM_BLIND, 5)
        mob:setMod(tpz.mod.SDT_LIGHT, 150)
        mob:setMod(tpz.mod.EEM_LIGHT_SLEEP, 150)
        mob:setMod(tpz.mod.EEM_CHARM, 150)
    end
end

function SetClusterDrops(mob)
    local element_drop = 
    {
        [tpz.magic.ele.FIRE] = 4104,
        [tpz.magic.ele.ICE] = 4105,
        [tpz.magic.ele.WIND] = 4106,
        [tpz.magic.ele.EARTH] = 4107,
        [tpz.magic.ele.LIGHTNING] = 4108,
        [tpz.magic.ele.WATER] = 4109,
        [tpz.magic.ele.LIGHT] = 4110,
        [tpz.magic.ele.DARK] = 4111,
    }
    if mob:getPool() == 1241 then -- Eo'Ghrah
        for v = 4104, 4111 do
            SetDropRate(777, v, 0)
        end
        SetDropRate(777, element_drop[mob:getLocalVar("element")], 50)
    elseif mob:getPool() == 300 then -- Aw'Ghrah
        for v = 4104, 4111 do
            SetDropRate(200, v, 0)
        end
        SetDropRate(200, element_drop[mob:getLocalVar("element")], 50)
    end
end

return g_mixins.families.ghrah
