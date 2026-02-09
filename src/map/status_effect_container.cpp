/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================

The StatusEffeectContainer manages status effects on battleentities.

When a status effect is gained twice on a player. It can do one or more of the following:

1 Overwrite if equal or higher (protect)
2 Overwrite if higher (blind)
3 Can only have one of type (physical shield, magic shield)
4 Overwrite if equal or stronger than negative (defense boost, defense down)

*/

#include "../common/showmsg.h"
#include "../common/timer.h"

#include <string.h>
#include <array>

#include "lua/luautils.h"

#include "ai/ai_container.h"
#include "ai/states/inactive_state.h"

#include "packets/char_health.h"
#include "packets/char_abilities.h"
#include "packets/char_job_extra.h"
#include "packets/char_update.h"
#include "packets/message_basic.h"
#include "packets/party_effects.h"
#include "packets/status_effects.h"

#include "utils/charutils.h"
#include "entities/battleentity.h"
#include "entities/charentity.h"
#include "entities/automatonentity.h"
#include "entities/mobentity.h"
#include "entities/trustentity.h"
#include "utils/itemutils.h"
#include "enmity_container.h"
#include "map.h"
#include "notoriety_container.h"
#include "latent_effect_container.h"
#include "status_effect_container.h"
#include "utils/zoneutils.h"
#include "utils/petutils.h"
#include "utils/puppetutils.h"
#include "utils/battleutils.h"
#include "job_points.h"

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

namespace effects
{
    /************************************************************************
    *                                                                       *
    *  Контейнер параметров эффектов                                        *
    *                                                                       *
    ************************************************************************/

    // Default effect of statuses are overwrite if equal or higher
    struct EffectParams_t
    {
        uint32   Flag;
        string_t Name;
        // type will erase all other effects that match
        // example: en- spells, spikes
        uint16   Type;
        // Negative means the new effect can only land if the negative id is weaker
        // example: haste, slow
        EFFECT   NegativeId;
        // only overwrite its self if the new effect is equal or higher / higher than current
        // example: protect, blind
        EFFECTOVERWRITE   Overwrite;
        // If this status effect is on the user, it will not take effect
        // example: lullaby will not take effect with sleep I
        EFFECT   BlockId;
        // Will always remove this effect when landing
        EFFECT   RemoveId;
        // status effect element, used in resistances
        uint8    Element;

        // minimum duration. IE: stun cannot last less than 1 second
        uint32    MinDuration;

        // Order in which the status effect should be displayed for the player
        uint16    SortKey;
    };

    std::array<EffectParams_t, MAX_EFFECTID> EffectsParams;

    /************************************************************************
    *                                                                       *
    *                                                                       *
    *                                                                       *
    ************************************************************************/

    void LoadEffectsParameters()
    {
        for (uint16 i = 0; i < MAX_EFFECTID; ++i)
        {
            EffectsParams[i].Flag = 0;
        }

        int32 ret = Sql_Query(SqlHandle, "SELECT id, name, flags, type, negative_id, overwrite, block_id, remove_id, element, min_duration, sort_key FROM status_effects WHERE id < %u", MAX_EFFECTID);

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                uint16 EffectID = (uint16)Sql_GetIntData(SqlHandle, 0);

                EffectsParams[EffectID].Name = (const char*)Sql_GetData(SqlHandle, 1);
                EffectsParams[EffectID].Flag = Sql_GetIntData(SqlHandle, 2);
                EffectsParams[EffectID].Type = Sql_GetIntData(SqlHandle, 3);
                EffectsParams[EffectID].NegativeId = (EFFECT)Sql_GetIntData(SqlHandle, 4);
                EffectsParams[EffectID].Overwrite = (EFFECTOVERWRITE)Sql_GetIntData(SqlHandle, 5);
                EffectsParams[EffectID].BlockId = (EFFECT)Sql_GetIntData(SqlHandle, 6);
                EffectsParams[EffectID].RemoveId = (EFFECT)Sql_GetIntData(SqlHandle, 7);

                EffectsParams[EffectID].Element = Sql_GetIntData(SqlHandle, 8);
                // convert from second to millisecond
                EffectsParams[EffectID].MinDuration = Sql_GetIntData(SqlHandle, 9) * 1000;

                uint16 sortKey = Sql_GetIntData(SqlHandle, 10);
                EffectsParams[EffectID].SortKey = sortKey == 0 ? 10000 : sortKey; // default to high number to such that effects without a sort key aren't first
            }
        }
    }

    // hacky way to get element from status effect
    uint16 GetEffectElement(uint16 effect)
    {
        return EffectsParams[effect].Element;
    }
}

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

bool isSortedByStartTime(uint16 effectId) {
    return effectId >= EFFECT_FIRE_MANEUVER && effectId <= EFFECT_DARK_MANEUVER;
}

bool statusOrdering(CStatusEffect* AStatus, CStatusEffect* BStatus) {
    // Sort by overall status effect ordering, if they have different sort keys
    uint16 ASortKey = effects::EffectsParams[AStatus->GetStatusID()].SortKey;
    uint16 BSortKey = effects::EffectsParams[BStatus->GetStatusID()].SortKey;
    if (ASortKey != BSortKey) {
        return ASortKey < BSortKey;
    }

    // Sort by song/roll slot
    if (AStatus->GetSlot() != BStatus->GetSlot()) {
        return AStatus->GetSlot() < BStatus->GetSlot();
    }

    // Sort by start time
    if (isSortedByStartTime(AStatus->GetStatusID()) && isSortedByStartTime(BStatus->GetStatusID())) {
        auto diff = std::chrono::duration_cast<std::chrono::milliseconds>(AStatus->GetStartTime() - BStatus->GetStartTime()).count();
        if (diff != 0) {
            return diff > 0;
        }
    }

    // Fall-back to sort by status effect ID, in case no other ordering is applied
    return AStatus->GetStatusID() < BStatus->GetStatusID();
}

CStatusEffectContainer::CStatusEffectContainer(CBattleEntity* PEntity) : m_StatusEffectSet(statusOrdering)
{
    m_POwner = PEntity;
    TPZ_DEBUG_BREAK_IF(m_POwner == nullptr);

    memset(m_StatusIcons, 0xFF, sizeof(m_StatusIcons));
}

CStatusEffectContainer::~CStatusEffectContainer()
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        delete PStatusEffect;
    }
}

/************************************************************************
*                                                                       *
*  Получаем количество эффектов с указанным id                          *
*                                                                       *
************************************************************************/

uint8 CStatusEffectContainer::GetEffectsCount(EFFECT ID)
{
    uint8 count = 0;

    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() == ID && !PStatusEffect->deleted)
        {
            count++;
        }
    }
    return count;
}

uint8 CStatusEffectContainer::GetLowestFreeSlot()
{
    uint8 lowestFreeSlot = 1;

    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetSlot() == lowestFreeSlot && !PStatusEffect->deleted)
        {
            lowestFreeSlot++;
        }
        else if (PStatusEffect->GetSlot() > lowestFreeSlot) {
            // Can break since the set is sorted by slot number,
            // and if we're past the lowest free one, we've found it already
            break;
        }
    }
    return lowestFreeSlot;
}

