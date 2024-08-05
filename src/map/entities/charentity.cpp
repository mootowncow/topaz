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
*/

#include "../../common/showmsg.h"
#include "../../common/timer.h"
#include "../../common/utils.h"

#include <string.h>

#include "../packets/action.h"
#include "../packets/basic.h"
#include "../packets/char.h"
#include "../packets/char_appearance.h"
#include "../packets/char_health.h"
#include "../packets/char_recast.h"
#include "../packets/char_sync.h"
#include "../packets/char_update.h"
#include "../packets/entity_update.h"
#include "../packets/inventory_finish.h"
#include "../packets/key_items.h"
#include "../packets/lock_on.h"
#include "../packets/menu_raisetractor.h"
#include "../packets/message_special.h"
#include "../packets/message_system.h"

#include "../ai/ai_container.h"
#include "../ai/controllers/player_controller.h"
#include "../ai/helpers/targetfind.h"
#include "../ai/states/ability_state.h"
#include "../ai/states/attack_state.h"
#include "../ai/states/death_state.h"
#include "../ai/states/item_state.h"
#include "../ai/states/magic_state.h"
#include "../ai/states/raise_state.h"
#include "../ai/states/range_state.h"
#include "../ai/states/weaponskill_state.h"

#include "charentity.h"
#include "automatonentity.h"
#include "trustentity.h"
#include "../ability.h"
#include "../battlefield.h"
#include "../enmity_container.h"
#include "../notoriety_container.h"
#include "../instance.h"
#include "../conquest_system.h"
#include "../spell.h"
#include "../attack.h"
#include "../utils/attackutils.h"
#include "../utils/charutils.h"
#include "../utils/battleutils.h"
#include "../utils/gardenutils.h"
#include "../utils/zoneutils.h"
#include "../item_container.h"
#include "../items/item_weapon.h"
#include "../items/item_usable.h"
#include "../items/item_furnishing.h"
#include "../trade_container.h"
#include "../universal_container.h"
#include "../char_recast_container.h"
#include "../latent_effect_container.h"
#include "../status_effect_container.h"
#include "../treasure_pool.h"
#include "../weapon_skill.h"
#include "../packets/char_job_extra.h"
#include "../packets/status_effects.h"
#include "../mobskill.h"
#include "../utils/petutils.h"
#include "../job_points.h"


CCharEntity::CCharEntity()
{
    objtype = TYPE_PC;
    m_EcoSystem = SYSTEM_HUMANOID;

    m_event.reset();

    m_GMlevel = 0;
    m_isGMHidden = false;

    allegiance = ALLEGIANCE_PLAYER;

    TradeContainer = new CTradeContainer();
    Container = new CTradeContainer();
    UContainer = new CUContainer();
    CraftContainer = new CTradeContainer();

    m_Inventory = std::make_unique<CItemContainer>(LOC_INVENTORY);
    m_Mogsafe = std::make_unique<CItemContainer>(LOC_MOGSAFE);
    m_Storage = std::make_unique<CItemContainer>(LOC_STORAGE);
    m_Tempitems = std::make_unique<CItemContainer>(LOC_TEMPITEMS);
    m_Moglocker = std::make_unique<CItemContainer>(LOC_MOGLOCKER);
    m_Mogsatchel = std::make_unique<CItemContainer>(LOC_MOGSATCHEL);
    m_Mogsack = std::make_unique<CItemContainer>(LOC_MOGSACK);
    m_Mogcase = std::make_unique<CItemContainer>(LOC_MOGCASE);
    m_Wardrobe = std::make_unique<CItemContainer>(LOC_WARDROBE);
    m_Mogsafe2 = std::make_unique<CItemContainer>(LOC_MOGSAFE2);
    m_Wardrobe2 = std::make_unique<CItemContainer>(LOC_WARDROBE2);
    m_Wardrobe3 = std::make_unique<CItemContainer>(LOC_WARDROBE3);
    m_Wardrobe4 = std::make_unique<CItemContainer>(LOC_WARDROBE4);
    m_Wardrobe5 = std::make_unique<CItemContainer>(LOC_WARDROBE5);
    m_Wardrobe6 = std::make_unique<CItemContainer>(LOC_WARDROBE6);
    m_Wardrobe7 = std::make_unique<CItemContainer>(LOC_WARDROBE7);
    m_Wardrobe8 = std::make_unique<CItemContainer>(LOC_WARDROBE8);
    m_RecycleBin = std::make_unique<CItemContainer>(LOC_RECYCLEBIN);

    memset(&jobs, 0, sizeof(jobs));
    // TODO: -Wno-class-memaccess - clearing an object on non-trivial type use assignment or value-init
    memset(&keys, 0, sizeof(keys));
    memset(&equip, 0, sizeof(equip));
    memset(&equipLoc, 0, sizeof(equipLoc));
    memset(&RealSkills, 0, sizeof(RealSkills));
    memset(&expChain, 0, sizeof(expChain));
    memset(&nameflags, 0, sizeof(nameflags));
    memset(&menuConfigFlags, 0, sizeof(menuConfigFlags));
    chatFilterFlags = 0;

    // TODO: -Wno-class-memaccess - clearing an object on non-trivial type use assignment or value-init
    memset(&m_SpellList, 0, sizeof(m_SpellList));
    memset(&m_LearnedAbilities, 0, sizeof(m_LearnedAbilities));
    memset(&m_TitleList, 0, sizeof(m_TitleList));
    memset(&m_ZonesList, 0, sizeof(m_ZonesList));
    memset(&m_Abilities, 0, sizeof(m_Abilities));
    memset(&m_TraitList, 0, sizeof(m_TraitList));
    memset(&m_PetCommands, 0, sizeof(m_PetCommands));
    memset(&m_WeaponSkills, 0, sizeof(m_WeaponSkills));
    memset(&m_SetBlueSpells, 0, sizeof(m_SetBlueSpells));
    memset(&m_unlockedAttachments, 0, sizeof(m_unlockedAttachments));

    memset(&m_questLog, 0, sizeof(m_questLog));
    memset(&m_missionLog, 0, sizeof(m_missionLog));
    memset(&m_assaultLog, 0, sizeof(m_assaultLog));
    memset(&m_campaignLog, 0, sizeof(m_campaignLog));
    memset(&m_eminenceLog, 0, sizeof(m_eminenceLog));
    m_eminenceCache.activemap.reset();

    memset(&teleport, 0, sizeof(teleport));
    memset(&teleport.homepoint.menu, -1, sizeof(teleport.homepoint.menu));
    memset(&teleport.survival.menu,  -1, sizeof(teleport.survival.menu));

    for (uint8 i = 0; i <= 3; ++i)
    {
        m_missionLog[i].current = 0xFFFF;
    }

    m_missionLog[4].current = 0;   // MISSION_TOAU
    m_missionLog[5].current = 0;   // MISSION_WOTG
    m_missionLog[6].current = 101; // MISSION_COP
    for (uint8 i = 0; i < MAX_MISSIONAREA; ++i)
    {
        m_missionLog[i].logExUpper = 0;
        m_missionLog[i].logExLower = 0;
    }

    m_copCurrent = 0;
    m_acpCurrent = 0;
    m_mkeCurrent = 0;
    m_asaCurrent = 0;

    m_Costume = 0;
    m_Monstrosity = 0;
    m_hasTractor = 0;
    m_hasRaise = 0;

    if (charutils::GetCharVar(this, "AUTOTARGET_ON") == 1)
        m_hasAutoTarget = 1;
    else
        m_hasAutoTarget = 0;

    m_InsideRegionID = 0;
    m_LevelRestriction = 0;
    m_lastBcnmTimePrompt = 0;
    m_AHHistoryTimestamp = 0;
    m_DeathTimestamp = 0;
    m_petAbilityWait = server_clock::now();

    m_EquipFlag = 0;
    m_EquipBlock = 0;
    m_StatsDebilitation = 0;
    m_EquipSwap = false;

    MeritMode = false;

    m_isWeaponSkillKill = false;
    m_isStyleLocked = false;
    m_isBlockingAid = false;

    BazaarID.clean();
    TradePending.clean();
    InvitePending.clean();

    PLinkshell1 = nullptr;
    PLinkshell2 = nullptr;
    PUnityChat = nullptr;
    PTreasurePool = nullptr;
    PWideScanTarget = nullptr;

    PAutomaton = nullptr;
    PClaimedMob = nullptr;
    PRecastContainer = std::make_unique<CCharRecastContainer>(this);
    PLatentEffectContainer = new CLatentEffectContainer(this);

    resetPetZoningInfo();
    petZoningInfo.petID = 0;

    m_LastEngagedTargID = 0;

    m_PlayTime = 0;
    m_SaveTime = 0;
    m_reloadParty = 0;

    m_LastYell = 0;
    m_moghouseID = 0;
    m_moghancementID = 0;
    m_previousLocation = {}; 

    m_Substate = CHAR_SUBSTATE::SUBSTATE_NONE;

    PAI = std::make_unique<CAIContainer>(this, nullptr, std::make_unique<CPlayerController>(this),
        std::make_unique<CTargetFind>(this));

    hookedFish = nullptr;
    lastCastTime = 0;
    nextFishTime = 0;
    fishingToken = 0;
    m_fomorHate = 0;
    m_sneakTrickActive = false;
}

void CCharEntity::SetFomorHate(uint32 fomorHate)
{
    if (fomorHate > 60)
    {
        fomorHate = 60;
    }
    m_fomorHate = fomorHate;
    charutils::SetCharVar(this, "FOMOR_HATE", fomorHate);
}

void CCharEntity::SetPixieHate(uint32 pixieHate)
{
    if (pixieHate > 60)
    {
        pixieHate = 60;
    }
    m_pixieHate = pixieHate;
    charutils::SetCharVar(this, "PIXIE_HATE", pixieHate);
}

CCharEntity::~CCharEntity()
{
    clearPacketList();

    if (PTreasurePool != nullptr)
    {
        // remove myself
        PTreasurePool->DelMember(this);
    }

    delete TradeContainer;
    delete Container;
    delete UContainer;
    delete CraftContainer;
    delete PMeritPoints;
}

uint8 CCharEntity::GetGender()
{
    return (look.race) % 2 ^ (look.race > 6);
}

bool CCharEntity::isPacketListEmpty()
{
    return PacketList.empty();
}

void CCharEntity::clearPacketList()
{
    while (!PacketList.empty())
    {
        delete popPacket();
    }
}

void CCharEntity::pushPacket(CBasicPacket* packet)
{
    TracyZoneScoped;
    TracyZoneIString(GetName());
    TracyZoneHex16(packet->id());

    std::lock_guard<std::mutex> lk(m_PacketListMutex);
    PacketList.push_back(packet);
}

void CCharEntity::pushPacket(std::unique_ptr<CBasicPacket> packet)
{
    pushPacket(packet.release());
}

void CCharEntity::updateCharPacket(CCharEntity* PChar, ENTITYUPDATE type, uint8 updatemask)
{
    auto existing = PendingCharPackets.find(PChar->id);
    if (existing == PendingCharPackets.end())
    {
        // No existing packet update for the given char, so we push new packet
        CCharPacket* packet = new CCharPacket(PChar, type, updatemask);
        PacketList.push_back(packet);
        PendingCharPackets.emplace(PChar->id, packet);
    }
    else
    {
        // Found existing packet update for the given char, so we update it instead of pushing new
        existing->second->updateWith(PChar, type, updatemask);
    }
}

void CCharEntity::updateEntityPacket(CBaseEntity* PEntity, ENTITYUPDATE type, uint8 updatemask)
{
    auto existing = PendingEntityPackets.find(PEntity->id);
    if (existing == PendingEntityPackets.end())
    {
        // No existing packet update for the given entity, so we push new packet
        CEntityUpdatePacket* packet = new CEntityUpdatePacket(PEntity, type, updatemask);
        PacketList.push_back(packet);
        PendingEntityPackets.emplace(PEntity->id, packet);
    }
    else
    {
        // Found existing packet update for the given entity, so we update it instead of pushing new
        existing->second->updateWith(PEntity, type, updatemask);
    }
}

CBasicPacket* CCharEntity::popPacket()
{
    CBasicPacket* PPacket = PacketList.front();

    // Clean up pending maps
    switch (PPacket->getType())
    {
        case 0x0D: // Char update
            PendingCharPackets.erase(PPacket->ref<uint32>(0x04));
            break;
        case 0x0E: // Entity update
            PendingEntityPackets.erase(PPacket->ref<uint32>(0x04));
            break;
        case 0x5B: // Position update
            PendingPositionPacket = nullptr;
            break;
        default:
            break;
    }

    PacketList.pop_front();
    return PPacket;
}

PacketList_t CCharEntity::getPacketList()
{
    std::lock_guard<std::mutex> lk(m_PacketListMutex);
    return PacketList;
}

size_t CCharEntity::getPacketCount()
{
    std::lock_guard<std::mutex> lk(m_PacketListMutex);
    return PacketList.size();
}

void CCharEntity::erasePackets(uint8 num)
{
    for (auto i = 0; i < num; i++)
    {
        delete popPacket();
    }
}

bool CCharEntity::isNewPlayer()
{
    return menuConfigFlags.flags & NFLAG_NEWPLAYER;
}

