---------------------------------------------------
-- Ranged Attack
---------------------------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/automatonweaponskills")
require("scripts/globals/weaponskills")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onPetAbility(target, pet, skill)
    local numhits = 1
    local params = {}
    params.ftp100 = 3.0
    params.ftp200 = 3.0
    params.ftp300 = 3.0
    params.str_wsc = 0.0
    params.dex_wsc = 0.3
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.NO_TP_CONSUMPTION = true

    local damage = AutoPhysicalWeaponSkill(pet, target, skill, tpz.attackType.RANGED, numhits, TP_NONE, params)

    -- Check for Barrage Turbine attachment
    -- Like barrage, once an arrow misses, it stops trying to hit with other arrows
    local arrowCount = 1
    arrowCount = arrowCount + pet:getLocalVar("barrage_turbine")

    -- Handle Double Shot
    if (math.random(100) <= pet:getMod(tpz.mod.DOUBLE_SHOT_RATE)) then
        arrowCount = arrowCount +1
    end
    --printf("Arrow count %i", arrowCount)
    -- Roll for extra hits
    if (arrowCount > 1) then
        local hitrate = getRangedHitRate(pet, target, true, 0)
        while numhits < arrowCount do
            -- End early if mob will die
            if target:getHP() < dmg then
                break
            end
            if (math.random() <= hitrate) then
                numhits = numhits + 1
            else
                break
            end
        end
    end
    --printf("Number of arrows: %i", numhits)
    damage.dmg = damage.dmg * numhits
    pet:setLocalVar("barrage_turbine", 0)

    dmg = AutoPhysicalFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.RANGED, tpz.damageType.RANGED, damage.hitslanded, params)

    return dmg
end
