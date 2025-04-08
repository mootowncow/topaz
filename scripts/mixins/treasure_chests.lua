-- Dynamis Yagudo NM Mixin
-- Yagudo NMs in dynamis remove doom upon death
-- TODO: A benediction effect animation should play on doom removal

require("scripts/globals/mixins")
require("scripts/globals/status")
require("scripts/globals/msg")

tpz = tpz or {}
tpz.mix = tpz.mix or {}
tpz.mix.treasure_chests = tpz.mix.treasure_chests or {}

g_mixins = g_mixins or {}

g_mixins.treasure_chests = function(player, npc)
    mob:addListener("TRIGGER", "TREASURE_CHEST_TRIGGER", function(player, npc)
        npc:entityAnimationPacket("open")
        npc:setLocalVar("open", 1)
        npc:timer(15000, function(npc)
        npc:entityAnimationPacket("kesu")
        end)
        npc:timer(16000, function(npc)
        npc:setStatus(tpz.status.DISAPPEAR)
        npc:timer(500, function(mob)
        npc:setLocalVar("open", 0)
        end)
    end)
end

return g_mixins.treasure_chests
