-----------------------------------------
-- ID: Unknown
-- Scroll of Inundation
-- Teaches the magic Inundation
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(879)
end

function onItemUse(target)
    target:addSpell(879)
end
