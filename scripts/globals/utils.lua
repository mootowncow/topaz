require("scripts/globals/status")
require("scripts/globals/spell_data")
require("scripts/globals/world")


utils = {}

-- Shuffles a table and returns a copy of it, not the original.
function utils.shuffle(tab)
    local copy = {}
    for k, v in pairs(tab) do
        copy[k] = v
    end

    local res = {}
    while next(copy) do
        res[#res + 1] = table.remove(copy, math.random(#copy))
    end
    return res
end

-- Generates a random permutation of integers >= min_val and <= max_val
-- If a min_val isn't given, 1 is used (assumes permutation of lua indices)
function utils.permgen(max_val, min_val)
    local indices = {}
    min_val = min_val or 1

    if min_val >= max_val then
        for iter = min_val, max_val, -1 do
            indices[iter] = iter
        end
    else
        for iter = min_val, max_val, 1 do
            indices[iter] = iter
        end
    end

    return utils.shuffle(indices)
end

function utils.chance(likelihood)
    return math.random(100) <= likelihood
end

function utils.diceroll(count, sides)
    local total = 0
    for _ = 1, count do
        total = total + math.random(sides)
    end
    return total
end

function utils.distance(position1, position2)
    return math.sqrt(math.pow(position2.x - position1.x, 2) + math.pow(position2.y - position1.y, 2) + math.pow(position2.z - position1.z, 2))
end

function utils.clamp(input, min_val, max_val)
    if input < min_val then
        input = min_val
    elseif max_val ~= nil and input > max_val then
        input = max_val
    end
    return input
end

-- returns unabsorbed damage
function utils.stoneskin(target, dmg, attackType)
    --handling stoneskin
    if (dmg > 0) then

        -- Check phys only Stoneskin
        physSkin = target:getMod(tpz.mod.PHYSICAL_SS)
        if (attackType == tpz.attackType.PHYSICAL or attackType == tpz.attackType.RANGED) then
            if (physSkin > 0) then
                if (physSkin > dmg) then --absorb all damage
                    target:delMod(tpz.mod.PHYSICAL_SS, dmg)
                    return 0
                else --absorbs some damage then wear
                    target:setMod(tpz.mod.PHYSICAL_SS, 0)
                    dmg = dmg - physSkin
                end
            end
        end

        -- Check normal stoneskin
        skin = target:getMod(tpz.mod.STONESKIN)
        if (skin > 0) then
            if (skin > dmg) then --absorb all damage
                target:delMod(tpz.mod.STONESKIN, dmg)
                return 0
            else --absorbs some damage then wear
                target:delStatusEffect(tpz.effect.STONESKIN)
                target:setMod(tpz.mod.STONESKIN, 0)
                return dmg - skin
            end
        end
    end

    return dmg
end

-- returns unabsorbed damage
function utils.rampartstoneskin(target, dmg)
    --handling rampart stoneskin
    local ramSS = target:getMod(tpz.mod.MAGIC_SS)
    -- Handle absorbs
    if dmg < 0 then
        return dmg
    end
    if ramSS > 0 then
        if dmg >= ramSS then
            target:setMod(tpz.mod.MAGIC_SS, 0)
            if target:isPC() then -- Remove Magic Shield off players
                target:delStatusEffectSilent(tpz.effect.MAGIC_SHIELD)
            end
            dmg = dmg - ramSS
        else
            target:setMod(tpz.mod.MAGIC_SS, ramSS - dmg)
            dmg = 0
        end
    end

    return dmg
end

function utils.FullSelfEraseNa(target)
    local removables =
    {
        tpz.effect.FLASH, tpz.effect.BLINDNESS, tpz.effect.ELEGY, tpz.effect.REQUIEM, tpz.effect.PARALYSIS, tpz.effect.POISON,
        tpz.effect.CURSE_I, tpz.effect.CURSE_II, tpz.effect.DISEASE, tpz.effect.PLAGUE, tpz.effect.WEIGHT, tpz.effect.BIND,
        tpz.effect.BIO, tpz.effect.DIA, tpz.effect.BURN, tpz.effect.FROST, tpz.effect.CHOKE, tpz.effect.RASP, tpz.effect.SHOCK, tpz.effect.DROWN,
        tpz.effect.STR_DOWN, tpz.effect.DEX_DOWN, tpz.effect.VIT_DOWN, tpz.effect.AGI_DOWN, tpz.effect.INT_DOWN, tpz.effect.MND_DOWN,
        tpz.effect.CHR_DOWN, tpz.effect.ADDLE, tpz.effect.SLOW, tpz.effect.HELIX, tpz.effect.ACCURACY_DOWN, tpz.effect.ATTACK_DOWN,
        tpz.effect.EVASION_DOWN, tpz.effect.DEFENSE_DOWN, tpz.effect.MAGIC_ACC_DOWN, tpz.effect.MAGIC_ATK_DOWN, tpz.effect.MAGIC_EVASION_DOWN,
        tpz.effect.MAGIC_DEF_DOWN, tpz.effect.CRIT_HIT_EVASION_DOWN, tpz.effect.MAX_TP_DOWN, tpz.effect.MAX_MP_DOWN, tpz.effect.MAX_HP_DOWN,
        tpz.effect.SLUGGISH_DAZE_1, tpz.effect.SLUGGISH_DAZE_2, tpz.effect.SLUGGISH_DAZE_3, tpz.effect.SLUGGISH_DAZE_4, tpz.effect.SLUGGISH_DAZE_5,
        tpz.effect.LETHARGIC_DAZE_1, tpz.effect.LETHARGIC_DAZE_2, tpz.effect.LETHARGIC_DAZE_3, tpz.effect.LETHARGIC_DAZE_4, tpz.effect.LETHARGIC_DAZE_5,
        tpz.effect.WEAKENED_DAZE_1, tpz.effect.WEAKENED_DAZE_2, tpz.effect.WEAKENED_DAZE_3, tpz.effect.WEAKENED_DAZE_4, tpz.effect.WEAKENED_DAZE_5,
        tpz.effect.HELIX, tpz.effect.KAUSTRA, tpz.effect.SILENCE, tpz.effect.PETRIFICATION
    }

    for i, effect in ipairs(removables) do
        if (target:delStatusEffectSilent(effect)) then
            target:delStatusEffectSilent(effect)
        end
    end
end

function utils.takeShadows(target, dmg, shadowbehav)
    if (shadowbehav == nil) then
        shadowbehav = 1;
    end

    local targShadows = target:getMod(tpz.mod.UTSUSEMI);
    local shadowType = tpz.mod.UTSUSEMI;

    if (targShadows == 0) then
        --try blink, as utsusemi always overwrites blink this is okay
        targShadows = target:getMod(tpz.mod.BLINK);
        shadowType = tpz.mod.BLINK;
    end

    local shadowsLeft = targShadows
    local shadowsUsed = 0

    if (targShadows > 0) then
        if shadowType == tpz.mod.BLINK then
            for i = 1, shadowbehav, 1 do
                if shadowsLeft > 0 then
                    local effect = target:getStatusEffect(tpz.effect.BLINK)
                    local procChance = 0.4
                    if (effect ~= nil) then
                        if (effect:getSubPower() ~= nil) then
                            if (effect:getSubPower() > 0) then
                                procChance = effect:getSubPower() / 10
                            end
                        end
                    end
                    if math.random() <= procChance then -- https://www.bg-wiki.com/ffxi/Category:Utsusemi Blink has a 50% chance to not absorb damage/enfeeble spells
                        shadowsUsed = shadowsUsed + 1
                        shadowsLeft = shadowsLeft - 1
                    end
                end
            end

            if shadowsUsed >= shadowbehav then
                dmg = 0
            else
                dmg = ((dmg / shadowbehav) * (shadowbehav - shadowsUsed))
            end
        else
            if (targShadows >= shadowbehav) then
                shadowsLeft = targShadows - shadowbehav

                if shadowsLeft > 0 then
                    --update icon
                    effect = target:getStatusEffect(tpz.effect.COPY_IMAGE)
                    if (effect ~= nil) then
                        if (shadowsLeft == 1) then
                            effect:setIcon(tpz.effect.COPY_IMAGE)
                        elseif (shadowsLeft == 2) then
                            effect:setIcon(tpz.effect.COPY_IMAGE_2)
                        elseif (shadowsLeft == 3) then
                            effect:setIcon(tpz.effect.COPY_IMAGE_3)
                        end
                    end
                end

                dmg = 0
            else
                shadowsLeft = 0
                dmg = dmg * ((shadowbehav - targShadows) / shadowbehav)
            end
        end

        target:setMod(shadowType, shadowsLeft);

        if (shadowsLeft <= 0) then
            target:delStatusEffect(tpz.effect.COPY_IMAGE)
            target:delStatusEffect(tpz.effect.BLINK)
        end
    end

    return dmg
end

function utils.conalDamageAdjustment(attacker, target, skill, max_damage, minimum_percentage)
    local final_damage = 1
    -- #TODO: Currently all cone attacks use static 45 degree (360 scale) angles in core, when cone attacks
    -- have different angles and there's a method to fetch the angle, use a line like the below
    -- local cone_angle = skill:getConalAngle()
    local cone_angle = 32 -- 256-degree based, equivalent to "45 degrees" on 360 degree scale

    -- #TODO: Conal attacks hit targets in a cone with a center line of the "primary" target (the mob's
    -- highest enmity target). These primary targets can be within 128 degrees of the mob's front. However,
    -- there's currently no way for a conal skill to store (and later check) the primary target a mob skill
    -- was trying to hit. Therefore the "damage drop off" here is based from an origin of the mob's rotation
    -- instead. Should conal skills become capable of identifying their primary target, this should be changed
    -- to be based on the degree difference from the primary target instead.
    local conal_angle_power = cone_angle - math.abs(attacker:getFacingAngle(target))

    if conal_angle_power < 0 then
        -- #TODO The below print will be a valid print upon fixing to-do above relating to beam center orgin
        -- print("Error: conalDamageAdjustment - Mob TP move hit target beyond conal angle: ".. cone_angle)
        conal_angle_power = 0
    end

    -- Calculate the amount of damage to add above the minimum percentage based on how close
    -- the target is to the center of the conal (0 degrees from the attacker's facing)
    local minimum_damage = max_damage * minimum_percentage
    local damage_per_angle = (max_damage - minimum_damage) / cone_angle
    local additional_damage = damage_per_angle * conal_angle_power

    final_damage = math.max(1, math.ceil(minimum_damage + additional_damage))

    return final_damage
end

function utils.thirdeye(attacker, target)
    -- Starts at 100% proc rate, decaying by 10% every 3 seconds until 10%.
    local thirdEye = target:getStatusEffect(tpz.effect.THIRD_EYE)
	local hasSeigan = target:getStatusEffect(tpz.effect.SEIGAN)

    if (thirdEye == nil) then
        return false
    end

    local anticipateChance = thirdEye:getPower()
    -- printf("anticipateChance: %d", anticipateChance)

    if
        target:isEngaged() and
        target:isFacing(attacker, 45) and
        not target:hasPreventActionEffect()
    then
        if not hasSeigan then
            -- printf("Anticipated!")
            target:delStatusEffect(tpz.effect.THIRD_EYE)
            return true
        end

        if (math.random(100) <= anticipateChance) then
            -- printf("Anticipated!")
            return true
        else
		    target:delStatusEffect(tpz.effect.THIRD_EYE)
	    end
    end

    return false
end

-- skillLevelTable contains matched pairs based on rank; First value is multiplier, second is additive value.  Index is the subtracted
-- baseInRange value (see below)
-- Original formula: ((level - <baseInRange>) * <multiplier>) + <additive>; where level is a range defined in utils.getSkillLvl
local skillLevelTable =
{
    --         A+             A-             B+             B              B-             C+             C              C-             D              E              F                  G
    [1]  = { { 3.00,   6 }, { 3.00,   6 }, { 2.90,   5 }, { 2.90,   5 }, { 2.90,   5 }, { 2.80,   5 }, { 2.80,   5 }, { 2.80,   5 }, { 2.70,   4 }, { 2.50,   4 }, { 2.30,   4 }, { 2,   3 } }, -- Level <= 50
    [50] = { { 5.00, 153 }, { 5.00, 153 }, { 4.90, 147 }, { 4.90, 147 }, { 4.90, 147 }, { 4.80, 142 }, { 4.80, 142 }, { 4.80, 142 }, { 4.70, 136 }, { 4.50, 126 }, { 4.30, 116 }, { 4, 101 } }, -- Level > 50 and Level <= 60
    [60] = { { 4.85, 203 }, { 4.10, 203 }, { 3.70, 196 }, { 3.23, 196 }, { 2.70, 196 }, { 2.50, 190 }, { 2.25, 190 }, { 2.00, 190 }, { 1.85, 183 }, { 1.95, 171 }, { 2.05, 159 }, { 2.00, 141 } }, -- Level > 60 and Level <= 70
    [70] = { { 5.00, 251 }, { 5.00, 244 }, { 3.70, 233 }, { 3.23, 228 }, { 2.70, 223 }, { 3.00, 215 }, { 2.60, 212 }, { 2.00, 210 }, { 1.85, 201 }, { 1.95, 190 }, { 2.00, 179 }, { 2.00, 161 } }, -- Level > 70
}

-- Get the corresponding table entry to use in skillLevelTable based on level range
-- TODO: Minval for ranges 2 and 3 in the conditional is probably not necessary
local function getSkillLevelIndex(level)
    local rangeId = nil

    if level <= 50 then
        rangeId = 1
    elseif level > 50 and level <= 60 then
        rangeId = 50
    elseif level > 60 and level <= 70 then
        rangeId = 60
    else
        rangeId = 70
    end

    return rangeId
end

function utils.getSkillLvl(rank, level)
    local levelTableIndex = getSkillLevelIndex(level)
    return ((level - levelTableIndex) * skillLevelTable[levelTableIndex][rank][1]) + skillLevelTable[levelTableIndex][rank][2]
end

function utils.getMobSkillLvl(rank, level)
     if(level > 50) then
         if(rank == 1) then
             return 153+(level-50)*5.0
         end
         if(rank == 2) then
             return 147+(level-50)*4.9
         end
         if(rank == 3) then
             return 136+(level-50)*4.8
         end
         if(rank == 4) then
             return 126+(level-50)*4.7
         end
         if(rank == 5) then
             return 116+(level-50)*4.5
         end
         if(rank == 6) then
             return 106+(level-50)*4.4
         end
         if(rank == 7) then
             return 96+(level-50)*4.3
         end
     end

     if(rank == 1) then
         return 6+(level-1)*3.0
     end
     if(rank == 2) then
         return 5+(level-1)*2.9
     end
     if(rank == 3) then
         return 5+(level-1)*2.8
     end
     if(rank == 4) then
         return 4+(level-1)*2.7
     end
     if(rank == 5) then
         return 4+(level-1)*2.5
     end
     if(rank == 6) then
         return 3+(level-1)*2.4
     end
     if(rank == 7) then
         return 3+(level-1)*2.3
     end
    return 0
end

-- Returns 1 if attacker has a bonus
-- Returns 0 no bonus
-- Returns -1 if weak against
function utils.getSystemStrengthBonus(attacker, defender)
    local attackerSystem = attacker:getSystem()
    local defenderSystem = defender:getSystem()

    if (attackerSystem == tpz.eco.BEAST) then
        if (defenderSystem == tpz.eco.LIZARD) then
            return 1
        elseif (defenderSystem == tpz.eco.PLANTOID) then
            return -1
        end
    end

    if (attackerSystem == tpz.eco.LIZARD) then
        if (defenderSystem == tpz.eco.VERMIN) then
            return 1
        elseif (defenderSystem == tpz.eco.BEAST) then
            return -1
        end
    end

    if (attackerSystem == tpz.eco.VERMIN) then
        if (defenderSystem == tpz.eco.PLANTOID) then
            return 1
        elseif (defenderSystem == tpz.eco.LIZARD) then
            return -1
        end
    end

    if (attackerSystem == tpz.eco.PLANTOID) then
        if (defenderSystem == tpz.eco.BEAST) then
            return 1
        elseif (defenderSystem == tpz.eco.VERMIN) then
            return -1
        end
    end

    if (attackerSystem == tpz.eco.AQUAN) then
        if (defenderSystem == tpz.eco.AMORPH) then
            return 1
        elseif (defenderSystem == tpz.eco.BIRD) then
            return -1
        end
    end

    if (attackerSystem == tpz.eco.AMORPH) then
        if (defenderSystem == tpz.eco.BIRD) then
            return 1
        elseif (defenderSystem == tpz.eco.AQUAN) then
            return -1
        end
    end

    if (attackerSystem == tpz.eco.BIRD) then
        if (defenderSystem == tpz.eco.AQUAN) then
            return 1
        elseif (defenderSystem == tpz.eco.AMORPH) then
            return -1
        end
    end

    if (attackerSystem == tpz.eco.UNDEAD) then
        if (defenderSystem == tpz.eco.ARCANA) then
            return 1
        end
    end

    if (attackerSystem == tpz.eco.ARCANA) then
        if (defenderSystem == tpz.eco.UNDEAD) then
            return 1
        end
    end

    if (attackerSystem == tpz.eco.DRAGON) then
        if (defenderSystem == tpz.eco.DEMON) then
            return 1
        end
    end

    if (attackerSystem == tpz.eco.DEMON) then
        if (defenderSystem == tpz.eco.DRAGON) then
            return 1
        end
    end

    if (attackerSystem == tpz.eco.LUMORIAN) then
        if (defenderSystem == tpz.eco.LUMINION) then
            return 1
        end
    end

    if (attackerSystem == tpz.eco.LUMINION) then
        if (defenderSystem == tpz.eco.LUMORIAN) then
            return 1
        end
    end

    return 0
end

-------------------------------------------------------
-- Returns true if player has any tier of given relic,
--  if tier is specified, returns true only if player
--  has that tier
-- Tier:
-- 1  = 75
-- 2  = 80
-- 3  = 85
-- 4  = 90
-- 5  = 95
-- 6  = 99 I
-- 7  = 99 II
-- 8  = 119 I
-- 9  = 119 II
-- 10 = 119 III
-- 11 = 119 III (ammo dispensing)
-------------------------------------------------------
function utils.hasRelic(player, relic, tier)
    if tier ~= nil then
        return player:hasItem(tpz.relicTiers[relic][tier])
    end

    for i, itemID in pairs(tpz.relicTiers[relic]) do
        if player:hasItem(itemID) then
            return true
        end
    end

    return false
end

-- utils.mask contains functions for bitmask variables
utils.mask =
{
    -- return mask's pos-th bit as bool
    getBit = function(mask, pos)
        return bit.band(mask, bit.lshift(1, pos)) ~= 0
    end,

    -- return value of mask after setting its pos-th bit
    -- val can be bool or number.  if number, any non-zero value will be treated as true.
    setBit = function(mask, pos, val)
        local state = false

        if type(val) == "boolean" then
            state = val
        elseif type(val) == "number" then
            state = (val ~= 0)
        end

        if state then
            -- turn bit on
            return bit.bor(mask, bit.lshift(1, pos))
        else
            -- turn bit off
            return bit.band(mask, bit.bnot(bit.lshift(1, pos)))
        end
    end,

    -- return number of true bits in mask of length len
    -- if len is omitted, assume 32
    countBits = function(mask, len)
        if not len then
            len = 32
        end

        local count = 0

        for i = 0, len - 1 do
            count = count + bit.band(bit.rshift(mask, i), 1)
        end

        return count
    end,

    -- are all bits true in mask of length len?
    -- if len is omitted, assume 32
    isFull = function(mask, len)
        if not len then
            len = 32
        end

        local fullMask = ((2 ^ len) - 1)

        return bit.band(mask, fullMask) == fullMask
    end,
}

-- Selects a random entry from a table, returns the index and the entry
-- https://gist.github.com/jdev6/1e7ff30671edf88d03d4
function utils.randomEntryIdx(t)
    local keys = {}
    local values = {}
    for key, value in pairs(t) do
        keys[#keys+1] = key
        values[#values+1] = value
    end
    local index = keys[math.random(1, #keys)]
    return index, t[index]
end

function utils.randomEntry(t)
    local _, item = utils.randomEntryIdx(t)
    return item
end

function utils.getMoonPhase()
    local moon = VanadielMoonPhase()
	if moon > 90 then 
        return 'Full'
    elseif moon >= 60 and moon < 90 then 
        return 'Gibbeus'
    elseif moon >= 40 and moon < 60 then 
        return 'Quarter'
    elseif moon >= 10 and moon < 40 then 
        return 'Cresecent'
    elseif moon < 10 then 
        return 'New'
	end
end

function utils.hasDispellableEffect(target)
    -- Negative status effects
    for i = 1,31,1 do
        if target:hasStatusEffect(i) then
            return true
        end
    end
    for i = 128,142,1 do
        if target:hasStatusEffect(i) then
            return true
        end
    end
    for i = 144,149,1 do
        if target:hasStatusEffect(i) then
            return true
        end
    end
    for i = 167,168,1 do
        if target:hasStatusEffect(i) then
            return true
        end
    end
    for i = 174,175,1 do
        if target:hasStatusEffect(i) then
            return true
        end
    end
    for i = 192,194,1 do
        if target:hasStatusEffect(i) then
            return true
        end
    end
    for i = 386,400,1 do
        if target:hasStatusEffect(i) then
            return true
        end
    end
    for i = 448,452,1 do
        if target:hasStatusEffect(i) then
            return true
        end
    end
    if target:hasStatusEffect(tpz.effect.FLASH) then
        return true
    end
    if target:hasStatusEffect(tpz.effect.HELIX) then
        return true
    end
    if target:hasStatusEffect(tpz.effect.MAX_TP_DOWN) then
        return true
    end
    return false
end


function utils.HandleWeaponResist(target, damageType)
    local weaponResist = 1

    if not target:isPC() then
        local hthres = target:getMod(tpz.mod.HTHRES)
        local pierceres = target:getMod(tpz.mod.PIERCERES)
        local rangedres = target:getMod(tpz.mod.RANGEDRES)
        local impactres = target:getMod(tpz.mod.IMPACTRES)
        local slashres = target:getMod(tpz.mod.SLASHRES)
        local spdefdown = target:getMod(tpz.mod.SPDEF_DOWN)

        if damageType == tpz.damageType.HTH then
            if hthres < 1000 then
                weaponResist = (1 - ((1 - hthres / 1000) * (1 - spdefdown/100)))
            else
                weaponResist = hthres / 1000
            end
        elseif damageType == tpz.damageType.PIERCING then
            if pierceres < 1000 then
                weaponResist = (1 - ((1 - pierceres / 1000) * (1 - spdefdown/100)))
            else
                weaponResist = pierceres / 1000
            end
        elseif damageType == tpz.damageType.RANGED then
            if rangedres < 1000 then
                weaponResist = (1 - ((1 - rangedres / 1000) * (1 - spdefdown/100)))
            else
                weaponResist = rangedres / 1000
            end
        elseif damageType == tpz.damageType.BLUNT then
            if impactres < 1000 then
                weaponResist = (1 - ((1 - impactres / 1000) * (1 - spdefdown/100)))
            else
                weaponResist = impactres / 1000
            end
        elseif damageType == tpz.damageType.SLASHING then
            if slashres < 1000 then
                weaponResist = (1 - ((1 - slashres / 1000) * (1 - spdefdown/100)))
            else
                weaponResist = slashres / 1000
            end
        end
    end

    return weaponResist
end

function utils.HandlePositionalPDT(attacker, target, dmg)
    if attacker:isInfront(target, 90) and target:hasStatusEffect(tpz.effect.PHYSICAL_SHIELD) then -- Front
        if target:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):getPower() == 3 then
            dmg = 0
        end
        if target:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):getPower() == 5 then
            dmg = math.floor(dmg * 0.25) -- 75% DR
        end
        if target:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):getPower() == 6 then
            dmg = math.floor(dmg * 0.50) -- 50% DR
        end
    end
    if attacker:isBehind(target, 90) and target:hasStatusEffect(tpz.effect.PHYSICAL_SHIELD) then -- Behind
        if target:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):getPower() == 4 then
            dmg = 0
        end
        if target:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):getPower() == 7 then
            dmg = math.floor(dmg * 0.25) -- 75% DR
        end
        if target:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):getPower() == 8 then
            dmg = math.floor(dmg * 0.50) -- 50% DR
        end
    end

    return dmg
