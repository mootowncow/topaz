-----------------------------------
-- Geomancer helpers
-----------------------------------
require("scripts/globals/pets")
require("scripts/globals/status")
-----------------------------------

tpz = tpz or {}
tpz.geo = tpz.geo or {}

local geoEffects =
{
    [tpz.magic.spell.INDI_REGEN] = tpz.effect.GEO_REGEN,
    [tpz.magic.spell.GEO_REGEN] = tpz.effect.GEO_REGEN,
    [tpz.magic.spell.INDI_POISON] = tpz.effect.GEO_POISON,
    [tpz.magic.spell.GEO_POISON] = tpz.effect.GEO_POISON,
    [tpz.magic.spell.INDI_REFRESH] = tpz.effect.GEO_REFRESH,
    [tpz.magic.spell.GEO_REFRESH] = tpz.effect.GEO_REFRESH,
    [tpz.magic.spell.INDI_HASTE] = tpz.effect.GEO_HASTE,
    [tpz.magic.spell.GEO_HASTE] = tpz.effect.GEO_HASTE,
    [tpz.magic.spell.INDI_STR] = tpz.effect.GEO_STR,
    [tpz.magic.spell.GEO_STR] = tpz.effect.GEO_STR,
    [tpz.magic.spell.INDI_DEX] = tpz.effect.GEO_DEX,
    [tpz.magic.spell.GEO_DEX] = tpz.effect.GEO_DEX,
    [tpz.magic.spell.INDI_VIT] = tpz.effect.GEO_VIT,
    [tpz.magic.spell.GEO_VIT] = tpz.effect.GEO_VIT,
    [tpz.magic.spell.INDI_AGI] = tpz.effect.GEO_AGI,
    [tpz.magic.spell.GEO_AGI] = tpz.effect.GEO_AGI,
    [tpz.magic.spell.INDI_INT] = tpz.effect.GEO_INT,
    [tpz.magic.spell.GEO_INT] = tpz.effect.GEO_INT,
    [tpz.magic.spell.INDI_MND] = tpz.effect.GEO_MND,
    [tpz.magic.spell.GEO_MND] = tpz.effect.GEO_MND,
    [tpz.magic.spell.INDI_CHR] = tpz.effect.GEO_CHR,
    [tpz.magic.spell.GEO_CHR] = tpz.effect.GEO_CHR,
    [tpz.magic.spell.INDI_FURY] = tpz.effect.GEO_ATTACK_BOOST,
    [tpz.magic.spell.GEO_FURY] = tpz.effect.GEO_ATTACK_BOOST,
    [tpz.magic.spell.INDI_BARRIER] = tpz.effect.GEO_DEFENSE_BOOST,
    [tpz.magic.spell.GEO_BARRIER] = tpz.effect.GEO_DEFENSE_BOOST,
    [tpz.magic.spell.INDI_ACUMEN] = tpz.effect.GEO_MAGIC_ATK_BOOST,
    [tpz.magic.spell.GEO_ACUMEN] = tpz.effect.GEO_MAGIC_ATK_BOOST,
    [tpz.magic.spell.INDI_FEND] = tpz.effect.GEO_MAGIC_DEF_BOOST,
    [tpz.magic.spell.GEO_FEND] = tpz.effect.GEO_MAGIC_DEF_BOOST,
    [tpz.magic.spell.INDI_PRECISION] = tpz.effect.GEO_ACCURACY_BOOST,
    [tpz.magic.spell.GEO_PRECISION] = tpz.effect.GEO_ACCURACY_BOOST,
    [tpz.magic.spell.INDI_VOIDANCE] = tpz.effect.GEO_EVASION_BOOST,
    [tpz.magic.spell.GEO_VOIDANCE] = tpz.effect.GEO_EVASION_BOOST,
    [tpz.magic.spell.INDI_FOCUS] = tpz.effect.GEO_MAGIC_ACC_BOOST,
    [tpz.magic.spell.GEO_FOCUS] = tpz.effect.GEO_MAGIC_ACC_BOOST,
    [tpz.magic.spell.INDI_ATTUNEMENT] = tpz.effect.GEO_MAGIC_EVASION_BOOST,
    [tpz.magic.spell.GEO_ATTUNEMENT] = tpz.effect.GEO_MAGIC_EVASION_BOOST,
    [tpz.magic.spell.INDI_WILT] = tpz.effect.GEO_ATTACK_DOWN,
    [tpz.magic.spell.GEO_WILT] = tpz.effect.GEO_ATTACK_DOWN,
    [tpz.magic.spell.INDI_FRAILTY] = tpz.effect.GEO_DEFENSE_DOWN,
    [tpz.magic.spell.GEO_FRAILTY] = tpz.effect.GEO_DEFENSE_DOWN,
    [tpz.magic.spell.INDI_FADE] = tpz.effect.GEO_MAGIC_ATK_DOWN,
    [tpz.magic.spell.GEO_FADE] = tpz.effect.GEO_MAGIC_ATK_DOWN,
    [tpz.magic.spell.INDI_MALAISE] = tpz.effect.GEO_MAGIC_DEF_DOWN,
    [tpz.magic.spell.GEO_MALAISE] = tpz.effect.GEO_MAGIC_DEF_DOWN,
    [tpz.magic.spell.INDI_SLIP] = tpz.effect.GEO_ACCURACY_DOWN,
    [tpz.magic.spell.GEO_SLIP] = tpz.effect.GEO_ACCURACY_DOWN,
    [tpz.magic.spell.INDI_TORPOR] = tpz.effect.GEO_EVASION_DOWN,
    [tpz.magic.spell.GEO_TORPOR] = tpz.effect.GEO_EVASION_DOWN,
    [tpz.magic.spell.INDI_VEX] = tpz.effect.GEO_MAGIC_ACC_DOWN,
    [tpz.magic.spell.GEO_VEX] = tpz.effect.GEO_MAGIC_ACC_DOWN,
    [tpz.magic.spell.INDI_LANGUOR] = tpz.effect.GEO_MAGIC_EVASION_DOWN,
    [tpz.magic.spell.GEO_LANGUOR] = tpz.effect.GEO_MAGIC_EVASION_DOWN,
    [tpz.magic.spell.INDI_SLOW] = tpz.effect.GEO_SLOW,
    [tpz.magic.spell.GEO_SLOW] = tpz.effect.GEO_SLOW,
    [tpz.magic.spell.INDI_PARALYSIS] = tpz.effect.GEO_PARALYSIS,
    [tpz.magic.spell.GEO_PARALYSIS] = tpz.effect.GEO_PARALYSIS,
    [tpz.magic.spell.INDI_GRAVITY] = tpz.effect.GEO_WEIGHT,
    [tpz.magic.spell.GEO_GRAVITY] = tpz.effect.GEO_WEIGHT
}

    local indiData =
    {
        [tpz.magic.spell.INDI_FURY] =
        {
            Tier = 30,
            Min = 5,
            Max = 35,
            GeomancyBonus = 2.7
        },

        [tpz.magic.spell.INDI_BARRIER] =
        {
            Tier = 30,
            Min = 10,
            Max = 40,
            GeomancyBonus = 4.6
        },

        [tpz.magic.spell.INDI_ACUMEN] =
        {
            Tier = 75,
            Min = 3,
            Max = 15,
            GeomancyBonus = 3
        },

        [tpz.magic.spell.INDI_FEND] =
        {
            Tier = 60,
            Min = 5,
            Max = 20,
            GeomancyBonus = 4,
        },

        [tpz.magic.spell.INDI_PRECISION] =
        {
            Tier = 18,
            Min = 1,
            Max = 50,
            GeomancyBonus = 5
        },

        [tpz.magic.spell.INDI_VOIDANCE] =
        {
            Tier = 14,
            Min = 1,
            Max = 65,
            GeomancyBonus = 6
        },

        [tpz.magic.spell.INDI_FOCUS] =
        {
            Tier = 18,
            Min = 1,
            Max = 50,
            GeomancyBonus = 5
        },

        [tpz.magic.spell.INDI_ATTUNEMENT] =
        {
            Tier = 14,
            Min = 1,
            Max = 65,
            GeomancyBonus = 6
        },

        [tpz.magic.spell.INDI_WILT] =
        {
            Tier = 44,
            Min = 5,
            Max = 25,
            GeomancyBonus = 4.6
        },

        [tpz.magic.spell.INDI_FRAILTY] =
        {
            Tier = 64,
            Min = 3,
            Max = 15,
            GeomancyBonus = 2.7
        },

        [tpz.magic.spell.INDI_MALAISE] =
        {
            Tier = 75,
            Min = 3,
            Max = 15,
            GeomancyBonus = 3
        },

        [tpz.magic.spell.INDI_SLIP] =
        {
            Tier = 14,
            Min = 1,
            Max = 65,
            GeomancyBonus = 6
        },

        [tpz.magic.spell.INDI_TORPOR] =
        {
            Tier = 18,
            Min = 1,
            Max = 50,
            GeomancyBonus = 5
        },

        [tpz.magic.spell.INDI_VEX] =
        {
            Tier = 14,
            Min = 1,
            Max = 65,
            GeomancyBonus = 6
        },

        [tpz.magic.spell.INDI_LANGUOR] =
        {
            Tier = 18,
            Min = 1,
            Max = 50,
            GeomancyBonus = 5
        },

        [tpz.magic.spell.INDI_SLOW] =
        {
            Tier = 64,
            Min = 9,
            Max = 1490,
            GeomancyBonus = 50
        },

        [tpz.magic.spell.INDI_PARALYSIS] =
        {
            Tier = 64,
            Min = 1,
            Max = 15,
            GeomancyBonus = 1
        },

        [tpz.magic.spell.INDI_GRAVITY] =
        {
            Tier = 56,
            Min = 4,
            Max = 20,
            GeomancyBonus = 1.1
        },

        [tpz.magic.spell.INDI_POISON] =
        {
            Tier = 20,
            Min = 1,
            Max = 30,
            GeomancyBonus = 3
        },

        [tpz.magic.spell.INDI_REGEN] =
        {
            Tier = 20,
            Min = 1,
            Max = 30,
            GeomancyBonus = 2
        },

        [tpz.magic.spell.INDI_REFRESH] =
        {
            Tier = 120,
            Min = 1,
            Max = 6,
            GeomancyBonus = 1
        },

        [tpz.magic.spell.INDI_HASTE] =
        {
            Tier = 33,
            Min = 240,
            Max = 2990,
            GeomancyBonus = 110
        },

        [tpz.magic.spell.INDI_STR] =
        {
            Tier = 37,
            Min = 1,
            Max = 25,
            GeomancyBonus = 2
        },

        [tpz.magic.spell.INDI_DEX] =
        {
            Tier = 37,
            Min = 1,
            Max = 25,
            GeomancyBonus = 2
        },

        [tpz.magic.spell.INDI_VIT] =
        {
            Tier = 37,
            Min = 1,
            Max = 25,
            GeomancyBonus = 2
        },

        [tpz.magic.spell.INDI_AGI] =
        {
            Tier = 37,
            Min = 1,
            Max = 25,
            GeomancyBonus = 2
        },

        [tpz.magic.spell.INDI_INT] =
        {
            Tier = 37,
            Min = 1,
            Max = 25,
            GeomancyBonus = 2
        },

        [tpz.magic.spell.INDI_MND] =
        {
            Tier = 37,
            Min = 1,
            Max = 25,
            GeomancyBonus = 2
        },

        [tpz.magic.spell.INDI_CHR] =
        {
            Tier = 37,
            Min = 1,
            Max = 25,
            GeomancyBonus = 2
        },
    }

    local geoData =
    {
        [tpz.magic.spell.GEO_FURY] =
        {
            Tier = 30,
            Min = 5,
            Max = 35,
            GeomancyBonus = 2.7
        },

        [tpz.magic.spell.GEO_BARRIER] =
        {
            Tier = 30,
            Min = 10,
            Max = 40,
            GeomancyBonus = 4.6
        },

        [tpz.magic.spell.GEO_ACUMEN] =
        {
            Tier = 75,
            Min = 3,
            Max = 15,
            GeomancyBonus = 3
        },

        [tpz.magic.spell.GEO_FEND] =
        {
            Tier = 60,
            Min = 5,
            Max = 20,
            GeomancyBonus = 4
        },

        [tpz.magic.spell.GEO_PRECISION] =
        {
            Tier = 18,
            Min = 1,
            Max = 50,
            GeomancyBonus = 5
        },

        [tpz.magic.spell.GEO_VOIDANCE] =
        {
            Tier = 14,
            Min = 1,
            Max = 65,
            GeomancyBonus = 6
        },

        [tpz.magic.spell.GEO_FOCUS] =
        {
            Tier = 18,
            Min = 1,
            Max = 50,
            GeomancyBonus = 5
        },

        [tpz.magic.spell.GEO_ATTUNEMENT] =
        {
            Tier = 14,
            Min = 1,
            Max = 65,
            GeomancyBonus = 6
        },

        [tpz.magic.spell.GEO_WILT] =
        {
            Tier = 44,
            Min = 5,
            Max = 25,
            GeomancyBonus = 4.6
        },

        [tpz.magic.spell.GEO_FRAILTY] =
        {
            Tier = 64,
            Min = 3,
            Max = 15,
            GeomancyBonus = 2.7
        },

        [tpz.magic.spell.GEO_MALAISE] =
        {
            Tier = 75,
            Min = 3,
            Max = 15,
            GeomancyBonus = 3
        },

        [tpz.magic.spell.GEO_SLIP] =
        {
            Tier = 14,
            Min = 1,
            Max = 65,
            GeomancyBonus = 6
        },

        [tpz.magic.spell.GEO_TORPOR] =
        {
            Tier = 18,
            Min = 1,
            Max = 50,
            GeomancyBonus = 5
        },

        [tpz.magic.spell.GEO_VEX] =
        {
            Tier = 14,
            Min = 1,
            Max = 65,
            GeomancyBonus = 6
        },

        [tpz.magic.spell.GEO_LANGUOR] =
        {
            Tier = 18,
            Min = 1,
            Max = 50,
            GeomancyBonus = 5
        },

        [tpz.magic.spell.GEO_SLOW] =
        {
            Tier = 64,
            Min = 9,
            Max = 1490,
            GeomancyBonus = 50
        },

        [tpz.magic.spell.GEO_PARALYSIS] =
        {
            Tier = 64,
            Min = 1,
            Max = 15,
            GeomancyBonus = 1
        },

        [tpz.magic.spell.GEO_GRAVITY] =
        {
            Tier = 56,
            Min = 4,
            Max = 20,
            GeomancyBonus = 1.1
        },

        [tpz.magic.spell.GEO_POISON] =
        {
            Tier = 20,
            Min = 1,
            Max = 30,
            GeomancyBonus = 3
        },

        [tpz.magic.spell.GEO_REGEN] =
        {
            Tier = 20,
            Min = 1,
            Max = 30,
            GeomancyBonus = 2
        },

        [tpz.magic.spell.GEO_REFRESH] =
        {
            Tier = 120,
            Min = 1,
            Max = 6,
            GeomancyBonus = 1
        },

        [tpz.magic.spell.GEO_HASTE] =
        {
            Tier = 33,
            Min = 240,
            Max = 2990,
            GeomancyBonus = 110
        },

        [tpz.magic.spell.GEO_STR] =
        {
            Tier = 37,
            Min = 1,
            Max = 25,
            GeomancyBonus = 2
        },

        [tpz.magic.spell.GEO_DEX] =
        {
            Tier = 37,
            Min = 1,
            Max = 25,
            GeomancyBonus = 2
        },

        [tpz.magic.spell.GEO_VIT] =
        {
            Tier = 37,
            Min = 1,
            Max = 25,
            GeomancyBonus = 2
        },

        [tpz.magic.spell.GEO_AGI] =
        {
            Tier = 37,
            Min = 1,
            Max = 25,
            GeomancyBonus = 2
        },

        [tpz.magic.spell.GEO_INT] =
        {
            Tier = 37,
            Min = 1,
            Max = 25,
            GeomancyBonus = 2
        },

        [tpz.magic.spell.GEO_MND] =
        {
            Tier = 37,
            Min = 1,
            Max = 25,
            GeomancyBonus = 2
        },

        [tpz.magic.spell.GEO_CHR] =
        {
            Tier = 37,
            Min = 1,
            Max = 25,
            GeomancyBonus = 2
        },
    }

