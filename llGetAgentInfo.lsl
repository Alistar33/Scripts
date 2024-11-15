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
                llSay(0,"AGENT_ATTACHMENTS started"); 
            } 
            else 
            { 
                llSay(0,"AGENT_ATTACHMENTS ended"); 
            } 
        }

        if (diffinfo & AGENT_AWAY)
        {
            if (info & AGENT_AWAY) 
            { 
                llSay(0,"AGENT_AWAY started"); 
            } 
            else 
            { 
                llSay(0,"AGENT_AWAY ended"); 
            } 
        } 

        if (diffinfo & AGENT_FLYING) 
        { 
            if (info & AGENT_FLYING) 
            { 
                llSay(0,"AGENT_FLYING started"); 
            } 
            else 
            { 
                llSay(0,"AGENT_FLYING ended"); 
            } 
        } 

         if (diffinfo & AGENT_HOVERING) 
        { 
            if (info & AGENT_HOVERING) 
            { 
                llSay(0,"AGENT_HOVERING started"); 
            } 
            else 
            { 
                llSay(0,"AGENT_HOVERING ended"); 
            } 
        } 

        if (diffinfo & AGENT_MOUSELOOK) 
        { 
            if (info & AGENT_MOUSELOOK) 
            { 
                llSay(0,"AGENT_MOUSELOOK started"); 
            } 
            else 
            { 
                llSay(0,"AGENT_MOUSELOOK ended"); 
            } 
        } 

        if (diffinfo & AGENT_WALKING) 
            { 
            if (info & AGENT_WALKING) 
            { 
                llSay(0,"AGENT_WALKING started"); 
            } 
            else 
            { 
                llSay(0,"AGENT_WALKING ended"); 
            } 
        } 

        if (diffinfo & AGENT_SCRIPTED) 
        { 
            if (info & AGENT_SCRIPTED) 
            { 
                llSay(0,"AGENT_SCRIPTED started"); 
            } 
            else 
            { 
                llSay(0,"AGENT_SCRIPTED ended"); 
            } 
        } 

        if (diffinfo & AGENT_SITTING) 
        { 
            if (info & AGENT_SITTING) 
            { 
                llSay(0,"AGENT_SITTING started"); 
            } 
            else 
            { 
                llSay(0,"AGENT_SITTING ended"); 
            } 
        } 

        if (diffinfo & AGENT_ON_OBJECT) 
        { 
            if (info & AGENT_ON_OBJECT) 
            { 
                llSay(0,"AGENT_ON_OBJECT started"); 
            } 
            else 
            { 
                llSay(0,"AGENT_ON_OBJECT ended"); 
            } 
        } 

        if (diffinfo & AGENT_IN_AIR) 
        { 
            if (info & AGENT_IN_AIR) 
            { 
                llSay(0,"AGENT_IN_AIR started"); 
            } 
            else 
            { 
                llSay(0,"AGENT_IN_AIR ended"); 
            } 
        } 

        if (diffinfo & AGENT_TYPING) 
        { 
            if (info & AGENT_TYPING) 
            { 
                llSay(0,"AGENT_TYPING started"); 
            } 
            else 
            { 
                llSay(0,"AGENT_TYPING ended"); 
            } 
        } 

        if (diffinfo & AGENT_CROUCHING) 
        { 
            if (info & AGENT_CROUCHING) 
            { 
                llSay(0,"AGENT_CROUCHING started"); 
            } 
            else 
            { 
                llSay(0,"AGENT_CROUCHING ended"); 
            } 
        } 

        if (diffinfo & AGENT_BUSY) 
        { 
            if (info & AGENT_BUSY) 
            { 
                llSay(0,"AGENT_BUSY started"); 
            } 
            else 
            { 
                llSay(0,"AGENT_BUSY ended"); 
            } 
        } 

        if (diffinfo & AGENT_ALWAYS_RUN) 
        { 
            if (info & AGENT_ALWAYS_RUN) 
            { 
                llSay(0,"AGENT_ALWAYS_RUN started"); 
            } 
            else 
            { 
                llSay(0,"AGENT_ALWAYS_RUN ended"); 
            } 
        } 
    } 
}
