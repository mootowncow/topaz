require("scripts/globals/mixins")
require("scripts/globals/status")
-----------------------------------

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function dive(mob)
    -- Only dive while roaming if the variable "[hpemde]dive" is set to 1 or higher
    if mob:getLocalVar("[hpemde]dive") > 0 then
        mob:hideName(true)
        mob:untargetable(true)
        mob:SetAutoAttackEnabled(false)
        mob:SetMobAbilityEnabled(false)
        mob:AnimationSub(5)
    end
end

local function surface(mob)
    mob:hideName(false)
    mob:untargetable(false)
    local animationSub = mob:AnimationSub()
    if animationSub == 0 or animationSub == 5 then
        mob:AnimationSub(6)
        mob:wait(2000)
    end
end

local function openMouth(mob)
    if not IsMobBusy(mob) then
        mob:setDamage(math.floor(mob:getWeaponDmg() * 2)) -- Weapon damage * 2
        mob:addMod(tpz.mod.UDMGPHYS, 100)
        mob:addMod(tpz.mod.UDMGBREATH, 100)
        mob:addMod(tpz.mod.UDMGMAGIC, 100)
        mob:addMod(tpz.mod.UDMGRANGE, 100)
        mob:setLocalVar("[hpemde]changeTime", mob:getBattleTime() + 30)
        mob:AnimationSub(3)
        mob:wait(2000)
    end
end

local function closeMouth(mob)
    if not IsMobBusy(mob) then
        mob:setDamage(mob:getMainLvl() + 2) -- Normal weapon damage
        mob:delMod(tpz.mod.UDMGPHYS, 100)
        mob:delMod(tpz.mod.UDMGBREATH, 100)
        mob:delMod(tpz.mod.UDMGMAGIC, 100)
        mob:delMod(tpz.mod.UDMGRANGE, 100)
        mob:setLocalVar("[hpemde]changeTime", mob:getBattleTime() + 30)
        mob:setLocalVar("damageTaken", 0)
        mob:AnimationSub(6)
        mob:wait(2000)
    end
end

g_mixins.families.hpemde = function(mob)
    mob:addListener("SPAWN", "HPEMDE_SPAWN", function(mob)
        mob:setMod(tpz.mod.REGEN, 10)
        dive(mob)
    end)

    mob:addListener("ROAM_TICK", "HPEMDE_RTICK", function(mob)
        if mob:getHPP() == 100 then
            mob:setLocalVar("[hpemde]damaged", 0)
        end
        if mob:AnimationSub() ~= 5 then
            dive(mob)
        end
    end)

    mob:addListener("ENGAGE", "HPEMDE_ENGAGE", function(mob, target)
        mob:setLocalVar("[hpemde]disengageTime",  mob:getBattleTime() + 45)
        surface(mob)
    end)

    mob:addListener("MAGIC_TAKE", "HPEMDE_MAGIC_TAKE", function(target, caster, spell)
        target:setLocalVar("[hpemde]disengageTime",  target:getBattleTime() + 45)
    end)

    mob:addListener("TAKE_DAMAGE", "HPEMDE_TAKE_DAMAGE", function(mob, damage, attacker, attackType, damageType)
        local damageTaken = mob:getLocalVar("damageTaken")
        local animationSub = mob:AnimationSub()
        -- Only track damage taken while open
        if (animationSub == 3) then
            mob:setLocalVar("damageTaken", mob:getLocalVar("damageTaken") + damage)
            if (damageTaken >= 250) then  -- Closes mouth after taking >= 250 damage
                closeMouth(mob)
            end
        end
    end)

    mob:addListener("COMBAT_TICK", "HPEMDE_CTICK", function(mob)
        if mob:getLocalVar("[hpemde]damaged") == 0 then
            local disengageTime = mob:getLocalVar("[hpemde]disengageTime")

            if mob:getHP() < mob:getMaxHP() then
                mob:SetAutoAttackEnabled(true)
                mob:SetMobAbilityEnabled(true)
                mob:setLocalVar("[hpemde]damaged", 1)
                mob:setLocalVar("[hpemde]changeTime", mob:getBattleTime() + 30)
            elseif disengageTime > 0 and mob:getBattleTime() > disengageTime then
                mob:setLocalVar("[hpemde]disengageTime",  0)
                mob:disengage()
            end
        else
            if mob:AnimationSub() == 6 and mob:getBattleTime() > mob:getLocalVar("[hpemde]changeTime") then
                openMouth(mob)
            end
        end
    end)
end

return g_mixins.families.hpemde