-- TODO: After elements are aligned in the codebase, this should become:
-- tpz.geo.spawnLuopan = function(player, target, spell, tick_effect, tick_power, target_type)
tpz.geo.spawnLuopan = function(player, target, modelID, tick_effect, tick_power, target_type, spell)

    tpz.pet.spawnPet(player, tpz.pet.id.LUOPAN)
    local luopan = player:getPet()

    -- Attach effect
    luopan:addStatusEffectEx(tpz.effect.COLURE_ACTIVE, tpz.effect.COLURE_ACTIVE, 0, 3, 0, tick_effect, tick_power, target_type, tpz.effectFlag.AURA)

    -- Save the mp cost for use with Full Circle
    luopan:setLocalVar("MP_COST", spell:getMPCost())

    -- Change the luopans appearance to match the effect
    -- TODO: This is should be the element of the spell being cast added as an offset
    --       on top of a base model ID in core.
    luopan:setModelId(modelID)

    -- Set HP loss over time
    luopan:addMod(tpz.mod.REGEN_DOWN, luopan:getMainLvl() / 4)

    -- Innate Damage Taken -50%
    luopan:addMod(tpz.mod.UDMGPHYS, -50)
    luopan:addMod(tpz.mod.UDMGBREATH, -50)
    luopan:addMod(tpz.mod.UDMGMAGIC, -50)
    luopan:addMod(tpz.mod.UDMGRANGE, -50)