end

function utils.HandlePositionalMDT(attacker, target, dmg)
    if attacker:isInfront(target, 90) and target:hasStatusEffect(tpz.effect.MAGIC_SHIELD) then -- Front
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 3 then
            dmg = 0
        end
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 5 then
            dmg = math.floor(dmg * 0.25) -- 75% DR
        end
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 6 then
            dmg = math.floor(dmg * 0.50) -- 50% DR
        end
    end
    if attacker:isBehind(target, 90) and target:hasStatusEffect(tpz.effect.MAGIC_SHIELD) then -- Behind
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 4 then
            dmg = 0
        end
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 7 then
            dmg = math.floor(dmg * 0.25) -- 75% DR
        end
        if target:getStatusEffect(tpz.effect.MAGIC_SHIELD):getPower() == 8 then
            dmg = math.floor(dmg * 0.50) -- 50% DR
        end
    end

    return dmg
end

function utils.GetSkillchainElement(element)
    local elements =
    {
        [1] = {element = {tpz.magic.ele.FIRE}, sc = {tpz.skillchainEle.LIQUEFACTION, tpz.skillchainEle.FUSION, tpz.skillchainEle.LIGHT, tpz.skillchainEle.LIGHT_II } },
        [2] = {element = {tpz.magic.ele.ICE}, sc = {tpz.skillchainEle.INDURATION, tpz.skillchainEle.DISTORTION, tpz.skillchainEle.DARKNESS, tpz.skillchainEle.DARKNESS_II } },
        [3] = {element = {tpz.magic.ele.WIND}, sc = {tpz.skillchainEle.DETONATION, tpz.skillchainEle.FRAGMENTATION, tpz.skillchainEle.LIGHT, tpz.skillchainEle.LIGHT_II } },
        [4] = {element = {tpz.magic.ele.EARTH}, sc = {tpz.skillchainEle.SCISSION, tpz.skillchainEle.GRAVITATION, tpz.skillchainEle.DISTORTION, tpz.skillchainEle.DARKNESS, tpz.skillchainEle.DARKNESS_II } },
        [5] = {element = {tpz.magic.ele.THUNDER}, sc = {tpz.skillchainEle.IMPACTION, tpz.skillchainEle.FRAGMENTATION, tpz.skillchainEle.LIGHT, tpz.skillchainEle.LIGHT_II } },
        [6] = {element = {tpz.magic.ele.WATER}, sc = {tpz.skillchainEle.REVERBERATION, tpz.skillchainEle.DISTORTION, tpz.skillchainEle.DARKNESS, tpz.skillchainEle.DARKNESS_II } },
        [7] = {element = {tpz.magic.ele.LIGHT}, sc = {tpz.skillchainEle.TRANSFIXION, tpz.skillchainEle.FUSION, tpz.skillchainEle.LIGHT, tpz.skillchainEle.LIGHT_II } },
        [8] = {element = {tpz.magic.ele.DARK}, sc = {tpz.skillchainEle.COMPRESSION, tpz.skillchainEle.GRAVITATION, tpz.skillchainEle.DISTORTION, tpz.skillchainEle.DARKNESS, tpz.skillchainEle.DARKNESS_II } },
    }
    local currentElement = {}
    currentElement = elements[element].sc

    return currentElement
