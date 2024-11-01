-----------------------------------
--
--     tpz.effect.HEADY_ARTIFICE
--     
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onEffectGain(target, effect)
    local pet = target:getPet()
    local head = pet:getAutomatonHead()
    local power = 0
    local jpValue = target:getJobPointLevel(tpz.jp.HEADY_ARTIFICE_EFFECT)
    local headJpBonuses = {
        { Head = tpz.heads.HARLEQUIN,         Mod = tpz.mod.ACC,                Power = 2,  }
        { Head = tpz.heads.SHARPSHOT,         Mod = tpz.mod.RATT,               Power = 3,  }
        { Head = tpz.heads.STORMWAKER,        Mod = tpz.mod.MAGIC_DAMAGE,       Power = 2,  }
        { Head = tpz.heads.SPIRITREAVER,      Mod = tpz.mod.MAGIC_DAMAGE,       Power = 5,  }
    }

    for _, jpBuffs in pairs(headJpBonuses) do
        if (head == jpBuffs.Head) then
            target:addMod(tpz.mod.jpBuffs.Mod, jpBuffs.Power * jpValue)
        end
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local pet = target:getPet()
    local head = pet:getAutomatonHead()
    local power = 0
    local jpValue = target:getJobPointLevel(tpz.jp.HEADY_ARTIFICE_EFFECT)
    local headJpBonuses = {
        { Head = tpz.heads.HARLEQUIN,         Mod = tpz.mod.ACC,                Power = 2,  }
        { Head = tpz.heads.SHARPSHOT,         Mod = tpz.mod.RATT,               Power = 3,  }
        { Head = tpz.heads.STORMWAKER,        Mod = tpz.mod.MAGIC_DAMAGE,       Power = 2,  }
        { Head = tpz.heads.SPIRITREAVER,      Mod = tpz.mod.MAGIC_DAMAGE,       Power = 5,  }
    }

    for _, jpBuffs in pairs(headJpBonuses) do
        if (head == jpBuffs.Head) then
            target:delMod(tpz.mod.jpBuffs.Mod, jpBuffs.Power * jpValue)
        end
    end
end
