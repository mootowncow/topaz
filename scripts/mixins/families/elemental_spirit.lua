require("scripts/globals/mixins")
require("scripts/globals/status")
require("scripts/globals/dynamis")
require("scripts/globals/utils")
require("scripts/globals/mobs")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

avatars =
{
   [8] = 'Fire Spirit',
   [9] = 'Ice Spirit',
   [10] = 'Air Spirit',
   [11] = 'Earth Spirit',
   [12] = 'Water Spirit',
   [13] = 'Thunder Spirit',
   [14] = 'Light Spirit',
   [15] = 'Dark Spirit',
   [16] = 'Carbuncle',
   [17] = 'Fenrir',
   [18] = 'Ifrit',
   [19] = 'Titan',
   [20] = 'Leviathan',
   [21] = 'Garuda',
   [22] = 'Shiva',
   [23] = 'Ramuh',
   [25] = 'Diabolos',
   [2159] = 'Cait Sith'
}

function setResistances(mob)
    local pet = avatars[mob:getModelId()]

    if (pet == nil) then
      return
    end

    if (pet == 'Fire Spirit') or (pet == 'Ifrit') then
        mob:setMod(tpz.mod.SDT_FIRE, 5)
        mob:setMod(tpz.mod.SDT_ICE, 5)
        mob:setMod(tpz.mod.SDT_WATER, 150)
        mob:setMod(tpz.mod.EEM_AMNESIA, 5)
        mob:setMod(tpz.mod.EEM_VIRUS, 5)
        mob:setMod(tpz.mod.EEM_PARALYZE, 5)
        mob:setMod(tpz.mod.EEM_BIND, 5)
        mob:setMod(tpz.mod.EEM_POISON, 150)
        mob:setSpellList(17)
    elseif (pet == 'Ice Spirit') or (pet == 'Shiva') then
        mob:setMod(tpz.mod.SDT_FIRE, 150)
        mob:setMod(tpz.mod.SDT_ICE, 5)
        mob:setMod(tpz.mod.SDT_WIND, 5)
        mob:setMod(tpz.mod.EEM_AMNESIA, 150)
        mob:setMod(tpz.mod.EEM_VIRUS, 150)
        mob:setMod(tpz.mod.EEM_SILENCE, 5)
        mob:setMod(tpz.mod.EEM_GRAVITY, 5)
        mob:setMod(tpz.mod.EEM_PARALYZE, 5)
        mob:setMod(tpz.mod.EEM_BIND, 5)
        mob:setSpellList(14)
    elseif (pet == 'Air Spirit') or (pet == 'Garuda') then
        mob:setMod(tpz.mod.SDT_ICE, 150)
        mob:setMod(tpz.mod.SDT_WIND, 5)
        mob:setMod(tpz.mod.SDT_EARTH, 5)
        mob:setMod(tpz.mod.EEM_SILENCE, 5)
        mob:setMod(tpz.mod.EEM_GRAVITY, 5)
        mob:setMod(tpz.mod.EEM_PARALYZE, 150)
        mob:setMod(tpz.mod.EEM_BIND, 150)
        mob:setMod(tpz.mod.EEM_SLOW, 5)
        mob:setMod(tpz.mod.EEM_PETRIFY, 5)
        mob:setMod(tpz.mod.EEM_TERROR, 5)
        mob:setSpellList(12)
    elseif (pet == 'Earth Spirit') or (pet == 'Titan') then
        mob:setMod(tpz.mod.SDT_WIND, 150)
        mob:setMod(tpz.mod.SDT_EARTH, 5)
        mob:setMod(tpz.mod.SDT_THUNDER, 5)
        mob:setMod(tpz.mod.EEM_SILENCE, 150)
        mob:setMod(tpz.mod.EEM_GRAVITY, 150)
        mob:setMod(tpz.mod.EEM_STUN, 5)
        mob:setMod(tpz.mod.EEM_SLOW, 5)
        mob:setMod(tpz.mod.EEM_PETRIFY, 5)
        mob:setMod(tpz.mod.EEM_TERROR, 5)
        mob:setSpellList(13)
    elseif (pet == 'Thunder Spirit') or (pet == 'Ramuh') then
        mob:setMod(tpz.mod.SDT_EARTH, 150)
        mob:setMod(tpz.mod.SDT_THUNDER, 5)
        mob:setMod(tpz.mod.SDT_WATER, 5)
        mob:setMod(tpz.mod.EEM_STUN, 5)
        mob:setMod(tpz.mod.EEM_SLOW, 150)
        mob:setMod(tpz.mod.EEM_PETRIFY, 150)
        mob:setMod(tpz.mod.EEM_TERROR, 150)
        mob:setMod(tpz.mod.EEM_POISON, 5)
        mob:setSpellList(16)
    elseif (pet == 'Water Spirit') or (pet == 'Leviathan') then
        mob:setMod(tpz.mod.SDT_FIRE, 5)
        mob:setMod(tpz.mod.SDT_THUNDER, 150)
        mob:setMod(tpz.mod.SDT_WATER, 5)
        mob:setMod(tpz.mod.EEM_AMNESIA, 5)
        mob:setMod(tpz.mod.EEM_VIRUS, 5)
        mob:setMod(tpz.mod.EEM_STUN, 150)
        mob:setMod(tpz.mod.EEM_POISON, 5)
        mob:setSpellList(15)
    elseif (pet == 'Light Spirit') or (pet == 'Carbuncle') or (pet == 'Cait Sith') then
        mob:setMod(tpz.mod.SDT_LIGHT, 5)
        mob:setMod(tpz.mod.SDT_DARK, 150)
        mob:setMod(tpz.mod.EEM_LIGHT_SLEEP, 5)
        mob:setMod(tpz.mod.EEM_CHARM, 5)
        mob:setMod(tpz.mod.EEM_DARK_SLEEP, 150)
        mob:setMod(tpz.mod.EEM_BLIND, 150)
        mob:setSpellList(19)
    elseif (pet == 'Dark Spirit') or (pet == 'Fenrir') or (pet == 'Diabolos') then
        mob:setMod(tpz.mod.SDT_LIGHT, 150)
        mob:setMod(tpz.mod.SDT_DARK, 5)
        mob:setMod(tpz.mod.EEM_LIGHT_SLEEP, 150)
        mob:setMod(tpz.mod.EEM_CHARM, 150)
        mob:setMod(tpz.mod.EEM_DARK_SLEEP, 5)
        mob:setMod(tpz.mod.EEM_BLIND, 5)
        mob:setSpellList(18)
    end
