function onTrigger(player)
    local targ = player:getCursorTarget();
    if (targ ~= nil)  then
        if (targ:isPC() or targ:isMob() or targ:isPet() or targ:isTrust()) then
            local str = targ:getStat(tpz.mod.STR)
            local dex = targ:getStat(tpz.mod.DEX)
            local vit = targ:getStat(tpz.mod.VIT)
            local agi = targ:getStat(tpz.mod.AGI)
            local int = targ:getStat(tpz.mod.INT)
            local mnd = targ:getStat(tpz.mod.MND)
            local chr = targ:getStat(tpz.mod.CHR)

            local acc = targ:getACC()
            local eva = targ:getEVA()
            local att = targ:getStat(tpz.mod.ATT)
            local ratt = targ:getRATT()
            local def = targ:getStat(tpz.mod.DEF)
            local matt = targ:getMod(tpz.mod.MATT)
            local macc = targ:getMod(tpz.mod.MACC)
            local mdef = targ:getMod(tpz.mod.MDEF)

            player:PrintToPlayer(string.format("%s Stats 1: MJOB: %i, SJOB: %i, HP: %i, MP: %i, Weapon Damage: %i, Delay: %i,", targ:getName(), targ:getMainJob(), targ:getSubJob(), targ:getMaxHP(), targ:getMaxMP(), targ:getWeaponDmg(), targ:getDelay()))
            player:PrintToPlayer(string.format("%s Stats 2: LVL: %i, SLVL: %i, ACC: %i, EVA: %i, ATT: %i, RATT: %i, DEF: %i, MATT: %i, MACC: %i, MDEF: %i ", targ:getName(), targ:getMainLvl(), targ:getSubLvl(), acc,eva,att,ratt,def,matt,macc,mdef))
            player:PrintToPlayer(string.format("%s Stats 3: STR: %i, DEX: %i, VIT: %i, AGI: %i, INT: %i, MND: %i, CHR: %i", targ:getName(), str,dex,vit,agi,int,mnd,chr))
        else
            player:PrintToPlayer("Must select a mob or pet using in game cursor first.");
        end
    end
end
---------------------------------------------------------------------------------------------------
-- func: statcheck
-- desc: Prints the Stats of the currently selected target under the cursor
---------------------------------------------------------------------------------------------------
require("scripts/globals/status")

cmdprops =
{
    permission = 1,
    parameters = ""
};