bool CStatusEffectContainer::CanGainStatusEffect(CStatusEffect* PStatusEffect)
{
    EFFECT statusEffect = PStatusEffect->GetStatusID();

    // Handle Divine Caress immunity buff
    if (m_POwner->StatusEffectContainer->HasStatusEffect(EFFECT_DIVINE_CARESS_2))
    {
        CStatusEffect* divineCaress = m_POwner->StatusEffectContainer->GetStatusEffect(EFFECT_DIVINE_CARESS_2);
        uint16 divineCaressImmunity = divineCaress->GetPower();

        if (statusEffect == divineCaressImmunity)
        {
            // Subpower is the amount of effects that can be immuned by Divine Caress. When it reaches 0 the effect ends
            int remainingImmunes = divineCaress->GetSubPower();
            if (remainingImmunes - 1 <= 0)
            {
                m_POwner->StatusEffectContainer->DelStatusEffectSilent(EFFECT_DIVINE_CARESS_2);
            }
            else
            {
                divineCaress->SetSubPower(remainingImmunes - 1);
            }

            return false;
        }
    }

    // check for immunities first
    switch (statusEffect) {
        case EFFECT_SLEEP:
        case EFFECT_SLEEP_II:
        case EFFECT_LULLABY:
        {
            if (m_POwner->hasImmunity(IMMUNITY_SLEEP))
                return false;

            uint16 subPower = PStatusEffect->GetSubPower();
            if (subPower == ELEMENT_LIGHT && m_POwner->hasImmunity(IMMUNITY_LIGHT_SLEEP))
                return false;
            if (subPower == ELEMENT_DARK && m_POwner->hasImmunity(IMMUNITY_DARK_SLEEP))
                return false;

            break;
        }
        case EFFECT_WEIGHT:
            if (m_POwner->hasImmunity(IMMUNITY_GRAVITY)) return false;
            break;
        case EFFECT_BIND:
            if (m_POwner->hasImmunity(IMMUNITY_BIND)) return false;
            break;
        case EFFECT_STUN:
            if (m_POwner->hasImmunity(IMMUNITY_STUN)) return false;
            break;
        case EFFECT_SILENCE:
        case EFFECT_MUTE:
            if (m_POwner->hasImmunity(IMMUNITY_SILENCE)) return false;
            break;
        case EFFECT_PARALYSIS:
            if (m_POwner->hasImmunity(IMMUNITY_PARALYZE)) return false;
            break;
        case EFFECT_BLINDNESS:
            if (m_POwner->hasImmunity(IMMUNITY_BLIND)) return false;
            break;
        case EFFECT_SLOW:
            if (m_POwner->hasImmunity(IMMUNITY_SLOW)) return false;
            break;
        case EFFECT_POISON:
            if (m_POwner->hasImmunity(IMMUNITY_POISON)) return false;
            break;
        case EFFECT_ELEGY:
            if (m_POwner->hasImmunity(IMMUNITY_ELEGY)) return false;
            break;
        case EFFECT_REQUIEM:
            if (m_POwner->hasImmunity(IMMUNITY_REQUIEM)) return false;
            break;
        case EFFECT_PETRIFICATION:
        case EFFECT_GRADUAL_PETRIFICATION:
            if (m_POwner->hasImmunity(IMMUNITY_PETRIFY))
                return false;
            if (m_POwner->hasImmunity(IMMUNITY_SLEEP))
                return false;
            break;
        case EFFECT_TERROR:
            if (m_POwner->hasImmunity(IMMUNITY_TERROR))
                return false;
            break;
        case EFFECT_AMNESIA:
            if (m_POwner->hasImmunity(IMMUNITY_AMNESIA))
                return false;
            break;
        case EFFECT_PLAGUE:
        case EFFECT_BANE:
            if (m_POwner->hasImmunity(IMMUNITY_VIRUS))
                return false;
            break;
        case EFFECT_CURSE:
        case EFFECT_CURSE_II:
            if (m_POwner->hasImmunity(IMMUNITY_CURSE))
                return false;
            break;
        case EFFECT_DOOM:
            if (m_POwner->hasImmunity(IMMUNITY_DOOM))
                return false;
            break;
        case EFFECT_CHARM:
            if (m_POwner->hasImmunity(IMMUNITY_CHARM))
                return false;
            break;
        default:
            break;
    }

    // make sure pets can't be charmed
    if ((statusEffect == EFFECT_CHARM || statusEffect == EFFECT_CHARM_II) && m_POwner->PMaster != nullptr)
    {
        return false;
    }

    // check if a status effect blocks this
    EFFECT blockId = effects::EffectsParams[statusEffect].BlockId;
    if (blockId != 0 && HasStatusEffect(blockId)) {
        return false;
    }

    // check if negative is strong enough to stop this
    EFFECT negativeId = effects::EffectsParams[statusEffect].NegativeId;
    if (negativeId != 0) {
        CStatusEffect* negativeEffect = GetStatusEffect(negativeId);

        if (negativeEffect != nullptr) {

            if (statusEffect == EFFECT_HASTE && negativeEffect->GetStatusID() == EFFECT_SLOW && negativeEffect->GetSubPower() == 1)
            {
                // slow i remote
                return true;
            }

            if (PStatusEffect->GetTier() != 0 && negativeEffect->GetTier() != 0)
            {
                return PStatusEffect->GetTier() == negativeEffect->GetTier() ? statusEffect > negativeId : PStatusEffect->GetTier() > negativeEffect->GetTier();
            }

            // new status effect must be stronger
            return PStatusEffect->GetPower() >= negativeEffect->GetPower();
        }
    }

    CStatusEffect* existingEffect = GetStatusEffect(statusEffect);

    // check overwrite
    if (existingEffect != nullptr) {
        EFFECTOVERWRITE overwrite = effects::EffectsParams[statusEffect].Overwrite;

        if (overwrite == EFFECTOVERWRITE_ALWAYS || overwrite == EFFECTOVERWRITE_IGNORE)
            return true;
        else if (overwrite == EFFECTOVERWRITE_NEVER)
            return false;
        else if (overwrite == EFFECTOVERWRITE_EQUAL_HIGHER)
        {
            if (PStatusEffect->GetTier() != 0 && existingEffect->GetTier() != 0)
                return PStatusEffect->GetTier() >= existingEffect->GetTier();
            return PStatusEffect->GetPower() >= existingEffect->GetPower();
        }
        else if (overwrite == EFFECTOVERWRITE_HIGHER)
        {
            if (PStatusEffect->GetTier() != 0 && existingEffect->GetTier() != 0)
                return PStatusEffect->GetTier() > existingEffect->GetTier();
            return PStatusEffect->GetPower() > existingEffect->GetPower();
        }
        else if (overwrite == EFFECTOVERWRITE_TIER_HIGHER)
        {
            if (PStatusEffect->GetTier() != 0 && existingEffect->GetTier() != 0)
                return PStatusEffect->GetTier() > existingEffect->GetTier();
        }

        return false;
    }

    return true;
}

void CStatusEffectContainer::OverwriteStatusEffect(CStatusEffect* StatusEffect)
{
    uint16 statusEffect = (uint16)StatusEffect->GetStatusID();
    // remove effect
    EFFECTOVERWRITE overwrite = effects::EffectsParams[statusEffect].Overwrite;
    if (overwrite != EFFECTOVERWRITE_IGNORE) {
        DelStatusEffectSilent((EFFECT)statusEffect);
    }

    // remove effect by id
    EFFECT removeId = effects::EffectsParams[statusEffect].RemoveId;
    if (removeId > EFFECT_KO) {
        DelStatusEffectSilent(removeId);
    }

    // remove negative effect
    EFFECT negativeId = effects::EffectsParams[statusEffect].NegativeId;
    if (negativeId > EFFECT_KO) {
        DelStatusEffectSilent(negativeId);
    }
}

/************************************************************************
*                                                                       *
*  Добавляем статус-эффект в контейнер                                  *
*  Если не ошибаюсь, то максимально-возможное количество эффектов 32    *
*                                                                       *
************************************************************************/

bool CStatusEffectContainer::AddStatusEffect(CStatusEffect* PStatusEffect, bool silent)
{
    if (PStatusEffect == nullptr) {
        ShowWarning("status_effect_container::AddStatusEffect Status effect given was nullptr!\n");
        return false;
    }

    uint16 statusId = PStatusEffect->GetStatusID();

    if (statusId >= MAX_EFFECTID) {
        ShowWarning("status_effect_container::AddStatusEffect statusId given is OVER limit %d\n", statusId);
        return false;
    }

    if (CanGainStatusEffect(PStatusEffect))
    {
        // check for minimum duration
        if (PStatusEffect->GetDuration() < effects::EffectsParams[statusId].MinDuration) {
            PStatusEffect->SetDuration(effects::EffectsParams[statusId].MinDuration);
        }

        // remove clean up other effects
        OverwriteStatusEffect(PStatusEffect);

        PStatusEffect->SetOwner(m_POwner);

        SetEffectParams(PStatusEffect);

        // remove effects with same type
        DelStatusEffectsByType(PStatusEffect->GetType());

        PStatusEffect->SetStartTime(server_clock::now());

        m_StatusEffectSet.insert(PStatusEffect);

        luautils::OnEffectGain(m_POwner, PStatusEffect);

        if (PStatusEffect->GetStatusID() == EFFECT_FOOD)
        {
            uint32 itemid = PStatusEffect->GetSubID();
            CItemUsable* PItem = dynamic_cast<CItemUsable*>(itemutils::GetItem(itemid));
            if (PItem && PItem->getMod(1) > 0 && PItem->getPower(1) > 0)
            {
                for (uint8 i = 0; i < 10; ++i)
                {
                    int16 mod = PItem->getMod(i + 1);
                    int16 power = PItem->getPower(i + 1);
                    if (mod != 0 && power != 0)
                    {
                        PStatusEffect->modList.push_back({ static_cast<Mod>(mod), power });
                    }
                }
            }
        }

        if (m_POwner->objtype == TYPE_PC)
        {
            CCharEntity* PChar = (CCharEntity*)m_POwner;
            charutils::BuildingCharSkillsTable(PChar);
            charutils::BuildingCharWeaponSkills(PChar);
            PChar->pushPacket(new CCharAbilitiesPacket(PChar));
        }
        m_POwner->PAI->EventHandler.triggerListener("EFFECT_GAIN", m_POwner, PStatusEffect);

        m_POwner->addModifiers(&PStatusEffect->modList);

        m_POwner->extDataUpdateFlag = true;

        if (PStatusEffect->GetStatusID() >= EFFECT_FIRE_MANEUVER &&
            PStatusEffect->GetStatusID() <= EFFECT_DARK_MANEUVER &&
            m_POwner->objtype == TYPE_PC)
        {
            puppetutils::CheckAttachmentsForManeuver((CCharEntity*)m_POwner, PStatusEffect->GetStatusID(), true);
        }

        if (m_POwner->health.maxhp != 0 && m_POwner->status != STATUS_DISAPPEAR) // make sure we're not in the middle of logging in
        {
            m_POwner->UpdateHealth();
        }

        if (m_POwner->objtype == TYPE_PC)
        {
            CCharEntity* PChar = (CCharEntity*)m_POwner;

            if (PStatusEffect->GetIcon() != 0)
            {
                UpdateStatusIcons();
            }

            if (m_POwner->health.maxhp != 0 && m_POwner->status != STATUS_DISAPPEAR) // make sure we're not in the middle of logging in
            {
                //check for latents
                PChar->PLatentEffectContainer->CheckLatentsFoodEffect();
                PChar->PLatentEffectContainer->CheckLatentsStatusEffect();
                PChar->PLatentEffectContainer->CheckLatentsRollSong();
                PChar->PLatentEffectContainer->CheckLatentsZone();

                charutils::BuildingCharSkillsTable(PChar);
                charutils::BuildingCharWeaponSkills(PChar);
                PChar->pushPacket(new CCharAbilitiesPacket(PChar));
                PChar->UpdateHealth();
            }
        }
        m_POwner->updatemask |= UPDATE_HP;

        return true;
    }
    else
    {
        delete PStatusEffect;
    }

    return false;
}

/************************************************************************
*                                                                       *
*  Эффекты во всех методах удаляются одинаково, вынес этот код в        *
*  отдельную функцию. Удаляем иконки только у CharEntity.               *
*                                                                       *
************************************************************************/

