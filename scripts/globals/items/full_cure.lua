-----------------------------------------
-- ID: 6606
-- Scroll of Full Cure
-- Teaches the White Magic Full Cure
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(893)
end

function onItemUse(target)
    target:addSpell(893)
end
