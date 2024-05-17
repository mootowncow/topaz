-----------------------------------------
-- ID: 4948
-- Scroll of Utsusemi: San
-- Teaches the ninjutsu Utsusemi: San
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(340)
end

function onItemUse(target)
    target:addSpell(340)
end