void CStatusEffectContainer::DeleteStatusEffects()
{
    bool update_icons = false;
    bool effects_removed = false;
    for (auto effect_iter = m_StatusEffectSet.begin(); effect_iter != m_StatusEffectSet.end();)
    {
        CStatusEffect* PStatusEffect = *effect_iter;
        if (PStatusEffect->deleted)
        {
            if (PStatusEffect->GetIcon() != 0)
            {
                update_icons = true;
            }
            effect_iter = m_StatusEffectSet.erase(effect_iter);
            delete PStatusEffect;
            effects_removed = true;
        }
        else
        {
            ++effect_iter;
        }
    }

    if (effects_removed)
    {
        if (m_POwner->objtype == TYPE_PC)
        {
            CCharEntity* PChar = (CCharEntity*)m_POwner;

            if (update_icons)
            {
                UpdateStatusIcons();
            }

            //check for latents
            PChar->PLatentEffectContainer->CheckLatentsFoodEffect();
            PChar->PLatentEffectContainer->CheckLatentsStatusEffect();
            PChar->PLatentEffectContainer->CheckLatentsRollSong();

            charutils::BuildingCharSkillsTable(PChar);
            charutils::BuildingCharWeaponSkills(PChar);
            PChar->pushPacket(new CCharAbilitiesPacket(PChar));
        }
        m_POwner->UpdateHealth();
        m_POwner->extDataUpdateFlag = true;
    }
}

void CStatusEffectContainer::RemoveStatusEffect(CStatusEffect* PStatusEffect, bool silent)
{
    if (PStatusEffect->deleted)
        return;

    // Puppet Maneuver detach check
    if (PStatusEffect->GetStatusID() >= EFFECT_FIRE_MANEUVER && PStatusEffect->GetStatusID() <= EFFECT_DARK_MANEUVER && m_POwner->objtype == TYPE_PC)
    {
        puppetutils::CheckAttachmentsForManeuver((CCharEntity*)m_POwner, PStatusEffect->GetStatusID(), false);
    }

    PStatusEffect->deleted = true;

    // Lua callback
    luautils::OnEffectLose(m_POwner, PStatusEffect);

    // Handle Food
    for (auto& mod : PStatusEffect->modList)
    {
        m_POwner->delModifier(mod.getModID(), mod.getModAmount());
    }

    // If player: rebuild skill tables and push ability packet
    if (m_POwner->objtype == TYPE_PC)
    {
        CCharEntity* PChar = (CCharEntity*)m_POwner;

        // check for latents
        PChar->PLatentEffectContainer->CheckLatentsFoodEffect();
        PChar->PLatentEffectContainer->CheckLatentsStatusEffect();
        PChar->PLatentEffectContainer->CheckLatentsRollSong();

        charutils::BuildingCharSkillsTable(PChar);
        charutils::BuildingCharWeaponSkills(PChar);
        PChar->pushPacket(new CCharAbilitiesPacket(PChar));
    }

    // Event listeners
    m_POwner->PAI->EventHandler.triggerListener("EFFECT_LOSE", m_POwner, PStatusEffect);

    // Mark for update
    m_POwner->extDataUpdateFlag = true;

    // Send status wear off message
    SendWearOffMessage(PStatusEffect, silent);
}

static const std::unordered_set<uint16> noLongerMsgEffects = {
    EFFECT_WEAKNESS,      EFFECT_SLEEP,    EFFECT_POISON, EFFECT_PARALYSIS,  EFFECT_BLINDNESS, EFFECT_SILENCE,
    EFFECT_PETRIFICATION, EFFECT_DISEASE,  EFFECT_CURSE,  EFFECT_STUN,       EFFECT_BIND,      EFFECT_WEIGHT,
    EFFECT_SLOW,          EFFECT_CHARM,    EFFECT_DOOM,   EFFECT_AMNESIA,    EFFECT_CHARM_II,  EFFECT_GRADUAL_PETRIFICATION,
    EFFECT_SLEEP_II,      EFFECT_CURSE_II, EFFECT_ADDLE,  EFFECT_INTIMIDATE, EFFECT_KAUSTRA,   EFFECT_TERROR,
    EFFECT_MUTE,          EFFECT_BANE,     EFFECT_PLAGUE, EFFECT_ENCUMBRANCE, EFFECT_ENCUMBRANCE_II, EFFECT_MUDDLE,
    EFFECT_TAINT,         EFFECT_HAUNT,    EFFECT_QUICKENING, EFFECT_OVERLOAD, EFFECT_LULLABY, EFFECT_INUNDATION,
};

void CStatusEffectContainer::SendWearOffMessage(CStatusEffect* PStatusEffect, bool silent)
{
    if (PStatusEffect->GetIcon() == 0 || silent || (PStatusEffect->GetFlag() & EFFECTFLAG_NO_LOSS_MESSAGE) || m_POwner->isDead())
        return;

    uint16 messageID = MSGBASIC_STATUS_WEARS_OFF;
    auto statusID = PStatusEffect->GetStatusID();

    if (noLongerMsgEffects.count(statusID))
    {
        messageID = MSGBASIC_STATUS_NO_LONGER;
    }

    m_POwner->loc.zone->PushPacket(m_POwner, CHAR_INRANGE_SELF, new CMessageBasicPacket(m_POwner, m_POwner, PStatusEffect->GetIcon(), 0, messageID));
}

/************************************************************************
*                                                                       *
*  Удаляем статус-эффект по его основному и дополнительному типам.      *
*  Возвращаем результат выполнения операции.                            *
*                                                                       *
************************************************************************/

bool CStatusEffectContainer::DelStatusEffect(EFFECT StatusID)
{
    for (auto it = m_StatusEffectSet.begin(); it != m_StatusEffectSet.end(); ++it)
    {
        CStatusEffect* effect = *it;
        if (effect->GetStatusID() == StatusID && !effect->deleted)
        {
            RemoveStatusEffect(effect);
            return true;
        }
    }
    return false;
}

bool CStatusEffectContainer::DelStatusEffectSilent(EFFECT StatusID)
{
    for (auto it = m_StatusEffectSet.begin(); it != m_StatusEffectSet.end(); ++it)
    {
        CStatusEffect* effect = *it;

        if (effect->GetStatusID() == StatusID && !effect->deleted)
        {
            RemoveStatusEffect(effect, true);
            return true;
        }
    }
    return false;
}

bool CStatusEffectContainer::DelStatusEffect(EFFECT StatusID, uint16 SubID)
{
    for (auto it = m_StatusEffectSet.begin(); it != m_StatusEffectSet.end(); ++it)
    {
        CStatusEffect* effect = *it;
        if (effect->GetStatusID() == StatusID &&
            effect->GetSubID() == SubID &&
            !effect->deleted)
        {
            RemoveStatusEffect(effect);
            return true;
        }
    }
    return false;
}

bool CStatusEffectContainer::DelStatusEffectBySource(EFFECT StatusID, EffectSourceType sourceType, uint16 sourceTypeParam)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() == StatusID && PStatusEffect->GetSourceType() == sourceType &&
            PStatusEffect->GetSourceTypeParam() == sourceTypeParam && !PStatusEffect->deleted)
        {
            RemoveStatusEffect(PStatusEffect);
            return true;
        }
    }
    return false;
}

bool CStatusEffectContainer::DelStatusEffectByTier(EFFECT StatusID, uint16 tier)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() == StatusID &&
            PStatusEffect->GetTier() == tier &&
            !PStatusEffect->deleted)
        {
            RemoveStatusEffect(PStatusEffect, true);
            return true;
        }
    }
    return false;
}

/************************************************************************
*                                                                       *
*  Deletes all status effects without sending messages                  *
*                                                                       *
************************************************************************/
void CStatusEffectContainer::KillAllStatusEffect()
{
    for (auto effect_iter = m_StatusEffectSet.begin(); effect_iter != m_StatusEffectSet.end();)
    {
        CStatusEffect* PStatusEffect = *effect_iter;
        if (PStatusEffect->GetDuration() != 0)
        {
            luautils::OnEffectLose(m_POwner, PStatusEffect);

            m_POwner->delModifiers(&PStatusEffect->modList);

            effect_iter = m_StatusEffectSet.erase(effect_iter);

            delete PStatusEffect;
        }
        else
        {
            ++effect_iter;
        }
    }
}

/************************************************************************
*                                                                       *
*  Удаляем все эффекты с указанными иконками                            *
*                                                                       *
************************************************************************/

void CStatusEffectContainer::DelStatusEffectsByIcon(uint16 IconID)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetIcon() == IconID)
        {
            // This covers all effects that client can remove. Function not used for anything the server removes.
            if (!(PStatusEffect->GetFlag() & EFFECTFLAG_NO_CANCEL))
                RemoveStatusEffect(PStatusEffect);
        }
    }
}

void CStatusEffectContainer::DelStatusEffectsByType(uint16 Type)
{
    if (Type <= 0) return;

    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetType() == Type)
        {
            RemoveStatusEffect(PStatusEffect, true);
        }
    }
}

/************************************************************************
*                                                                       *
*  Удаляем все эффекты с указанными флагами                             *
*                                                                       *
************************************************************************/

void CStatusEffectContainer::DelStatusEffectsByFlag(uint32 flag, bool silent)
{
    std::vector<CStatusEffect*> toRemove;

    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetFlag() & flag)
        {
            toRemove.push_back(PStatusEffect);
        }
    }

    for (CStatusEffect* PStatusEffect : toRemove)
    {
        RemoveStatusEffect(PStatusEffect, silent);
    }
}

/************************************************************************
*                                                                       *
*  Удаляем первый добавленный отрицательный эффект с флагом erase.      *
*  Возвращаем результат выполнения операции.                            *
*                                                                       *
************************************************************************/

EFFECT CStatusEffectContainer::EraseStatusEffect()
{
    std::vector<CStatusEffect*> erasableList;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetFlag() & EFFECTFLAG_ERASABLE &&
            PStatusEffect->GetDuration() > 0 &&
            !PStatusEffect->deleted)
        {
            erasableList.push_back(PStatusEffect);
        }
    }
    if (!erasableList.empty())
    {
        auto rndIdx = tpzrand::GetRandomNumber(erasableList.size());
        EFFECT result = erasableList.at(rndIdx)->GetStatusID();
        RemoveStatusEffect(erasableList.at(rndIdx));
        return result;
    }
    return EFFECT_NONE;
}