end

function utils.GetMatchingSCDayElement()
    local elements =
    {
        {day = tpz.day.FIRESDAY, sc = {tpz.skillchainEle.LIQUEFACTION, tpz.skillchainEle.FUSION, tpz.skillchainEle.LIGHT, tpz.skillchainEle.LIGHT_II } },
        {day = tpz.day.EARTHSDAY, sc = {tpz.skillchainEle.SCISSION, tpz.skillchainEle.GRAVITATION, tpz.skillchainEle.DARKNESS, tpz.skillchainEle.DARKNESS_II } },
        {day = tpz.day.WATERSDAY, sc = {tpz.skillchainEle.REVERBERATION, tpz.skillchainEle.DISTORTION, tpz.skillchainEle.DARKNESS, tpz.skillchainEle.DARKNESS_II } },
        {day = tpz.day.WINDSDAY, sc = {tpz.skillchainEle.DETONATION, tpz.skillchainEle.FRAGMENTATION, tpz.skillchainEle.LIGHT, tpz.skillchainEle.LIGHT_II } },
        {day = tpz.day.ICEDAY, sc = {tpz.skillchainEle.INDURATION, tpz.skillchainEle.DISTORTION, tpz.skillchainEle.DARKNESS, tpz.skillchainEle.DARKNESS_II } },
        {day = tpz.day.LIGHTNINGDAY, sc = {tpz.skillchainEle.IMPACTION, tpz.skillchainEle.FRAGMENTATION, tpz.skillchainEle.LIGHT, tpz.skillchainEle.LIGHT_II } },
        {day = tpz.day.LIGHTSDAY, sc = {tpz.skillchainEle.TRANSFIXION, tpz.skillchainEle.FUSION, tpz.skillchainEle.LIGHT, tpz.skillchainEle.LIGHT_II } },
        {day = tpz.day.DARKSDAY, sc = {tpz.skillchainEle.COMPRESSION, tpz.skillchainEle.GRAVITATION,  tpz.skillchainEle.DARKNESS, tpz.skillchainEle.DARKNESS_II } },
    }
    
    local day = VanadielDayOfTheWeek()
    for _,entry in ipairs(elements) do
        if day == entry.day then
            return entry.sc
        end
    end
    
    return nil
