---------------------------------------------
-- Astral Flow
-- make existing pet use astral flow skill
---------------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

local function petInactive(pet)
    return
        pet:hasStatusEffect(tpz.effect.LULLABY) or
        pet:hasStatusEffect(tpz.effect.STUN) or
        pet:hasStatusEffect(tpz.effect.PETRIFICATION) or
        pet:hasStatusEffect(tpz.effect.SLEEP_II) or
        pet:hasStatusEffect(tpz.effect.SLEEP_I) or
        pet:hasStatusEffect(tpz.effect.TERROR)
end

function onMobSkillCheck(target, mob, skill)
    -- must have pet
    if not mob:hasPet() then
        return 1
    end

    local pet = mob:getPet()

    -- pet must be an avatar, and active
    if pet:getSystem() ~= 5 or petInactive(pet) then
        return 1
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.ASTRAL_FLOW
    local pet = mob:getPet()

    skill:setMsg(tpz.msg.basic.USES)
    pet:setLocalVar("astralFlowEnabled", 1) -- Handled in elemental_spirit.lua
    mob:addStatusEffect(tpz.effect.ASTRAL_FLOW, 1, 0, 180)

    return typeEffect
end