void CCharEntity::setPetZoningInfo()
{
    if (PPet == nullptr || PPet->objtype != TYPE_PET)
    {
        return;
    }

    auto PPetEntity = dynamic_cast<CPetEntity*>(PPet);
    if (PPetEntity == nullptr)
    {
        return;
    }

    switch (PPetEntity->getPetType())
    {
        case PETTYPE_JUG_PET:
            petZoningInfo.jugSpawnTime = PPetEntity->getJugSpawnTime();
            petZoningInfo.jugDuration  = PPetEntity->getJugDuration();
            [[fallthrough]];
        case PETTYPE_AVATAR:
        case PETTYPE_AUTOMATON:
        case PETTYPE_WYVERN:
            petZoningInfo.petLevel = PPetEntity->getSpawnLevel();
            petZoningInfo.petHP    = PPet->health.hp;
            petZoningInfo.petTP    = PPet->health.tp;
            petZoningInfo.petMP    = PPet->health.mp;
            petZoningInfo.petType  = PPetEntity->getPetType();
            break;
        default:
            break;
    }

    petZoningInfo.respawnPet = true;
}

void CCharEntity::resetPetZoningInfo()
{
    // reset the petZoning info
    petZoningInfo.petLevel = 0;
    petZoningInfo.petHP = 0;
    petZoningInfo.petTP = 0;
    petZoningInfo.petMP = 0;
    petZoningInfo.respawnPet = false;
    petZoningInfo.petType = PETTYPE_AVATAR;
    petZoningInfo.jugSpawnTime = 0;
    petZoningInfo.jugDuration = 0;
}


bool CCharEntity::shouldPetPersistThroughZoning()
{
    PETTYPE petType;
    auto PPetEntity = dynamic_cast<CPetEntity*>(PPet);

    if (PPetEntity == nullptr && !petZoningInfo.respawnPet)
    {
        return false;
    }

    if (PPetEntity != nullptr)
    {
        petType = PPetEntity->getPetType();
    }
    else // petZoningInfo.respawnPet == true
    {
        petType = petZoningInfo.petType;
    }

    return petType == PETTYPE_WYVERN || petType == PETTYPE_AVATAR || petType == PETTYPE_AUTOMATON ||
           (petType == PETTYPE_JUG_PET);
}
/************************************************************************
*																		*
 * Return the container with the specified ID.If the ID goes beyond,then*
 * We protect the server from falling the use of temporary container    *
 * Items as a plug (from this container items can not                   *
 * Move, wear, transmit, sell, etc.).Display                            *
 * Fatal error message.*										        *
*																		*
************************************************************************/

CItemContainer* CCharEntity::getStorage(uint8 LocationID)
{
    switch (LocationID)
    {
        case LOC_INVENTORY:	 return m_Inventory.get();
        case LOC_MOGSAFE:	 return m_Mogsafe.get();
        case LOC_STORAGE:	 return m_Storage.get();
        case LOC_TEMPITEMS:	 return m_Tempitems.get();
        case LOC_MOGLOCKER:	 return m_Moglocker.get();
        case LOC_MOGSATCHEL: return m_Mogsatchel.get();
        case LOC_MOGSACK:	 return m_Mogsack.get();
        case LOC_MOGCASE:	 return m_Mogcase.get();
        case LOC_WARDROBE:   return m_Wardrobe.get();
        case LOC_MOGSAFE2:   return m_Mogsafe2.get();
        case LOC_WARDROBE2:  return m_Wardrobe2.get();
        case LOC_WARDROBE3:  return m_Wardrobe3.get();
        case LOC_WARDROBE4:  return m_Wardrobe4.get();

    case LOC_WARDROBE5:
        return m_Wardrobe5.get();
    case LOC_WARDROBE6:
        return m_Wardrobe6.get();
    case LOC_WARDROBE7:
        return m_Wardrobe7.get();
    case LOC_WARDROBE8:
        return m_Wardrobe8.get();
    case LOC_RECYCLEBIN:
        return m_RecycleBin.get();
}

    TPZ_DEBUG_BREAK_IF(LocationID >= CONTAINER_ID::MAX_CONTAINER_ID); // Unresolved storage ID
    return 0;
}

int8 CCharEntity::getShieldSize()
{
    CItemEquipment* PItem = (CItemEquipment*)(getEquip(SLOT_SUB));

    if (PItem == nullptr) {
        return 0;
    }

    if (!PItem->IsShield()) {
        return 0;
    }

    return PItem->getShieldSize();
}

void CCharEntity::SetName(int8* name)
{
    this->name.insert(0, (const char*)name, std::min<size_t>(strlen((const char*)name), PacketNameLength));
}

int16 CCharEntity::addTP(int16 tp)
{
    // int16 oldtp = health.tp;
    tp = CBattleEntity::addTP(tp);
    //	if ((oldtp < 1000 && health.tp >= 1000 ) || (oldtp >= 1000 && health.tp < 1000))
    //	{
    PLatentEffectContainer->CheckLatentsTP();
    //	}
    return abs(tp);
}

int32 CCharEntity::addHP(int32 hp)
{
    hp = CBattleEntity::addHP(hp);
    PLatentEffectContainer->CheckLatentsHP();

    return abs(hp);
}

int32 CCharEntity::addMP(int32 mp)
{
    mp = CBattleEntity::addMP(mp);
    PLatentEffectContainer->CheckLatentsMP();

    return abs(mp);
}

bool CCharEntity::getWeaponSkillKill()
{
    return m_isWeaponSkillKill;
}

void CCharEntity::setWeaponSkillKill(bool isWeaponSkillKill)
{
    m_isWeaponSkillKill = isWeaponSkillKill;
}

bool CCharEntity::getStyleLocked()
{
    return m_isStyleLocked;
}

void CCharEntity::setStyleLocked(bool isStyleLocked)
{
    m_isStyleLocked = isStyleLocked;
}

bool CCharEntity::getBlockingAid()
{
    return m_isBlockingAid;
}

void CCharEntity::setBlockingAid(bool isBlockingAid)
{
    m_isBlockingAid = isBlockingAid;
}


/************************************************************************
 *                                                                       *
 *  Does the user have all yell mesages filtered?                        *
 *                                                                       *
 ************************************************************************/

bool CCharEntity::isYellFiltered() const
{
    return (chatFilterFlags & CHATFILTER_YELL) != 0;
}

/************************************************************************
 *                                                                       *
 *  Does the user have "all yell/shout messages deemed spam" filtered?   *
 *                                                                       *
 ************************************************************************/

bool CCharEntity::isYellSpamFiltered() const
{
    return (chatFilterFlags & CHATFILTER_YELL_SPAM) != 0;
}

void CCharEntity::SetPlayTime(uint32 playTime)
{
    m_PlayTime = playTime;
    m_SaveTime = gettick() / 1000;
}

uint32 CCharEntity::GetPlayTime(bool needUpdate)
{
    if (needUpdate)
    {
        uint32 currentTime = gettick() / 1000;

        m_PlayTime += currentTime - m_SaveTime;
        m_SaveTime = currentTime;
    }

    return m_PlayTime;
}

CItemEquipment* CCharEntity::getEquip(SLOTTYPE slot)
{
    uint8 loc = equip[slot];
    uint8 est = equipLoc[slot];
    CItemEquipment* item = nullptr;

    if (loc != 0)
    {
        item = (CItemEquipment*)getStorage(est)->GetItem(loc);
    }
    return item;
}

void CCharEntity::ReloadPartyInc()
{
    m_reloadParty = true;
}

void CCharEntity::ReloadPartyDec()
{
    m_reloadParty = false;
}

bool CCharEntity::ReloadParty()
{
    return m_reloadParty;
}

void CCharEntity::RemoveTrust(CTrustEntity* PTrust)
{
    if (!PTrust->PAI->IsSpawned())
    {
        return;
    }

    auto trustIt = std::find_if(PTrusts.begin(), PTrusts.end(), [PTrust](auto trust) { return PTrust == trust; });
    if (trustIt != PTrusts.end())
    {
        if (PTrust->animation == ANIMATION_DESPAWN)
        {
            luautils::OnMobDespawn(PTrust);
        }
        PTrust->PAI->Despawn();
        PTrusts.erase(trustIt);
    }

    ReloadPartyInc();
}

void CCharEntity::ClearTrusts()
{
    for (auto PTrust : PTrusts)
    {
        PTrust->PAI->Despawn();
    }
    PTrusts.clear();

    ReloadPartyInc();
}

void CCharEntity::RequestPersist(CHAR_PERSIST toPersist)
{
    dataToPersist |= toPersist;
}

bool CCharEntity::PersistData()
{
    bool didPersist = false;

    if (!charVarChanges.empty())
    {
        /* TODO
        for (auto&& charVarName : charVarChanges)
        {
            charutils::PersistCharVar(this->id, charVarName.c_str(), charVarCache[charVarName]);
        }
        */

        charVarChanges.clear();
        didPersist = true;
    }

    if (!dataToPersist)
    {
        return didPersist;
    }
    else
    {
        didPersist = true;
    }

    if (dataToPersist & CHAR_PERSIST::EQUIP)
    {
        charutils::SaveCharEquip(this);
        charutils::SaveCharLook(this);
    }

    if (dataToPersist & CHAR_PERSIST::POSITION)
    {
        charutils::SaveCharPosition(this);
    }

    if (dataToPersist & CHAR_PERSIST::EFFECTS)
    {
        StatusEffectContainer->SaveStatusEffects(true);
    }

    /* TODO
    if (dataToPersist & CHAR_PERSIST::LINKSHELL)
    {
        charutils::SaveCharLinkshells(this);
    }
    */

    dataToPersist = 0;
    return didPersist;
}

bool CCharEntity::PersistData(time_point tick)
{
    if (tick < nextDataPersistTime || !PersistData())
    {
        return false;
    }

    nextDataPersistTime = tick + TIME_BETWEEN_PERSIST;
    return true;
}

void CCharEntity::Tick(time_point tick)
{
    TracyZoneScoped;
    CBattleEntity::Tick(tick);
    if (m_DeathTimestamp > 0 && tick >= m_deathSyncTime)
    {
        // Send an update packet at a regular interval to keep the player's death variables synced
        updatemask |= UPDATE_STATUS;
        m_deathSyncTime = tick + death_update_frequency;
    }

    if (m_moghouseID != 0)
    {
        gardenutils::UpdateGardening(this, true);
    }

    this->pushPacket(new CInventoryFinishPacket());
}

void CCharEntity::PostTick()
{
    TracyZoneScoped;
    CBattleEntity::PostTick();
    if (m_EquipSwap)
    {
        pushPacket(new CCharAppearancePacket(this));

        updatemask |= UPDATE_HP;
        m_EquipSwap = false;
    }
    if (ReloadParty())
    {
        charutils::ReloadParty(this);
    }
    if (m_EffectsChanged)
    {
        pushPacket(new CCharUpdatePacket(this));
        pushPacket(new CCharSyncPacket(this));
        pushPacket(new CCharJobExtraPacket(this, true));
        pushPacket(new CCharJobExtraPacket(this, false));
        pushPacket(new CStatusEffectPacket(this));
        if (PParty)
        {
            PParty->PushEffectsPacket();
        }
        m_EffectsChanged = false;
    }
    if (updatemask)
    {
        if (loc.zone && !m_isGMHidden)
        {
            loc.zone->PushPacket(this, CHAR_INRANGE, new CCharPacket(this, ENTITY_UPDATE, updatemask));
        }
        if (isCharmed)
        {
            StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DETECTABLE);
            pushPacket(new CCharPacket(this, ENTITY_UPDATE, updatemask));
        }
        if (updatemask & UPDATE_HP)
        {
            ForAlliance([&](auto PEntity)
            {
                if (PEntity->objtype == TYPE_PC)
                {
                    static_cast<CCharEntity*>(PEntity)->pushPacket(new CCharHealthPacket(this));
                }
            });
        }
        // Do not send an update packet when only the position has change
        if (updatemask ^ UPDATE_POS)
        pushPacket(new CCharUpdatePacket(this));
        updatemask = 0;
    }
}

void CCharEntity::addTrait(CTrait* PTrait)
{
    CBattleEntity::addTrait(PTrait);
    charutils::addTrait(this, PTrait->getID());
}

void CCharEntity::delTrait(CTrait* PTrait)
{
    CBattleEntity::delTrait(PTrait);
    charutils::delTrait(this, PTrait->getID());
}

bool CCharEntity::ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags)
{
    if (StatusEffectContainer->GetConfrontationEffect() != PInitiator->StatusEffectContainer->GetConfrontationEffect())
    {
        return false;
    }
    if (isDead())
    {
        return (targetFlags & TARGET_PLAYER_DEAD) != 0;
    }

    if ((targetFlags & TARGET_PLAYER) && allegiance == PInitiator->allegiance)
    {
        return true;
    }

    if (CBattleEntity::ValidTarget(PInitiator, targetFlags))
    {
        return true;
    }

    if (((targetFlags & TARGET_PLAYER_PARTY) || ((targetFlags & TARGET_PLAYER_PARTY_PIANISSIMO) &&
        PInitiator->StatusEffectContainer->HasStatusEffect(EFFECT_PIANISSIMO))) &&
        ((PParty && PInitiator->PParty == PParty) ||
        (PInitiator->PMaster && PInitiator->PMaster->PParty == PParty)) &&
        PInitiator != this)
    {
        return true;
    }

    return false;
}

bool CCharEntity::CanUseSpell(CSpell* PSpell)
{
    return charutils::hasSpell(this, static_cast<uint16>(PSpell->getID())) && CBattleEntity::CanUseSpell(PSpell) &&
        !PRecastContainer->Has(RECAST_MAGIC, static_cast<uint16>(PSpell->getID()));
}

