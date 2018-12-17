/*
OSW Elevator
    Copyright (C) 2019 OpenSimWorld and contributors

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/
vector COLOR = <1.0,1.0,1.0>;
float ALPHA_ON = .5;
float ALPHA_OFF = 0.0;
string TITLE="";
 
show(){
    //visible = TRUE;
    llSetText("", COLOR,ALPHA_ON);        
    llSetAlpha(ALPHA_ON, ALL_SIDES);
}
 
hide(){
//    visible = FALSE;
    llSetText("", COLOR,ALPHA_ON);        
    llSetAlpha(ALPHA_OFF, ALL_SIDES);
}
 

startAnimation()
{
    string name = llGetInventoryName(INVENTORY_ANIMATION, 0);
    hide();
    llStopAnimation("sit"); // Stop the default animation
    llStartAnimation(name); // and start the new one
}

stopAnimation()
{
    string name = llGetInventoryName(INVENTORY_ANIMATION, 0);
    show();
    llStopAnimation(name); // Stop the animation
}

default
{
    state_entry()
    {
        llSitTarget(<0.0, 0.0, 0.1>, ZERO_ROTATION);
    }
    
    changed(integer change)
    {
        TITLE = llGetObjectName();
        if (change & CHANGED_LINK)
        {

            if (llGetInventoryNumber(INVENTORY_ANIMATION)) // If there is at least one animation in the inventory
            {
                key who = llAvatarOnSitTarget();
              
                integer perm = llGetPermissions();
                if (who!= NULL_KEY) // If someone sits down, animate the avatar
                {
                      llMessageLinked(LINK_ROOT, 1, "SIT", who);
                    if ( (perm & PERMISSION_TRIGGER_ANIMATION) &&
                         (who == llGetPermissionsKey())
                       ) startAnimation();
                    else
                        llRequestPermissions(who, PERMISSION_TRIGGER_ANIMATION);
                }
                else // If the person stands up and was playing the animation, stop the animation
                {
                    if (perm & PERMISSION_TRIGGER_ANIMATION)
                        stopAnimation();
                }
            }
        }
    }
    
    run_time_permissions(integer perm)
    {
        if (perm & PERMISSION_TRIGGER_ANIMATION) // If the permission is granted, start the animation
            startAnimation();
    }
}
