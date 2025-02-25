//Add this script inside your rezzer with your item that you want to give to group members

key ToucherID;

string known_group_key = "ADD YOUR GROUP KEY HERE";

default
{
    state_entry()
    {
        // text above the rezzer object
        llSetText("WRITE SOME TEXT HERE AND YOU CAN CHANGE COLOURS",<1.0,1.0,1.0>,1.0);
    }

    touch_start(integer num_detected)
    {
       //When a resident click the rezzer, we check if he's wearing the group
        ToucherID = llDetectedKey(0);
         if(llList2String(llGetObjectDetails(llList2Key(llGetAttachedList(llDetectedKey(0)), 0), [OBJECT_GROUP]), 0) == known_group_key)   {
    llGiveInventory(ToucherID, llGetInventoryName(INVENTORY_OBJECT, 0) );
          }

       else
        {
            // we say in region chat to take and wear the group
            llSay(0, "This object is for Group Members\nJoin this group / Wear your group tag\nPASTE YOUR ID GROUP URI HERE!");
        }
    }



}