void CCharEntity::OnChangeTarget(CBattleEntity* PNewTarget)
{
    battleutils::RelinquishClaim(this);

    // Safety check to not get locked in cutscene status
    if (this->status == STATUS_CUTSCENE_ONLY || this->m_Substate == CHAR_SUBSTATE::SUBSTATE_IN_CS)
    {
        this->m_Substate = CHAR_SUBSTATE::SUBSTATE_NONE;
        this->status = STATUS_NORMAL;
    }
    this->pushPacket(new CInventoryFinishPacket());
    pushPacket(new CLockOnPacket(this, PNewTarget));
    PLatentEffectContainer->CheckLatentsTargetChange();
}

void CCharEntity::OnEngage(CAttackState& state)
{
    CBattleEntity::OnEngage(state);

    // Safety check to not get locked in cutscene status
    if (this->status == STATUS_CUTSCENE_ONLY || this->m_Substate == CHAR_SUBSTATE::SUBSTATE_IN_CS)
    {
        this->m_Substate = CHAR_SUBSTATE::SUBSTATE_NONE;
        this->status = STATUS_NORMAL;
    }
    this->pushPacket(new CInventoryFinishPacket());
    PLatentEffectContainer->CheckLatentsTargetChange();
}

void CCharEntity::OnDisengage(CAttackState& state)
{
    battleutils::RelinquishClaim(this);
    CBattleEntity::OnDisengage(state);

    // Safety check to not get locked in cutscene status
    if (this->status == STATUS_CUTSCENE_ONLY || this->m_Substate == CHAR_SUBSTATE::SUBSTATE_IN_CS)
    {
        this->m_Substate = CHAR_SUBSTATE::SUBSTATE_NONE;
        this->status = STATUS_NORMAL;
    }
    this->pushPacket(new CInventoryFinishPacket());

    if (state.HasErrorMsg())
    {
        pushPacket(state.GetErrorMsg());
    }
    PLatentEffectContainer->CheckLatentsWeaponDraw(false);
}

bool CCharEntity::CanAttack(CBattleEntity* PTarget, std::unique_ptr<CBasicPacket>& errMsg)
{
    float dist = distance(loc.p, PTarget->loc.p);

    if (!IsMobOwner(PTarget))
    {
        errMsg = std::make_unique<CMessageBasicPacket>(this, PTarget, 0, 0, MSGBASIC_ALREADY_CLAIMED);
        if (PAI->Disengage())
            m_LastEngagedTargID = 0;
        return false;
    }
    else if (dist > 30)
    {
        errMsg = std::make_unique<CMessageBasicPacket>(this, PTarget, 0, 0, MSGBASIC_LOSE_SIGHT);
        if (PAI->Disengage())
            m_LastEngagedTargID = 0;
        return false;
    }
    else if (!facing(this->loc.p, PTarget->loc.p, 64))
    {
        errMsg = std::make_unique<CMessageBasicPacket>(this, PTarget, 0, 0, MSGBASIC_CANNOT_SEE);
        return false;
    }
    else if (PTarget->IsNameHidden())
    {
        return false;
    }
    else if ((dist - PTarget->m_ModelSize) > GetMeleeRange())
    {
        errMsg = std::make_unique<CMessageBasicPacket>(this, PTarget, 0, 0, MSGBASIC_TARG_OUT_OF_RANGE);
        return false;
    }
    return true;
}


bool CCharEntity::OnAttack(CAttackState& state, action_t& action)
{
    auto controller{ static_cast<CPlayerController*>(PAI->GetController()) };
    controller->setLastAttackTime(server_clock::now());
    auto ret = CBattleEntity::OnAttack(state, action);

    // Safety check to not get locked in cutscene status
    if (this->status == STATUS_CUTSCENE_ONLY || this->m_Substate == CHAR_SUBSTATE::SUBSTATE_IN_CS)
    {
        this->m_Substate = CHAR_SUBSTATE::SUBSTATE_NONE;
        this->status = STATUS_NORMAL;
    }

    // Send inventory finish packet to check for temps
    if (server_clock::now() < AttackInventoryFinishPacket)
    {
        AttackInventoryFinishPacket = server_clock::now() + std::chrono::milliseconds(500);
        this->pushPacket(new CInventoryFinishPacket());
    }

    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());

    if (PTarget->isDead() && PTarget->objtype == TYPE_MOB)
    {
        ((CMobEntity*)PTarget)->m_autoTargetKiller = this;
        ((CMobEntity*)PTarget)->DoAutoTarget();
    }

    return ret;
}


void CCharEntity::OnCastFinished(CMagicState& state, action_t& action)
{
    CBattleEntity::OnCastFinished(state, action);

    auto PSpell = state.GetSpell();
    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());

    PRecastContainer->Add(RECAST_MAGIC, static_cast<uint16>(PSpell->getID()), action.recast);

    for (auto&& actionList : action.actionLists)
    {
        for (auto&& actionTarget : actionList.actionTargets)
        {
            if (StatusEffectContainer->HasStatusEffect(EFFECT_CHAIN_AFFINITY) || StatusEffectContainer->HasStatusEffect(EFFECT_AZURE_LORE))
            {
                if (PSpell->dealsDamage() && PSpell->getSpellGroup() == SPELLGROUP_BLUE && static_cast<CBlueSpell*>(PSpell)->getPrimarySkillchain() != 0)
                {
                    auto PBlueSpell = static_cast<CBlueSpell*>(PSpell);
                    SUBEFFECT effect = battleutils::GetSkillChainEffect(PTarget, PBlueSpell->getPrimarySkillchain(), PBlueSpell->getSecondarySkillchain(), 0);
                    if (effect != SUBEFFECT_NONE)
                    {
                        // Apply Inundation weapon skill type tracking
                        if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_INUNDATION))
                        {
                            CStatusEffect* PEffect = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_INUNDATION, 0);
                            auto power = PEffect->GetPower();
                            auto currentFlag = WEAPONTYPE_BLUE_MAGIC;
                            auto subPower = PEffect->GetSubPower();
                            if ((subPower & currentFlag) == 0)
                            {
                                PEffect->SetPower(power + 1);
                                PEffect->SetSubPower(subPower | currentFlag);
                            }
                        }

                        uint16 skillChainDamage = battleutils::TakeSkillchainDamage(static_cast<CBattleEntity*>(this), PTarget, actionTarget.param, nullptr);

                        actionTarget.addEffectParam = skillChainDamage;
                        actionTarget.addEffectMessage = 287 + effect;
                        actionTarget.additionalEffect = effect;
                    }
                    else if (effect == SUBEFFECT_NONE)
                    {
                        // Reset Inundation weapon skill type tracking
                        if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_INUNDATION))
                        {
                            CStatusEffect* PEffect = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_INUNDATION, 0);
                            auto currentFlag = WEAPONTYPE_BLUE_MAGIC;
                            PEffect->SetPower(0);
                            PEffect->SetSubPower(currentFlag);
                        }
                    }
                    if (StatusEffectContainer->HasStatusEffect({ EFFECT_SEKKANOKI, EFFECT_MEIKYO_SHISUI }))
                    {
                        health.tp = (health.tp > 1000 ? health.tp - 1000 : 0);
                    }
                    else
                    {
                        // Don't consume TP from spells casted during Azure Lore
                        if (!StatusEffectContainer->HasStatusEffect(EFFECT_AZURE_LORE))
                        {
                            health.tp = 0;
                        }
                    }

                    StatusEffectContainer->DelStatusEffectSilent(EFFECT_CHAIN_AFFINITY);
                }
            }   
        }
    }
    StatusEffectContainer->DelStatusEffectSilent(EFFECT_SENGIKORI);
    charutils::RemoveStratagems(this, PSpell);

    // Remove Burst Affinity, Convergence and Efflux if a BLU offensive spell was used
    if (PSpell->getSpellGroup() == SPELLGROUP_BLUE)
    {
        if (PSpell->dealsDamage() || PSpell->getID() == SpellID::MP_Drainkiss || PSpell->getID() == SpellID::Magic_Hammer)
        {
            // Magical damage spells only
            if (static_cast<CBlueSpell*>(PSpell)->getPrimarySkillchain() == 0)
            {
                StatusEffectContainer->DelStatusEffectSilent(EFFECT_BURST_AFFINITY);
                StatusEffectContainer->DelStatusEffectSilent(EFFECT_CONVERGENCE);

            }
            // Physical spells only
            else
            {
                StatusEffectContainer->DelStatusEffectSilent(EFFECT_EFFLUX);
            }
        }
    }
    // Remove Divine seal if the spell is a healing spell or Stoneskin
    if (PSpell->isHeal() || PSpell->getID() == SpellID::Stoneskin)
    {
        StatusEffectContainer->DelStatusEffectSilent(EFFECT_DIVINE_SEAL);
    }

    // Remove Elemental Seal if the spell is black magic, blue magic, ninjitsu, a song, or a divine spell
    if (PSpell->getSpellGroup() >= SPELLGROUP_SONG && PSpell->getSpellGroup() <= SPELLGROUP_NINJUTSU ||
        PSpell->getSkillType()  == SKILL_DIVINE_MAGIC)
    {
        StatusEffectContainer->DelStatusEffectSilent(EFFECT_ELEMENTAL_SEAL);
    }
    if (PSpell->tookEffect())
    {
        if (PSpell->dealsDamage() || PSpell->getSpellFamily() == SPELLFAMILY_DRAIN || PSpell->getSpellFamily() == SPELLFAMILY_ASPIR)
        {
            charutils::TrySkillUP(this, (SKILLTYPE)PSpell->getSkillType(), PTarget->GetMLevel(), true);
        }
        else
        {
            charutils::TrySkillUP(this, (SKILLTYPE)PSpell->getSkillType(), PTarget->GetMLevel(), false);
        }
        if (PSpell->getSkillType() == SKILL_SINGING)
        {
            CItemWeapon* PItem = static_cast<CItemWeapon*>(getEquip(SLOT_RANGED));
            if (PItem && PItem->isType(ITEM_EQUIPMENT))
            {
                SKILLTYPE Skilltype = (SKILLTYPE)PItem->getSkillType();
                if (Skilltype == SKILL_STRING_INSTRUMENT || Skilltype == SKILL_WIND_INSTRUMENT || Skilltype == SKILL_SINGING)
                {
                    charutils::TrySkillUP(this, Skilltype, PTarget->GetMLevel(), false);
                }
            }
        }
    }

    // Safety check to not get locked in cutscene status
    if (this->status == STATUS_CUTSCENE_ONLY || this->m_Substate == CHAR_SUBSTATE::SUBSTATE_IN_CS)
    {
        this->m_Substate = CHAR_SUBSTATE::SUBSTATE_NONE;
        this->status = STATUS_NORMAL;
    }
    this->pushPacket(new CInventoryFinishPacket());

    if (PTarget->isDead() && PTarget->objtype == TYPE_MOB)
    {
        ((CMobEntity*)PTarget)->m_autoTargetKiller = this;
        ((CMobEntity*)PTarget)->DoAutoTarget();
    }
}

void CCharEntity::OnCastInterrupted(CMagicState& state, action_t& action, MSGBASIC_ID msg, bool blockedCast)
{
    TracyZoneScoped;
    CBattleEntity::OnCastInterrupted(state, action, msg, blockedCast);

    // Safety check to not get locked in cutscene status
    if (this->status == STATUS_CUTSCENE_ONLY || this->m_Substate == CHAR_SUBSTATE::SUBSTATE_IN_CS)
    {
        this->m_Substate = CHAR_SUBSTATE::SUBSTATE_NONE;
        this->status = STATUS_NORMAL;
    }
    this->pushPacket(new CInventoryFinishPacket());

    auto message = state.GetErrorMsg();

    if (message)
    {
        pushPacket(message);
    }
}

