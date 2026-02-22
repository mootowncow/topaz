-- mammet family mixin

require("scripts/globals/mixins")
require("scripts/globals/utils")
require("scripts/globals/mobs")
require("scripts/globals/status")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.mammet = function(mob)
    mob:addListener("SPAWN", "MAMMET_SPAWN", function(mob)
        local baseDamage = mob:getWeaponDmg()
        mob:setLocalVar("baseDamage", baseDamage)
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 10)
        mob:SetMagicCastingEnabled(false)
    end)

    mob:addListener("COMBAT_TICK", "MAMMET_COMBAT", function(mob)
        if not IsMobBusy(mob) and not mob:hasPreventActionEffect() then
            if ((mob:getBattleTime() > mob:getLocalVar('weaponSwap') + 60 or mob:getLocalVar('weaponSwap') == 0) and math.random(0, 1) == 1
                and not mob:hasStatusEffect(tpz.effect.FOOD)) then
                ChangeWeapon(mob)
            end
        end
    end)
end

function ChangeWeapon(mob)
    local weapon =
    {
        H2H = 0,
        SWORD = 1,
        POLEARM = 2,
        STAFF = 3,
    }
    local baseDamage = mob:getLocalVar("baseDamage")
    local newWeapon = math.random(0, 3)

    -- Guarantee that a new weapon will be selected
    while mob:AnimationSub() == newWeapon do
        newWeapon = math.random(0, 3)
    end

    -- Mammets: Staff gets + 35 MAB,  Delay: Unarmed 130 / Sword 115 / Spear 320 / Staff 240
    -- "Unarmed normal, Staff are Attack * .5, Sword are D * 1.4, Polearm is D * 1.4 + Attack * 2"
    if (newWeapon == weapon.H2H) then
        utils.DelDynamicMod(mob, tpz.mod.ATTP)
        utils.DelDynamicMod(mob, tpz.mod.MATT)
        mob:setDamage(baseDamage)
        mob:setDelay(1300)
        mob:SetMagicCastingEnabled(false)
    elseif (newWeapon == weapon.SWORD) then
        utils.DelDynamicMod(mob, tpz.mod.ATTP)
        utils.DelDynamicMod(mob, tpz.mod.MATT)
        mob:setDamage(math.floor(baseDamage * 1.4))
		mob:setDelay(1150)
        mob:SetMagicCastingEnabled(false)
    elseif (newWeapon == weapon.POLEARM) then
        utils.AddDynamicMod(mob, tpz.mod.ATTP, 100)
        utils.DelDynamicMod(mob, tpz.mod.MATT)
        mob:setDamage(math.floor(baseDamage * 1.4))
		mob:setDelay(3200)
        mob:SetMagicCastingEnabled(false)
    elseif (newWeapon == weapon.STAFF) then
        utils.AddDynamicMod(mob, tpz.mod.ATTP, -50)
        utils.AddDynamicMod(mob, tpz.mod.MATT, 35)
        mob:setDamage(math.floor(baseDamage))
		mob:setDelay(2400)
        mob:SetMagicCastingEnabled(true)
    end
    mob:AnimationSub(newWeapon)
    mob:setLocalVar('weaponSwap', mob:getBattleTime())
end

return g_mixins.families.mammet
