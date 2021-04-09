/*
	items.qc

	item functions

	Copyright (C) 1996-1997  Id Software, Inc.

	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

	See the GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to:

		Free Software Foundation, Inc.
		59 Temple Place - Suite 330
		Boston, MA  02111-1307, USA

*/
/* ALL LIGHTS SHOULD BE 0 1 0 IN COLOR ALL OTHER ITEMS SHOULD
BE .8 .3 .4 IN COLOR */

void() item_health              	= {remove(self);};
void() item_megahealth_rot      	= {remove(self);};
void() item_armor1              	= {remove(self);};
void() item_armor2              	= {remove(self);};
void() item_armorInv            	= {remove(self);};
void() item_shells              	= {remove(self);};
void() item_spikes              	= {remove(self);};
void() item_rockets             	= {remove(self);};
void() item_cells               	= {remove(self);};
void() item_key1               	 	= {remove(self);};
void() item_key2               		= {remove(self);};
void() item_artifact_invulnerability 	= {remove(self);};
void() item_artifact_envirosuit 	= {remove(self);};
void() item_artifact_invisibility 	= {remove(self);};
void() item_artifact_super_damage 	= {remove(self);};
void() item_weapon 			= {remove(self);};

void () GrenPackTouch = {

	if (other.classname != "player")
		return;
	if (other.health <= 0)
		return;
	if(other.role == ROLE_NONE)
		return;
   // if (other.button0)
    //    return;
	local string str = "you find";

	if(other.grencount < MAX_GRENCOUNT)
        {
		other.grencount = other.grencount + 1;
		other.ammo_nails = other.ammo_nails + 1;
		//sprint(other, PRINT_HIGH, "you found an extra grenade in backpack.\n");
		str = strcat(str," an extra grenade.");
		self.bubble_count = 1;
	}
		
	if(self.bubble_count >= 1)
	{
		FO_Sound(other, CHAN_ITEM, "beta1/pickup_gren.wav", 1, ATTN_NORM);
		stuffcmd(other, "bf\n");
		self.nextthink = time + 0.1;
		self.think = SUB_Remove;
		self.touch = SUB_Null;
		sprint(other, PRINT_HIGH, strcat(str,"\n"));
	}
};

void () HealthPack_Touch = {

	if (other.classname != "player")
		return;
	if (other.health <= 0)
		return;
	if(other.role == ROLE_NONE)
		return;
	
	local string str = "you gain";
	
	if(other.health < 100)
	{
		if(other.health + BACKPACK_HEAL > 100)
		{
			local float hpgain = 100 - other.health;
			str = strcat(str," ",ftos(hpgain)," health.");
			other.health = other.health + hpgain;
		}
		else
		{
			other.health = other.health + BACKPACK_HEAL;
			str = strcat(str," ",ftos(BACKPACK_HEAL)," health.");
		}
		self.bubble_count = 1;
	}
	
	if(self.bubble_count >= 1)
	{
		FO_Sound(other, CHAN_ITEM, "beta1/pickup_health.wav", 1, ATTN_NORM);
		stuffcmd(other, "bf\n");
		self.nextthink = time + 0.1;
		self.think = SUB_Remove;
		self.touch = SUB_Null;
		sprint(other, PRINT_HIGH, strcat(str,"\n"));
	}
};


void () ArmourShard_Touch = {

	if (other.classname != "player")
		return;
	if (other.health <= 0)
		return;
	if(other.role == ROLE_NONE)
		return;
		
	local string str = "you repair";
		
	local float maxarm = 0;
	if(other.role == ROLE_RECON)
		maxarm = ARMOUR_MAX_RECON;
	if(other.role == ROLE_ASSASSIN)
		maxarm = ARMOUR_MAX_ASSASSIN;
	if(other.role == ROLE_FIGHTER)
		maxarm = ARMOUR_MAX_FIGHTER;
	if(other.role == ROLE_BOMBER)
		maxarm = ARMOUR_MAX_BOMBER;
	if(other.role == ROLE_SUPPORT)
		maxarm = ARMOUR_MAX_SUPPORT;
	if(other.role == ROLE_MGUNNER)
		maxarm = ARMOUR_MAX_MGUNNER;
		
	if(other.armorvalue < maxarm)
	{
		if(other.armorvalue + BACKPACK_ARMOUR > maxarm)
		{
			local float armgain = maxarm - other.armorvalue;
			str = strcat(str," ",ftos(armgain)," armour.");
			other.armorvalue = other.armorvalue + armgain;
		}
		else
		{
			other.armorvalue = other.armorvalue + BACKPACK_ARMOUR;
			str = strcat(str," ",ftos(BACKPACK_ARMOUR)," armour.");
		}
		self.bubble_count = 1;
	}
	
	if(self.bubble_count >= 1)
	{
		FO_Sound(other, CHAN_ITEM, "beta1/pickup_armour.wav", 1, ATTN_NORM);
		stuffcmd(other, "bf\n");
		self.nextthink = time + 0.1;
		self.think = SUB_Remove;
		self.touch = SUB_Null;
		sprint(other, PRINT_HIGH, strcat(str,"\n"));
	}
};



void () DropArmourShard = {

    newmis = spawn();
    newmis.origin = self.origin - '0 0 24';

    newmis.velocity_z = 300;
    newmis.velocity_x = -100 + random() * 200;
    newmis.velocity_y = -100 + random() * 200;

    newmis.flags = FL_ITEM;
    newmis.solid = SOLID_TRIGGER;
    newmis.movetype = MOVETYPE_TOSS;
    FO_SetModel(newmis, "progs/beta1/mcp_armourshard.mdl", DIM_WORLD);
    setsize(newmis, '-16 -16 0', '16 16 56');
    newmis.touch = ArmourShard_Touch;
    newmis.classname = "armourshard";

    newmis.nextthink = time + LOOT_DURATION;
    newmis.think = SUB_Remove;
};

void () DropHealthPack = {

    newmis = spawn();
    newmis.origin = self.origin - '0 0 24';

    newmis.velocity_z = 300;
    newmis.velocity_x = -100 + random() * 200;
    newmis.velocity_y = -100 + random() * 200;

    newmis.flags = FL_ITEM;
    newmis.solid = SOLID_TRIGGER;
    newmis.movetype = MOVETYPE_TOSS;
    FO_SetModel(newmis, "progs/beta1/mcp_healthpack.mdl", DIM_WORLD);
    setsize(newmis, '-16 -16 0', '16 16 56');
    newmis.touch = HealthPack_Touch;
    newmis.classname = "healthpack";

    newmis.nextthink = time + LOOT_DURATION;
    newmis.think = SUB_Remove;
};



void () DropGrenPack = {

    newmis = spawn();
    newmis.origin = self.origin - '0 0 24';

    newmis.velocity_z = 300;
    newmis.velocity_x = -100 + random() * 200;
    newmis.velocity_y = -100 + random() * 200;

    newmis.flags = FL_ITEM;
    newmis.solid = SOLID_TRIGGER;
    newmis.movetype = MOVETYPE_TOSS;
    FO_SetModel(newmis, "progs/backpack.mdl", DIM_WORLD);
    setsize(newmis, '-16 -16 0', '16 16 56');
    newmis.touch = GrenPackTouch;
    newmis.classname = "grenpack";

    newmis.nextthink = time + LOOT_DURATION;
    newmis.think = SUB_Remove;
};