void CCharEntity::OnWeaponSkillFinished(CWeaponSkillState& state, action_t& action)
{
    CBattleEntity::OnWeaponSkillFinished(state, action);

    auto PWeaponSkill = state.GetSkill();
    auto PBattleTarget = static_cast<CBattleEntity*>(state.GetTarget());

    int16 tp = state.GetSpentTP();
    tp = battleutils::CalculateWeaponSkillTP(this, PWeaponSkill, tp);

    PLatentEffectContainer->CheckLatentsTP();

    SLOTTYPE damslot = SLOT_MAIN;
    bool isRangedWS = (PWeaponSkill->getID() >= 192 && PWeaponSkill->getID() <= 218);
    CItemWeapon* PItem = (CItemWeapon*)this->getEquip(SLOT_MAIN);

    // Check if target is alive
    if (PBattleTarget->GetHPP() < 1)
        return;

    if (distance(loc.p, PBattleTarget->loc.p) - PBattleTarget->m_ModelSize <= PWeaponSkill->getRange())
    {
        if (PWeaponSkill->getID() >= 192 && PWeaponSkill->getID() <= 221)
        {
            damslot = SLOT_RANGED;
            CItemWeapon* PItem = (CItemWeapon*)this->getEquip(SLOT_RANGED);
        }
        if (PWeaponSkill->getID() >= 1 && PWeaponSkill->getID() <= 15)
        {
            damslot = SLOT_MAIN;
        }

        PAI->TargetFind->reset();
        // #TODO: revise parameters
        if (PWeaponSkill->isAoE())
        {
            PAI->TargetFind->findWithinArea(PBattleTarget, AOERADIUS_TARGET, 10);
        }
        else
        {
            PAI->TargetFind->findSingleTarget(PBattleTarget);
        }

        // Assumed, it's very difficult to produce this due to WS being nearly instant
        // TODO: attempt to verify.
        if (PAI->TargetFind->m_targets.size() == 0)
        {
            // No targets, perhaps something like Super Jump or otherwise untargetable
            action.actiontype = ACTION_MAGIC_FINISH;
            action.actionid = 28787; // Some hardcoded magic for interrupts
            actionList_t& actionList = action.getNewActionList();
            actionList.ActionTargetID = id;

            actionTarget_t& actionTarget = actionList.getNewActionTarget();

            actionTarget.animation = 0x1FC; // Assumed, but not verified.
            actionTarget.messageID = 0;
            actionTarget.reaction = REACTION_ABILITY_HIT;

            return;
        }

        for (auto&& PTarget : PAI->TargetFind->m_targets)
        {
            bool primary = PTarget == PBattleTarget;
            actionList_t& actionList = action.getNewActionList();
            actionList.ActionTargetID = PTarget->id;

            actionTarget_t& actionTarget = actionList.getNewActionTarget();

            uint16 tpHitsLanded;
            uint16 extraHitsLanded;
            int32 damage;
            CBattleEntity* taChar = battleutils::getAvailableTrickAttackChar(this, PTarget);

            actionTarget.reaction = REACTION_NONE;
            actionTarget.speceffect = SPECEFFECT_NONE;
            actionTarget.animation = PWeaponSkill->getAnimationId();
            actionTarget.messageID = 0;
            std::tie(damage, tpHitsLanded, extraHitsLanded) = luautils::OnUseWeaponSkill(this, PTarget, PWeaponSkill, tp, primary, action, taChar);

            if (!battleutils::isValidSelfTargetWeaponskill(PWeaponSkill->getID()))
            {
                if (primary && PBattleTarget->objtype == TYPE_MOB)
                {
                    luautils::OnWeaponskillHit(PBattleTarget, this, PWeaponSkill->getID());
                }
            }
            else
            {
                actionTarget.messageID = primary ? 224 : 276; // restores mp msg
                actionTarget.reaction = REACTION_HIT;
                damage = std::max(damage, 0);
                actionTarget.param = PTarget->addMP(damage);
            }

            if (primary)
            {
                if (PWeaponSkill->getID() >= 192 && PWeaponSkill->getID() <= 218)
                {
                    uint16 recycleChance =
                        getMod(Mod::RECYCLE) + PMeritPoints->GetMeritValue(MERIT_RECYCLE, this) + this->PJobPoints->GetJobPointValue(JP_AMMO_CONSUMPTION);

                    if (StatusEffectContainer->HasStatusEffect(EFFECT_UNLIMITED_SHOT))
                    {
                        StatusEffectContainer->DelStatusEffectSilent(EFFECT_UNLIMITED_SHOT);
                        recycleChance = 100;
                    }
                    if (tpzrand::GetRandomNumber(100) > recycleChance)
                    {
                        battleutils::RemoveAmmo(this);
                    }
                }
                if (actionTarget.reaction == REACTION_HIT)
                {
                    if (battleutils::GetScaledItemModifier(this, m_Weapons[damslot], Mod::ADDITIONAL_EFFECT))
                    {
                        actionTarget_t dummy;
                        luautils::OnAdditionalEffect(this, PTarget, static_cast<CItemWeapon*>(m_Weapons[damslot]), &dummy, damage);
                    }
                    else if (damslot == SLOT_RANGED && m_Weapons[SLOT_AMMO] &&
                             battleutils::GetScaledItemModifier(this, m_Weapons[damslot], Mod::ADDITIONAL_EFFECT))
                    {
                        actionTarget_t dummy;
                        luautils::OnAdditionalEffect(this, PTarget, static_cast<CItemWeapon*>(getEquip(SLOT_AMMO)), &dummy, damage);
                    }
                    int wspoints = 1;
                    if (PWeaponSkill->getPrimarySkillchain() != 0)
                    {
                        // NOTE: GetSkillChainEffect is INSIDE this if statement because it
                        //  ALTERS the state of the resonance, which misses and non-elemental(i.e. spirits within) skills should NOT do.

                        SUBEFFECT effect = battleutils::GetSkillChainEffect(PBattleTarget, PWeaponSkill->getPrimarySkillchain(),
                                                                            PWeaponSkill->getSecondarySkillchain(), PWeaponSkill->getTertiarySkillchain());
                        if (effect != SUBEFFECT_NONE)
                        {
                            // Apply Inundation weapon skill type tracking
                            if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_INUNDATION))
                            {
                                CStatusEffect* PEffect = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_INUNDATION, 0);
                                auto power = PEffect->GetPower();
                                auto currentFlag = PItem->getSkillTypeFlag();
                                auto subPower = PEffect->GetSubPower();
                                if ((subPower & currentFlag) == 0)
                                {
                                    PEffect->SetPower(power + 1);
                                    PEffect->SetSubPower(subPower | currentFlag);
                                }
                            }

                            actionTarget.addEffectParam = battleutils::TakeSkillchainDamage(this, PBattleTarget, damage, taChar);
                            if (actionTarget.addEffectParam < 0)
                            {
                                actionTarget.addEffectParam = -actionTarget.addEffectParam;
                                actionTarget.addEffectMessage = 384 + effect;
                            }
                            else
                                actionTarget.addEffectMessage = 287 + effect;
                            actionTarget.additionalEffect = effect;

                            if (effect >= 7)
                                wspoints += 1;
                            else if (effect >= 3)
                                wspoints += 2;
                            else
                                wspoints += 4;
                        }
                        else if (effect == SUBEFFECT_NONE)
                        {
                            // Reset Inundation weapon skill type tracking
                            if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_INUNDATION))
                            {
                                CStatusEffect* PEffect = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_INUNDATION, 0);
                                auto currentFlag = PItem->getSkillTypeFlag();
                                PEffect->SetPower(0);
                                PEffect->SetSubPower(currentFlag);
                            }
                        }
                    }
                    // check for ws points
                    if (charutils::CheckMob(this->GetMLevel(), PTarget->GetMLevel()) > EMobDifficulty::TooWeak)
                    {
                        charutils::AddWeaponSkillPoints(this, damslot, wspoints);
                    }
                }
            }
        }
        // Remove effects consumed if present
        StatusEffectContainer->DelStatusEffectSilent(EFFECT_SENGIKORI);
        StatusEffectContainer->DelStatusEffectSilent(EFFECT_FOOTWORK);
        battleutils::ClaimMob(PBattleTarget, this);

        // Safety check to not get locked in cutscene status
        if (this->status == STATUS_CUTSCENE_ONLY || this->m_Substate == CHAR_SUBSTATE::SUBSTATE_IN_CS)
        {
            this->m_Substate = CHAR_SUBSTATE::SUBSTATE_NONE;
            this->status = STATUS_NORMAL;
        }
        this->pushPacket(new CInventoryFinishPacket());

        if (PBattleTarget->isDead() && PBattleTarget->objtype == TYPE_MOB)
        {
            ((CMobEntity*)PBattleTarget)->m_autoTargetKiller = this;
            ((CMobEntity*)PBattleTarget)->DoAutoTarget();
        }
    }
    else
    {
        actionList_t& actionList = action.getNewActionList();
        actionList.ActionTargetID = PBattleTarget->id;
        action.actiontype = ACTION_MAGIC_FINISH; // all "Too Far" messages use cat 4

        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.animation = 0x1FC; // Seems hardcoded, two bits away from 0x1FF
        actionTarget.messageID = MSGBASIC_TOO_FAR_AWAY;

        // While it doesn't seem that speceffect is actually used at all in this "do nothing" animation, this is here for accuracy.
        if (isRangedWS) // Ranged WS seem to stay 0 on Reaction
        {
            actionTarget.speceffect = SPECEFFECT_NONE;
        }
        else // Always 2 observed on various melee weapons
        {
            actionTarget.speceffect = SPECEFFECT_BLOOD;
        }
    }
}

