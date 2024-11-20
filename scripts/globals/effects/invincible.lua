-----------------------------------
--
--     tpz.effect.INVINCIBLE
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.UDMGPHYS, -100)
    target:addMod(tpz.mod.UDMGRANGE, -100)

    -- Handle Heady Artifice (PUP)
    local master = target:getMaster()
    if master and master:getMainJob() == tpz.job.PUP then
        local head = target:getAutomatonHead()
        local jpValue = master:getJobPointLevel(tpz.jp.HEADY_ARTIFICE_EFFECT)
        local headJpBonuses = {
            { Head = tpz.heads.HARLEQUIN,         Mod = tpz.mod.ACC,                Power = 2,  },
            { Head = tpz.heads.SHARPSHOT,         Mod = tpz.mod.RATT,               Power = 3,  },
            { Head = tpz.heads.STORMWAKER,        Mod = tpz.mod.MAGIC_DAMAGE,       Power = 2,  },
            { Head = tpz.heads.SPIRITREAVER,      Mod = tpz.mod.MAGIC_DAMAGE,       Power = 5,  }
        }

        for _, jpBuffs in pairs(headJpBonuses) do
            if (head == jpBuffs.Head) then
                target:addMod(jpBuffs.Mod, jpBuffs.Power * jpValue)
            end
        end
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.UDMGPHYS, -100)
    target:delMod(tpz.mod.UDMGRANGE, -100)

    -- Handle Heady Artifice (PUP)
    local master = target:getMaster()
    if master and master:getMainJob() == tpz.job.PUP then
        local head = target:getAutomatonHead()
        local jpValue = master:getJobPointLevel(tpz.jp.HEADY_ARTIFICE_EFFECT)
        local headJpBonuses = {
            { Head = tpz.heads.HARLEQUIN,         Mod = tpz.mod.ACC,                Power = 2,  },
            { Head = tpz.heads.SHARPSHOT,         Mod = tpz.mod.RATT,               Power = 3,  },
            { Head = tpz.heads.STORMWAKER,        Mod = tpz.mod.MAGIC_DAMAGE,       Power = 2,  },
            { Head = tpz.heads.SPIRITREAVER,      Mod = tpz.mod.MAGIC_DAMAGE,       Power = 5,  }
        }

        for _, jpBuffs in pairs(headJpBonuses) do
            if (head == jpBuffs.Head) then
                target:delMod(jpBuffs.Mod, jpBuffs.Power * jpValue)
            end
        end
    end
end
