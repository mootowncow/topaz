-----------------------------------
-- Area: Beadeaux [S]
--  Mob: Observant Zekka
-- !pos 128 0.4 161
-- BLM/BLM
-- Immune to Silence, Paralyze, Sleep, Bind, Gravity, Break
-- Casts Blaze Spikes, T3 Nukes, Blind, Stun, Elemental Enfeebles(All BLM spells basically)
-- After using Abrasive Tantara he will counter magic with AM of that element, Holy, and Sleepga2 for ~90s
-- After using Deafening Tantara he will counter Weapon Skills with Frenetic Rip for ~90s
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/wotg")
require("scripts/globals/spell_data")
mixins = {require("scripts/mixins/families/imp")}
-----------------------------------

function onMobSpawn(mob)
    tpz.wotg.NMMods(mob)
end

function onMobFight(mob, target)
    local counterMode = mob:getLocalVar("counterMode")
    local modeTimer = mob:getLocalVar("modeTimer")
    local retaliated = mob:getLocalVar("retaliated")

    if (modeTimer >= os.time()) then
        if (counterMode == 1) then -- Magic Counter Mode
            -- After using Abrasive Tantara he will counter magic with AM of that element, Holy, and Sleepga2
            MagicCounter(mob, target)
        elseif (counterMode == 2) then -- WS counter mode
            -- After using Deafening Tantara he will counter Weapon Skills with Frenetic Rip
            WSCounter(mob, target)
        end
    end

    -- Make sure being WSed mid casting doesn't break him being able to Retaliate
    mob:addListener("MAGIC_STATE_EXIT", "ZEKKA_MAGIC_STATE_EXIT", function(mob, spell)
        mob:setLocalVar("retaliated", 0)
    end)
    mob:addListener("WEAPONSKILL_STATE_EXIT", "ZEKKA_STATE_EXIT", function(mob, skill)
        mob:setLocalVar("retaliated", 0)
    end)
end

function onMobWeaponSkillPrepare(mob, target)
    return math.random(1709, 1710)
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 1709 then  -- Abrasive Tantara
        mob:setLocalVar("counterMode", 1)
        mob:setLocalVar("modeTimer", os.time() + 90)
    elseif skill:getID() == 1710 then -- Deafening Tantara
        mob:setLocalVar("counterMode", 2)
        mob:setLocalVar("modeTimer", os.time() + 90)
    end

    if skill:getID() == 1711 then -- Frenetic Rip
        mob:setLocalVar("retaliated", 0)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.MagianT4(mob, player, isKiller, noKiller)
end

function MagicCounter(mob, target)
    local spellToMimic = mob:getLocalVar("[zekka]spellToMimic")
    mob:addListener("MAGIC_TAKE", "ZEKKA_MIMIC_MAGIC_TAKE", function(target, caster, spell)
        if
            spell:tookEffect() and
            (caster:isPC() or caster:isPet()) and
            (spell:getSpellGroup() ~= tpz.magic.spellGroup.BLUE) 
        then
            target:setLocalVar("[zekka]spellToMimic", getMimicSpell(target, spell)) -- which spell to mimic
        end
    end)

    if (spellToMimic > 0) then
        mob:setLocalVar("[zekka]spellToMimic", 0)
        mob:castSpell(spellToMimic)
    end
end

function WSCounter(mob, target)
    mob:addListener("WEAPONSKILL_TAKE", "ZEKKA_WEAPONSKILL_TAKE", function(target, user, wsid)
        target:setLocalVar("retaliated", 0)
        if target:checkDistance(user) <= 7 and target:getLocalVar("retaliated") == 0 and target:actionQueueEmpty() then
            target:setLocalVar("retaliated", 1)
            target:useMobAbility(1711, user) -- Frenetic Rip
        elseif target:checkDistance(user) > 7 and target:getLocalVar("retaliated") == 0 and target:actionQueueEmpty() then
            target:setLocalVar("retaliated", 1)
            local user = target:getTarget()
            target:useMobAbility(1711, user) -- Frenetic Rip
        end
    end)
end

function getMimicSpell(target, spell)
    local mimicspells =
    {
        { tpz.magic.ele.FIRE, 204 }, -- Flare
        { tpz.magic.ele.ICE, 206 }, -- Freeze
        { tpz.magic.ele.WIND, 208 }, -- Tornado
        { tpz.magic.ele.EARTH, 210 }, -- Quake
        { tpz.magic.ele.THUNDER, 212 }, -- Burst
        { tpz.magic.ele.WATER, 214 }, -- Flood
        { tpz.magic.ele.LIGHT, 21 }, -- Holy
        { tpz.magic.ele.DARK, 274 }, -- Sleepga II
    }
    local mimicSpellID = 0

    for _, element in pairs(mimicspells) do
        if spell:getElement() == element[1] then
            mimicSpellID = element[2]
        end
    end

    return mimicSpellID
end