EFFECT CStatusEffectContainer::HealingWaltz()
{
    std::vector<CStatusEffect*> waltzableList;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if ((PStatusEffect->GetFlag() & EFFECTFLAG_WALTZABLE ||
            PStatusEffect->GetFlag() & EFFECTFLAG_ERASABLE) &&
            PStatusEffect->GetDuration() > 0 &&
            !PStatusEffect->deleted)
        {
            waltzableList.push_back(PStatusEffect);
        }
    }
    if (!waltzableList.empty())
    {
        auto rndIdx = tpzrand::GetRandomNumber(waltzableList.size());
        EFFECT result = waltzableList.at(rndIdx)->GetStatusID();
        RemoveStatusEffect(waltzableList.at(rndIdx));
        return result;
    }
    return EFFECT_NONE;
}

/*
Erases all negative status effects
returns number of erased effects
*/
uint8 CStatusEffectContainer::EraseAllStatusEffect()
{
    uint8 count = 0;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetFlag() & EFFECTFLAG_ERASABLE &&
            PStatusEffect->GetDuration() > 0 &&
            !PStatusEffect->deleted)
        {
            RemoveStatusEffect(PStatusEffect, true);
            count++;
        }
    }
    return count;
}

uint8 CStatusEffectContainer::RemoveAllNegativeEffects()
{
    uint8 count = 0;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetFlag() & EFFECTFLAG_ERASABLE &&
            PStatusEffect->GetDuration() > 0 &&
            !PStatusEffect->deleted)
        {
            RemoveStatusEffect(PStatusEffect, true);
            count++;
        }
        if (PStatusEffect->GetStatusID() == 1 &&
            PStatusEffect->GetDuration() > 0 &&
            !PStatusEffect->deleted)
        {
            RemoveStatusEffect(PStatusEffect, true);
            count++;
        }
        if (PStatusEffect->GetStatusID() >= 2 && PStatusEffect->GetStatusID() <= 31 &&
            PStatusEffect->GetDuration() > 0 &&
            !PStatusEffect->deleted)
        {
            RemoveStatusEffect(PStatusEffect, true);
            count++;
        }
        if (PStatusEffect->GetStatusID() >= 128 && PStatusEffect->GetStatusID() <= 142 &&
            PStatusEffect->GetDuration() > 0 &&
            !PStatusEffect->deleted)
        {
            RemoveStatusEffect(PStatusEffect, true);
            count++;
        }
        if (PStatusEffect->GetStatusID() >= 144 && PStatusEffect->GetStatusID() <= 149 &&
            PStatusEffect->GetDuration() > 0 &&
            !PStatusEffect->deleted)
        {
            RemoveStatusEffect(PStatusEffect, true);
            count++;
        }
        if (PStatusEffect->GetStatusID() >= 167 && PStatusEffect->GetStatusID() <= 168 &&
            PStatusEffect->GetDuration() > 0 &&
            !PStatusEffect->deleted)
        {
            RemoveStatusEffect(PStatusEffect, true);
            count++;
        }
        if (PStatusEffect->GetStatusID() >= 192 && PStatusEffect->GetStatusID() <= 194 &&
            PStatusEffect->GetDuration() > 0 &&
            !PStatusEffect->deleted)
        {
            RemoveStatusEffect(PStatusEffect, true);
            count++;
        }
        if (PStatusEffect->GetStatusID() >= 386 && PStatusEffect->GetStatusID() <= 400 &&
            PStatusEffect->GetDuration() > 0 &&
            !PStatusEffect->deleted)
        {
            RemoveStatusEffect(PStatusEffect, true);
            count++;
        }
        if (PStatusEffect->GetStatusID() == 156 &&
            PStatusEffect->GetDuration() > 0 &&
            !PStatusEffect->deleted)
        {
            RemoveStatusEffect(PStatusEffect, true);
            count++;
        }
        if (PStatusEffect->GetStatusID() == 186 &&
            PStatusEffect->GetDuration() > 0 &&
            !PStatusEffect->deleted)
        {
            RemoveStatusEffect(PStatusEffect, true);
            count++;
        }
        if (PStatusEffect->GetStatusID() == 189 &&
            PStatusEffect->GetDuration() > 0 &&
            !PStatusEffect->deleted)
        {
            RemoveStatusEffect(PStatusEffect, true);
            count++;
        }
    }
    return count;
}

/************************************************************************
*                                                                       *
*  Удаляем первый добавленный положительный эффект с флагом dispel.     *
*  Возвращаем результат выполнения операции.                            *
*                                                                       *
************************************************************************/

EFFECT CStatusEffectContainer::DispelStatusEffect(EFFECTFLAG flag)
{
    std::vector<CStatusEffect*> dispelableList;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetFlag() & flag &&
            PStatusEffect->GetDuration() > 0 &&
            !PStatusEffect->deleted)
        {
            dispelableList.push_back(PStatusEffect);
        }
    }
    if (!dispelableList.empty())
    {
        auto rndIdx = tpzrand::GetRandomNumber(dispelableList.size());
        EFFECT result = dispelableList.at(rndIdx)->GetStatusID();
        RemoveStatusEffect(dispelableList.at(rndIdx), true);
        return result;
    }
    return EFFECT_NONE;
}

/*
Dispels all positive status effects
returns number of dispelled effects
*/
uint8 CStatusEffectContainer::DispelAllStatusEffect(EFFECTFLAG flag)
{
    uint8 count = 0;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetFlag() & flag &&
            PStatusEffect->GetDuration() > 0 &&
            !PStatusEffect->deleted)
        {
            RemoveStatusEffect(PStatusEffect, true);
            count++;
        }
    }
    return count;
}

/************************************************************************
*                                                                       *
*  Проверяем наличие статус-эффекта в контейнере                        *
*                                                                       *
************************************************************************/

bool CStatusEffectContainer::HasStatusEffect(EFFECT StatusID)
{
    if (m_StatusEffectSet.empty())
    {
        return false;
    }

    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect && PStatusEffect->GetStatusID() == StatusID && !PStatusEffect->deleted)
        {
            return true;
        }
    }

    return false;
}


uint16 CStatusEffectContainer::GetTotalMinneBonus()
{
    uint16 ret = 0;

    for (auto&& PEffect : m_StatusEffectSet)
    {
        if (PEffect->GetStatusID() == EFFECT_MINNE && !PEffect->deleted)
        {
            ret += PEffect->GetPower();
        }
    }

    return ret;
}

uint16 CStatusEffectContainer::GetTotalSongBonus(EFFECT SongEffect)
{
    uint16 ret = 0;

    for (auto&& PEffect : m_StatusEffectSet)
    {
        if (PEffect->GetStatusID() == SongEffect && !PEffect->deleted)
        {
            ret += PEffect->GetPower();
        }
    }

    return ret;
}

uint16 CStatusEffectContainer::GetTotalBuffSongCount()
{
    uint16 songCount = 0;

    // Iterate this container's effects directly and skip deleted ones.
    ForEachEffect([&songCount](CStatusEffect* effect)
    {
        if (effect && !effect->deleted &&
            effect->GetStatusID() >= EFFECT_PAEON &&
            effect->GetStatusID() <= EFFECT_SCHERZO)
        {
            ++songCount;
        }
    });

    return songCount;
}

bool CStatusEffectContainer::HasStatusEffectByFlag(uint32 flag)
{

    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetFlag() & flag &&
            !PStatusEffect->deleted)
        {
            return true;
        }
    }
    return false;
}

/************************************************************************
        Applies a bard song effect (after checking restrictions)
        Returns true if the effect is applied, false otherwise.
*************************************************************************/

bool CStatusEffectContainer::ApplyBardEffect(CStatusEffect* PStatusEffect, uint8 maxSongs)
{
    //if all match tier/id/effect then overwrite

    //if tier/effect match then overwrite //but id doesn't, NO EFFECT
    //if targ has <2 of your songs on, then just apply
    //if targ has 2 of your songs, remove oldest one and apply this one.

    uint8 numOfEffects = 0;
    CStatusEffect* oldestSong = nullptr;
    for (CStatusEffect* ExistingStatusEffect : m_StatusEffectSet)
    {
        if (ExistingStatusEffect->GetStatusID() >= EFFECT_REQUIEM &&
            ExistingStatusEffect->GetStatusID() <= EFFECT_NOCTURNE) //is an active brd effect
        {
            if (ExistingStatusEffect->GetTier() == PStatusEffect->GetTier() &&
                ExistingStatusEffect->GetStatusID() == PStatusEffect->GetStatusID()) {//same tier/type, overwrite
                    //OVERWRITE
                PStatusEffect->SetSlot(ExistingStatusEffect->GetSlot()); // use same slot as the one it replaces
                DelStatusEffectByTier(PStatusEffect->GetStatusID(), PStatusEffect->GetTier());
            }
            if (ExistingStatusEffect->GetSubID() == PStatusEffect->GetSubID()) {//YOUR BRD effect
                numOfEffects++;
                if (!oldestSong) {
                    oldestSong = ExistingStatusEffect;
                }
                else if (std::chrono::milliseconds(ExistingStatusEffect->GetDuration()) + ExistingStatusEffect->GetStartTime() <
                    std::chrono::milliseconds(oldestSong->GetDuration()) + oldestSong->GetStartTime()) {
                    oldestSong = ExistingStatusEffect;
                }
            }
        }
    }

    if (numOfEffects < maxSongs) {
        if (PStatusEffect->GetSlot() == 0) {
            // use lowest available slot, unless it's replacing an existing song
            PStatusEffect->SetSlot(GetLowestFreeSlot());
        }
        AddStatusEffect(PStatusEffect);
        return true;
    }
    else if (oldestSong) {
        //overwrite oldest
        PStatusEffect->SetSlot(oldestSong->GetSlot());
        DelStatusEffectByTier(oldestSong->GetStatusID(), oldestSong->GetTier());
        AddStatusEffect(PStatusEffect);
        return true;
    }

    return false;
}

