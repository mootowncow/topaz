---------------------------------------------------
-- Ranged Attack
---------------------------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/automatonweaponskills")
require("scripts/globals/weaponskills")
require("scripts/globals/utils")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onPetAbility(target, pet, skill)
    local numhits = 1
    local params = {}
    params.ftp100 = 2.0
    params.ftp200 = 2.0
    params.ftp300 = 2.0
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.NO_TP_CONSUMPTION = true

    local damage = AutoPhysicalWeaponSkill(pet, target, skill, tpz.attackType.RANGED, numhits, TP_NONE, params)

    -- Check for Barrage Turbine attachment
    -- Like barrage, once an arrow misses, it stops trying to hit with other arrows
    local master = pet:getMaster()
    local arrowCount = 1
    arrowCount = arrowCount + pet:getLocalVar("barrage_turbine")

    -- Handle Double Shot
    if (math.random(100) <= pet:getMod(tpz.mod.DOUBLE_SHOT_RATE)) then
        arrowCount = arrowCount +1
    end
    --printf("Arrow count %i", arrowCount)
    -- Roll for extra hits
    if (arrowCount > 1) then
        local hitrate = pet:getRangedHitRate(target, false, 0, false)
        while numhits < arrowCount do
            -- TODO: End early if mob will die
            if (math.random() <= hitrate) then
                numhits = numhits + 1
            else
                break
            end
        end
    end

    damage.dmg = damage.dmg * numhits
    pet:setLocalVar("barrage_turbine", 0)
    pet:delStatusEffectSilent(tpz.effect.BARRAGE)

    dmg = AutoPhysicalFinalAdjustments(damage.dmg, pet, skill, target, tpz.attackType.RANGED, tpz.damageType.RANGED, damage.hitslanded, params)

    local tpGained = pet:getTPToAttacker(tpz.slot.RANGED, tpz.physicalAttackType.NORMAL, 1)
    local tpGiven = pet:getTPToVictim(target, tpz.slot.RANGED, tpz.physicalAttackType.NORMAL, 1)

    -- Add TP to self and give TP to target based on number of hits succesfully landed
    if numhits > 1 then
        -- First hit is calculated in automatically, additional hits are not
        tpGained = tpGained * (numhits - 1)
        tpGiven = tpGiven * (numhits - 1)
        pet:addTP(tpGained)
        target:addTP(tpGiven)
        --printf("Number of hits: %d, Gained: %d, Given: %d", numhits, tpGained, tpGiven)
    end

    -- Try to skill up per number of arrows succesfully landed
    if (dmg > 0) then
        master:trySkillUp(target, tpz.skill.AUTOMATON_RANGED, numhits)
    end

    return dmg
end