end

tpz.geo.doIndiSpell = function(caster, target, spell)
    local spellId = spell:getID()
    local currentSpell = indiData[spellId]

    if not currentSpell then return end

    local notEntrust = caster:getID() == target:getID()
    local combinedSkill = caster:getSkillLevel(tpz.skill.GEOMANCY) + caster:getSkillLevel(tpz.skill.HANDBELL)
    local power = math.floor(combinedSkill / currentSpell.Tier) + currentSpell.Min
    local radius = 6 + caster:getMod(tpz.mod.AURA_RADIUS) -- TODO: Wide compass effect
    local tick = 3
    local duration = 180 + caster:getMod(tpz.mod.INDI_DURATION)
    -- TODO: augments is a second multiplicative term similar to how Enhancing Magic Duration functions.

    -- Clamp to minimum and maximum values
    power = utils.clamp(power, currentSpell.Min, currentSpell.Max)

    if notEntrust then
        -- Add +Geomancy bonus
        -- An Indicolure spell cast on another party member with Entrust active will not factor in Geomancy+ equipment from the caster.
        power = power + math.floor(caster:getMod(tpz.mod.GEOMANCY) * currentSpell.GeomancyBonus)

        -- Add Bolster
        if caster:hasStatusEffect(tpz.effect.BOLSTER) then
            power = power * 2
        end
    end

    target:addStatusEffectEx(tpz.effect.COLURE_ACTIVE, tpz.effect.COLURE_ACTIVE, radius, tick, duration, geoEffects[spellId], power, tpz.auraTarget.ALLIES, tpz.effectFlag.AURA)
    caster:delStatusEffectSilent(tpz.effect.ENTRUST)

    return tpz.effect.COLURE_ACTIVE
end

tpz.geo.doGeomancySpell = function(caster, target, spell)
    local spellId = spell:getID()
    local currentSpell = geoData[spellId]

    if not currentSpell then return end

    local combinedSkill = caster:getSkillLevel(tpz.skill.GEOMANCY) + caster:getSkillLevel(tpz.skill.HANDBELL)
    local power = math.floor(combinedSkill / currentSpell.Tier) + currentSpell.Min

    -- Clamp to minimum and maximum values
    power = utils.clamp(power, currentSpell.Min, currentSpell.Max)

    -- Add +Geomancy bonus
    -- An Indicolure spell cast on another party member with Entrust active will not factor in Geomancy+ equipment from the caster.
    power = power + math.floor(caster:getMod(tpz.mod.GEOMANCY) * currentSpell.GeomancyBonus)

    -- Add Bolster
    if caster:hasStatusEffect(tpz.effect.BOLSTER) then
        power = power * 2
    end

    -- TODO: Wide compass effect
    -- TODO: Change the luopans appearance to match the effect, NOT hardcoded model ID (2856) Maybe add to geoData table?
    tpz.geo.spawnLuopan(caster, target, 2856, geoEffects[spellId], power, tpz.auraTarget.ALLIES, spell)
end