end

function utils.CheckForZombie(player, target, ability)
    if target:hasStatusEffect(tpz.effect.CURSE_II) then
        ability:setMsg(tpz.msg.basic.JA_NO_EFFECT_2)
        return true
    end
    return false
end

function utils.CheckForZombieSpell(caster, spell)
    if caster:hasStatusEffect(tpz.effect.CURSE_II) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return true
    end
    return false
end

function utils.IsElementalDOT(effect)
    if (effect >= tpz.effect.BURN) and (effect <= tpz.effect.DROWN) then
        return true
    end
    return false
end

function utils.IsDOT(effect) -- TODO: Unfinished(?)
    if (effect >= tpz.effect.BURN) and (effect <= tpz.effect.BIO) then
        return true
    end
    return false
end

function utils.IsStatDown(effect)
    if (effect >= tpz.effect.STR_DOWN) and (effect <= tpz.effect.CHR_DOWN) then
        return true
    end
    return false
end

function utils.MessageParty(player, msg, textcolor, sender)
    if player == nil then
        return
    end

    local party = player:getParty()
    if player:isPet() then
        party = player:getMaster():getParty()
    end

    --Text color: default(name shown) - 0, gold - 0x1F, green - 0x1C, blue - 0xF, white(no sender name) - 0xD
    if (party ~= nil) then
        for _,v in ipairs(party) do
            if v:isPC() then
                v:PrintToPlayer(msg, textcolor, sender)
            end
        end
    end
