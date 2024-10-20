﻿/*
===========================================================================

    Copyright (c) 2020 Project Topaz

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

    ---

    ADDITIONAL RESTRICTIONS PERTAINING TO ATTRIBUTION AND MISREPRESENTATION
    APPLY TO THIS SOFTWARE.

    ADDITIONAL PERMISSIONS MAY APPLY TO THIS SOFTWARE.

    You should have received a full copy of these additional terms included
    in a license along with this program. If not, see:
    <http://project-topaz.com/blob/release/LICENSE>

===========================================================================
*/

#ifndef _GAMBITSCONTAINER
#define _GAMBITSCONTAINER

#include "../../../common/cbasetypes.h"
#include "../../entities/charentity.h"
#include "../../entities/trustentity.h"
#include "../ai_container.h"
#include "../controllers/trust_controller.h"
#include "../../mob_spell_container.h"
#include "../../status_effect.h"
#include "../../status_effect_container.h"

#include <set>

namespace gambits
{

enum class G_TARGET : uint16
{
    SELF            = 0,
    PARTY           = 1,
    TARGET          = 2,
    MASTER          = 3,
    TANK            = 4,
    MELEE           = 5,
    RANGED          = 6,
    CASTER          = 7,
    TOP_ENMITY      = 8,
    CURILLA         = 9, // Special case for Rainemard
    PARTY_DEAD      = 10,
    PARTY_MULTI     = 11,
    CASTS_SPELLS    = 12,
};

enum class G_CONDITION : uint16
{
    ALWAYS             = 0,
    HPP_LT             = 1,
    HPP_GTE            = 2,
    MPP_LT             = 3,
    TP_LT              = 4,
    TP_GTE             = 5,
    STATUS             = 6,
    NOT_STATUS         = 7,
    STATUS_FLAG        = 8,
    HAS_TOP_ENMITY     = 9,
    NOT_HAS_TOP_ENMITY = 10,
    SC_AVAILABLE       = 11,
    NOT_SC_AVAILABLE   = 12,
    MB_AVAILABLE       = 13,
    READYING_WS        = 14,
    READYING_MS        = 15,
    READYING_JA        = 16,
    CASTING_MA         = 17,
    RANDOM             = 18,
    NO_SAMBA           = 19,
    NO_STORM           = 20,
    PT_HAS_TANK        = 21,
    NOT_PT_HAS_TANK    = 22,
    IS_ECOSYSTEM       = 23,
    HP_MISSING         = 24,
    RESISTS_DMGTYPE    = 25,
    PT_HAS_WHM         = 26,
    CAN_SNEAK_ATTACK   = 27,
    WITH_WS            = 28, // TODO
    PROTECTRA          = 29,
    SHELLRA            = 30,
    DETECT_MIJIN       = 31,
    CASTING_SPECIFIC   = 32,
    CAN_DRAIN          = 33, // Arg is MP% to cast
    CAN_ASPIR          = 34, // Arg is MP% to cast
    REFRESH            = 35,
};

enum class G_REACTION : uint16
{
    ATTACK  = 0,
    RATTACK = 1,
    MA      = 2,
    JA      = 3,
    WS      = 4,
    MS      = 5,
    MSG     = 6,
};

enum class G_SELECT : uint16
{
    HIGHEST                 = 0,
    LOWEST                  = 1,
    SPECIFIC                = 2,
    RANDOM                  = 3,
    MB_ELEMENT              = 4,
    SPECIAL_AYAME           = 5,
    BEST_AGAINST_TARGET     = 6,
    BEST_SAMBA              = 7,
    HIGHEST_WALTZ           = 8,
    ENTRUSTED               = 9,
    BEST_INDI               = 10,
    STORM_DAY               = 11,
    HELIX_DAY               = 12,
    STORM_WEAKNESS          = 13,
    HELIX_WEAKNESS          = 14,
    LOWEST_WALTZ            = 15,
};

enum class G_TP_TRIGGER : uint16
{
    ASAP            = 0,
    RANDOM          = 1,
    OPENER          = 2,
    CLOSER          = 3,
    CLOSER_UNTIL_TP = 4,
};

struct Predicate_t
{
    G_TARGET target;
    G_CONDITION condition;
    uint32 condition_arg = 0;

    bool parseInput(std::string key, uint32 value)
    {
        if (key.compare("target") == 0)
        {
            target = static_cast<G_TARGET>(value);
        }
        else if (key.compare("condition") == 0)
        {
            condition = static_cast<G_CONDITION>(value);
        }
        else if (key.compare("argument") == 0)
        {
            condition_arg = value;
        }
        else
        {
            // TODO: Log error
            return false;
        }
        return true;
    }
};

struct Action_t
{
    G_REACTION reaction;
    G_SELECT select;
    uint32 select_arg = 0;

    bool parseInput(std::string key, uint32 value)
    {
        if (key.compare("reaction") == 0)
        {
            reaction = static_cast<G_REACTION>(value);
        }
        else if (key.compare("select") == 0)
        {
            select = static_cast<G_SELECT>(value);
        }
        else if (key.compare("argument") == 0)
        {
            select_arg = value;
        }
        else
        {
            // TODO: Log error
            return false;
        }
        return true;
    }
};

struct Gambit_t
{
    std::vector<Predicate_t> predicates;
    std::vector<Action_t> actions;
    uint16 retry_delay = 0;
    time_point last_used;
};

// TODO
struct Chain_t
{
    std::vector<Gambit_t> gambits;
};

// TODO: smaller types, make less bad.
struct TrustSkill_t
{
    G_REACTION skill_type;
    uint32 skill_id;
    uint8 primary;
    uint8 secondary;
    uint8 tertiary;
};

class CGambitsContainer
{
public:
    CGambitsContainer(CTrustEntity* trust)
        : POwner(trust)
    {
    }
    ~CGambitsContainer() = default;

    void AddGambit(Gambit_t gambit);
    void Tick(time_point tick);

    // TODO: make private
    std::vector<TrustSkill_t> tp_skills;
    G_TP_TRIGGER tp_trigger;
    G_SELECT tp_select;
    uint16 tp_value;

private:
    bool CheckTrigger(CBattleEntity* trigger_target, Predicate_t& predicate);
    bool TryTrustSkill();
    bool PartyHasHealer();
    bool PartyHasTank();
    bool PartyHasWHM();
    bool ShouldProtectra();
    bool ShouldShellra();
    bool CanSneakAttack();
    bool IsStunImmune(CBattleEntity* trigger_target);
    bool HasSpells(CBattleEntity* PEntity);
    CTrustEntity* POwner;
    time_point m_lastAction;
    std::vector<Gambit_t> gambits;

    std::set<JOBTYPE> melee_jobs =
    {
        JOB_WAR,
        JOB_MNK,
        JOB_THF,
        JOB_PLD,
        JOB_DRK,
        JOB_BST,
        JOB_SAM,
        JOB_NIN,
        JOB_DRG,
        JOB_BLU,
        JOB_PUP,
        JOB_DNC,
        JOB_RUN,
    };

    std::set<JOBTYPE> caster_jobs =
    {
        JOB_WHM,
        JOB_BLM,
        JOB_RDM,
        JOB_SMN,
        JOB_SCH,
        JOB_GEO,
    };
};

} // namespace gambits

#endif // _GAMBITSCONTAINER
