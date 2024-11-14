key requestID;
integer handle;
integer channel;
string currentsim;
string query_string;
key uuid;
list buttons = ["Insert","Close"];
integer gListener;
string dialogInfo = "\nPlease make your choice.";
key ToucherID;
integer dialogChannel;
integer listenHandle;
string username;

ShowMap(key avatar) {

   string url = "http://map.secondlife.com/";
   vector sim_coord = llGetRegionCorner();
   string x = (string)((integer)(sim_coord.x / 256.0));
   string y = (string)((integer)(sim_coord.y / 256.0));
   url += "map-1-" + x + "-" + y + "-objects.jpg";
   llLoadURL(avatar, "View the sim map", url);
}

default
{

    state_entry()
    {
       llWhisper(0, "Board ready!");
     dialogChannel = -1 - (integer)("0x" + llGetSubString( (string)llGetKey(), -7, -1) ); 
      llSetText("Click me!\nSecond Life Region Map UUID",<1.0,1.0,1.0>,1.0);
    }

    touch_start(integer num_detected)
    {
        uuid = llDetectedKey(0);
        username = llDetectedName(0);

        ToucherID = llDetectedKey(0);
        listenHandle = llListen(dialogChannel, "", ToucherID, "");
        llDialog(ToucherID, dialogInfo, buttons, dialogChannel);
    }
    
    listen(integer channel, string name, key id, string message)
    { 
        if (message == "Close") 
                {
            state default;
        }
                llListenRemove(listenHandle);
        //  stop timer since the menu was clicked
        llSetTimerEvent(0);
        if (message == "Insert") {
            state region;
             }
        }

}


state region  
 {

 state_entry()
    {
     //use channel 87 for listening
     llSetTimerEvent(20.0);
      llSetText("Board in use, please wait 20 seconds.",<1.0,1.0,1.0>,1.0);
     channel=87;
      gListener = llListen( channel, "", "", "");
     llTextBox(uuid, "Insert name of the Region ", channel);
    }
 
  listen(integer channel, string name, key id, string message)
    {   
         llInstantMessage(uuid, "You chose " + message + " Region ");
        currentsim=message;
      
       /*urlencode region name and create the query string
       &item=objects_uuid requests the object map layer
       &item=terrain_uuid requests the terrain map layer
       */
       query_string="region=" + llEscapeURL(message) + "&item=objects_uuid";

       //send the request to api.gridsurvey.com
       requestID = llHTTPRequest("https://api.gridsurvey.com/simquery.php",[HTTP_METHOD, "POST",HTTP_MIMETYPE,"application/x-www-form-urlencoded"], query_string);


      }  
    http_response(key req_id, integer status, list meta, string body)
    {
        if (req_id == requestID)
        {
            if(llGetSubString(body, 0, 4)=="Error") {
               //the api returned an error so report it
               llInstantMessage(uuid,body);
                  state default;
             //  llSay(0,body);
            } else {
               //set the prim texture
              llSetTexture(body, ALL_SIDES);
              llInstantMessage(uuid, "Current Region Map UUID for "+ currentsim + " is "+ body);
               ShowMap(uuid);
             // llSay(0,"Current Region Map UUID for "+ currentsim + " is "+ body);
            }

        }
        else
        {
            llSay(0,"Error: " + (string)status);
               state default;
         }
          state default;
    }
    
   timer()
    {
    //  stop timer
        llSetTimerEvent(0);
        llWhisper(0, "Board restarting.");
        state default;
    }

}