end

function utils.ShowTextParty(player, textId)
    if (player == nil) then
        return
    end

    local party = player:getParty()
    if player:isPet() then
        party = player:getMaster():getParty()
    end

    --Text color: default(name shown) - 0, gold - 0x1F, green - 0x1C, blue - 0xF, white(no sender name) - 0xD
    if (party ~= nil) then
        for _,v in ipairs(party) do
            if v:isPC() then
                v:showText(npc, textId)
            end
        end
    end
end

-- add alliance enmity
function utils.linkAlliance(mob, player)
    local alliance = player:getAlliance()
    if alliance ~= nil then
        for _, member in pairs(alliance) do
            if member:getZoneID() == zone and member:isAlive() then
                mob:addEnmity(member, 1, 0) -- 1 CE
            end
        end
    end
end

function utils.getDropRate(mob, base)
    local dropRateBase =
    {
        [2400] = { 2400, 4800, 5600, 6000, 6400, 6666, 6800, 6900, 7050, 7200, 7350, 7400, 7600, 7800, 8000 },
        [1500] = { 1500, 3000, 4000, 4250, 4500, 4750, 5000, 5250, 5500, 5750, 6000, 6250, 6500, 6750, 7000 },
        [1000] = { 1000, 1200, 1500, 1650, 1800, 1900, 2000, 2100, 2250, 2400, 2650, 2800, 2950, 3100, 3250 },
        [500] =  { 0500, 0600, 0700, 0750, 800, 850, 900, 950, 1050, 1150, 1250, 1350, 1550, 1750, 2000 },
        [100] =  { 0100, 0150, 0200, 0225, 0250, 0300, 0350, 0400, 0475, 0550, 0650, 0750, 825, 900, 1000 },
        [50] =   { 0050, 0075, 0100, 0120, 0140, 0160, 180, 0200, 0230, 0260, 0300, 0350, 0400, 0450, 0500 },
        [10] =   { 0010, 0020, 0030, 0035, 0040, 0045, 0050, 0060, 0070, 80, 90, 0100, 0115, 0130, 0150 }
    }
    local th = mob:getTHlevel() + 1

    if (th > 15) then
        th = 15
    end

    local baseRate = 0;
    for compBase,_ in pairs(dropRateBase) do
        if (compBase <= base) and (compBase > baseRate) then
            baseRate = compBase
        end
    end

    local dropChance = dropRateBase[baseRate][th]
    -- printf("Base drop rate %s", baseRate)
    -- printf("Drop chance: %s", dropChance)
    return dropChance
