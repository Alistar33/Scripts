integer info; 
integer lastinfo; 
integer diffinfo; 

default 
{ 
    state_entry() 
    { 
        llSetTimerEvent(0.1); 
    } 

    timer() 
    { 

        lastinfo = info; 
        info = llGetAgentInfo(llGetOwner()); 


        diffinfo = lastinfo ^ info; 


        if (diffinfo & AGENT_ATTACHMENTS) 
        { 
            if (info & AGENT_ATTACHMENTS) 
            { 
                llOwnerSay("AGENT_ATTACHMENTS started"); 
            } 
            else 
            { 
                llOwnerSay("AGENT_ATTACHMENTS ended"); 
            } 
        }

        if (diffinfo & AGENT_AWAY)
        {
            if (info & AGENT_AWAY) 
            { 
                llOwnerSay("AGENT_AWAY started"); 
            } 
            else 
            { 
                llOwnerSay("AGENT_AWAY ended"); 
            } 
        } 

        if (diffinfo & AGENT_FLYING) 
        { 
            if (info & AGENT_FLYING) 
            { 
                llOwnerSay("AGENT_FLYING started"); 
            } 
            else 
            { 
                llOwnerSay("AGENT_FLYING ended"); 
            } 
        } 
        
         if (diffinfo & AGENT_HOVERING) 
        { 
            if (info & AGENT_HOVERING) 
            { 
               llOwnerSay("AGENT_HOVERING started"); 
            } 
            else 
            { 
               llOwnerSay("AGENT_HOVERING ended"); 
            } 
        } 

        if (diffinfo & AGENT_MOUSELOOK) 
        { 
            if (info & AGENT_MOUSELOOK) 
            { 
                llOwnerSay("AGENT_MOUSELOOK started"); 
            } 
            else 
            { 
                llOwnerSay("AGENT_MOUSELOOK ended"); 
            } 
        } 

        if (diffinfo & AGENT_WALKING) 
            { 
            if (info & AGENT_WALKING) 
            { 
                llOwnerSay("AGENT_WALKING started"); 
            } 
            else 
            { 
                llOwnerSay("AGENT_WALKING ended"); 
            } 
        } 

        if (diffinfo & AGENT_SCRIPTED) 
        { 
            if (info & AGENT_SCRIPTED) 
            { 
                llOwnerSay("AGENT_SCRIPTED started"); 
            } 
            else 
            { 
                llOwnerSay("AGENT_SCRIPTED ended"); 
            } 
        } 

        if (diffinfo & AGENT_SITTING) 
        { 
            if (info & AGENT_SITTING) 
            { 
                llOwnerSay("AGENT_SITTING started"); 
            } 
            else 
            { 
                llOwnerSay("AGENT_SITTING ended"); 
            } 
        } 

        if (diffinfo & AGENT_ON_OBJECT) 
        { 
            if (info & AGENT_ON_OBJECT) 
            { 
                llOwnerSay("AGENT_ON_OBJECT started"); 
            } 
            else 
            { 
                llOwnerSay("AGENT_ON_OBJECT ended"); 
            } 
        } 

        if (diffinfo & AGENT_IN_AIR) 
        { 
            if (info & AGENT_IN_AIR) 
            { 
                llOwnerSay("AGENT_IN_AIR started"); 
            } 
            else 
            { 
                llOwnerSay("AGENT_IN_AIR ended"); 
            } 
        } 

        if (diffinfo & AGENT_TYPING) 
        { 
            if (info & AGENT_TYPING) 
            { 
                llOwnerSay("AGENT_TYPING started"); 
            } 
            else 
            { 
                llOwnerSay("AGENT_TYPING ended"); 
            } 
        } 

        if (diffinfo & AGENT_CROUCHING) 
        { 
            if (info & AGENT_CROUCHING) 
            { 
                llOwnerSay("AGENT_CROUCHING started"); 
            } 
            else 
            { 
                llOwnerSay("AGENT_CROUCHING ended"); 
            } 
        } 

        if (diffinfo & AGENT_BUSY) 
        { 
            if (info & AGENT_BUSY) 
            { 
                llOwnerSay("AGENT_BUSY started"); 
            } 
            else 
            { 
                llOwnerSay("AGENT_BUSY ended"); 
            } 
        } 

        if (diffinfo & AGENT_ALWAYS_RUN) 
        { 
            if (info & AGENT_ALWAYS_RUN) 
            { 
                llOwnerSay("AGENT_ALWAYS_RUN started"); 
            } 
            else 
            { 
                llOwnerSay("AGENT_ALWAYS_RUN ended"); 
            } 
        } 
    } 
}
