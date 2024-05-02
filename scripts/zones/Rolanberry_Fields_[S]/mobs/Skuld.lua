-----------------------------------
-- Area: Rolanberry Fields_[S]
--  VNM: Skuld
-----------------------------------
require("scripts/globals/voidwalker")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobInitialize(mob)
    tpz.voidwalker.onMobInitialize(mob)
end

function onMobSpawn(mob)
    tpz.voidwalker.onMobSpawn(mob)
end

function onMobFight(mob, target)
    tpz.voidwalker.onMobFight(mob, target)
end

function onMonsterMagicPrepare(mob, target)
    local singleTargetSpells = {162, 147, 152, 157, 167, 172}
    local gaSpells = {176, 181, 186, 191, 196, 201, 356, 362, 360, 357, 366}
    local currentElement = mob:getLocalVar("currentElement")
    local validSpells = {};
    if mob:getHPP() < 50 or mob:hasStatusEffect(tpz.effect.CHAINSPELL) then
        for _,spellId in ipairs(gaSpells) do
            local spell = getSpell(spellId);
            if (spell:getElement() == currentElement) then
                validSpells[#validSpells + 1] = spellId;
            end
        end
    end
    if not mob:hasStatusEffect(tpz.effect.CHAINSPELL) then
        for _,spellId in ipairs(singleTargetSpells) do
            local spell = getSpell(spellId);
            if (spell:getElement() == currentElement) then
                validSpells[#validSpells + 1] = spellId;
            end
        end
    end

    if (#validSpells > 0) then
        return validSpells[math.random(#validSpells)];
    end

    return 0
end

function onMobDisengage(mob)
    tpz.voidwalker.onMobDisengage(mob)
end

function onMobDespawn(mob)
    tpz.voidwalker.onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.voidwalker.onMobDeath(mob, player, isKiller, tpz.keyItem.YELLOW_ABYSSITE)
end