end

function utils.spawnPetInBattle(mob, pet, aggro)
    mob:entityAnimationPacket("casm")
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(false)
    mob:SetMobAbilityEnabled(false)
    mob:timer(3000, function(mob)
        mob:entityAnimationPacket("shsm")
        mob:SetAutoAttackEnabled(true)
        mob:SetMagicCastingEnabled(true)
        mob:SetMobAbilityEnabled(true)
        pet:spawn()
        if (aggro ~= nil) then
            pet:updateEnmity(mob:getTarget())
        end
    end)
end

function utils.givePartyKeyItem(entity, keyitem)
    local zonePlayers = entity:getZone():getPlayers()
    local ID = zones[entity:getZoneID()]

    for _, zonePlayer in pairs(zonePlayers) do
        if not zonePlayer:hasKeyItem(keyitem) then
	        zonePlayer:addKeyItem(keyitem)
            zonePlayer:messageSpecial(ID.text.KEYITEM_OBTAINED, keyitem)
        end
    end
end

function utils.getWeaponStyle(player)
    if not player:isPC() then
        return 'Unknown'
    end

    local mainEquip = player:getStorageItem(0, 0, tpz.slot.MAIN)
    local subEquip = player:getStorageItem(0, 0, tpz.slot.SUB)

    if (mainEquip ~= nil) then
        if mainEquip:isHandToHand() then
            return 'H2H'
        end

        if mainEquip:isTwoHanded() then
            return '2H'
        end
    end

    if (subEquip ~= nil) then
        if subEquip == nil or subEquip:getSkillType() == tpz.skill.NONE or subEquip:isShield() then
            return 'SHIELD'
        else
            return 'DW'
        end
    end


    return 'H2H'
