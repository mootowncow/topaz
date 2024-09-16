-----------------------------------------
-- ID: 4887
-- Scroll of Absorb-Attri
-- Teaches the black magic Absorb-Attri
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(243)
end

function onItemUse(target)
    target:addSpell(243)
end
