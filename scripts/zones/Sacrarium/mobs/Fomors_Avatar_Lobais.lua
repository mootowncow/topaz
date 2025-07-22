-----------------------------------
-- Area: Sacrarium
--  Mob: Lobais' Fomor's Avatar
--  Note: The summoned avatar is the same element as Lobais' last summoned elemental spirit
-----------------------------------
function onMobSpawn(mob)
    local modelId = 791
    local lobais = GetMobByID(16892070)
    local elemental = lobais:getLocalVar("Elemental")

    switch (elemental) : caseof
    {
            [294] = function (x) modelId = 791 end, -- Carbuncle
            [295] = function (x) modelId = 792 end, -- Fenrir
            [288] = function (x) modelId = 793 end, -- Ifrit
            [291] = function (x) modelId = 794 end, -- Titan
            [293] = function (x) modelId = 795 end, -- Leviathan
            [290] = function (x) modelId = 796 end, -- Garuda
            [289] = function (x) modelId = 797 end, -- Shiva
            [292] = function (x) modelId = 798 end, -- Ramuh
    }

    mob:setModelId(modelId)
    mob:hideName(false)
    mob:untargetable(true)
    mob:setUnkillable(true)
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(false)

    mob:addListener("ENGAGE", "LOBAIS_AVATAR_ENGAGE", function(mob, target)
        local abilityID = nil
        local modelId = mob:getModelId()

        switch (modelId) : caseof
        {
                [791] = function (x) abilityID = 919 end, -- Carbuncle
                [792] = function (x) abilityID = 839 end, -- Fenrir
                [793] = function (x) abilityID = 913 end, -- Ifrit
                [794] = function (x) abilityID = 914 end, -- Titan
                [795] = function (x) abilityID = 915 end, -- Leviathan
                [796] = function (x) abilityID = 916 end, -- Garuda
                [797] = function (x) abilityID = 917 end, -- Shiva
                [798] = function (x) abilityID = 918 end, -- Ramuh
        }

        if (abilityID ~= nil) then
            mob:useMobAbility(abilityID)
        end
    end)

    mob:addListener("WEAPONSKILL_STATE_EXIT", "LOBAIS_AVATAR_MOBSKILL_FINISHED", function(mob)
        mob:setUnkillable(false)
        DespawnMob(mob:getID())
    end)
end

function onMobDeath(mob, player, isKiller, noKiller)
end
