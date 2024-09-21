-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Cherukiki
-- WHM Mythic weapon fight
-----------------------------------
local ID = require("scripts/zones/Dangruf_Wadi/IDs")
require("scripts/globals/instance")
require("scripts/globals/mobs")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
    mob:SetAutoAttackEnabled(true)
    mob:setUnkillable(true)
    mob:setSpellList(1)
    ResetVars(mob)
end

function onMobEngaged(mob, target)
    ResetVars(mob)
end

function onMobFight(mob, target)
    local phase = mob:getLocalVar("phase")

    -- Phase 1 ends once Cherukiki gets to 20% HP or less.
    if (phase == 1) then
        mob:setMod(tpz.mod.DEFP, 0)
        mob:setMod(tpz.mod.MDEF, 0) 
        mob:setMod(tpz.mod.DMG, 0)
        mob:setSpellList(1)
        mob:SetMagicCastingEnabled(true)

        -- Cast benediction on herself then summons her siblings once she gets to 20% HP for the first time
        -- Buffs them with Protectra V and Shellra V
        if (mob:getHPP() <= 20) then
            local makki = mob:getID() +1
            local kukki = mob:getID() +2
            for v = makki, kukki do
                GetMobByID(v):spawn()
                GetMobByID(v):updateEnmity(mob:getTarget())
            end
            MessageGroup(mob, target, "Feel the fear! The Chebukkis are here!", 0, "Cherukiki")
            MessageGroup(mob, target, "Chebukki Sumo Siblings!", 0, "Kukki-Chebukki")
            MessageGroup(mob, target, "Samurai Sky Pirate Power!", 0, "Makki-Chebukki")
            mob:useMobAbility(tpz.jsa.BENEDICTION)
            mob:castSpell(tpz.magic.spell.PROTECTRA_V, mob)
            mob:castSpell(tpz.magic.spell.SHELLRA_V, mob)
            mob:setLocalVar("phase", 2)
        end
    end

    -- Stops attacking and only heals and buffs her Siblings
    if (phase == 2) then
        mob:SetAutoAttackEnabled(false)
        mob:SetMagicCastingEnabled(false)
        TryCastSpell(mob)
        -- Remove unkillable if Kukki and Makki are dead
        if AreSiblingsDead(mob) then
            MessageGroup(mob, target, "I learned this from Prishe!", 0, "Cherukiki")
            mob:useMobAbility(3395) -- Lvl up!
            mob:setHP(4500)
            mob:setUnkillable(false)
            mob:setLocalVar("phase", 3)
        end
    end

    if (phase == 3) then
        mob:setMod(tpz.mod.DEFP, 33)
        mob:setMod(tpz.mod.MDEF, 33) 
        mob:setMod(tpz.mod.DMG, -33)
        mob:setSpellList(541)
        mob:SetAutoAttackEnabled(true)
        mob:SetMagicCastingEnabled(true)
    end
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDisengage(mob)
    ResetVars(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    OnDeathMessage(mob, player, isKiller, noKiller, "Urgh... At least it beats getting smacked around by Prishe...", 0, "Cherukiki")
end

function AreSiblingsDead(mob)
    local makki = mob:getID() +1
    local kukki = mob:getID() +2
    for v = makki, kukki do
        if not GetMobByID(v):isDead() then
            return false
        end
    end

    return true
end

function TryCastSpell(mob)
    local spellTimer = mob:getLocalVar("spellTimer")
    local battleTime = mob:getBattleTime()
    local spell, target = GetBestSpell(mob)
    -- printf("target %d", target)

    if (spellTimer < battleTime) then
        mob:setLocalVar("spellTimer", battleTime + 10)
        mob:castSpell(spell, GetMobByID(target))
    end
end

function GetBestSpell(mob)
    local buffIds =
    {
        { tpz.effect.SHELL, tpz.magic.spell.SHELL_V },
        { tpz.effect.PROTECT, tpz.magic.spell.PROTECT_V },
        { tpz.effect.HASTE, tpz.magic.spell.HASTE },
        { tpz.effect.REGEN, tpz.magic.spell.REGEN_III }
    }

    local makki = mob:getID() +1
    local kukki = mob:getID() +2
    local spell = 0
    local target = 0

    for v = makki, kukki do
        -- Check for buffs
        for _, buffs in pairs(buffIds) do
            if GetMobByID(v):isAlive() and not GetMobByID(v):hasStatusEffect(buffs[1]) then
                spell = buffs[2]
                target = v
                break
            end
        end

        -- Try to Cure if their HP is below 75%
        if (GetMobByID(v):isAlive() and GetMobByID(v):getHPP() <= 75) then
             spell = tpz.magic.spell.CURE_V
             target = v
             break
        end
    end

    return spell, target
end

function ResetVars(mob)
    mob:setLocalVar("phase", 1)
    mob:setLocalVar("spellTimer", 0)
end