bool CStatusEffectContainer::ApplyCorsairEffect(CStatusEffect* PStatusEffect, uint8 maxRolls, uint8 bustDuration)
{
    //break if not a COR roll.
    TPZ_DEBUG_BREAK_IF(!((PStatusEffect->GetStatusID() >= EFFECT_FIGHTERS_ROLL &&
        PStatusEffect->GetStatusID() <= EFFECT_NATURALISTS_ROLL) || (PStatusEffect->GetStatusID() == EFFECT_RUNEISTS_ROLL)));

    //if all match tier/id/effect then overwrite

    //if tier/effect match then overwrite //but id doesn't, NO EFFECT
    //if targ has <2 of your rolls on, then just apply
    //if targ has 2 of your rolls, remove oldest one and apply this one.

    uint8 numOfEffects = 0;
    CStatusEffect* oldestRoll = nullptr;
    for (auto&& PEffect : m_StatusEffectSet)
    {
        if ((PEffect->GetStatusID() >= EFFECT_FIGHTERS_ROLL &&
            PEffect->GetStatusID() <= EFFECT_NATURALISTS_ROLL) ||
            PEffect->GetStatusID() == EFFECT_RUNEISTS_ROLL ||
            PEffect->GetStatusID() == EFFECT_BUST)//is a cor effect
        {
            if (PEffect->GetStatusID() == PStatusEffect->GetStatusID() &&
                PEffect->GetSubID() == PStatusEffect->GetSubID() &&
                PEffect->GetSubPower() < PStatusEffect->GetSubPower()) {//same type, double up
                if (PStatusEffect->GetSubPower() < 12)
                {
                    PStatusEffect->SetDuration(PEffect->GetDuration());
                    PStatusEffect->SetSlot(PEffect->GetSlot());
                    DelStatusEffectSilent(PStatusEffect->GetStatusID());
                    AddStatusEffect(PStatusEffect, true);
                    return true;
                }
                else
                {
                    if (PEffect->GetSubID() == m_POwner->id)
                    {
                        if (!CheckForElevenRoll())
                        {
                            uint16 bustEvasion = 0;
                            uint16 randomChance = tpzrand::GetRandomNumber(100);
                            if (m_POwner->objtype == TYPE_PC)
                            {
                                if (auto* PChar = static_cast<CCharEntity*>(m_POwner))
                                {
                                    bustEvasion += PChar->PJobPoints->GetJobPointValue(JP_BUST_EVASION);
                                }
                            }

                            if (randomChance >= bustEvasion)
                            {
                                uint16 duration = 300;
                                duration -= bustDuration;
                                CStatusEffect* bustEffect = new CStatusEffect(EFFECT_BUST, EFFECT_BUST, PStatusEffect->GetPower(), 0, duration,
                                                                              PStatusEffect->GetTier(), PStatusEffect->GetStatusID());
                                AddStatusEffect(bustEffect, true);
                            }
                            DelStatusEffectSilent(EFFECT_DOUBLE_UP_CHANCE);
                        }
                    }
                    DelStatusEffectSilent(PStatusEffect->GetStatusID());

                    return true;
                }
            }
            if (PEffect->GetSubID() == PStatusEffect->GetSubID() ||
                PEffect->GetStatusID() == EFFECT_BUST) {//YOUR cor effect
                numOfEffects++;
                if (oldestRoll == nullptr) {
                    oldestRoll = PEffect;
                }
                else if (std::chrono::milliseconds(PEffect->GetDuration()) + PEffect->GetStartTime() <
                    std::chrono::milliseconds(oldestRoll->GetDuration()) + oldestRoll->GetStartTime()) {
                    oldestRoll = PEffect;
                }
            }
        }
    }

    if (numOfEffects < maxRolls) {
        PStatusEffect->SetSlot(GetLowestFreeSlot());
        AddStatusEffect(PStatusEffect, true);
        return true;
    }
    else {
        //i'm a liar, can overwrite rolls
        PStatusEffect->SetSlot(oldestRoll->GetSlot());
        DelStatusEffect(oldestRoll->GetStatusID());
        AddStatusEffect(PStatusEffect);
        return true;
    }

    return false;
}

bool CStatusEffectContainer::HasCorsairEffect(uint32 charid)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if ((PStatusEffect->GetStatusID() >= EFFECT_FIGHTERS_ROLL &&
            PStatusEffect->GetStatusID() <= EFFECT_NATURALISTS_ROLL) ||
            PStatusEffect->GetStatusID() == EFFECT_RUNEISTS_ROLL ||
            PStatusEffect->GetStatusID() == EFFECT_BUST)//is a cor effect
        {
            if (PStatusEffect->GetSubID() == charid ||
                PStatusEffect->GetStatusID() == EFFECT_BUST)
            {
                return true;
            }
        }
    }
    return false;
}

void CStatusEffectContainer::Fold(uint32 charid)
{
    CStatusEffect* oldestRoll = nullptr;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if ((PStatusEffect->GetStatusID() >= EFFECT_FIGHTERS_ROLL &&
            PStatusEffect->GetStatusID() <= EFFECT_NATURALISTS_ROLL) ||
            PStatusEffect->GetStatusID() == EFFECT_RUNEISTS_ROLL ||
            PStatusEffect->GetStatusID() == EFFECT_BUST)//is a cor effect
        {
            if (PStatusEffect->GetSubID() == charid ||
                PStatusEffect->GetStatusID() == EFFECT_BUST)
            {
                if (oldestRoll == nullptr)
                {
                    oldestRoll = PStatusEffect;
                }
                else if (PStatusEffect->GetStatusID() == EFFECT_BUST)
                {
                    if (oldestRoll->GetStatusID() == EFFECT_BUST)
                    {
                        oldestRoll = PStatusEffect->GetStartTime() > oldestRoll->GetStartTime() ? PStatusEffect : oldestRoll;
                    }
                    else
                    {
                        oldestRoll = PStatusEffect;
                    }
                }
                else if (oldestRoll->GetStatusID() != EFFECT_BUST && PStatusEffect->GetStartTime() > oldestRoll->GetStartTime())
                {
                    oldestRoll = PStatusEffect;
                }
            }
        }
    }
    if (oldestRoll != nullptr)
    {
        RemoveStatusEffect(oldestRoll);
        DelStatusEffectSilent(EFFECT_DOUBLE_UP_CHANCE);
    }
}

uint8 CStatusEffectContainer::GetActiveManeuvers()
{
    uint8 count = 0;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() >= EFFECT_FIRE_MANEUVER &&
            PStatusEffect->GetStatusID() <= EFFECT_DARK_MANEUVER &&
            !PStatusEffect->deleted)
        {
            count++;
        }
    }
    return count;
}

void CStatusEffectContainer::ConsumeManeuversByElement(EFFECT Maneuver)
{
    while (HasStatusEffect(Maneuver))
    {
        DelStatusEffectSilent(Maneuver);
    }
}

void CStatusEffectContainer::RemoveOldestManeuver()
{
    CStatusEffect* oldest = nullptr;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() >= EFFECT_FIRE_MANEUVER &&
            PStatusEffect->GetStatusID() <= EFFECT_DARK_MANEUVER &&
            !PStatusEffect->deleted)
        {
            if (!oldest || PStatusEffect->GetStartTime() < oldest->GetStartTime())
            {
                oldest = PStatusEffect;
            }
        }
    }
    if (oldest)
    {
        RemoveStatusEffect(oldest, true);
    }
}

void CStatusEffectContainer::RemoveAllManeuvers()
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() >= EFFECT_FIRE_MANEUVER &&
            PStatusEffect->GetStatusID() <= EFFECT_DARK_MANEUVER)
        {
            RemoveStatusEffect(PStatusEffect, true);
        }
    }
}

std::vector<EFFECT> CStatusEffectContainer::GetAllRuneEffects()
{
    return GetStatusEffectsInIDRange(EFFECT_IGNIS, EFFECT_TENEBRAE);
}

uint8 CStatusEffectContainer::GetActiveRuneCount()
{
    return GetStatusEffectCountInIDRange(EFFECT_IGNIS, EFFECT_TENEBRAE);
}

EFFECT CStatusEffectContainer::GetHighestRuneEffect()
{
    std::unordered_map<EFFECT, uint8> runeEffects;

    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() >= EFFECT_IGNIS && PStatusEffect->GetStatusID() <= EFFECT_TENEBRAE && !PStatusEffect->deleted)
        {
            if (runeEffects.count(PStatusEffect->GetStatusID()) == 0)
            {
                runeEffects[PStatusEffect->GetStatusID()] = 1;
            }
            else
            {
                runeEffects.at(PStatusEffect->GetStatusID())++;
            }
        }
    }

    EFFECT highestRune = EFFECT_NONE;
    int highestRuneValue = 0;

    for (auto iter = runeEffects.begin(); iter != runeEffects.end(); ++iter)
    {
        if (highestRune == EFFECT_NONE || iter->second > highestRuneValue)
        {
            highestRune = iter->first;
            highestRuneValue = iter->second;
        }
    }

    return highestRune;
}

EFFECT CStatusEffectContainer::GetNewestRuneEffect()
{
    return GetNewestStatusEffectInIDRange(EFFECT_IGNIS, EFFECT_TENEBRAE);
}

void CStatusEffectContainer::RemoveNewestRune()
{
    RemoveNewestStatusEffectInIDRange(EFFECT_IGNIS, EFFECT_TENEBRAE);
}

void CStatusEffectContainer::RemoveOldestRune()
{
    RemoveOldestStatusEffectInIDRange(EFFECT_IGNIS, EFFECT_TENEBRAE);
}

void CStatusEffectContainer::RemoveAllRunes()
{
    RemoveAllStatusEffectsInIDRange(EFFECT_IGNIS, EFFECT_TENEBRAE);
}


/************************************************************************
*                                                                       *
*  Проверяем наличие статус-эффекта в контейнере с уникальным subid     *
*                                                                       *
************************************************************************/

bool CStatusEffectContainer::HasStatusEffect(EFFECT StatusID, uint16 SubID)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() == StatusID &&
            PStatusEffect->GetSubID() == SubID &&
            !PStatusEffect->deleted)
        {
            return true;
        }
    }
    return false;
}

bool CStatusEffectContainer::HasStatusEffect(std::initializer_list<EFFECT> effects)
{
    for (auto&& effect_from_set : m_StatusEffectSet)
    {
        if (!effect_from_set->deleted)
        {
            for (auto&& effect_to_check : effects)
            {
                if (effect_to_check == effect_from_set->GetStatusID())
                {
                    return true;
                }
            }
        }
    }
    return false;
}