void CCharEntity::OnAbility(CAbilityState& state, action_t& action)
{
    auto PAbility = state.GetAbility();
    auto success = true;
    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());
    uint16 targets = static_cast<uint16>(PAI->TargetFind->m_targets.size());
    std::unique_ptr<CBasicPacket> errMsg;
    if (IsValidTarget(PTarget->targid, PAbility->getValidTarget(), errMsg))
    {
        if (this != PTarget && distance(this->loc.p, PTarget->loc.p) > PAbility->getRange())
        {
            setActionInterrupted(action, PTarget, MSGBASIC_TOO_FAR_AWAY, 0);
            return;
        }

        // get any available merit recast reduction
        uint8 meritRecastReduction = 0;

        if (PAbility->getMeritModID() > 0 && !(PAbility->getAddType() & ADDTYPE_MERIT))
        {
            meritRecastReduction = PMeritPoints->GetMeritValue((MERIT_TYPE)PAbility->getMeritModID(), this);
        }

        auto charge = ability::GetCharge(this, PAbility->getRecastId());
        if (charge && PAbility->getID() != ABILITY_SIC)
        {
            action.recast = charge->chargeTime * PAbility->getRecastTime() - meritRecastReduction;
        }
        else
        {
            action.recast = PAbility->getRecastTime() - meritRecastReduction;
        }

        // Ready moves recast reduction
        if (PAbility->isReadyMove())
        {
            action.recast = charge->chargeTime * PAbility->getRecastTime() - PMeritPoints->GetMeritValue((MERIT_TYPE)MERIT_SIC_RECAST, this);
        }

        // If Third Eye is paralyzed while seigan is active, use the modified seigan cooldown for thirdeye(30s instead of 1m)
        if (PAbility->getID() == ABILITY_THIRD_EYE && this->StatusEffectContainer->HasStatusEffect(EFFECT_SEIGAN))
        {
            action.recast /= 2;
        }
        // Sneak Attack merits also reduce the recast of BUlly
        if (PAbility->getID() == ABILITY_BULLY)
        {
            action.recast = PAbility->getRecastTime() - PMeritPoints->GetMeritValue((MERIT_TYPE)MERIT_SNEAK_ATTACK_RECAST, this);
        }

        if (PAbility->getID() == ABILITY_LIGHT_ARTS || PAbility->getID() == ABILITY_DARK_ARTS || PAbility->getRecastId() == 231) //stratagems
        {
            if (this->StatusEffectContainer->HasStatusEffect(EFFECT_TABULA_RASA))
                action.recast = 0;
        }
        else if (PAbility->getID() == ABILITY_DEACTIVATE && PAutomaton && PAutomaton->health.hp == PAutomaton->GetMaxHP())
        {
            CAbility* PAbility = ability::GetAbility(ABILITY_ACTIVATE);
            if (PAbility)
                PRecastContainer->Del(RECAST_ABILITY, PAbility->getRecastId());
        }
        else if (PAbility->getID() >= ABILITY_HEALING_RUBY && PAbility->getID() <= ABILITY_PERFECT_DEFENSE)
        {
            if (this->StatusEffectContainer->HasStatusEffect(EFFECT_APOGEE))
            {
                action.recast = 0;
            }
            else
            {
                action.recast = 45;
                action.recast -= std::min<int16>(getMod(Mod::BP_DELAY), 15);
                action.recast -= std::min<int16>(getMod(Mod::BP_DELAY_II), 15);
            }
        }

        // Remove invisible if aggressive and not specific BST JA's
        if (PAbility->getID() != ABILITY_TAME && PAbility->getID() != ABILITY_FIGHT)
        {
            if (PAbility->getValidTarget() & TARGET_ENEMY)
            {
                StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DAMAGE);
                // aggressive action, SMN/PUP pet "assault" commands don't remove sneak but remove invis and quickening
                if (PAbility->getID() != ABILITY_ASSAULT && PAbility->getID() != ABILITY_DEPLOY)
                    StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DETECTABLE);
                else 
                    StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_INVISIBLE);
                    StatusEffectContainer->DelStatusEffectSilent(EFFECT_QUICKENING);
            }
            else if (PAbility->getID() != ABILITY_TRICK_ATTACK) {
                // remove invisible only
                StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_INVISIBLE);
            }
        }

        if (PAbility->getID() == ABILITY_REWARD) {
            action.recast -= getMod(Mod::REWARD_RECAST);
        }

        // The minimum recast time for Ready is 10 seconds per charge when taking into account all effects from merit points, Job Point Gifts, and equipment.
        // https://www.bg-wiki.com/ffxi/Ready
        if (PAbility->getID() == ABILITY_READY || PAbility->getID() == ABILITY_SIC || PAbility->isReadyMove())
        {
            action.recast -= std::min<int16>(getMod(Mod::SIC_READY_RECAST), 10);
        }

        // There is an overall cap of -25 seconds for a 35 second recast
        // https://www.bg-wiki.com/ffxi/Quick_Draw
        if ( PAbility->isQuickDraw())
        {
            action.recast -= std::min<int16>(getMod(Mod::QUICK_DRAW_RECAST), 25);
        }

        if (PAbility->getRecastId() == ABILITYRECAST_TWO_HOUR)
        {
            action.recast -= getMod(Mod::ONE_HOUR_RECAST);
        }

        // For testing
        if (charutils::GetCharVar(this, "GodMode") > 0 || charutils::GetCharVar(this, "SoftGodMode") > 0)
        {
            action.recast = 0;
        }

        action.id = this->id;
        action.actiontype = PAbility->getActionType();
        action.actionid = PAbility->getID();

        // #TODO: get rid of this to script, too
        if (PAbility->isPetAbility())
        {
            if (PPet) // is a bp - don't display msg and notify pet
            {
                m_petAbilityWait = server_clock::now() + std::chrono::milliseconds(5000);

                actionList_t& actionList = action.getNewActionList();
                actionList.ActionTargetID = PTarget->id;
                actionTarget_t& actionTarget = actionList.getNewActionTarget();
                actionTarget.animation = 94; //assault anim
                actionTarget.reaction = REACTION_NONE;
                actionTarget.speceffect = SPECEFFECT_RECOIL;
                actionTarget.param = 0;
                actionTarget.messageID = 0;

                auto PPetTarget = PTarget->targid;
                if (PAbility->getID() >= ABILITY_HEALING_RUBY && PAbility->getID() <= ABILITY_PERFECT_DEFENSE)
                {
                    // Blood Pact mp cost stored in animation ID
                    float mpCost = PAbility->getAnimationID();

                    if (StatusEffectContainer->HasStatusEffect(EFFECT_APOGEE))
                    {
                        StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_BLOODPACT, true);
                    }

                    // Blood Boon (does not affect Astra Flow BPs)
                    if ((PAbility->getAddType() & ADDTYPE_ASTRAL_FLOW) == 0)
                    {
                        int16 bloodBoonRate = getMod(Mod::BLOOD_BOON);
                        if (tpzrand::GetRandomNumber(100) < bloodBoonRate)
                        {
                            mpCost *= tpzrand::GetRandomNumber(8.f, 16.f) / 16.f;
                        }

                        if (this->health.mp < mpCost)
                        {
                            setActionInterrupted(action, PTarget, MSGBASIC_UNABLE_TO_USE_JA, 0);
                            return;
                        }
                    }

                    addMP((int32)-mpCost);

                    if (PAbility->getValidTarget() == TARGET_SELF)
                    {
                        PPetTarget = PPet->targid;
                    }
                }
                else
                {
                    auto PMobSkill = battleutils::GetMobSkill(PAbility->getMobSkillID());
                    if (PMobSkill)
                    {
                        if (PMobSkill->getValidTargets() & TARGET_ENEMY)
                        {
                            PPetTarget = PPet->GetBattleTargetID();
                        }
                        else
                        {
                            PPetTarget = PPet->targid;
                        }
                    }
                }
                if (PAbility->getID() == ABILITY_LEVEL_QUESTION_HOLY)
                {
                    int16 tp = PPet->health.tp;
                    PPet->SetLocalVar("tp", tp);
                    // ShowDebug("doing qm holy...\n");
                    PPet->PAI->MobSkill(PPetTarget, tpzrand::GetRandomNumber((uint16)2452, (uint16)2458));
                    PPet->PAI->MobSkill(PPetTarget, tpzrand::GetRandomNumber((uint16)2452, (uint16)2458)); // GetRandomNumber never returns the max value
                }
                else
                {
                    if (PPetTarget > 0 && PAbility->getMobSkillID() > 0)
                    {
                        int16 tp = PPet->health.tp;
                        PPet->SetLocalVar("tp", tp);
                        PPet->PAI->MobSkill(PPetTarget, PAbility->getMobSkillID());
                    }
                }
            }
            PAbility->setTotalTargets(targets);
            PAbility->setPrimaryTargetID(PTarget->id);
        }
        else
        {
            uint16 totalTargets = static_cast<uint16>(PAI->TargetFind->m_targets.size());

            PAbility->setTotalTargets(totalTargets);
            PAbility->setPrimaryTargetID(PTarget->id);

            std::vector<CBattleEntity*> targets = { PTarget };
            auto& PTargets = targets;
            bool first = true;

            if (PAbility->isAoE() && this->PParty != nullptr)
            {
                PAI->TargetFind->reset();

                float distance = PAbility->getRange();
                FINDFLAGS findFlags = FINDFLAGS_NONE;

                // AoE ALL targets if certain status effects are active in order to buff friendly NPCs
                if (this->StatusEffectContainer->HasStatusEffect({ EFFECT_CONFRONTATION, EFFECT_BESIEGED, EFFECT_ALLIED_TAGS, EFFECT_VOIDWATCHER, EFFECT_REIVE_MARK, EFFECT_ELVORSEAL }))
                {
                    findFlags = FINDFLAGS_HIT_ALL;
                }

                PAI->TargetFind->findWithinArea(this, AOERADIUS_ATTACKER, distance, findFlags);
                PTargets = PAI->TargetFind->m_targets;
            }
            for (auto&& PTarget : PTargets)
            {
                actionList_t& actionList = action.getNewActionList();
                actionList.ActionTargetID = PTarget->id;
                actionTarget_t& actionTarget = actionList.getNewActionTarget();
                actionTarget.reaction = REACTION_NONE;
                actionTarget.speceffect = SPECEFFECT_NONE;
                actionTarget.animation = PAbility->getAnimationID();
                actionTarget.messageID = 0;
                actionTarget.param = 0;

                if (PTarget->isSuperJumped)
                {
                    actionTarget.animation = ANIMATION_NONE;
                    actionTarget.messageID = 0;
                }
                else
                {
                    int32 value = luautils::OnUseAbility(this, PTarget, PAbility, &action);

                    // If a script set messageID directly, use that;
                    // otherwise, use the ability's message id.
                    if (actionTarget.messageID == 0)
                    {
                        actionTarget.messageID = first ? PAbility->getMessage() : PAbility->getAoEMsg();
                    }

                    // Display a generic message for the caster if no message is set.
                    if (first && actionTarget.messageID == 0)
                        actionTarget.messageID = MSGBASIC_USES_JA;

                    actionTarget.param = value;

                    if (value < 0)
                    {
                        actionTarget.messageID = ability::GetAbsorbMessage(actionTarget.messageID);
                        actionTarget.param = -value;
                    }

                    state.ApplyEnmity();
                }

                first = false;
            }
        }


        // Interrupted
        if (!success)
        {
            actionList_t& actionList = action.getNewActionList();
            actionList.ActionTargetID = this->id;

            actionTarget_t& actionTarget = actionList.getNewActionTarget();
            actionTarget.animation = 508;
            actionTarget.messageID = 88;
            action.actionid = 0;
            action.recast = 0;

            return;
        }

        // Remove Contradance after using a Waltz
        if (StatusEffectContainer->HasStatusEffect(EFFECT_CONTRADANCE) && PAbility->getID() > ABILITY_HASTE_SAMBA && PAbility->getID() < ABILITY_HEALING_WALTZ ||
            PAbility->getID() == ABILITY_DIVINE_WALTZ || PAbility->getID() == ABILITY_DIVINE_WALTZ_II)
        {
            StatusEffectContainer->DelStatusEffectSilent(EFFECT_CONTRADANCE);
        }
        battleutils::HandlePlayerAbilityUsed(this, PAbility, &action);

        PRecastContainer->Add(RECAST_ABILITY, PAbility->getRecastId(), action.recast);

        uint16 recastID = PAbility->getRecastId();
        if (map_config.blood_pact_shared_timer && (recastID == 173 || recastID == 174))
        {
            PRecastContainer->Add(RECAST_ABILITY, (recastID == 173 ? 174 : 173), action.recast);
        }

        // Safety check to not get locked in cutscene status
        if (this->status == STATUS_CUTSCENE_ONLY || this->m_Substate == CHAR_SUBSTATE::SUBSTATE_IN_CS)
        {
            this->m_Substate = CHAR_SUBSTATE::SUBSTATE_NONE;
            this->status = STATUS_NORMAL;
        }
        pushPacket(new CCharRecastPacket(this));
        this->pushPacket(new CInventoryFinishPacket());

        if (PTarget->isDead() && PTarget->objtype == TYPE_MOB)
        {
            ((CMobEntity*)PTarget)->m_autoTargetKiller = this;
            ((CMobEntity*)PTarget)->DoAutoTarget();
        }
    }
    else if (errMsg)
    {
        pushPacket(std::move(errMsg));
    }
}