end

function utils.GetWeaponType(player)
    local mainHandSkill = player:getWeaponSkillType(tpz.slot.MAIN)

    local skills =
    {
        {1, 'H2H'},
        {2, 'DAGGER'},
        {3, 'SWORD'},
        {4, 'GREAT SWORD'},
        {5, 'AXE'},
        {6, 'GREAT AXE'},
        {7, 'SCYTHE'},
        {8, 'POLEARM'},
        {9, 'KATANA'},
        {10, 'GREAT KATANA'},
        {11, 'CLUB'},
        {12, 'STAFF'},
    }

    for _, combatSkills in pairs (skills) do
        if (mainHandSkill == combatSkills[1]) then
            return combatSkills[2]
        end
    end
end

function utils.ScarletDeliriumBonus(player, dmg)
    local scarletDeliriumEffect = player:getStatusEffect(tpz.effect.SCARLET_DELIRIUM_1)
    if (scarletDeliriumEffect ~= nil) and (scarletDeliriumEffect:getPower() >= 1) then
        local dmgBonus = (1 + (scarletDeliriumEffect:getPower() / 100))
        --printf("scarletDelirium dmg bonus  %i", dmgBonus*100)
        dmg = math.floor(dmg * dmgBonus)
    end

    return dmg
end

function utils.CapHealAmount(target, healamount)
    if ((target:getMaxHP() - target:getHP()) < healamount) then
        healamount = (target:getMaxHP() - target:getHP())
    end

    return healamount
end

function utils.ApplyStoneskinBonuses(caster, power)
    -- Apply Divine Seal bonus
    if (caster:hasStatusEffect(tpz.effect.DIVINE_SEAL)) then
        power = math.floor(power * 2)
    end

    -- Apply Rapture bonus
    if (caster:hasStatusEffect(tpz.effect.RAPTURE)) then
        power = math.floor(power * (1.5 + caster:getMod(tpz.mod.RAPTURE_AMOUNT)/100))
    end

    return power
end

-- TODO: Still wrong, missing stuff for h2h
-- battle utils   baseTp = (int16)(CalculateBaseTP((delay * 60) / 1000) / ratio); etc
function utils.CalcualteTPGain(attacker, target, ranged) 
    local delay = attacker:getDelay()
    local baseTp = utils.CalculateBaseTP(delay)
    local tpGained = 0

    if ranged then
        delay = attacker:getRangedDelay()
        baseTp = utils.CalculateBaseTP((delay * 120) / 1000);
    end

    if attacker:isPC() then
        tpAdded = math.floor(((baseTp / 3) * (100 + attacker:getMod(tpz.mod.STORETP))) / 100)
    elseif attacker:isMob() and not attacker:isCharmed() and not attacker:isJugPet() then
        tpGained = math.floor(((baseTp + 3) * (100 + attacker:getMod(tpz.mod.STORETP))) / 100)
    end

    return tpGained
end