CStatusEffect* CStatusEffectContainer::GetStatusEffect(EFFECT StatusID)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() == StatusID &&
            !PStatusEffect->deleted)
        {
            return PStatusEffect;
        }
    }
    return nullptr;
}

CStatusEffect* CStatusEffectContainer::GetStatusEffectBySource(EFFECT StatusID, EffectSourceType SourceType, uint16 SourceTypeParam)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() == StatusID && PStatusEffect->GetSourceType() == SourceType &&
            PStatusEffect->GetSourceTypeParam() == SourceTypeParam && !PStatusEffect->deleted)
        {
            return PStatusEffect;
        }
    }
    return nullptr;
}

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

CStatusEffect* CStatusEffectContainer::GetStatusEffect(EFFECT StatusID, uint32 SubID)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() == StatusID &&
            PStatusEffect->GetSubID() == SubID &&
            !PStatusEffect->deleted)
        {
            return PStatusEffect;
        }
    }
    return nullptr;
}

/************************************************************************
* Dispels one effect and returns it.
* Used in mob abilities
************************************************************************/

CStatusEffect* CStatusEffectContainer::StealStatusEffect(EFFECTFLAG flag)
{
    std::vector<CStatusEffect*> dispelableList;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetFlag() & flag &&
            PStatusEffect->GetDuration() > 0 &&
            !PStatusEffect->deleted)
        {
            dispelableList.push_back(PStatusEffect);
        }
    }
    if (!dispelableList.empty())
    {
        auto rndIdx = tpzrand::GetRandomNumber(dispelableList.size());

        CStatusEffect* oldEffect = dispelableList.at(rndIdx);

        //make a copy
        CStatusEffect* EffectCopy = new CStatusEffect(oldEffect->GetStatusID(), oldEffect->GetIcon(), oldEffect->GetPower(), oldEffect->GetTickTime() / 1000,
                                                      oldEffect->GetDuration() / 1000, oldEffect->GetSubID(), oldEffect->GetSubPower(), oldEffect->GetTier());

        RemoveStatusEffect(oldEffect, true);

        return EffectCopy;
    }
    return nullptr;
}

/************************************************************************
*                                                                       *
*  Пересчитываем иконки всех эфффектов                                  *
*                                                                       *
************************************************************************/

void CStatusEffectContainer::UpdateStatusIcons()
{
    if (m_POwner->objtype != TYPE_PC) return;

    auto PChar = static_cast<CCharEntity*>(m_POwner);

    m_Flags = 0;
    memset(m_StatusIcons, EFFECT_NONE, sizeof(m_StatusIcons));

    uint8 count = 0;

    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        uint16 icon = PStatusEffect->GetIcon();

        if (icon != 0)
        {
            if (icon >= 256 && icon < 512)
            {
                m_Flags |= 1LL << (count * 2);
            }
            if (icon >= 512)
            {
                m_Flags |= 1LL << (count * 2 + 1);
            }
            //Note: it may be possible that having both bits set is for effects over 768, but there aren't
            // that many effects as of this writing
            m_StatusIcons[count] = (uint8)icon;

            if (++count == 32) break;
        }
    }
    PChar->m_EffectsChanged = true;

    if (PChar->PParty)
    {
        PChar->PParty->EffectsChanged();
    }
}

std::vector<EFFECT> CStatusEffectContainer::GetStatusEffectsInIDRange(EFFECT start, EFFECT end)
{
    std::vector<EFFECT> effectList;

    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() >= start && PStatusEffect->GetStatusID() <= end && !PStatusEffect->deleted)
        {
            effectList.emplace_back(PStatusEffect->GetStatusID());
        }
    }
    return effectList;
}

uint8 CStatusEffectContainer::GetStatusEffectCountInIDRange(EFFECT start, EFFECT end)
{
    uint8 count = 0;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() >= start && PStatusEffect->GetStatusID() <= end && !PStatusEffect->deleted)
        {
            count++;
        }
    }
    return count;
}

EFFECT CStatusEffectContainer::GetNewestStatusEffectInIDRange(EFFECT start, EFFECT end)
{
    CStatusEffect* newest = nullptr;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() >= start && PStatusEffect->GetStatusID() <= end && !PStatusEffect->deleted)
        {
            if (!newest || PStatusEffect->GetStartTime() > newest->GetStartTime())
            {
                newest = PStatusEffect;
            }
        }
    }
    if (newest)
    {
        return newest->GetStatusID();
    }
    return EFFECT_NONE;
}

void CStatusEffectContainer::RemoveOldestStatusEffectInIDRange(EFFECT start, EFFECT end)
{
    CStatusEffect* oldest = nullptr;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() >= start && PStatusEffect->GetStatusID() <= end && !PStatusEffect->deleted)
        {
            if (!oldest || PStatusEffect->GetStartTime() < oldest->GetStartTime())
            {
                oldest = PStatusEffect;
            }
        }
    }
    if (oldest)
    {
        RemoveStatusEffect(oldest, true);
    }
}

void CStatusEffectContainer::RemoveNewestStatusEffectInIDRange(EFFECT start, EFFECT end)
{
    CStatusEffect* newest = nullptr;
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() >= start && PStatusEffect->GetStatusID() <= end && !PStatusEffect->deleted)
        {
            if (!newest || PStatusEffect->GetStartTime() > newest->GetStartTime())
            {
                newest = PStatusEffect;
            }
        }
    }
    if (newest)
    {
        RemoveStatusEffect(newest, true);
    }
}

void CStatusEffectContainer::RemoveAllStatusEffectsInIDRange(EFFECT start, EFFECT end)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() >= start && PStatusEffect->GetStatusID() <= end)
        {
            RemoveStatusEffect(PStatusEffect, true);
        }
    }
}

/************************************************************************
*                                                                       *
*  Set the name of the effect for working with scripts                  *
*                                                                       *
************************************************************************/

void CStatusEffectContainer::SetEffectParams(CStatusEffect* StatusEffect)
{
    TPZ_DEBUG_BREAK_IF(StatusEffect->GetStatusID() >= MAX_EFFECTID);
    TPZ_DEBUG_BREAK_IF(StatusEffect->GetStatusID() == EFFECT_FOOD && StatusEffect->GetSubID() == 0);
    TPZ_DEBUG_BREAK_IF(StatusEffect->GetStatusID() == EFFECT_NONE && StatusEffect->GetSubID() == 0);

    string_t name;
    EFFECT effect = StatusEffect->GetStatusID();

    //Determine if this is a BRD Song or COR Effect.
    if (StatusEffect->GetSubID() == 0 || StatusEffect->GetSubID() > 20000 ||
        (effect >= EFFECT_REQUIEM && effect <= EFFECT_NOCTURNE) ||
        (effect >= EFFECT_DOUBLE_UP_CHANCE && effect <= EFFECT_NATURALISTS_ROLL) ||
        effect == EFFECT_RUNEISTS_ROLL)
    {
        name.insert(0, "globals/effects/");
        name.insert(name.size(), effects::EffectsParams[effect].Name);
    }
    else {
        CItem* Ptem = itemutils::GetItemPointer(StatusEffect->GetSubID());
        if (Ptem != nullptr)
        {
            name.insert(0, "globals/items/");
            name.insert(name.size(), (const char*)Ptem->getName());
        }
    }
    StatusEffect->SetName(name);
    StatusEffect->SetFlag(effects::EffectsParams[effect].Flag);
    StatusEffect->SetType(effects::EffectsParams[effect].Type);


    //todo: find a better place to put this?
    if (m_POwner->isAlive())
    {
        // this should actually go into a char charm AI
        if (m_POwner->objtype == TYPE_PC)
        {
            if (effect == EFFECT_CHARM || effect == EFFECT_CHARM_II)
            {
                if (m_POwner->PPet != nullptr)
                {
                    petutils::DespawnPet(m_POwner);
                }
            }
        }

        if (effect == EFFECT_SLEEP || effect == EFFECT_SLEEP_II ||
            effect == EFFECT_STUN || effect == EFFECT_PETRIFICATION ||
            effect == EFFECT_TERROR || effect == EFFECT_LULLABY ||
            effect == EFFECT_PENALTY)
        {

            // change icon of sleep II and lullaby. Apparently they don't stop player movement.
            if (effect == EFFECT_SLEEP_II || effect == EFFECT_LULLABY)
            {
                StatusEffect->SetIcon(EFFECT_SLEEP);
            }
            if (!m_POwner->PAI->IsCurrentState<CInactiveState>())
            {
                m_POwner->PAI->Inactive(0ms, false);
            }
        }
    }
}

/************************************************************************
*                                                                       *
*  Loading Character Effects                                       *
*                                                                       *
************************************************************************/

void CStatusEffectContainer::LoadStatusEffects()
{
    TPZ_DEBUG_BREAK_IF(m_POwner->objtype != TYPE_PC);

    const char* Query =
        "SELECT "
        "effectid,"
        "icon,"
        "power,"
        "tick,"
        "duration,"
        "subid,"
        "subpower,"
        "tier, "
        "flags, "
        "timestamp "
        "FROM char_effects "
        "WHERE charid = %u;";

    int32 ret = Sql_Query(SqlHandle, Query, m_POwner->id);

    std::vector<CStatusEffect*> PEffectList;

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            auto flags = (uint32)Sql_GetUIntData(SqlHandle, 8);
            auto duration = (uint32)Sql_GetUIntData(SqlHandle, 4);
            if (flags & EFFECTFLAG_OFFLINE_TICK)
            {
                auto timestamp = (uint32)Sql_GetUIntData(SqlHandle, 9);
                if (server_clock::now() < time_point() + std::chrono::seconds(timestamp) + std::chrono::seconds(duration))
                {
                    duration = (uint32)std::chrono::duration_cast<std::chrono::seconds>(
                        time_point() + std::chrono::seconds(timestamp) + std::chrono::seconds(duration) - server_clock::now()
                    ).count();
                }
                else
                {
                    // Effect expired while offline
                    continue;
                }
            }
            CStatusEffect* PStatusEffect = new CStatusEffect(
                (EFFECT)Sql_GetUIntData(SqlHandle, 0),
                (uint16)Sql_GetUIntData(SqlHandle, 1),
                (uint16)Sql_GetUIntData(SqlHandle, 2),
                (uint32)Sql_GetUIntData(SqlHandle, 3),
                duration,
                (uint16)Sql_GetUIntData(SqlHandle, 5),
                (uint16)Sql_GetUIntData(SqlHandle, 6),
                (uint16)Sql_GetUIntData(SqlHandle, 7),
                flags
                );

            PEffectList.push_back(PStatusEffect);

            // load shadows left
            if (PStatusEffect->GetStatusID() == EFFECT_COPY_IMAGE) {
                m_POwner->setModifier(Mod::UTSUSEMI, PStatusEffect->GetSubPower());
            }
            else if (PStatusEffect->GetStatusID() == EFFECT_BLINK) {
                m_POwner->setModifier(Mod::BLINK, PStatusEffect->GetPower());
            }
        }
    }

    for (auto&& PStatusEffect : PEffectList)
    {
        AddStatusEffect(PStatusEffect);
    }

    m_POwner->UpdateHealth(); // после загрузки эффектов пересчитываем максимальное количество HP/MP
}