void CCharEntity::OnRangedAttack(CRangeState& state, action_t& action)
{
    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());

    if (battleutils::IsParalyzed(this))
    {
        // setup new action packet to send paralyze message
        action_t paralyze_action = {};
        setActionInterrupted(paralyze_action, PTarget, MSGBASIC_IS_PARALYZED, 0);
        loc.zone->PushPacket(this, CHAR_INRANGE_SELF, new CActionPacket(paralyze_action));

        // Set up /ra action to be interrupted
        action.actiontype = ACTION_RANGED_INTERRUPT; // This handles some magic numbers in CActionPacket to cancel actions
        action.id = id;

        actionList_t& actionList = action.getNewActionList();
        actionList.ActionTargetID = id;

        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.animation = 0x1FC; // Seems hardcoded, two bits away from 0x1FF (0x1FC = 1 1111 1100)
        actionTarget.speceffect = SPECEFFECT::SPECEFFECT_RECOIL;
        actionTarget.reaction = REACTION::REACTION_NONE;

        return;
    }

    int32 damage = 0;
    int32 totalDamage = 0;

    action.id = id;
    action.actiontype = ACTION_RANGED_FINISH;

    actionList_t& actionList = action.getNewActionList();
    actionList.ActionTargetID = PTarget->id;

    actionTarget_t& actionTarget = actionList.getNewActionTarget();
    actionTarget.reaction = REACTION_HIT;		//0x10
    actionTarget.speceffect = SPECEFFECT_HIT;		//0x60 (SPECEFFECT_HIT + SPECEFFECT_RECOIL)
    actionTarget.messageID = 352;

    CItemWeapon* PItem = (CItemWeapon*)this->getEquip(SLOT_RANGED);
    CItemWeapon* PAmmo = (CItemWeapon*)this->getEquip(SLOT_AMMO);

    bool ammoThrowing = PAmmo ? PAmmo->isThrowing() : false;
    bool rangedThrowing = PItem ? PItem->isThrowing() : false;
    uint8 slot = SLOT_RANGED;

    if (ammoThrowing)
    {
        slot = SLOT_AMMO;
        PItem = nullptr;
    }
    if (rangedThrowing)
    {
        PAmmo = nullptr;
    }

    uint8 shadowsTaken = 0;
    uint8 hitCount = 1;			// 1 hit by default
    uint8 realHits = 0;			// to store the real number of hit for tp multipler
    auto ammoConsumed = 0;
    bool hitOccured = false;	// track if player hit mob at all
    bool isBarrage = StatusEffectContainer->HasStatusEffect(EFFECT_BARRAGE, 0);

    // if barrage is detected, getBarrageShotCount also checks for ammo count
    if (!ammoThrowing && !rangedThrowing && isBarrage)
    {
        hitCount += battleutils::getBarrageShotCount(this);
    }
    else if (this->StatusEffectContainer->HasStatusEffect(EFFECT_DOUBLE_SHOT) && tpzrand::GetRandomNumber(100) < (this->getMod(Mod::DOUBLE_SHOT_RATE)))
    {
        hitCount = 2;
    }
    else if (this->StatusEffectContainer->HasStatusEffect(EFFECT_TRIPLE_SHOT) && tpzrand::GetRandomNumber(100) < (this->getMod(Mod::TRIPLE_SHOT_RATE)))
    {
        hitCount = 3;
    }

    // loop for barrage hits, if a miss occurs, the loop will end
    for (uint8 i = 1; i <= hitCount; ++i)
    {
        if (tpzrand::GetRandomNumber(100) < battleutils::GetRangedHitRate(this, PTarget, isBarrage)) // hit!
        {
            // absorbed by shadow
            if (battleutils::IsAbsorbByShadow(PTarget, this))
            {
                shadowsTaken++;
            }
            else
            {
                bool isCritical = tpzrand::GetRandomNumber(100) < battleutils::GetRangedCritHitRate(this, PTarget, true);
                float pdif = battleutils::GetRangedDamageRatio(this, PTarget, isCritical);

                if (isCritical)
                {
                    actionTarget.speceffect = SPECEFFECT_CRITICAL_HIT;
                    actionTarget.messageID = 353;

                    luautils::OnCriticalHit(PTarget, this);
                }

                // at least 1 hit occured
                hitOccured = true;
                realHits++;

                damage = (int32)((this->GetRangedWeaponDmg() + battleutils::GetFSTR(this, PTarget, slot)) * pdif);

                if (slot == SLOT_RANGED)
                {
                    if (state.IsRapidShot())
                    {
                        damage = attackutils::CheckForDamageMultiplier(this, PItem, damage, PHYSICAL_ATTACK_TYPE::RAPID_SHOT, SLOT_RANGED);
                    }
                    else
                    {
                        damage = attackutils::CheckForDamageMultiplier(this, PItem, damage, PHYSICAL_ATTACK_TYPE::RANGED, SLOT_RANGED);
                    }

                    if (PItem != nullptr)
                    {
                        charutils::TrySkillUP(this, (SKILLTYPE)PItem->getSkillType(), PTarget->GetMLevel(), false);
                    }
                }
                else if (slot == SLOT_AMMO && PAmmo != nullptr)
                {
                    charutils::TrySkillUP(this, (SKILLTYPE)PAmmo->getSkillType(), PTarget->GetMLevel(), false);
                }
            }
        }
        else //miss
        {
            damage = 0;
            actionTarget.reaction = REACTION_EVADE;
            actionTarget.speceffect = SPECEFFECT_NONE;
            actionTarget.messageID = 354;
            hitCount = i; // end barrage, shot missed
        }

        // check for recycle chance
        uint16 recycleChance = getMod(Mod::RECYCLE);
        if (charutils::hasTrait(this, TRAIT_RECYCLE))
        {
            recycleChance += PMeritPoints->GetMeritValue(MERIT_RECYCLE, this);
        }

        recycleChance += this->PJobPoints->GetJobPointValue(JP_AMMO_CONSUMPTION);

        // Only remove unlimited shot on hit
        if (hitOccured && this->StatusEffectContainer->HasStatusEffect(EFFECT_UNLIMITED_SHOT))
        {
            StatusEffectContainer->DelStatusEffectSilent(EFFECT_UNLIMITED_SHOT);
            recycleChance = 100;
        }

        if (PAmmo != nullptr && tpzrand::GetRandomNumber(100) > recycleChance)
        {
            ++ammoConsumed;
            TrackArrowUsageForScavenge(PAmmo);
            if (PAmmo->getQuantity() == i)
            {
                hitCount = i;
            }
        }
        totalDamage += damage;
    }

    // if a hit did occur (even without barrage)
    if (hitOccured == true)
    {
        // any misses with barrage cause remaing shots to miss, meaning we must check Action.reaction
        if (actionTarget.reaction == REACTION_EVADE && (this->StatusEffectContainer->HasStatusEffect(EFFECT_BARRAGE)))
        {
            actionTarget.messageID = 352;
            actionTarget.reaction = REACTION_HIT;
            actionTarget.speceffect = SPECEFFECT_CRITICAL_HIT;
        }

        actionTarget.param = battleutils::TakePhysicalDamage(this, PTarget, PHYSICAL_ATTACK_TYPE::RANGED, totalDamage, false, slot, realHits, nullptr, true, true);

        // lower damage based on shadows taken
        if (shadowsTaken)
            actionTarget.param = (int32)(actionTarget.param * (1 - ((float)shadowsTaken / realHits)));

        // absorb message
        if (actionTarget.param < 0)
        {
            actionTarget.param = -(actionTarget.param);
            actionTarget.messageID = 382;
        }

        // Handle frontal PDT
        if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_PHYSICAL_SHIELD) && infront(this->loc.p, PTarget->loc.p, 64))
        {
            int power = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_PHYSICAL_SHIELD)->GetPower();
            float resist = 1.0f;
            if (power == 3)
            {
                resist = 0;
            }
            actionTarget.param = (int32)(actionTarget.param * (float)resist);
        }
        if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_PHYSICAL_SHIELD) && infront(this->loc.p, PTarget->loc.p, 64))
        {
            int power = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_PHYSICAL_SHIELD)->GetPower();
            float resist = 1.0f;
            if (power == 5)
            {
                resist = 0.25f;
            }
            actionTarget.param = (int32)(actionTarget.param * (float)resist);
        }
        if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_PHYSICAL_SHIELD) && infront(this->loc.p, PTarget->loc.p, 64))
        {
            int power = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_PHYSICAL_SHIELD)->GetPower();
            float resist = 1.0f;
            if (power == 6)
            {
                resist = 0.5f;
            }
            actionTarget.param = (int32)(actionTarget.param * (float)resist);
        }

        // Handle Behind PDT
        if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_PHYSICAL_SHIELD) && behind(this->loc.p, PTarget->loc.p, 64))
        {
            int power = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_PHYSICAL_SHIELD)->GetPower();
            float resist = 1.0f;
            if (power == 4)
            {
                resist = 0;
            }
            actionTarget.param = (int32)(actionTarget.param * (float)resist);
        }
        if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_PHYSICAL_SHIELD) && behind(this->loc.p, PTarget->loc.p, 64))
        {
            int power = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_PHYSICAL_SHIELD)->GetPower();
            float resist = 1.0f;
            if (power == 7)
            {
                resist = 0.25f;
            }
            actionTarget.param = (int32)(actionTarget.param * (float)resist);
        }
        if (PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_PHYSICAL_SHIELD) && behind(this->loc.p, PTarget->loc.p, 64))
        {
            int power = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_PHYSICAL_SHIELD)->GetPower();
            float resist = 1.0f;
            if (power == 8)
            {
                resist = 0.5f;
            }
            actionTarget.param = (int32)(actionTarget.param * (float)resist);
        }

        //add additional effects
        //this should go AFTER damage taken
        //or else sleep effect won't work
        //battleutils::HandleRangedAdditionalEffect(this,PTarget,&Action);
        //TODO: move all hard coded additional effect ammo to scripts
        if ((PAmmo != nullptr && battleutils::GetScaledItemModifier(this, PAmmo, Mod::ADDITIONAL_EFFECT) > 0) ||
            (PItem != nullptr && battleutils::GetScaledItemModifier(this, PItem, Mod::ADDITIONAL_EFFECT) > 0)) {}
        luautils::OnAdditionalEffect(this, PTarget, (PAmmo != nullptr ? PAmmo : PItem), &actionTarget, totalDamage);
    }
    else if (shadowsTaken > 0)
    {
        // shadows took damage
        actionTarget.messageID = 0;
        actionTarget.reaction = REACTION_EVADE;
        PTarget->loc.zone->PushPacket(PTarget, CHAR_INRANGE_SELF, new CMessageBasicPacket(PTarget, PTarget, 0, shadowsTaken, MSGBASIC_SHADOW_ABSORB));
    }

    if (actionTarget.speceffect == SPECEFFECT_HIT && actionTarget.param > 0)
        actionTarget.speceffect = SPECEFFECT_RECOIL;

    // remove barrage effect if present
    if (this->StatusEffectContainer->HasStatusEffect(EFFECT_BARRAGE, 0)) {
        StatusEffectContainer->DelStatusEffect(EFFECT_BARRAGE, 0);
    }
    battleutils::ClaimMob(PTarget, this);
    battleutils::RemoveAmmo(this, ammoConsumed);
    // only remove detectables and NOT camouflage
    if (!StatusEffectContainer->HasStatusEffect(EFFECT_CAMOUFLAGE))
        StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DETECTABLE);


    // Safety check to not get locked in cutscene status
    if (this->status == STATUS_CUTSCENE_ONLY || this->m_Substate == CHAR_SUBSTATE::SUBSTATE_IN_CS)
    {
        this->m_Substate = CHAR_SUBSTATE::SUBSTATE_NONE;
        this->status = STATUS_NORMAL;
    }
    this->pushPacket(new CInventoryFinishPacket());

    if (PTarget->isDead() && PTarget->objtype == TYPE_MOB)
    {
        ((CMobEntity*)PTarget)->m_autoTargetKiller = this;
        ((CMobEntity*)PTarget)->DoAutoTarget();
    }
    else if (hitOccured == false && PTarget->objtype == TYPE_MOB)
    {
        // 1 ce for a missed attack for TH application
        ((CMobEntity*)PTarget)->PEnmityContainer->UpdateEnmity((CBattleEntity*)this, 1, 0);
    }


    // Try to double shot
    //#TODO: figure out the packet structure of double/triple shot
    //if (this->StatusEffectContainer->HasStatusEffect(EFFECT_DOUBLE_SHOT, 0) && !this->secondDoubleShotTaken &&	!isBarrage)
    //{
    //    uint16 doubleShotChance = getMod(Mod::DOUBLE_SHOT_RATE);
    //    if (tpzrand::GetRandomNumber(100) < doubleShotChance)
    //    {
    //        this->secondDoubleShotTaken = true;
    //        m_ActionType = ACTION_RANGED_FINISH;
    //        this->m_rangedDelay = 0;
    //        return;
    //    }
    //}
}

bool CCharEntity::IsMobOwner(CBattleEntity* PBattleTarget)
{
    TPZ_DEBUG_BREAK_IF(PBattleTarget == nullptr);

    if (PBattleTarget->m_OwnerID.id == 0 || PBattleTarget->m_OwnerID.id == this->id || PBattleTarget->objtype == TYPE_PC)
    {
        return true;
    }

    bool found = false;

    static_cast<CCharEntity*>(this)->ForAlliance([&PBattleTarget, &found](CBattleEntity* PEntity) {
        if (PEntity->id == PBattleTarget->m_OwnerID.id)
        {
            found = true;
        }
    });

    return found;
}


bool CCharEntity::IsPartiedWith(CCharEntity* PTarget)
{
    bool found = false;

    static_cast<CCharEntity*>(this)->ForAlliance(
        [&PTarget, &found](CBattleEntity* PEntity)
        {
            if (PEntity->id == PTarget->id)
            {
                found = true;
            }
        });

    return found;
}

void CCharEntity::HandleErrorMessage(std::unique_ptr<CBasicPacket>& msg)
{
    if (msg && !isCharmed)
        pushPacket(msg.release());
}

void CCharEntity::OnDeathTimer()
{
    charutils::HomePoint(this);
}

void CCharEntity::OnRaise()
{
    // TODO: Moghancement Experience needs to be factored in here somewhere.
    if (m_hasRaise > 0)
    {
        uint8 weaknessLvl = 1;
        int weaknessDura = 0;
        if (StatusEffectContainer->HasStatusEffect(EFFECT_WEAKNESS))
        {
            //double weakness!
            weaknessLvl = 2;
        }

        // Add weakness effect (75% reduction in HP/MP) if not Mijin or GM command raise
        if (GetLocalVar("MijinGakure") == 0 && GetLocalVar("GMRaise") == 0)
        {
            // Duration of Weakness varies with raise effect
            switch (m_hasRaise)
            {
                case 1:
                    weaknessDura = 180;
                    break;
                case 2:
                    weaknessDura = 120;
                    break;
                case 3:
                    weaknessDura = 60;
                    break;
                case 4:
                case 5:
                    weaknessDura = 30;
                    break;
                default:
                    weaknessDura = 180;
                    break;
            }
        }

        CStatusEffect* PWeaknessEffect = new CStatusEffect(EFFECT_WEAKNESS, EFFECT_WEAKNESS, weaknessLvl, 0, weaknessDura);
        StatusEffectContainer->AddStatusEffect(PWeaknessEffect);

        double ratioReturned = 0.0f;
        uint16 hpReturned = 1;

        action_t action;
        action.id = id;
        action.actiontype = ACTION_RAISE_MENU_SELECTION;
        auto& list = action.getNewActionList();
        auto& actionTarget = list.getNewActionTarget();

        list.ActionTargetID = id;
        // Mijin Gakure used with MIJIN_RERAISE MOD
        if (GetLocalVar("MijinGakure") != 0 && getMod(Mod::MIJIN_RERAISE) != 0)
        {
            actionTarget.animation = 511;
            hpReturned = (uint16)(GetMaxHP());
        }
        else if (GetLocalVar ("GMRaise") != 0)
        {
            actionTarget.animation = 511;
            hpReturned = (uint16)(GetMaxHP());
            ratioReturned = 1.0f;
        }
        else if (m_hasRaise == 1)
        {
            actionTarget.animation = 511;
            hpReturned = (uint16)((GetLocalVar("MijinGakure") != 0) ? GetMaxHP() * 0.5 : GetMaxHP() * 0.1);
            ratioReturned = 0.50f * (1 - map_config.exp_retain);
        }
        else if (m_hasRaise == 2)
        {
            actionTarget.animation = 512;
            hpReturned = (uint16)((GetLocalVar("MijinGakure") != 0) ? GetMaxHP() * 0.5 : GetMaxHP() * 0.25);
            ratioReturned = ((GetMLevel() <= 50) ? 0.50f : 0.75f) * (1 - map_config.exp_retain);
        }
        else if (m_hasRaise == 3)
        {
            actionTarget.animation = 496;
            hpReturned = (uint16)(GetMaxHP() * 0.5);
            ratioReturned = ((GetMLevel() <= 50) ? 0.50f : 0.90f) * (1 - map_config.exp_retain);
        }
        else if (m_hasRaise == 4) // reraise IV
        {
            actionTarget.animation = 496;
            hpReturned = GetMaxHP();
            ratioReturned = ((GetMLevel() <= 50) ? 0.50f : 0.90f) * (1.0f - (map_config.exp_retain));
        }
        else if (m_hasRaise == 5) // arise
        {
            actionTarget.animation = 496;
            hpReturned = GetMaxHP();
            ratioReturned = ((GetMLevel() <= 50) ? 0.50f : 0.90f) * (1.0f - (map_config.exp_retain));
            CStatusEffect* PEffect = new CStatusEffect(EFFECT_RERAISE, EFFECT_RERAISE, 3, 3, 3600, 0, 0, 0);
            this->StatusEffectContainer->AddStatusEffect(PEffect, true);
        }
        else if (m_hasRaise == 6) // pixie raise
        {
            actionTarget.animation = 496;
            hpReturned = GetMaxHP();
            ratioReturned = 1.0f - (map_config.exp_retain);
        }
        addHP(((hpReturned < 1) ? 1 : hpReturned));
        updatemask |= UPDATE_HP;
        actionTarget.speceffect = SPECEFFECT_RAISE;

        loc.zone->PushPacket(this, CHAR_INRANGE_SELF, new CActionPacket(action));

        uint8 mLevel = (m_LevelRestriction != 0 && m_LevelRestriction < GetMLevel()) ? m_LevelRestriction : GetMLevel();
        uint16 expLost = mLevel <= 67 ? (charutils::GetExpNEXTLevel(mLevel) * 8) / 100 : 2400;

        uint16 xpNeededToLevel = charutils::GetExpNEXTLevel(jobs.job[GetMJob()]) - jobs.exp[GetMJob()];

        // Exp is enough to level you and (you're not under a level restriction, or the level restriction is higher than your current main level).
        if (xpNeededToLevel < expLost && (m_LevelRestriction == 0 || GetMLevel() < m_LevelRestriction))
        {
            // Player probably leveled down when they died.  Give they xp for the next level.
            expLost = GetMLevel() <= 67 ? (charutils::GetExpNEXTLevel(jobs.job[GetMJob()] + 1) * 8) / 100 : 2400;
        }

        uint16 xpReturned = (uint16)(ceil(expLost * ratioReturned));

        if (GetLocalVar("MijinGakure") == 0 && GetMLevel() >= map_config.exp_loss_level)
        {
            charutils::AddExperiencePoints(true, this, this, xpReturned);
        }

        SetLocalVar("MijinGakure", 0);
        SetLocalVar("GMRaise", 0);

        m_hasRaise = 0;
    }
}

