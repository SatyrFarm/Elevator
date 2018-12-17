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
integer channel = -84242;

default
{
    touch_start(integer n)
    {
        
        channel = -84242 + (integer)llGetObjectDesc();

        llSay(channel, (string)llGetLinkName(llDetectedLinkNumber(0)));
        llSay(0, "Please wait for elevator");
        integer i=6;
        while (i-->0)
        {
            llSetLinkColor(llDetectedLinkNumber(0), <.8,.1,.1>, ALL_SIDES);
            llSleep(.7);
            llSetLinkColor( llDetectedLinkNumber(0) ,<0.000, 0.502, 0.000>, ALL_SIDES);
            
            llSleep(.7);
        }
    }
}