/************************************************************************
*                                                                       *
*  Save temporary character effects                             *
*                                                                       *
************************************************************************/

void CStatusEffectContainer::SaveStatusEffects(bool logout, bool removeOnZone)
{
    TPZ_DEBUG_BREAK_IF(m_POwner->objtype != TYPE_PC);

    Sql_Query(SqlHandle, "DELETE FROM char_effects WHERE charid = %u", m_POwner->id);

    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if ((logout && PStatusEffect->GetFlag() & EFFECTFLAG_LOGOUT) || (!logout && removeOnZone && PStatusEffect->GetFlag() & EFFECTFLAG_ON_ZONE))
        {
            RemoveStatusEffect(PStatusEffect, true);
            continue;
        }

        if (PStatusEffect->deleted)
            continue;

        auto realduration = std::chrono::milliseconds(PStatusEffect->GetDuration()) +
            PStatusEffect->GetStartTime() - server_clock::now();

        if (realduration > 0s || PStatusEffect->GetDuration() == 0)
        {
            const char* Query = "INSERT INTO char_effects (charid, effectid, icon, power, tick, duration, subid, subpower, tier, flags, timestamp) VALUES(%u,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u);";

            // save power of utsusemi and blink
            if (PStatusEffect->GetStatusID() == EFFECT_COPY_IMAGE) {
                PStatusEffect->SetSubPower(m_POwner->getMod(Mod::UTSUSEMI));
            }
            else if (PStatusEffect->GetStatusID() == EFFECT_BLINK) {
                PStatusEffect->SetPower(m_POwner->getMod(Mod::BLINK));
            }
            else if (PStatusEffect->GetStatusID() == EFFECT_STONESKIN) {
                PStatusEffect->SetPower(m_POwner->getMod(Mod::STONESKIN));
            }

            uint32 tick = PStatusEffect->GetTickTime() == 0 ? 0 : PStatusEffect->GetTickTime() / 1000;
            uint32 duration = 0;

            if (PStatusEffect->GetDuration() > 0)
            {
                if (PStatusEffect->GetFlag() & EFFECTFLAG_OFFLINE_TICK)
                {
                    duration = PStatusEffect->GetDuration() / 1000;
                }
                else
                {
                    auto seconds = (uint32)std::chrono::duration_cast<std::chrono::seconds>(realduration).count();

                    if (seconds > 0)
                        duration = seconds;
                    else
                        continue;
                }
            }
            Sql_Query(SqlHandle, Query,
                m_POwner->id,
                PStatusEffect->GetStatusID(),
                PStatusEffect->GetIcon(),
                PStatusEffect->GetPower(),
                tick,
                duration,
                PStatusEffect->GetSubID(),
                PStatusEffect->GetSubPower(),
                PStatusEffect->GetTier(),
                PStatusEffect->GetFlag(),
                std::chrono::duration_cast<std::chrono::seconds>(PStatusEffect->GetStartTime().time_since_epoch()).count()
            );
        }
    }
    DeleteStatusEffects();
}

/************************************************************************
*                                                                       *
*  Expires status effects                                               *
*                                                                       *
************************************************************************/

void CStatusEffectContainer::CheckEffectsExpiry(time_point tick)
{
    TPZ_DEBUG_BREAK_IF(m_POwner == nullptr);
    TracyZoneScoped;

    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetDuration() != 0 &&
            std::chrono::milliseconds(PStatusEffect->GetDuration()) + PStatusEffect->GetStartTime() <= tick)
        {
            // Mobs shouldn't display effects fading in chat when out of combat
            if (m_POwner->objtype == TYPE_MOB && m_POwner->PAI->IsRoaming())
            {
                RemoveStatusEffect(PStatusEffect, true);
            }
            // Status effects that have no loss flag
            else if (PStatusEffect->GetIcon() != 0 && ((PStatusEffect->GetFlag() & EFFECTFLAG_NO_LOSS_MESSAGE) == 1))
            {
                RemoveStatusEffect(PStatusEffect, true);
            }
            else
            {
                RemoveStatusEffect(PStatusEffect);
            }
        }
    }
    DeleteStatusEffects();
}

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

void CStatusEffectContainer::HandleAura(CStatusEffect* PStatusEffect)
{
    TracyZoneScoped;
    CBattleEntity* PEntity = static_cast<CBattleEntity*>(m_POwner);
    AURATARGET auraTarget = static_cast<AURATARGET>(PStatusEffect->GetTier());

    if (PEntity->objtype == TYPE_PET || PEntity->objtype == TYPE_TRUST)
    {
        PEntity = PEntity->PMaster;
    }

    float aura_range = 6.25 + static_cast<float>(PEntity->getMod(Mod::AURA_RADIUS));

    if (PEntity->objtype == TYPE_PC)
    {
        auto* PChar = static_cast<CCharEntity*>(PEntity);
        if (auraTarget == AURATARGET_ALLIES)
        {
             PChar->ForPartyWithTrusts([&](CBattleEntity* PMember) {
                if (PMember != nullptr && PEntity->loc.zone->GetID() == PMember->loc.zone->GetID() && distance(m_POwner->loc.p, PMember->loc.p) <= aura_range && !PMember->isDead())
                {
                    CStatusEffect* PEffect = new CStatusEffect(
                        (EFFECT)PStatusEffect->GetSubID(), // Effect ID
                        (uint16)PStatusEffect->GetSubID(), // Effect Icon (Associated with ID)
                        (uint16)PStatusEffect->GetSubPower(), // Power
                        3, // Tick
                        4); // Duration
                    PEffect->SetFlag(EFFECTFLAG_NO_LOSS_MESSAGE);
                    PMember->StatusEffectContainer->AddStatusEffect(PEffect, true);
                }
            });
        }
        else if (auraTarget == AURATARGET_ENEMIES)
        {
            for (CBattleEntity* PTarget : *PEntity->PNotorietyContainer)
            {
                if (PTarget != nullptr && PEntity->loc.zone->GetID() == PTarget->loc.zone->GetID() && distance(m_POwner->loc.p, PTarget->loc.p) <= aura_range && !PTarget->isDead())
                {
                    CStatusEffect* PEffect = new CStatusEffect(
                        (EFFECT)PStatusEffect->GetSubID(), // Effect ID
                        (uint16)PStatusEffect->GetSubID(), // Effect Icon (Associated with ID)
                        (uint16)PStatusEffect->GetSubPower(), // Power
                        3, // Tick
                        4); // Duration
                    PEffect->SetFlag(EFFECTFLAG_NO_LOSS_MESSAGE);
                    PTarget->StatusEffectContainer->AddStatusEffect(PEffect, true);
                }
            }
        }
    }
    else if (PEntity->objtype == TYPE_MOB)
    {
        if (auraTarget == AURATARGET_ALLIES)
        {
            // Get the position and aura range
            position_t position = PEntity->loc.p;

            // Lambda function to add an effect if the entity is nearby
            auto addEffectIfNearby = [&](CBattleEntity* PMember)
            {
                if (PMember != nullptr &&
                    PEntity->loc.zone->GetID() == PMember->loc.zone->GetID() &&
                    PEntity->allegiance == PMember->allegiance &&
                    distance(position, PMember->loc.p) <= aura_range &&
                    !PMember->isDead())
                {
                    CStatusEffect* PEffect = new CStatusEffect((EFFECT)PStatusEffect->GetSubID(),    // Effect ID
                                                               (uint16)PStatusEffect->GetSubID(),    // Effect Icon (Associated with ID)
                                                               (uint16)PStatusEffect->GetSubPower(), // Power
                                                               3,                                    // Tick
                                                               4);                                   // Duration
                    PEffect->SetFlag(EFFECTFLAG_NO_LOSS_MESSAGE);
                    PMember->StatusEffectContainer->AddStatusEffect(PEffect, true);
                }
            };

            // Iterate over all characters
            zoneutils::GetZone(PEntity->loc.zone->GetID())->ForEachChar([&addEffectIfNearby](CCharEntity* PChar) { addEffectIfNearby(PChar); });

            // Iterate over all mobs
            zoneutils::GetZone(PEntity->loc.zone->GetID())->ForEachMob([&addEffectIfNearby](CMobEntity* PMob) { addEffectIfNearby(PMob); });
        }
        else if (auraTarget == AURATARGET_ENEMIES)
        {
            auto* PMob = static_cast<CMobEntity*>(PEntity);
            auto* enmityList = PMob->PEnmityContainer->GetEnmityList();
            for (auto& enmityPair : *enmityList)
            {
                auto* PTarget = enmityPair.second.PEnmityOwner;
                if (PTarget != nullptr && PEntity->loc.zone->GetID() == PTarget->loc.zone->GetID() && distance(m_POwner->loc.p, PTarget->loc.p) <= aura_range &&
                    !PTarget->isDead())
                {
                    CStatusEffect* PEffect = new CStatusEffect((EFFECT)PStatusEffect->GetSubID(),    // Effect ID
                                                               (uint16)PStatusEffect->GetSubID(),    // Effect Icon (Associated with ID)
                                                               (uint16)PStatusEffect->GetSubPower(), // Power
                                                               3,                                    // Tick
                                                               4);                                   // Duration
                    PEffect->SetFlag(EFFECTFLAG_NO_LOSS_MESSAGE);
                    PTarget->StatusEffectContainer->AddStatusEffect(PEffect, true);
                }
            }
        }
    }
}