end

function setSpellList(mob)
    local pet = avatars[mob:getModelId()]

    if (pet ~= nil) and not string.match(pet, 'Spirit') then
        mob:setSpellList(0)
    end
end

g_mixins.families.elemental_spirit = function(mob)
    mob:addListener("SPAWN", "ELEMENTAL_SPIRIT_SPAWN", function(mob)
        -- First set all SDT's and EEM's to 100
        for v = tpz.mod.SDT_FIRE, tpz.mod.SDT_DARK, 1 do
            mob:setMod(v, 100)
        end
        for v = tpz.mod.EEM_AMNESIA, tpz.mod.EEM_BLIND, 1 do
            mob:setMod(v, 100)
        end

        -- Set specific SDT and EEM
        setResistances(mob)
        -- Set avatar spell lists to 0
        setSpellList(mob)
    end)

    mob:addListener("COMBAT_TICK", "ES_COMBAT", function(mob, target)
        local master = mob:getMaster()
        local astralFlowEnabled = mob:getLocalVar("astralFlowEnabled")

        if
            master:hasStatusEffect(tpz.effect.ASTRAL_FLOW) and
            (astralFlowEnabled == 1) and
            not IsMobBusy(mob) and
            not mob:hasPreventActionEffect()
        then
            -- Find proper pet skill
            local petFamily = mob:getFamily()
            local skillId = 0

            if     petFamily == 34 or petFamily == 379 then skillId = 919 -- carbuncle searing light
            elseif petFamily == 36 or petFamily == 381 then skillId = 839 -- fenrir    howling moon
            elseif petFamily == 37 or petFamily == 382 then skillId = 916 -- garuda    aerial blast
            elseif petFamily == 38 or petFamily == 383 then skillId = 913 -- ifrit     inferno
            elseif petFamily == 40 or petFamily == 384 then skillId = 915 -- leviathan tidal wave
            elseif petFamily == 43 or petFamily == 386 then skillId = 918 -- ramuh     judgment bolt
            elseif petFamily == 44 or petFamily == 387 then skillId = 917 -- shiva     diamond dust
            elseif petFamily == 45 or petFamily == 388 then skillId = 914 -- titan     earthen fury
            else
                printf("[elemental_spirit] received unexpected pet family %i. Defaulted skill to Searing Light.", petFamily)
                skillId = 919 -- searing light
            end

            if (skillId > 0) then
                mob:useMobAbility(skillId)
            end
        end
    end)

    mob:addListener("WEAPONSKILL_STATE_EXIT", "ES_WS_EXIT", function(mob, skillId)
        local astralFlowIds = {
            919, -- Carbuncle
            839, -- Fenrir
            913, -- Ifrit
            914, -- Titan
            915, -- Leviathan
            916, -- Garuda
            917, -- Shiva
            918  -- Ramuh
        }

        for _, id in ipairs(astralFlowIds) do
            if skillId == id then
                mob:setLocalVar("astralFlowEnabled", 0)
                break
            end
        end
    end)
end

return g_mixins.families.elemental_spirit
