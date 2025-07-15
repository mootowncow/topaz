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
require("scripts/globals/mob_skills")
-----------------------------------

tpz = tpz or {}
tpz.mix = tpz.mix or {}
tpz.mix.uragnite = tpz.mix.uragnite or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local animation = {
    OutsideShell  = 0,
    InsideShell   = 1
}

local function setDamageTakenThreshold(mob)
    local hpp = mob:getHPP()
    local thresholdPercent = math.max(math.floor(hpp / 10), 1)
    local threshold = mob:getMaxHP() * (thresholdPercent / 100)

    mob:setLocalVar("[uragnite]damageThreshold", threshold)
end

local function enterShell(mob)
    if not IsMobBusy(mob) then
        mob:AnimationSub(animation.InsideShell)
        mob:SetAutoAttackEnabled(false)
        mob:useMobAbility(1572) -- Always immediately uses Venom Shell 
        mob:addMod(tpz.mod.DEFP, 100)
        mob:addMod(tpz.mod.UDMGMAGIC, -75)
        mob:addMod(tpz.mod.UDMGBREATH, -75)
        mob:addMod(tpz.mod.REGEN, mob:getMaxHP() * 0.01)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, mob:getLocalVar("[uragnite]inShellSkillList"))
        mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
        mob:setLocalVar("damageTaken", 0)
        mob:setLocalVar("[uragnite]shellTime", 0)
        mob:setLocalVar("[uragnite]timeInShell", os.time() + 27)
    end
end

local function exitShell(mob)
    if not IsMobBusy(mob) then
        mob:AnimationSub(animation.OutsideShell)
        mob:SetAutoAttackEnabled(true)
        mob:delMod(tpz.mod.DEFP, 100)
        mob:delMod(tpz.mod.UDMGMAGIC, -75)
        mob:delMod(tpz.mod.UDMGBREATH, -75)
        mob:delMod(tpz.mod.REGEN, mob:getMaxHP() * 0.01)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, mob:getLocalVar("[uragnite]noShellSkillList"))
        mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
        mob:setLocalVar("damageTaken", 0)
        mob:setLocalVar("[uragnite]shellTime", os.time() + 40)
        setDamageTakenThreshold(mob)
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
        mob:AnimationSub(animation.OutsideShell)
        mob:setLocalVar("damageTaken", 0)
        mob:setLocalVar("[uragnite]noShellSkillList", 251)
        mob:setLocalVar("[uragnite]inShellSkillList", 250)
        mob:setLocalVar("[uragnite]timeInShell", 0)
        mob:setLocalVar("[uragnite]shellTime", 0)
        setDamageTakenThreshold(mob)
    end)

    mob:addListener("COMBAT_TICK", "URAGNITE_COMBAT_TICK", function(mob)
        local timeInShell = mob:getLocalVar("[uragnite]timeInShell")
        local shellTime = mob:getLocalVar("[uragnite]shellTime")
        local animationSub = mob:AnimationSub()

        -- Leaves shell after 27 seconds
        if (animationSub == animation.InsideShell) and os.time() > timeInShell then
            exitShell(mob)
            --printf("exit shell timer")
        end

        -- Hides in its shell after being out of it for 40 seconds.
        if (animationSub == animation.OutsideShell) and (shellTime == 0) then
            mob:setLocalVar("[uragnite]shellTime", os.time() + 40)
        elseif (animationSub == animation.OutsideShell) and os.time() > shellTime then
            enterShell(mob)
        end
    end)

    mob:addListener("TAKE_DAMAGE", "URAGNITE_TAKE_DAMAGE", function(mob, damage, attacker, attackType, damageType)
        local animationSub = mob:AnimationSub()

        -- Only process damage threshold logic if outside the shell
        if (animationSub ~= animation.InsideShell) then
            local damageTaken = mob:getLocalVar("damageTaken") + damage
            local threshold = mob:getLocalVar("[uragnite]damageThreshold")

            mob:setLocalVar("damageTaken", damageTaken)
            --printf("Threshold %d, damageTaken %d", threshold, damageTaken)

            if (damageTaken >= threshold) then
                enterShell(mob)
            end
        end
    end)
end

return g_mixins.families.uragnite