-- TODO: Still wrong, missing stuff for h2h
-- battle utils   baseTp = (int16)(CalculateBaseTP((delay * 60) / 1000) / ratio); etc
function utils.CalcualteTPGiven(attacker, target, ranged)
    local delay = attacker:getDelay()
    local baseTp = utils.CalculateBaseTP(delay)
    local tpAdded = 0

    if ranged then
        delay = attacker:getRangedDelay()
        baseTp = utils.CalculateBaseTP((delay * 120) / 1000);
    end

    -- Mobs get basetp+30 whereas pcs and their pets get basetp/3 when hit
    if target:isPC() then
        tpAdded = math.floor(((baseTp / 3) * (100 + target:getMod(tpz.mod.STORETP))) / 100)
    elseif target:isMob() and not target:isCharmed() and not target:isJugPet() then
        tpAdded = math.floor(((baseTp + 3) * (100 + target:getMod(tpz.mod.STORETP))) / 100)
    end

    -- print(string.format("Delay: %d, Base TP: %d, StoreTP Mod: %d,  TP Added: %d", delay, baseTp, target:getMod(tpz.mod.STORETP), tpAdded))
    return tpAdded
end

function utils.CalculateBaseTP(delay)
    local tp = 1
    if (delay <= 180) then
        tp = (61 + ((delay - 180) * 63) / 360)
    elseif (delay <= 540) then
        tp = (61 + ((delay - 180) * 88) / 360)
    elseif (delay <= 630) then
        tp = (149 + ((delay - 540) * 20) / 360)
    elseif (delay <= 720) then
        tp = (154 + ((delay - 630) * 28) / 360)
    elseif (delay <= 900) then
        tp = (161 + ((delay - 720) * 24) / 360)
    else 
        tp = (173 + ((delay - 900) * 28) / 360)
    end

    return tp
end

function utils.CalculateSpellTPGiven(caster, target, totalhits)
    local sBlow1 = utils.clamp(caster:getMod(tpz.mod.SUBTLE_BLOW), -50, 50)
    local sBlow2 = utils.clamp(caster:getMod(tpz.mod.SUBTLE_BLOW_II), -50, 50)
    local sBlowMult = (utils.clamp((sBlow1 + sBlow2), -75, 75))
    local TP = 100
    if (totalhits == nil) then
        totalhits = 1
    end
    -- Add casters Subtle Blow
    local sBlowReduction = math.floor(100 * sBlowMult / 100)
    -- Remove TP given from subtle blow
    TP = TP - sBlowReduction

    -- Add targets Store TP
    TP = math.floor(TP * (100 + target:getMod(tpz.mod.STORETP)) / 100)

    -- Add TP per hit
    TP = TP * totalhits

    return TP
end

function utils.PrintTable(table)
    local point = paths[currentPath]
    local line = ""
    for key, value in pairs(point) do
        line = line .. key .. "=" .. value .. ", "
    end
    print(line:sub(1, -3))  -- Remove the last ", " from the line and print
end

function utils.GetRemovableEffects()
    local effects =
    {
        tpz.effect.FLASH, tpz.effect.BLINDNESS, tpz.effect.ELEGY, tpz.effect.REQUIEM, tpz.effect.PARALYSIS, tpz.effect.POISON,
        tpz.effect.CURSE_I, tpz.effect.CURSE_II, tpz.effect.DISEASE, tpz.effect.PLAGUE, tpz.effect.WEIGHT, tpz.effect.BIND,
        tpz.effect.BIO, tpz.effect.DIA, tpz.effect.BURN, tpz.effect.FROST, tpz.effect.CHOKE, tpz.effect.RASP, tpz.effect.SHOCK, tpz.effect.DROWN,
        tpz.effect.STR_DOWN, tpz.effect.DEX_DOWN, tpz.effect.VIT_DOWN, tpz.effect.AGI_DOWN, tpz.effect.INT_DOWN, tpz.effect.MND_DOWN,
        tpz.effect.CHR_DOWN, tpz.effect.ADDLE, tpz.effect.SLOW, tpz.effect.HELIX, tpz.effect.ACCURACY_DOWN, tpz.effect.ATTACK_DOWN,
        tpz.effect.EVASION_DOWN, tpz.effect.DEFENSE_DOWN, tpz.effect.MAGIC_ACC_DOWN, tpz.effect.MAGIC_ATK_DOWN, tpz.effect.MAGIC_EVASION_DOWN,
        tpz.effect.MAGIC_DEF_DOWN, tpz.effect.CRIT_HIT_EVASION_DOWN, tpz.effect.MAX_TP_DOWN, tpz.effect.MAX_MP_DOWN, tpz.effect.MAX_HP_DOWN,
        tpz.effect.SLUGGISH_DAZE_1, tpz.effect.SLUGGISH_DAZE_2, tpz.effect.SLUGGISH_DAZE_3, tpz.effect.SLUGGISH_DAZE_4, tpz.effect.SLUGGISH_DAZE_5,
        tpz.effect.LETHARGIC_DAZE_1, tpz.effect.LETHARGIC_DAZE_2, tpz.effect.LETHARGIC_DAZE_3, tpz.effect.LETHARGIC_DAZE_4, tpz.effect.LETHARGIC_DAZE_5,
        tpz.effect.WEAKENED_DAZE_1, tpz.effect.WEAKENED_DAZE_2, tpz.effect.WEAKENED_DAZE_3, tpz.effect.WEAKENED_DAZE_4, tpz.effect.WEAKENED_DAZE_5,
        tpz.effect.HELIX, tpz.effect.KAUSTRA, tpz.effect.SILENCE, tpz.effect.INUNDATION, tpz.effect.PETRIFICATION
    }
    return effects
end

