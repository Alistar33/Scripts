 integer chan;
 integer gListener;
 integer timeout;
 integer offset = 110; 
 
 // copy your discord webhook url and use it here.
 string  webhook_url    = "https://discord.com/api/webhooks/xxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"; 
 string  sound          = "cc5bd489-5b9d-136e-8b74-bc614415d5d3"; 
 string  objName;
 string  region;
 string  name;  
 string  ampm;
 string  Dname; 
 string  time;
 string  picUrl; 
 
 key     obj; 
 key     id;
 list    details;
 vector  slurl_vector;

 
 // to change the image, choose one from your inv, right click &
 // choose "copy asset UUID"
 string image_UUID = "c8a209f0-6063-b4af-2886-7914494844c2";
 
 
string slurl(key AvatarID)
{
    string regionname = llGetRegionName();
    vector pos = llList2Vector(llGetObjectDetails(AvatarID, [ OBJECT_POS ]), 0); 
    return "http://maps.secondlife.com/secondlife/"
        + llEscapeURL(regionname) + "/"
        + (string)llRound(pos.x)  + "/"
        + (string)llRound(pos.y)  + "/"
        + (string)llRound(pos.z)  + "/";
}

key PostToDiscord(key AvatarID, string Message)
{ 
    string user_name = llGetUsername(AvatarID);
    string SLURL     = slurl(AvatarID);
    string user      = llKey2Name( AvatarID );
    list   json      = [      
        "embeds", 
            llList2Json(JSON_ARRAY,
            [
                    llList2Json(JSON_OBJECT,
                    [
                            "color", "100000",
                            "title", user + "'s Location ( click for SLURL )",
                            "url", SLURL,
                            "description",  "\n" + user_name + "'s Profile: http://my.secondlife.com/" +
                             llGetUsername(AvatarID) +  "\nMessage from " + user_name + ": \n \n" + Message + "\n \n.",
                           
                            "author", llList2Json(JSON_OBJECT, 
                            [ 
                                "name",  user,
                                "icon_url", "https://my-secondlife-agni.akamaized.net/users/" +
                                 llGetUsername(AvatarID) + "/sl_image.png"                               
                            ]),
                            "footer", llList2Json(JSON_OBJECT, 
                            [ 
                                "icon_url", picUrl,
                                "text", "Discord Embedder"
                            ]),
                            "image", llList2Json(JSON_OBJECT,
                            [
                                "url",  "https://my-secondlife-agni.akamaized.net/users/" +
                                         llGetUsername(AvatarID) + "/sl_image.png" 
                            ]),                
                            "thumbnail", llList2Json(JSON_OBJECT,
                            [
                                "url",  picUrl
                            ])                                            
                     ]) 
            ])
    ]; 
    return llHTTPRequest( webhook_url ,
      [ HTTP_METHOD, "POST", 
        HTTP_MIMETYPE, "application/json",
        HTTP_VERIFY_CERT,TRUE,
        HTTP_VERBOSE_THROTTLE, TRUE,
        HTTP_PRAGMA_NO_CACHE, TRUE ],
        llList2Json(JSON_OBJECT, json));
}

string ConvertWallclockToTime()
{   ampm = "AM";
    integer now     = (integer)llGetWallclock();
    integer seconds = now % 60;
    integer minutes = (now / 60) % 60;
    integer hours   = now / 3600;
    if (hours > 12)
      { hours -=  12;
        ampm   = "PM";
      }
    return llGetSubString("0" + (string)hours,   -2, -1) + ":" 
         + llGetSubString("0" + (string)minutes, -2, -1) + ":" 
         + llGetSubString("0" + (string)seconds, -2, -1) + " " + ampm;
}

default
{
    state_entry()
    {  region = llEscapeURL( llGetRegionName() );        
       obj    = llGetKey();  
       chan   = 0x80000000 | (integer)("0x"+(string)llGetOwner() );    
       chan  += offset;  
       picUrl = "http://secondlife.com/app/image/" + image_UUID + "/2";  
    }
    on_rez(integer start_param)
    {  llResetScript(); 
    }
    touch_start(integer total_number)
    { 
       id                 = llDetectedKey(0); 
       integer sameGroup  = llSameGroup(id);
       gListener          = llListen( chan, "", "", "");     
       llTextBox( llDetectedKey(0), "\n \nMessage to send to Discord...\n \n", chan);  
    } 
    listen(integer channel, string name, key id, string message)
    {  llListenRemove(gListener);     
       PostToDiscord( id, message ); 
       llPlaySound( sound , 0.25);       
       llRegionSayTo( id, 0, "\nMessage has been sent to your Discord Server....");
    }   
    http_response(key request_id, integer status, list metadata, string body)
    { 
    }
    timer()
    {      
    }    
}
