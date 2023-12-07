--[[
https://ffxiclopedia.fandom.com/wiki/Category:Uragnites
https://www.bg-wiki.com/bg/Category:Uragnite

Uragnite mob can optionally be modified by calling tpz.mix.uragnite.config(mob, params) from within onMobSpawn.

params is a table that can contain the following keys:
    inShellSkillList : skill list given to mob when it enters shell (default: 250)
    noShellSkillList : skill list given to mob when it exits shell (default: 251)
    chanceToShell    : percent chance to enter shell when hit by a physical attack (default: 20)
    timeInShell   : least time mob can stay in shell, in seconds (default: 27)
    inShellRegen     : amount of regen mob gets while in shell (default: 50)

Example:

tpz.mix.uragnite.config(mob, {
    chanceToShell = 10,
    timeInShell = 45,
})

--]]
require("scripts/globals/mixins")
require("scripts/globals/status")
-----------------------------------

tpz = tpz or {}
tpz.mix = tpz.mix or {}
tpz.mix.uragnite = tpz.mix.uragnite or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function enterShell(mob)
    if not IsMobBusy(mob) then
        mob:AnimationSub(1)
        mob:SetAutoAttackEnabled(false)
        mob:useMobAbility(1572) -- Always immediately uses Venom Shell 
        mob:addMod(tpz.mod.DEFP, 100)
        mob:addMod(tpz.mod.UDMGMAGIC, -75)
        mob:addMod(tpz.mod.UDMGBREATH, -75)
        mob:addMod(tpz.mod.REGEN, mob:getMaxHP() * 0.02)
        mob:setMod(tpz.mod.REGAIN, 250) -- Gains TP fast inside hell
        mob:setMobMod(tpz.mobMod.SKILL_LIST, mob:getLocalVar("[uragnite]inShellSkillList"))
        mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
        mob:setLocalVar("damageTaken", 0)
        mob:setLocalVar("[uragnite]timeInShell", os.time() + 27)
    end
end

local function exitShell(mob)
    if not IsMobBusy(mob) then
        mob:AnimationSub(0)
        mob:SetAutoAttackEnabled(true)
        mob:delMod(tpz.mod.DEFP, 100)
        mob:delMod(tpz.mod.UDMGMAGIC, -75)
        mob:delMod(tpz.mod.UDMGBREATH, -75)
        mob:delMod(tpz.mod.REGEN, mob:getMaxHP() * 0.02)
        mob:setMod(tpz.mod.REGAIN, 0)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, mob:getLocalVar("[uragnite]noShellSkillList"))
        mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
        mob:setLocalVar("damageTaken", 0)
    end
end

tpz.mix.uragnite.config = function(mob, params)
    if params.inShellSkillList and type(params.inShellSkillList) == "number" then
        mob:setLocalVar("[uragnite]inShellSkillList", params.inShellSkillList)
    end
    if params.noShellSkillList and type(params.noShellSkillList) == "number" then
        mob:setLocalVar("[uragnite]noShellSkillList", params.noShellSkillList)
    end
    if params.chanceToShell and type(params.chanceToShell) == "number" then
        mob:setLocalVar("[uragnite]chanceToShell", params.chanceToShell)
    end
    if params.timeInShell and type(params.timeInShell) == "number" then
        mob:setLocalVar("[uragnite]timeInShell", params.timeInShell)
    end
    if params.inShellRegen and type(params.inShellRegen) == "number" then
        mob:setLocalVar("[uragnite]inShellRegen", params.inShellRegen)
    end
end

g_mixins.families.uragnite = function(mob)

    -- at spawn, give mob default skill lists for in-shell and out-of-shell states
    -- these defaults can be overwritten by using tpz.mix.uragnite.config() in onMobSpawn.
    mob:addListener("SPAWN", "URAGNITE_SPAWN", function(mob)
        mob:setLocalVar("[uragnite]noShellSkillList", 251)
        mob:setLocalVar("[uragnite]inShellSkillList", 250)
        mob:setLocalVar("[uragnite]timeInShell", 0)
    end)

    mob:addListener("COMBAT_TICK", "URAGNITE_COMBAT_TICK", function(mob)
        local timeInShell = mob:getLocalVar("[uragnite]timeInShell")
        local animationSub = mob:AnimationSub()
        -- Leaves shell after 27 seconds
        if (animationSub == 1) and os.time() > timeInShell then
            exitShell(mob)
            --printf("exit shell timer")
        end
    end)

    mob:addListener("TAKE_DAMAGE", "URAGNITE_TAKE_DAMAGE", function(mob, damage, attacker, attackType, damageType)
        local damageTaken = mob:getLocalVar("damageTaken")
        local timeInShell = mob:getLocalVar("[uragnite]timeInShell")
        local animationSub = mob:AnimationSub()
        mob:setLocalVar("damageTaken", mob:getLocalVar("damageTaken") + damage)
        if (animationSub ~= 1) and (damageTaken > 125) then  -- Retreats into shell after taking 150 damage
            enterShell(mob)
            --printf("enterShell")
        elseif (animationSub == 1) and (damageTaken >= 150) then -- Leaves shell early after taking 150 damage
            exitShell(mob)
            --printf("exit shell damage")
        end
    end)
end

return g_mixins.families.uragnite
