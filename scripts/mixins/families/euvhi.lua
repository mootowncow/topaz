require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}
-- opens/closed based on animation sub
-- 4 = closed(petal) 6 = open(bloomed)
-- Closed Euvhi is predicted base damage, open Euvhi is Base damage * 1.5.

-- will go into closed mode when it takes a hit of at least 350 damage,
-- and will unclose after 80 seconds.					

function CheckForm(mob)
    if mob:AnimationSub() == 4 then -- Petal
        PetalMods(mob)
    elseif mob:AnimationSub() == 6 then -- Bloomed
        BloomedMods(mob)
    end
end

function CheckFormRoaming(mob)
    if mob:AnimationSub() == 4 then -- Petal
        PetalRoamMods(mob)
    elseif mob:AnimationSub() == 6 then -- Bloomed
        BloomedRoamMods(mob)
    end
end

function petal_form(mob)
    PetalMods(mob)
    mob:AnimationSub(4)
end

function bloomed_form(mob)
    BloomedMods(mob)
    mob:AnimationSub(6)
end

function PetalMods(mob)
    if mob:getLocalVar("petalMods") == 0 then
        mob:setLocalVar("petalMods", 1)
        mob:setLocalVar("bloomedMods", 0)
        mob:setLocalVar("changeTime", os.time() + 80)
        mob:setLocalVar("damageTaken", 0)
        mob:setDamage(mob:getMainLvl() + 2) -- Normal weapon damage
        mob:addMod(tpz.mod.DEFP, 100) 
        mob:setDelay(4000)
    end
end

function BloomedMods(mob)
    if mob:getLocalVar("bloomedMods") == 0 then
        mob:setLocalVar("petalMods", 0)
        mob:setLocalVar("bloomedMods", 1)
        mob:setDamage(math.floor(mob:getWeaponDmg() * 1.5)) -- Weapon damage * 1.5
        mob:setDelay(3000)
        mob:delMod(tpz.mod.DEFP, 100)
    end
end

function PetalRoamMods(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
    mob:setMobMod(tpz.mobMod.LINK_RADIUS, 11)
    mob:setMobMod(tpz.mobMod.ROAM_DISTANCE, 3)
    mob:setMobMod(tpz.mobMod.ROAM_COOL, 30)
    mob:setAggressive(0)
end

function BloomedRoamMods(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.LINK_RADIUS, 0)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 11)
    mob:setAggressive(1)
end


g_mixins.families.euvhi = function(mob)
    mob:addListener("SPAWN", "EUVHI_SPAWN", function(mob)
        CheckForm(mob)
    end)

    mob:addListener("ROAM_TICK", "EUVHI_ROAM", function(mob)
        CheckFormRoaming(mob)
    end)

    mob:addListener("ENGAGE", "EUVHI_ENGAGE", function(mob, target)
        if mob:AnimationSub() == 4 then -- Petal
            mob:setLocalVar("changeTime", os.time() + 80)
            PetalMods(mob)
        end
        mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
    end)

    mob:addListener("DISENGAGE", "EUVHI_DISENGAGE", function(mob)
        CheckForm(mob)
    end)

    mob:addListener("TAKE_DAMAGE", "EUVHI_TAKE_DAMAGE", function(mob, damage, attacker, attackType, damageType)
        local damageTaken = mob:getLocalVar("damageTaken")
        local animationSub = mob:AnimationSub()
        -- Only track damage taken while open(bloomed)
        if (animationSub ~= 4) then
            mob:setLocalVar("damageTaken", mob:getLocalVar("damageTaken") + damage)
            if (damageTaken >= 350) and not IsMobBusy(mob) then  -- Goes into petal form after taking 350 damage
                petal_form(mob)
            end
        end
    end)


    mob:addListener("COMBAT_TICK", "EUVHI_CTICK", function(mob)
        -- Ensure the Euvhi won't stop moving mid fight
        mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
        local changeTime = mob:getLocalVar("changeTime")
        -- Open after 80 seconds
        if os.time() >= changeTime and mob:AnimationSub() == 4 then
            if mob:AnimationSub() == 4 and not IsMobBusy(mob) then
                bloomed_form(mob)
                mob:setLocalVar("changeTime", 0)
            end
        end
    end)

end

return g_mixins.families.euvhi
