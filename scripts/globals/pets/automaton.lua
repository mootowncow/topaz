-----------------------------------
-- PET: Automaton
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/pets")
require("scripts/globals/weaponskillids")
require("scripts/globals/utils")
-----------------------------------

function onMobSpawn(mob)
    AddTranquilHeartBonus(mob)
    mob:setLocalVar("MANEUVER_DURATION", 60)
    mob:addListener("EFFECTS_TICK", "MANEUVER_DURATION", function(automaton)
        if (automaton:getTarget()) then
            local dur = automaton:getLocalVar("MANEUVER_DURATION")
            automaton:setLocalVar("MANEUVER_DURATION", math.min(dur+3, 300))
        end
    end)
end

function onMobDeath(mob)
    DeleteTranquilHeartBonus(mob)
    mob:removeListener("MANEUVER_DURATION")
end

function AddTranquilHeartBonus(mob)
    local head = mob:getAutomatonHead()
    local master = mob:getMaster()
    local tranquilHeartPower = master:getMod(tpz.mod.TRANQUIL_HEART)
    local weaponType = utils.GetWeaponType(master)

    if (tranquilHeartPower > 0) then
        if head == tpz.heads.HARLEQUIN then
         -- TODO
        elseif head == tpz.heads.VALOREDGE then
            master:addMod(tpz.mod.SWORD, 25)
            master:addMod(tpz.mod.FENCER_TP_BONUS, 500)
            master:addMod(tpz.mod.FENCER_CRITHITRATE, 8)
            master:addMod(tpz.mod.FENCER_JA_HASTE, 10)
            master:addMod(tpz.mod.ADDS_WEAPONSKILL, tpz.weaponskill.URIEL_BLADE)
            if (weaponType == 'SWORD') then
                master:recalculateSkillsTable()
            end
        elseif head == tpz.heads.SHARPSHOT then
            master:addMod(tpz.mod.ACC, 10)
        elseif head == tpz.heads.STORMWAKER then
            master:addStatusEffectEx(tpz.effect.COLURE_ACTIVE, tpz.effect.COLURE_ACTIVE, 13, 3, 0, tpz.effect.GEO_ATTACK_BOOST, 7, tpz.auraTarget.ALLIES, tpz.effectFlag.AURA)
        elseif head == tpz.heads.SOULSOOTHER then
            master:addMod(tpz.mod.DEFP, 33)
            master:addMod(tpz.mod.MDEF, 18)
            master:addMod(tpz.mod.REGEN, 3)
        elseif head == tpz.heads.SPIRITREAVER then
            if (weaponType == 'DAGGER') then
                master:addMod(tpz.mod.DAGGER, 25)
                master:addMod(tpz.mod.ELEMENTAL_WSDMG, 50)
                master:addMod(tpz.mod.ELEMENTAL_WSACC, 50)
                master:addMod(tpz.mod.REGAIN, 100)
            end
        end
    end
end

function DeleteTranquilHeartBonus(mob)
    local head = mob:getAutomatonHead()
    local master = mob:getMaster()
    local tranquilHeartPower = master:getMod(tpz.mod.TRANQUIL_HEART)
    local weaponType = utils.GetWeaponType(master)

    if (tranquilHeartPower > 0) then
        if head == tpz.heads.HARLEQUIN then
         -- TODO
        elseif head == tpz.heads.VALOREDGE then
            master:delMod(tpz.mod.SWORD, 25)
            master:delMod(tpz.mod.FENCER_TP_BONUS, 500)
            master:delMod(tpz.mod.FENCER_CRITHITRATE, 8)
            master:delMod(tpz.mod.FENCER_JA_HASTE, 10)
            master:delMod(tpz.mod.ADDS_WEAPONSKILL, tpz.weaponskill.URIEL_BLADE)
            if (weaponType == 'SWORD') then 
                master:recalculateSkillsTable()
            end
        elseif head == tpz.heads.SHARPSHOT then
            master:delMod(tpz.mod.ACC, 10)
        elseif head == tpz.heads.STORMWAKER then
            master:delStatusEffect(tpz.effect.COLURE_ACTIVE)
        elseif head == tpz.heads.SOULSOOTHER then
            master:delMod(tpz.mod.DEFP, 33)
            master:delMod(tpz.mod.MDEF, 18)
            master:delMod(tpz.mod.REGEN, 3)
        elseif head == tpz.heads.SPIRITREAVER then
            if (weaponType == 'DAGGER') then
                master:delMod(tpz.mod.DAGGER, 25)
                master:delMod(tpz.mod.ELEMENTAL_WSDMG, 50)
                master:delMod(tpz.mod.ELEMENTAL_WSACC, 50)
                master:delMod(tpz.mod.REGAIN, 100)
            end
        end
    end
end