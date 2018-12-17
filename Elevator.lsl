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
integer run = 0;
vector initPos;
list heights  = [30];



integer channel;


integer listener=-1;
integer listenTs;

startListen()
{
    if (listener<0) 
    {
        //listener = llListen(chan(llGetKey()), "", "", "");
        listenTs = llGetUnixTime();
    }
}

checkListen()
{
    if (listener > 0 && llGetUnixTime() - listenTs > 200)
    {
        llListenRemove(listener);
        listener = -1;
    }
}


menu(key id)
{
        heights = llParseString2List(llGetObjectDesc(), [",", " "], []);
        list opts  = [];
        integer i;
        while (i <llGetListLength(heights)) opts += (string)i++;
        llDialog(id,  "Select floor", opts, channel);

}



default
{
    state_entry()
    {
        channel = -84242 + (integer)llGetObjectDesc();
        initPos = llGetPos();
        listener = llListen(channel, "", "", "");
    }
    
    touch_start(integer n)
    {
        menu(llDetectedKey(0));
    }
    
    
    listen (integer c, string nm, key kk, string m)
    {
        if (m == "CLOSE" ) return;
        list kf;
        vector pos = llGetPos();
        llSetKeyframedMotion( [], []);       
        
        float height = llList2Float(heights, (integer)(m));
        vector v = pos;
        
        kf += <0,0,height - pos.z>;
        kf += llFabs(height-pos.z)/2.5;   
        llSetRegionPos(pos);
        llSetKeyframedMotion( kf, [KFM_DATA, KFM_TRANSLATION, KFM_MODE, KFM_FORWARD]);
        
    }
    
    timer()
    {
        checkListen();
        llSetTimerEvent(0);
    }
    
    link_message(integer l, integer n, string s, key id)
    {
        menu(id);
    }
}