void CCharEntity::OnItemFinish(CItemState& state, action_t& action)
{
    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());
    auto PItem = static_cast<CItemUsable*>(state.GetItem());

    PAI->TargetFind->reset();
    if (PItem->getAoE())
    {
        PTarget->ForParty([PItem, PTarget](CBattleEntity* PMember)
        {
            if (!PMember->isDead() && distance(PTarget->loc.p, PMember->loc.p) <= 10)
            {
                luautils::OnItemUse(PMember, PItem);
                battleutils::GenerateInRangeEnmity(PTarget, 0, 640);
                // Prism and Rainbow powders
                if (PItem->getID() != 4164 && PItem->getID() != 5362)
                {
                    PTarget->StatusEffectContainer->DelStatusEffectSilent(EFFECT_INVISIBLE);
                }
            }
        });
        float radius = 10.0f;
        PAI->TargetFind->findWithinArea(PTarget, AOERADIUS_ATTACKER, radius);

        uint16 targets = (uint16)PAI->TargetFind->m_targets.size();

        for (auto&& PActionTarget : PAI->TargetFind->m_targets)
        {
            if (this->allegiance == PActionTarget->allegiance)
            {
                action.id = this->id;
                action.actiontype = ACTION_ITEM_FINISH;
                action.actionid = PItem->getID();

                actionList_t& actionList = action.getNewActionList();
                actionList.ActionTargetID = PActionTarget->id;

                actionTarget_t& actionTarget = actionList.getNewActionTarget();
                actionTarget.animation = PItem->getAnimationID();
                actionTarget.reaction = REACTION_HIT;
                actionTarget.messageID = PItem->getMsg();
                actionTarget.param = PItem->getParam();

                // Percentage HP / MP restored msg, Healing/Mana Powder
                if (actionTarget.messageID == MSGBASIC_RECOVERS_HP_MP || PItem->getID() == 5322 || PItem->getID() == 4255)
                {
                    int hp = floor(PActionTarget->GetMaxHP() * actionTarget.param);
                    int mp = floor(PActionTarget->GetMaxMP() * actionTarget.param);
                    int hpp = floor(hp / 100);
                    int mpp = floor(mp / 100);

                    actionTarget.param = hpp;

                    // Mana Powder
                    if (PItem->getID() == 4255)
                    {
                        actionTarget.param = mpp;
                    }
                }

                // HP restored msg
                if (actionTarget.messageID == MSGBASIC_RECOVERS_HP || actionTarget.messageID == MSGBASIC_RECOVERS_HP_MP)
                {
                    if (this->StatusEffectContainer->HasStatusEffect(EFFECT_CURSE_II))
                    {
                        actionTarget.param = 0;
                    }
                }
            }
        }


    }
    else
    {
        luautils::OnItemUse(PTarget, PItem);
        battleutils::GenerateInRangeEnmity(PTarget, 0, 640);
        // Prism and Rainbow powders
        if (PItem->getID() != 4164 && PItem->getID() != 5362)
        {
            this->StatusEffectContainer->DelStatusEffectSilent(EFFECT_INVISIBLE);
        }
        action.id = this->id;
        action.actiontype = ACTION_ITEM_FINISH;
        action.actionid = PItem->getID();

        actionList_t& actionList = action.getNewActionList();
        actionList.ActionTargetID = PTarget->id;

        // Healing / Clear Salve / Dawn Mulsum (Pet items)
        if (PItem->getID() >= 5835 && PItem->getID() <= 5838 || PItem->getID() == 5411)
        {
            if (PTarget->PPet != nullptr)
            {
                actionList.ActionTargetID = PTarget->PPet->id;
            }
        }

        actionTarget_t& actionTarget = actionList.getNewActionTarget();
        actionTarget.animation = PItem->getAnimationID();
        actionTarget.reaction = REACTION_HIT;
        actionTarget.messageID = PItem->getMsg();
        actionTarget.param = PItem->getParam();

        // Percentage HP for Healing Salve I and II
        if (PItem->getID() == 5835 || PItem->getID() == 5836)
        {
            if (PTarget->PPet != nullptr)
            {
                int hp = floor(PPet->GetMaxHP() * actionTarget.param);
                int hpp = floor(hp / 100);

                actionTarget.param = hpp;
            }
        }

        // Percentage HP / MP restored msg, Healing/Mana Powder
        if (actionTarget.messageID == MSGBASIC_RECOVERS_HP_MP || PItem->getID() == 5322 || PItem->getID() == 4255)
        {
            int hp = floor(this->GetMaxHP() * actionTarget.param);
            int mp = floor(this->GetMaxMP() * actionTarget.param);
            int hpp = floor(hp / 100);
            int mpp = floor(mp / 100);

            actionTarget.param = hpp;

            // Mana Powder
            if (PItem->getID() == 4255)
            {
                actionTarget.param = mpp;
            }
        }

        // HP restored msg
        if (actionTarget.messageID == MSGBASIC_RECOVERS_HP || actionTarget.messageID == MSGBASIC_RECOVERS_HP_MP)
        {
            if (this->StatusEffectContainer->HasStatusEffect(EFFECT_CURSE_II))
            {
                actionTarget.param = 0;
            }
        }
    }

    if (PItem->isType(ITEM_EQUIPMENT))
    {
        if (PItem->getMaxCharges() > 1)
        {
            PItem->setCurrentCharges(PItem->getCurrentCharges() - 1);
        }
        PItem->setLastUseTime(CVanaTime::getInstance()->getVanaTime());

        char extra[sizeof(PItem->m_extra) * 2 + 1];
        Sql_EscapeStringLen(SqlHandle, extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));

        const char* Query =
            "UPDATE char_inventory "
            "SET extra = '%s' "
            "WHERE charid = %u AND location = %u AND slot = %u;";

        Sql_Query(
            SqlHandle,
            Query,
            extra,
            this->id,
            PItem->getLocationID(),
            PItem->getSlotID());

        if (PItem->getCurrentCharges() != 0)
        {
            this->PRecastContainer->Add(RECAST_ITEM, PItem->getSlotID() << 8 | PItem->getLocationID(), PItem->getReuseTime() / 1000); // add recast timer to Recast List from any bag
        }
    }
    else // разблокируем все предметы, кроме экипирвоки
    {
        PItem->setSubType(ITEM_UNLOCKED);

        charutils::UpdateItem(this, PItem->getLocationID(), PItem->getSlotID(), -1, true);
    }
}

CBattleEntity* CCharEntity::IsValidTarget(uint16 targid, uint16 validTargetFlags, std::unique_ptr<CBasicPacket>& errMsg)
{
    auto PTarget = CBattleEntity::IsValidTarget(targid, validTargetFlags, errMsg);
    if (PTarget)
    {
        if (PTarget->objtype == TYPE_PC && charutils::IsAidBlocked(this, static_cast<CCharEntity*>(PTarget)))
        {
            // Target is blocking assistance
            errMsg = std::make_unique<CMessageSystemPacket>(0, 0, 225);
            // Interaction was blocked
            static_cast<CCharEntity*>(PTarget)->pushPacket(new CMessageSystemPacket(0, 0, 226));
        }
        else if (static_cast<CCharEntity*>(this)->IsMobOwner(PTarget))
        {
            if (PTarget->isAlive() || (validTargetFlags & TARGET_PLAYER_DEAD) != 0)
            {
                return PTarget;
            }
            else
            {
                errMsg = std::make_unique<CMessageBasicPacket>(this, this, 0, 0, MSGBASIC_CANNOT_ON_THAT_TARG);
            }
        }
        else
        {
            errMsg = std::make_unique<CMessageBasicPacket>(this, PTarget, 0, 0, MSGBASIC_ALREADY_CLAIMED);
        }
    }
    else
    {
        errMsg = std::make_unique<CMessageBasicPacket>(this, this, 0, 0, MSGBASIC_CANNOT_ATTACK_TARGET);
    }
    return nullptr;
}

void CCharEntity::Die()
{
    m_LastEngagedTargID = 0;
    if (PLastAttacker)
        loc.zone->PushPacket(this, CHAR_INRANGE_SELF, new CMessageBasicPacket(PLastAttacker, this, 0, 0, MSGBASIC_PLAYER_DEFEATED_BY));
    else
        loc.zone->PushPacket(this, CHAR_INRANGE_SELF, new CMessageBasicPacket(this, this, 0, 0, MSGBASIC_FALLS_TO_GROUND));

    battleutils::RelinquishClaim(this);
    Die(death_duration);
    SetDeathTimestamp((uint32)time(nullptr));

    setBlockingAid(false);

    //influence for conquest system
    conquest::LoseInfluencePoints(this);
    if (this->PPet != nullptr)
    {
        petutils::DespawnPet(this);
    }

    if (GetLocalVar("MijinGakure") == 0)
    {
        float retainPercent = std::clamp(map_config.exp_retain + getMod(Mod::EXPERIENCE_RETAINED) / 100.0f, 0.0f, 1.0f);
        charutils::DelExperiencePoints(this, retainPercent, 0);
    }
}

void CCharEntity::Die(duration _duration)
{
    this->ClearTrusts();

    m_deathSyncTime = server_clock::now() + death_update_frequency;
    PAI->ClearStateStack();
    PAI->Internal_Die(_duration);

    // If player allegiance is not reset on death they will auto-homepoint
    allegiance = ALLEGIANCE_PLAYER;

    // reraise modifiers
    if (this->getMod(Mod::RERAISE_I) > 0)
        m_hasRaise = 1;

    if (this->getMod(Mod::RERAISE_II) > 0)
        m_hasRaise = 2;

    if (this->getMod(Mod::RERAISE_III) > 0)
        m_hasRaise = 3;

    if (this->getMod(Mod::RERAISE_IV) > 0)
        m_hasRaise = 4;

    // MIJIN_RERAISE checks
    if (m_hasRaise == 0 && this->getMod(Mod::MIJIN_RERAISE) > 0)
        m_hasRaise = 1;

    CBattleEntity::Die();
}

void CCharEntity::Raise()
{
    PAI->Internal_Raise();
    SetDeathTimestamp(0);
}

void CCharEntity::SetDeathTimestamp(uint32 timestamp)
{
    m_DeathTimestamp = timestamp;
}

int32 CCharEntity::GetSecondsElapsedSinceDeath()
{
    return m_DeathTimestamp > 0 ? (uint32)time(nullptr) - m_DeathTimestamp : 0;
}

int32 CCharEntity::GetTimeRemainingUntilDeathHomepoint()
{
    // 0x0003A020 is 60 * 3960 and 3960 is 66 minutes in seconds
    // The client uses this time as the maximum amount of time for death
    // We convert the elapsed death time to this total time and subtract it which gives us the remaining time to a forced homepoint
    // Once the returned value here reaches below 360 then the client with force homepoint the character
    return 0x0003A020 - (60 * GetSecondsElapsedSinceDeath());
}


int32 CCharEntity::GetTimeCreated()
{
    const char* fmtQuery = "SELECT UNIX_TIMESTAMP(timecreated) FROM chars WHERE charid = %u;";

    int32 ret = Sql_Query(SqlHandle, fmtQuery, id);

    if (ret != SQL_ERROR &&
        Sql_NumRows(SqlHandle) != 0 &&
        Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        return Sql_GetIntData(SqlHandle, 0);
    }
    
    return 0;
}

bool CCharEntity::hasMoghancement(uint16 moghancementID)
{
    return m_moghancementID == moghancementID;
}

