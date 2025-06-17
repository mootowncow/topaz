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

#include "event_handler.h"

CAIEventHandler::~CAIEventHandler()
{
    eventListeners.clear();
}


void CAIEventHandler::addListener(std::string eventname, int lua_func, std::string identifier)
{
    // Make sure the listener doesn't already exist
    if (!listenerExists(identifier))
    {
        eventListeners[eventname].emplace_back(identifier, lua_func);
    }
}


void CAIEventHandler::removeListener(std::string identifier)
{
    for (auto&& eventListener : eventListeners)
    {
        eventListener.second.erase(std::remove_if(eventListener.second.begin(), eventListener.second.end(), [&identifier](const ai_event_t& event)
        {
            if (identifier == event.identifier)
            {
                if (event.lua_func)
                {
                    luautils::unregister_fp(event.lua_func);
                }
                return true;
            }
            return false;
        }), eventListener.second.end());
    }
}


bool CAIEventHandler::listenerExists(const std::string& identifier)
{
    for (const auto& eventListener : eventListeners)
    {
        for (const auto& event : eventListener.second)
        {
            if (event.identifier == identifier)
            {
                return true; // Listener with this identifier already exists
            }
        }
    }
    return false;
}