/************************************************************************
*                                                                       *
*  Runs OnEffectTick for all status effects                             *
*                                                                       *
************************************************************************/

void CStatusEffectContainer::TickEffects(time_point tick)
{
    TracyZoneScoped;
    TPZ_DEBUG_BREAK_IF(m_POwner == nullptr);

    if (!m_POwner->isDead())
    {
        for (const auto& PStatusEffect : m_StatusEffectSet)
        {
            if (PStatusEffect->GetTickTime() != 0 &&
                PStatusEffect->GetElapsedTickCount() <
                    std::chrono::duration_cast<std::chrono::milliseconds>(tick - PStatusEffect->GetStartTime()).count() / PStatusEffect->GetTickTime())
            {
                if (PStatusEffect->GetFlag() & EFFECTFLAG_AURA)
                {
                    HandleAura(PStatusEffect);
                }
                PStatusEffect->IncrementElapsedTickCount();

                try
                {
                    luautils::OnEffectTick(m_POwner, PStatusEffect);
                }
                catch (const std::exception& e)
                {
                    ShowDebug("Exception caught in OnEffectTick: %s\n", e.what());
                }
                catch (...)
                {
                    ShowDebug("Unknown exception caught in OnEffectTick.\n");
                }
            }
        }
    }

    if (!m_POwner->isDead())
    {
        for (const auto& PStatusEffect : m_StatusEffectSet)
        {
            if (PStatusEffect->GetTickTime() != 0 &&
                PStatusEffect->GetElapsedTickCount() <=
                    std::chrono::duration_cast<std::chrono::milliseconds>(tick - PStatusEffect->GetStartTime()).count() / PStatusEffect->GetTickTime())
            {
                if (PStatusEffect->GetFlag() & EFFECTFLAG_AURA)
                {
                    HandleAura(PStatusEffect);
                    PStatusEffect->IncrementElapsedTickCount();

                    try
                    {
                        luautils::OnEffectTick(m_POwner, PStatusEffect);
                    }
                    catch (const std::exception& e)
                    {
                        ShowDebug("Exception caught in OnEffectTick (AURA): %s\n", e.what());
                    }
                    catch (...)
                    {
                        ShowDebug("Unknown exception caught in OnEffectTick (AURA).\n");
                    }
                }
            }
        }
    }

    DeleteStatusEffects();
    m_POwner->PAI->EventHandler.triggerListener("EFFECTS_TICK", m_POwner);
}

/************************************************************************
*                                                                       *
*  Tick regen/refresh/regain effects                                    *
*                                                                       *
************************************************************************/

void CStatusEffectContainer::TickRegen(time_point tick)
{
    TracyZoneScoped;
    TPZ_DEBUG_BREAK_IF(m_POwner == nullptr);

    // Nothing ticks while in a cutscene
    if (!m_POwner->isDead() && m_POwner->status != STATUS_CUTSCENE_ONLY)
    {
        CCharEntity* PChar = nullptr;
        if (m_POwner->objtype == TYPE_PC)
        {
            PChar = (CCharEntity*)m_POwner;
        }

        int16 regen = m_POwner->getMod(Mod::REGEN);
        int16 poison = m_POwner->getMod(Mod::REGEN_DOWN);
        int16 refresh = m_POwner->getMod(Mod::REFRESH) - m_POwner->getMod(Mod::REFRESH_DOWN);
        int16 regain = m_POwner->getMod(Mod::REGAIN) - m_POwner->getMod(Mod::REGAIN_DOWN);

        // Zombie stops regen (TODO: Retail Testing)
        // https://ffxiclopedia.fandom.com/wiki/Curse_(Special)
        if (!m_POwner->StatusEffectContainer->HasStatusEffect(EFFECT_CURSE_II))
        {
            m_POwner->addHP(regen);
        }

        if (poison)
        {
            int16 damage = battleutils::HandleMagicStoneskin(m_POwner, poison);
            int16 magicSS = m_POwner->getMod(Mod::MAGIC_SS);
            if (!magicSS)
            {
                damage = battleutils::HandleStoneskin(m_POwner, poison, ATTACK_NONE);
            }

            if (damage > 0)
            {
                DelStatusEffectSilent(EFFECT_HEALING);
                m_POwner->takeDamage(damage, 0, ATTACK_NONE, DAMAGE_NONE, true);
			if (!m_POwner->StatusEffectContainer->HasStatusEffect(EFFECT_DEEPSLEEP))
                WakeUp();
            }
        }

        if (m_POwner->getMod(Mod::AVATAR_PERPETUATION) > 0 && (m_POwner->objtype == TYPE_PC))
        {
            int16 perpetuation = m_POwner->getMod(Mod::AVATAR_PERPETUATION);

            if (m_POwner->StatusEffectContainer->HasStatusEffect(EFFECT_ASTRAL_FLOW))
                perpetuation = 0;
            else
            {
                if (m_POwner->PPet != nullptr && PChar != nullptr)
                {

                    if (m_POwner->PPet->objtype == TYPE_PET)
                    {

                        CPetEntity* PPet = (CPetEntity*)m_POwner->PPet;
                        CItem* hands = PChar->getEquip(SLOT_HANDS);

                        // carbuncle mitts only work on carbuncle
                        if (hands && hands->getID() == 14062 && PPet->name == "Carbuncle") {
                            perpetuation /= 2;
                        }
                    }


                    perpetuation -= charutils::AvatarPerpetuationReduction(PChar);

                    if (perpetuation < 1)
                        perpetuation = 1;
                }
            }

            // Zombie stops Refresh (TODO: Retail Testing)
            // https://ffxiclopedia.fandom.com/wiki/Curse_(Special)
            if (!m_POwner->StatusEffectContainer->HasStatusEffect(EFFECT_CURSE_II))
            {
                m_POwner->addMP(refresh - perpetuation);
            }

            if (m_POwner->health.mp == 0 && m_POwner->PPet != nullptr && m_POwner->PPet->objtype == TYPE_PET)
            {
                CPetEntity* PPet = (CPetEntity*)m_POwner->PPet;
                if (PPet->getPetType() == PETTYPE_AVATAR) {
                    petutils::DespawnPet(m_POwner);
                }
            }
        }
        else
        {
            // Zombie stops Refresh (TODO: Retail Testing)
            // https://ffxiclopedia.fandom.com/wiki/Curse_(Special)
            if (!m_POwner->StatusEffectContainer->HasStatusEffect(EFFECT_CURSE_II))
            {
                m_POwner->addMP(refresh);
            }
        }

        m_POwner->addTP(regain);

        if (m_POwner->PPet && ((CPetEntity*)(m_POwner->PPet))->getPetType() == PETTYPE_AUTOMATON)
        {
            ((CAutomatonEntity*)(m_POwner->PPet))->burdenTick();
        }
    }
}

bool CStatusEffectContainer::HasPreventActionEffect(bool checkCharm)
{
    if (checkCharm)
    return HasStatusEffect({
        EFFECT_SLEEP,
        EFFECT_SLEEP_II,
        EFFECT_PETRIFICATION,
        EFFECT_LULLABY,
        EFFECT_CHARM,
        EFFECT_CHARM_II,
        EFFECT_PENALTY,
        EFFECT_STUN,
        EFFECT_TERROR,
        EFFECT_DEEPSLEEP});
    else
    {
        return HasStatusEffect({
        EFFECT_SLEEP,
        EFFECT_SLEEP_II,
        EFFECT_PETRIFICATION,
        EFFECT_LULLABY,
        EFFECT_PENALTY,
        EFFECT_STUN,
        EFFECT_TERROR,
        EFFECT_DEEPSLEEP});
    }
}

uint16 CStatusEffectContainer::GetConfrontationEffect()
{
    for (auto PEffect : m_StatusEffectSet)
    {
        if (PEffect->GetFlag() & EFFECTFLAG_CONFRONTATION)
        {
            return PEffect->GetPower();
        }
    }
    return 0;
}

void CStatusEffectContainer::CopyConfrontationEffect(CBattleEntity* PEntity)
{
    for (auto PEffect : m_StatusEffectSet)
    {
        if (PEffect->GetFlag() & EFFECTFLAG_CONFRONTATION)
        {
            PEntity->StatusEffectContainer->AddStatusEffect(new CStatusEffect(*PEffect));
        }
    }
}

bool CStatusEffectContainer::CheckForElevenRoll()
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if ((PStatusEffect->GetStatusID() >= EFFECT_FIGHTERS_ROLL &&
            PStatusEffect->GetStatusID() <= EFFECT_NATURALISTS_ROLL &&
            PStatusEffect->GetSubPower() == 11) || (
            PStatusEffect->GetStatusID() == EFFECT_RUNEISTS_ROLL &&
            PStatusEffect->GetSubPower() == 11))
        {
            return true;
        }
    }
    return false;
}

bool CStatusEffectContainer::IsAsleep()
{
    return HasStatusEffect({
        EFFECT_SLEEP,
        EFFECT_SLEEP_II,
        EFFECT_LULLABY
    });
}

void CStatusEffectContainer::WakeUp()
{
    DelStatusEffect(EFFECT_SLEEP);
    DelStatusEffect(EFFECT_SLEEP_II);
    DelStatusEffect(EFFECT_LULLABY);
}

bool CStatusEffectContainer::HasBustEffect(uint16 id)
{
    for (CStatusEffect* PStatusEffect : m_StatusEffectSet)
    {
        if (PStatusEffect->GetStatusID() == EFFECT_BUST &&
            PStatusEffect->GetSubPower() == id)
        {
            return true;
        }
    }
    return false;
}