void CCharEntity::UpdateMoghancement()
{
    // Add up all of the installed furniture auras
    std::array<uint16, 8> elements = { 0 };
    for (auto containerID : {LOC_MOGSAFE, LOC_MOGSAFE2})
    {
        CItemContainer* PContainer = getStorage(containerID);
        for (int slotID = 1; slotID <= PContainer->GetSize(); ++slotID)
        {
            CItem* PItem = PContainer->GetItem(slotID);
            if (PItem != nullptr && PItem->isType(ITEM_FURNISHING))
            {
                CItemFurnishing* PFurniture = static_cast<CItemFurnishing*>(PItem);
                if (PFurniture->isInstalled())
                {
                    elements[PFurniture->getElement() - 1] += PFurniture->getAura();
                }
            }
        }
    }

    // Determine the dominant aura
    uint8 dominantElement = 0;
    uint16 dominantAura = 0;
    bool hasTiedElements = false;
    for (uint8 elementID = 1; elementID < 9; ++elementID)
    {
        uint16 aura = elements[elementID - 1];
        if (aura > dominantAura)
        {
            dominantElement = elementID;
            dominantAura = aura;
            hasTiedElements = false;
        }
        else if (aura == dominantAura)
        {
            hasTiedElements = true;
        }
    }

    // Determine which moghancement to use from the dominant element
    uint8 bestAura = 0;
    uint8 bestOrder = 255;
    uint16 newMoghancementID = 0;
    if (!hasTiedElements && dominantAura > 0)
    {
        for (auto containerID : { LOC_MOGSAFE, LOC_MOGSAFE2 })
        {
            CItemContainer* PContainer = getStorage(containerID);
            for (int slotID = 1; slotID <= PContainer->GetSize(); ++slotID)
            {
                CItem* PItem = PContainer->GetItem(slotID);
                if (PItem != nullptr && PItem->isType(ITEM_FURNISHING))
                {
                    CItemFurnishing* PFurniture = static_cast<CItemFurnishing*>(PItem);
                    // If aura is tied then use whichever furniture was placed most recently
                    if (PFurniture->isInstalled() &&
                        PFurniture->getElement() == dominantElement &&
                        (PFurniture->getAura() > bestAura || (PFurniture->getAura() == bestAura && PFurniture->getOrder() < bestOrder)))
                    {
                        bestAura = PFurniture->getAura();
                        bestOrder = PFurniture->getOrder();
                        newMoghancementID = PFurniture->getMoghancement();
                    }
                }
            }
        }
    }

    // Always show which moghancement the player has if they have one at all
    if (newMoghancementID != 0)
    {
        pushPacket(new CMessageSpecialPacket(this, luautils::GetTextIDVariable(getZone(), "KEYITEM_OBTAINED"), newMoghancementID, 0, 0, 0, 0));
    }

    if (newMoghancementID != m_moghancementID)
    {
        // Remove the previous moghancement
        if (m_moghancementID != 0)
            charutils::delKeyItem(this, m_moghancementID);

        // Add the new moghancement
        if (newMoghancementID != 0)
            charutils::addKeyItem(this, newMoghancementID);

        // Send only one key item packet if they are in the same key item table
        uint8 newTable = newMoghancementID >> 9;
        uint8 currentTable = m_moghancementID >> 9;
        if (newTable == currentTable)
        {
            pushPacket(new CKeyItemsPacket(this, (KEYS_TABLE)newTable));
        }
        else
        {
            if (newTable != 0)
                pushPacket(new CKeyItemsPacket(this, (KEYS_TABLE)newTable));
            if (currentTable != 0)
                pushPacket(new CKeyItemsPacket(this, (KEYS_TABLE)currentTable));
        }
        charutils::SaveKeyItems(this);

        SetMoghancement(newMoghancementID);
        charutils::SaveCharMoghancement(this);
    }
}

void CCharEntity::SetMoghancement(uint16 moghancementID)
{
    m_moghancementID = moghancementID;

    // Apply the moghancement
    if (m_moghancementID != 0)
    {
        switch (m_moghancementID)
        {
            case MOGHANCEMENT_FIRE:
                addModifier(Mod::SYNTH_FAIL_RATE_FIRE, 5);
                break;
            case MOGHANCEMENT_ICE:
                addModifier(Mod::SYNTH_FAIL_RATE_ICE, 5);
                break;
            case MOGHANCEMENT_WIND:
                addModifier(Mod::SYNTH_FAIL_RATE_WIND, 5);
                break;
            case MOGHANCEMENT_EARTH:
                addModifier(Mod::SYNTH_FAIL_RATE_EARTH, 5);
                break;
            case MOGHANCEMENT_LIGHTNING:
                addModifier(Mod::SYNTH_FAIL_RATE_LIGHTNING, 5);
                break;
            case MOGHANCEMENT_WATER:
                addModifier(Mod::SYNTH_FAIL_RATE_WATER, 5);
                break;
            case MOGHANCEMENT_LIGHT:
                addModifier(Mod::SYNTH_FAIL_RATE_LIGHT, 5);
                break;
            case MOGHANCEMENT_DARK:
                addModifier(Mod::SYNTH_FAIL_RATE_DARK, 5);
                break;

            case MOGHANCEMENT_FISHING:
                addModifier(Mod::FISH, 1);
                break;
            case MOGHANCEMENT_WOODWORKING:
                addModifier(Mod::WOOD, 1);
                break;
            case MOGHANCEMENT_SMITHING:
                addModifier(Mod::SMITH, 1);
                break;
            case MOGHANCEMENT_GOLDSMITHING:
                addModifier(Mod::GOLDSMITH, 1);
                break;
            case MOGHANCEMENT_CLOTHCRAFT:
                addModifier(Mod::CLOTH, 1);
                break;
            case MOGHANCEMENT_LEATHERCRAFT:
                addModifier(Mod::LEATHER, 1);
                break;
            case MOGHANCEMENT_BONECRAFT:
                addModifier(Mod::BONE, 1);
                break;
            case MOGHANCEMENT_ALCHEMY:
                addModifier(Mod::ALCHEMY, 1);
                break;
            case MOGHANCEMENT_COOKING:
                addModifier(Mod::COOK, 1);
                break;

            case MOGLIFICATION_FISHING:
                addModifier(Mod::FISH, 1);
                // TODO: "makes it slightly easier to reel in your catch"
                break;
            case MOGLIFICATION_WOODWORKING:
                addModifier(Mod::WOOD, 1);
                break;
            case MOGLIFICATION_SMITHING:
                addModifier(Mod::SMITH, 1);
                break;
            case MOGLIFICATION_GOLDSMITHING:
                addModifier(Mod::GOLDSMITH, 1);
                break;
            case MOGLIFICATION_CLOTHCRAFT:
                addModifier(Mod::CLOTH, 1);
                break;
            case MOGLIFICATION_LEATHERCRAFT:
                addModifier(Mod::LEATHER, 1);
                break;
            case MOGLIFICATION_BONECRAFT:
                addModifier(Mod::BONE, 1);
                break;
            case MOGLIFICATION_ALCHEMY:
                addModifier(Mod::ALCHEMY, 1);
                break;
            case MOGLIFICATION_COOKING:
                addModifier(Mod::COOK, 1);
                break;

            case MEGA_MOGLIFICATION_FISHING:
                addModifier(Mod::FISH, 5);
                break;
            case MEGA_MOGLIFICATION_WOODWORKING:
                addModifier(Mod::WOOD, 5);
                addModifier(Mod::SYNTH_FAIL_RATE_WOOD, 5);
                break;
            case MEGA_MOGLIFICATION_SMITHING:
                addModifier(Mod::SMITH, 5);
                addModifier(Mod::SYNTH_FAIL_RATE_SMITH, 5);
                break;
            case MEGA_MOGLIFICATION_GOLDSMITHING:
                addModifier(Mod::GOLDSMITH, 5);
                addModifier(Mod::SYNTH_FAIL_RATE_GOLDSMITH, 5);
                break;
            case MEGA_MOGLIFICATION_CLOTHCRAFT:
                addModifier(Mod::CLOTH, 5);
                addModifier(Mod::SYNTH_FAIL_RATE_CLOTH, 5);
                break;
            case MEGA_MOGLIFICATION_LEATHERCRAFT:
                addModifier(Mod::LEATHER, 5);
                addModifier(Mod::SYNTH_FAIL_RATE_LEATHER, 5);
                break;
            case MEGA_MOGLIFICATION_BONECRAFT:
                addModifier(Mod::BONE, 5);
                addModifier(Mod::SYNTH_FAIL_RATE_BONE, 5);
                break;
            case MEGA_MOGLIFICATION_ALCHEMY:
                addModifier(Mod::ALCHEMY, 5);
                addModifier(Mod::SYNTH_FAIL_RATE_ALCHEMY, 5);
                break;
            case MEGA_MOGLIFICATION_COOKING:
                addModifier(Mod::COOK, 5);
                addModifier(Mod::SYNTH_FAIL_RATE_COOK, 5);
                break;

            case MOGHANCEMENT_EXPERIENCE:
                addModifier(Mod::EXPERIENCE_RETAINED, 5);
                break;
            case MOGHANCEMENT_GARDENING:
                addModifier(Mod::GARDENING_WILT_BONUS, 36);
                break;
            case MOGHANCEMENT_DESYNTHESIS:
                addModifier(Mod::DESYNTH_SUCCESS, 2);
                break;
            case MOGHANCEMENT_CONQUEST:
                addModifier(Mod::CONQUEST_BONUS, 6);
                break;
            case MOGHANCEMENT_REGION:
                addModifier(Mod::CONQUEST_REGION_BONUS, 10);
                break;
            case MOGHANCEMENT_FISHING_ITEM:
                // TODO: Increases the chances of finding items when fishing
                break;
            case MOGHANCEMENT_SANDORIA_CONQUEST:
                if (profile.nation == 0)
                    addModifier(Mod::CONQUEST_BONUS, 6);
                break;
            case MOGHANCEMENT_BASTOK_CONQUEST:
                if (profile.nation == 1)
                    addModifier(Mod::CONQUEST_BONUS, 6);
                break;
            case MOGHANCEMENT_WINDURST_CONQUEST:
                if (profile.nation == 2)
                    addModifier(Mod::CONQUEST_BONUS, 6);
                break;
            case MOGHANCEMENT_MONEY:
                addModifier(Mod::GILFINDER, 10);
                break;
            case MOGHANCEMENT_CAMPAIGN:
                addModifier(Mod::CAMPAIGN_BONUS, 5);
                break;
            case MOGHANCEMENT_MONEY_II:
                addModifier(Mod::GILFINDER, 15);
                break;
            case MOGHANCEMENT_SKILL_GAINS:
                // NOTE: Exact value is unknown but considering this only granted by a newish item it makes sense SE made it fairly strong
                addModifier(Mod::COMBAT_SKILLUP_RATE, 25);
                addModifier(Mod::MAGIC_SKILLUP_RATE, 25);
                break;
            case MOGHANCEMENT_BOUNTY:
                addModifier(Mod::EXP_BONUS, 10);
                addModifier(Mod::CAPACITY_BONUS, 10);
                break;
            case MOGLIFICATION_EXPERIENCE_BOOST:
                addModifier(Mod::EXP_BONUS, 15);
                break;
            case MOGLIFICATION_CAPACITY_BOOST:
                addModifier(Mod::CAPACITY_BONUS, 15);
                break;

            // NOTE: Exact values for resistances is unknown
            case MOGLIFICATION_RESIST_POISON:
                addModifier(Mod::POISONRESTRAIT, 10);
                break;
            case MOGLIFICATION_RESIST_PARALYSIS:
                addModifier(Mod::PARALYZERESTRAIT, 10);
                break;
            case MOGLIFICATION_RESIST_SILENCE:
                addModifier(Mod::SILENCERESTRAIT, 10);
                break;
            case MOGLIFICATION_RESIST_PETRIFICATION:
                addModifier(Mod::PETRIFYRESTRAIT, 10);
                break;
            case MOGLIFICATION_RESIST_VIRUS:
                addModifier(Mod::VIRUSRESTRAIT, 10);
                break;
            case MOGLIFICATION_RESIST_CURSE:
                addModifier(Mod::CURSERESTRAIT, 10);
                break;
            default:
                break;
        }
    }
}

void CCharEntity::TrackArrowUsageForScavenge(CItemWeapon* PAmmo)
{
    // Check if local has been set yet
    if (this->GetLocalVar("ArrowsUsed") == 0)
    {
        // Local not set yet so set
        this->SetLocalVar("ArrowsUsed", PAmmo->getID() * 10000 + 1);
    }
    else
    {
        // Local exists now check if arrow used is same as last time
        if ((floor(this->GetLocalVar("ArrowsUsed") / 10000)) == PAmmo->getID())
        {
            // Same arrow used as last time now check that arrows used do not go above 1980
            if (!(floor(this->GetLocalVar("ArrowsUsed") % 10000) >= 1980))
            {
                // Safe to increment arrows used
                this->SetLocalVar("ArrowsUsed", this->GetLocalVar("ArrowsUsed") + 1);
            }
        }
        else
        {
            // Different arrow is being used so remake local
            this->SetLocalVar("ArrowsUsed", PAmmo->getID() * 10000 + 1);
        }
    }
}

bool CCharEntity::OnAttackError(CAttackState& state)
{
    auto controller {static_cast<CPlayerController*>(PAI->GetController())};
    if (controller->getLastErrMsgTime() + std::chrono::milliseconds(this->GetWeaponDelay(false)) < PAI->getTick())
    {
        controller->setLastErrMsgTime(PAI->getTick());
        return true;
    }
    return false;
}

void CCharEntity::clearCharVarsWithPrefix(std::string const& prefix)
{
    if (prefix.size() < 5)
    {
        ShowError("Prefix too short to clear with: '%s'", prefix);
        return;
    }

    auto iter = charVarCache.begin();
    while (iter != charVarCache.end())
    {
        if (iter->first.rfind(prefix, 0) == 0)
        {
            iter->second = 0;
        }
        ++iter;
    }

    Sql_Query(SqlHandle, "DELETE FROM char_vars WHERE charid = %u AND varname LIKE '%s%%';", this->id, prefix.c_str());
}