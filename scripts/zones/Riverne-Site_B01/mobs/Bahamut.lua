-----------------------------------
-- Area: Riverne - Site B01 (BCNM)
--   NM: Bahamut
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_B01/IDs")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------
function onMobInitialise(mob)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
end

function onMobSpawn(mob)
    mob:setDamage(250)
    mob:setMod(tpz.mod.UFASTCAST, 50) 
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 25)
    mob:addMod(tpz.mod.REGAIN, 50)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 25)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 25)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:addStatusEffect(tpz.effect.PHALANX, 35, 0, 180)
    mob:addStatusEffect(tpz.effect.STONESKIN, 350, 0, 300)
    mob:addStatusEffect(tpz.effect.PROTECT, 175, 0, 1800)
    mob:addStatusEffect(tpz.effect.SHELL, 24, 0, 1800)
    mob:SetMagicCastingEnabled(true)
end

function onMobRoam(mob)
end

function onMobFight(mob, target)
    local phaseData = {
        { HP = 20,  Skill = tpz.mob.skills.GIGAFLARE,   Var = 'megaFlare_20',   Msg = function(mob, target) return DisplayMegaFlareText(mob, target) end },
        { HP = 30,  Skill = tpz.mob.skills.GIGAFLARE,   Var = 'megaFlare_30',   Msg = function(mob, target) return DisplayMegaFlareText(mob, target) end },
        { HP = 40,  Skill = tpz.mob.skills.GIGAFLARE,   Var = 'megaFlare_40',   Msg = function(mob, target) return DisplayMegaFlareText(mob, target) end },
        { HP = 50,  Skill = tpz.mob.skills.GIGAFLARE,   Var = 'megaFlare_50',   Msg = function(mob, target) return DisplayMegaFlareText(mob, target) end },
        { HP = 60,  Skill = tpz.mob.skills.GIGAFLARE,   Var = 'megaFlare_60',   Msg = function(mob, target) return DisplayMegaFlareText(mob, target) end },
        { HP = 70,  Skill = tpz.mob.skills.MEGAFLARE,   Var = 'megaFlare_70',   Msg = function(mob, target) return DisplayMegaFlareText(mob, target) end },
        { HP = 80,  Skill = tpz.mob.skills.MEGAFLARE,   Var = 'megaFlare_80',   Msg = function(mob, target) return DisplayMegaFlareText(mob, target) end },
        { HP = 90,  Skill = tpz.mob.skills.MEGAFLARE,   Var = 'megaFlare_90',   Msg = function(mob, target) return DisplayMegaFlareText(mob, target) end },
    }
    local currentHP = mob:getHPP()
    local forcedMegaFlare = mob:getLocalVar("forcedFlare-" .. tpz.mob.skills.MEGAFLARE)
    local gigaFlareTimer = mob:getLocalVar("gigaFlareTimer")
    local autoattackDelay = mob:getLocalVar("autoattackDelay")

    SetBattleMusicOnFight(mob, tpz.music.track.FINAL_THEME)

    -- Delays his autos by 10-13 seconds after every TP move
    if (os.time() >= autoattackDelay) then
        mob:SetAutoAttackEnabled(true)
    end

    -- Logic for Flares being interrupted
    if not IsMobBusy(mob) and not mob:hasPreventActionEffect() then
        if (forcedMegaFlare > 0) then
            mob:setLocalVar("forcedFlare-" .. tpz.mob.skills.MEGAFLARE, 0)
            mob:useMobAbility(tpz.mob.skills.MEGAFLARE)
        end
    end

    -- 10-90% HP logic
    for _, phase in ipairs(phaseData) do
        if (currentHP <= phase.HP) and (mob:getLocalVar(phase.Var) == 0) then
            if not IsMobBusy(mob) and not mob:hasPreventActionEffect() then
                mob:setLocalVar(phase.Var, 1)
                mob:useMobAbility(phase.Skill)
                phase.Msg(mob, target)
                break
            end
        end
    end

    -- < 10% HP Giga flare logic
    if (currentHP <= 10) then
        mob:SetMagicCastingEnabled(false)
        if (os.time() >= gigaFlareTimer) then
            mob:setLocalVar("gigaFlareTimer", os.time() + 30)
            mob:useMobAbility(tpz.mob.skills.GIGAFLARE)
            DisplayGigaFlareText(mob, target)
        end
    end

    -- Delays his autos by 10-13 seconds after every TP move
    mob:addListener("WEAPONSKILL_STATE_EXIT", "BAHAMUT_WS_EXIT", function(mob, skill)
        mob:setLocalVar("autoattackDelay", os.time() + math.random(10, 13))
        mob:SetAutoAttackEnabled(false)
    end)

    mob:addListener("WEAPONSKILL_STATE_INTERRUPTED", "BAHAMUT_WS_INTERRUPTED", function(mob, skill)
        -- 20-90% HP logic
        if (skill == tpz.mob.skills.MEGAFLARE) then
            mob:setLocalVar("forcedFlare-" .. skill, 1)
        end

        -- < 10% HP Giga flare logic
        if (skill == tpz.mob.skills.GIGAFLARE) then
            mob:setLocalVar("gigaFlareTimer", os.time())
        end
    end)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function DisplayMegaFlareText(mob, target)
    local zonePlayers = mob:getZone():getPlayers()
    for _, zonePlayer in pairs(zonePlayers) do
        zonePlayer:showText(mob, ID.text.BAHAMUT_TAUNT)
        zonePlayer:showText(mob, ID.text.BAHAMUT_TAUNT +1)
    end
end

function DisplayGigaFlareText(mob, target)
    local zonePlayers = mob:getZone():getPlayers()
    for _, zonePlayer in pairs(zonePlayers) do
        zonePlayer:showText(mob, ID.text.BAHAMUT_TAUNT +2)
    end
end