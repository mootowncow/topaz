-- Djinn family mixin

require("scripts/globals/mixins")
require("scripts/globals/utils")
require("scripts/globals/world")
require("scripts/globals/spell_data")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

-- Elemental TP Bonus: If the element corresponding to the elemental day of the in-game Vana'diel week is used on a Djinn,
-- it will get 100% TP instantly. (e.g. Using Fire II on Firesday.)
g_mixins.families.djinn = function(mob)
    mob:addListener("SPELL_DMG_TAKEN", "DJINN_SPELL_DMG_TAKEN", function(mob, caster, spell, amount, msg)
        local element = spell:getElement()
        local dayElement = VanadielDayElement()

        if (element == dayElement) then
            mob:addTP(1000)
        end
    end)
end

return g_mixins.families.djinn
