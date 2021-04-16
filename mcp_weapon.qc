float Imp2Weap(float imp) =
{
	local float slot1 = WPN_NONE;
	local float slot2 = WPN_NONE;
	local float slot3 = WPN_NONE;
	local float slot4 = WPN_NONE;
	
	if(self.role == ROLE_RECON)
	{
		slot1 = WPN_AXE;
		slot2 = WPN_SHOTGUN;
		slot3 = WPN_SUPERSHOTGUN;
		slot4 = WPN_NAILGUN;	
	}
	
	if(self.role == ROLE_ASSASSIN)
	{
		slot1 = WPN_AXE;
		slot2 = WPN_SHOTGUN;
		slot3 = WPN_SUPERSHOTGUN;	
		slot4 = WPN_RAILGUN;			
	}
	
	if(self.role == ROLE_FIGHTER)
	{
		slot1 = WPN_AXE;
		slot2 = WPN_SHOTGUN;
		slot3 = WPN_SUPERSHOTGUN;
		slot4 = WPN_ROCKETLAUNCHER;				
	}
		
	if(self.role == ROLE_BOMBER)
	{
		slot1 = WPN_AXE;
		slot2 = WPN_SHOTGUN;
		slot3 = WPN_SUPERSHOTGUN;
		slot4 = WPN_PIPELAUNCHER;				
	}
		
	if(self.role == ROLE_SUPPORT)
	{
		slot1 = WPN_AXE;
		slot2 = WPN_SHOTGUN;
		slot3 = WPN_SUPERSHOTGUN;
		slot4 = WPN_SHAFT;				
	}
	
	if(self.role == ROLE_MGUNNER)
	{
		slot1 = WPN_AXE;
		slot2 = WPN_SHOTGUN;
		slot3 = WPN_SUPERSHOTGUN;
		slot4 = WPN_MINIGUN;				
	}

	if(infokey(self, "tf2slots") == "1")
	{
		if(imp == 1)
			return slot4;
		if(imp == 2)
			return slot3;
		if(imp == 3)
			return slot2;
		if(imp == 4)
			return slot1;
	}
	
	if(imp == 1)
		return slot1;
	if(imp == 2)
		return slot2;
	if(imp == 3)
		return slot3;
	if(imp == 4)
		return slot4;
	
	//bprint(2,"this shouldnt be reached\n");
	return WPN_NONE;	
};

float Weap2Imp(float wpn) =
{
	if(infokey(self, "tf2slots") == "1")
	{
		if(wpn == WPN_AXE)
			return 4;
		else if(wpn == WPN_SHOTGUN)
			return 3;
		else if(wpn == WPN_SUPERSHOTGUN)
			return 2;
		else
			return 1;
	}
	if (wpn == WPN_AXE)
		return 1;
	else if(wpn == WPN_SHOTGUN)
		return 2;
	else if(wpn == WPN_SUPERSHOTGUN)
		return 3;
	else
		return 4;
};


void ClusterBigTouch() =
{
    if (other == self.owner)
        return;

    if (other.takedamage == DAMAGE_AIM) {
        ClusterBigDirectExplode();
        return;
    }
    FO_Sound(self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);
     ClusterBigSplit();
    remove(self);

   
    

};

entity GetMarker() =
{

	local entity head = findradius(self.origin, 500);
	local entity targ = world;
	while (head)
	{
		if (head.takedamage && head.classname == "player")
		{
			local entity te2 = find(world, classname, "marker");
			while (te2) 
			{
				if (te2 != world && te2.owner == head && te2.gren == self.owner) 
				{
					if(targ == world)
						targ = head;
					else if (vlen(head.origin - self.origin) > vlen(targ.origin - self.origin))
						targ = head;
						
				}
				te2 = find(te2, classname, "marker");
			}

		}
		head = head.chain;
	}
	return targ;
	//return self.owner;
	
	
	//if(targ == world)
		//return;
	//bprint(2,strcat(targ.netname,"markerchecker\n"));
	//local vector dir = normalize(targ.origin - self.origin);
	//self.solid = SOLID_NOT;
	//setorigin(self, self.origin+'0 0 8');
	//self.movetype = MOVETYPE_FLY;
	//self.velocity = dir;
	//self.velocity = dir * 500;
	//self.angles = vectoangles(self.velocity);
	//self.velocity_z = 64;
	
	//local vector dir2 = normalize((self.owner.origin + (normalize(self.owner.velocity) * 150)) - self.origin);	//aiming just ahead
	//local entity mis = spawn();
	
	//FO_SetModel(mis, "progs/beta1/mcp_pinesmall.mdl", DIM_WORLD);
	//mis.skin = self.skin;
	//setsize (mis, '0 0 0', '0 0 0'); 
	//setorigin(mis,self.origin + '0 0 8');
	//mis.movetype = MOVETYPE_BOUNCE;
	//mis.velocity = dir2 * 300;
	//if(self.owner.origin_z > self.origin_z)
	//	mis.velocity_z = mis.velocity_z + 128;
	//else
	//	mis.velocity_z = mis.velocity_z + 64;
	
	//remove(self);
}



/*void StickyTouch() = 
{
	if (other == self.owner)
		return;

	if (other.takedamage == DAMAGE_AIM) 
	{
		StickyDirectExplode();
		return;
	}
	//sound(self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);

	else
	{
		self.classname = "sticky_trap";
		self.velocity = '0 0 0';
		self.avelocity = '0 0 0';
		self.movetype = MOVETYPE_NONE;
		self.think = StickyTrapGroundExplode;
		self.nextthink = time + 480;
		CheckStickyLimit();
		if(self.owner.team_no == TEAM_BLUE)
			//self.skin = 3;
		if(self.owner.team_no == TEAM_RED)
			//self.skin = 4;
		self.touch = SUB_Null;
		setsize (self, VEC_ORIGIN, VEC_ORIGIN);
		FO_Sound(self, CHAN_WEAPON, "beta1/sticky.wav", 1, ATTN_NORM);
	}
};
*/

string GetWeaponModel() =
{
	local string t = "";
	local string wpn = "";
	local string result = "";
	
	if (self.team_no == TEAM_BLUE)
		t = "blue";
	if (self.team_no == TEAM_RED)
		t = "red";

	switch (self.weapon)
	{	
		case WPN_AXE:
			wpn = "axe";
			break;
		case WPN_SHOTGUN:
			wpn = "shotgun";
			break;
		case WPN_SUPERSHOTGUN:
			wpn = "supershotgun";
			break;
		case WPN_NAILGUN:
			wpn = "nailgun";
			break;
		case WPN_RAILGUN:
			wpn = "railgun";
			break;
		case WPN_ROCKETLAUNCHER:
			wpn = "rocketlauncher";
			break;
		case WPN_PIPELAUNCHER:
			wpn = "pipelauncher";
			break;
		case WPN_SHAFT:
			wpn = "shaft";
			break;
		case WPN_MINIGUN:
			wpn = "minigun";
			break;
						
		default:            
			break;
	}
	result = strcat(t,"_",wpn,"_",ftos(self.currentammo));
	return result;
};

void ChangeHudAmmo(entity owner, float wpn) =
{
	owner.items = owner.items - ( owner.items & ( IT_SHELLS | IT_NAILS | IT_ROCKETS | IT_CELLS) );
	if(wpn == WPN_AXE)
	{
		owner.currentammo = 0;
	}
	else if (wpn == WPN_SHOTGUN)
	{
		owner.currentammo = owner.clip_curr_tertiary;
		owner.items = owner.items | IT_SHELLS;
	}
	else if (wpn == WPN_SUPERSHOTGUN)
	{
		owner.currentammo = owner.clip_curr_secondary;
		owner.items = owner.items | IT_SHELLS;
	}
	else if (wpn == WPN_NAILGUN || wpn == WPN_RAILGUN)
	{
		owner.currentammo = owner.clip_curr_primary;
		owner.items = owner.items | IT_NAILS;
	}
	else if (wpn == WPN_ROCKETLAUNCHER || wpn == WPN_PIPELAUNCHER)
	{
		owner.currentammo = owner.clip_curr_primary;
		owner.items = owner.items | IT_ROCKETS;
	}
	else if (wpn == WPN_SHAFT)
	{
		owner.currentammo = owner.clip_curr_primary;
		owner.items = owner.items | IT_CELLS;
	}
	else if (wpn == WPN_MINIGUN)
	{
		owner.currentammo = owner.clip_curr_primary;
		owner.items = owner.items | IT_SHELLS;
	}
	else
	{
		owner.currentammo = 0;
	}
};

void ChangeWeaponModel(float wpn) =
{
	player_run ();          // get out of any weapon firing states

	if (wpn == WPN_AXE)
	{
		if(self.team_no == TEAM_BLUE)
		{
			self.weaponmodel = "progs/beta1/wpn/blue_axe.mdl";
		}
		if(self.team_no == TEAM_RED)
		{
			self.weaponmodel = "progs/beta1/wpn/red_axe.mdl";
		}
		if(self.iscloaked == 1)
		{
			self.weaponmodel = "progs/beta1/wpn/grey_axe.mdl";
		}
		self.weaponframe = 0;
	}
	else if (wpn == WPN_SUPERSHOTGUN)
	{	
		if(self.team_no == TEAM_BLUE)
		{
			self.weaponmodel = "progs/beta1/wpn/blue_supershotgun.mdl";
		}
		if(self.team_no == TEAM_RED)
		{
			self.weaponmodel = "progs/beta1/wpn/red_supershotgun.mdl";
		}
		if(self.iscloaked == 1)
		{
			self.weaponmodel = "progs/beta1/wpn/grey_supershotgun.mdl";
		}
		self.weaponframe = 0;
	}
	else if (wpn== WPN_SHOTGUN)
	{
		if(self.team_no == TEAM_BLUE)
		{
			self.weaponmodel = "progs/beta1/wpn/blue_shotgun.mdl";
		}
		if(self.team_no == TEAM_RED)
		{
			self.weaponmodel = "progs/beta1/wpn/red_shotgun.mdl";
		}
		if(self.iscloaked == 1)
		{
			self.weaponmodel = "progs/beta1/wpn/grey_shotgun.mdl";
		}
		self.weaponframe = 0;
	}
	else if (wpn == WPN_NAILGUN)
	{
		if(self.team_no == TEAM_BLUE)
		{
			self.weaponmodel = "progs/beta1/wpn/blue_supernailgun.mdl";
		}
		if(self.team_no == TEAM_RED)
		{
			self.weaponmodel = "progs/beta1/wpn/red_supernailgun.mdl";
		}
		self.weaponframe = 0;
	}
	else if (wpn == WPN_RAILGUN)
	{
		if(self.team_no == TEAM_BLUE)
		{
			self.weaponmodel = "progs/beta1/wpn/blue_railgun.mdl";
		}
		if(self.team_no == TEAM_RED)
		{
			self.weaponmodel = "progs/beta1/wpn/red_railgun.mdl";
		}
		if(self.iscloaked == 1)
		{
			self.weaponmodel = "progs/beta1/wpn/grey_railgun.mdl";
		}
		self.weaponframe = 0;
	}
	else if (wpn == WPN_ROCKETLAUNCHER)
	{
		if(self.team_no == TEAM_BLUE)
		{
			self.weaponmodel = "progs/beta1/wpn/blue_rocketlauncher.mdl";
		}
		if(self.team_no == TEAM_RED)
		{
			self.weaponmodel = "progs/beta1/wpn/red_rocketlauncher.mdl";
		}
		self.weaponframe = 0;
	}
	else if (wpn == WPN_PIPELAUNCHER)
	{
		if(self.team_no == TEAM_BLUE)
		{
			self.weaponmodel = "progs/beta1/wpn/blue_pipelauncher.mdl";
		}
		if(self.team_no == TEAM_RED)
		{
			self.weaponmodel = "progs/beta1/wpn/red_pipelauncher.mdl";
		}
		self.weaponframe = 0;
	}
	else if (wpn == WPN_SHAFT)
	{
		if(self.team_no == TEAM_BLUE)
		{
			self.weaponmodel = "progs/beta1/wpn/blue_shaft.mdl";
		}
		if(self.team_no == TEAM_RED)
		{
			self.weaponmodel = "progs/beta1/wpn/red_shaft.mdl";
		}
		self.weaponframe = 0;
	}
	else if (wpn == WPN_MINIGUN)
	{
		if(self.team_no == TEAM_BLUE)
		{
			self.weaponmodel = "progs/beta1/wpn/blue_minigun.mdl";
		}
		if(self.team_no == TEAM_RED)
		{
			self.weaponmodel = "progs/beta1/wpn/red_minigun.mdl";
		}
		self.weaponframe = 0;
	}
	else if (wpn == WPN_RELOAD)
	{
		self.weaponmodel = "";
		self.weaponframe = 0;
	}
	else
	{
		self.weaponmodel = "";
		self.weaponframe = 0;		
	}
};

void NextWeapon() =
{

	self.impulse = 0;
	if (self.isreloading == 1)
		return;
	if(infokey(self, "tf2slots") == "1")
	{
		if(self.weapon == WPN_AXE)
			W_ZutChangeWeapon (IMP_KEYBOARD1);
		else if(self.weapon == WPN_SHOTGUN)
			W_ZutChangeWeapon (IMP_KEYBOARD2);
		else if(self.weapon == WPN_SUPERSHOTGUN)
			W_ZutChangeWeapon (IMP_KEYBOARD3);
		else
			W_ZutChangeWeapon (IMP_KEYBOARD4);
	}
	else
	{
		if(self.weapon == WPN_AXE)
			W_ZutChangeWeapon (IMP_KEYBOARD2);
		else if(self.weapon == WPN_SHOTGUN)
			W_ZutChangeWeapon (IMP_KEYBOARD3);
		else if(self.weapon == WPN_SUPERSHOTGUN)
			W_ZutChangeWeapon (IMP_KEYBOARD4);
		else
			W_ZutChangeWeapon (IMP_KEYBOARD1);
	}
};

void PrevWeapon() =
{
	self.impulse = 0;
	if (self.isreloading == 1)
		return;
	if(infokey(self, "tf2slots") == "1")
	{
		if(self.weapon == WPN_AXE)
			W_ZutChangeWeapon (IMP_KEYBOARD1);
		else if(self.weapon == WPN_SHOTGUN)
			W_ZutChangeWeapon (IMP_KEYBOARD4);
		else if(self.weapon == WPN_SUPERSHOTGUN)
			W_ZutChangeWeapon (IMP_KEYBOARD3);
		else
			W_ZutChangeWeapon (IMP_KEYBOARD2);
	}
	else
	{
		if(self.weapon == WPN_AXE)
			W_ZutChangeWeapon (IMP_KEYBOARD4);
		else if(self.weapon == WPN_SHOTGUN)
			W_ZutChangeWeapon (IMP_KEYBOARD1);
		else if(self.weapon == WPN_SUPERSHOTGUN)
			W_ZutChangeWeapon (IMP_KEYBOARD2);
		else
			W_ZutChangeWeapon (IMP_KEYBOARD3);
	}
};

void LastWeapon() =
{
	self.impulse = 0;
	if (self.isreloading == 1)
		return;
	if(self.weapon == self.lastweapon)
		return;

	W_ZutChangeWeapon (Weap2Imp(self.lastweapon));
};

void W_ZutChangeWeapon(float imp) =
{
	self.impulse = 0;
	if (self.isreloading == 1)
		return;
	

	
	local float wpn = Imp2Weap(imp);
	if(wpn == self.weapon)
	{
		return;
	}
	
	self.lastweapon = self.weapon;
		
	self.weapon = wpn;
	ChangeWeaponModel(self.weapon);
	ChangeHudAmmo(self,self.weapon);
	
	if(self.role == ROLE_MGUNNER)
		SetPlayerSpeed();
};




void MCP_Attack(float wpn) =
{
	if (self.isreloading == 1)
		return;
	//local   float   r;
	//local vector dir;

	//makevectors     (self.v_angle);	// calculate forward angle for velocity
	//self.show_hostile = time + 1;	// wake monsters up

	if (wpn == WPN_AXE)
	{
		self.attack_finished = time + 0.5;
		FO_Sound(self, CHAN_WEAPON, "weapons/ax1.wav", 1, ATTN_NORM);
		local float r = random();
		if (r < 0.25)
			player_axe1();
		else if (r < 0.5)
			player_axeb1();
		else if (r < 0.75)
			player_axec1();
		else
			player_axed1();

		
		local   vector  source;
		local   vector  org;

		makevectors (self.v_angle);
		source = self.origin + '0 0 16';
		traceline (source, source + v_forward*64, FALSE, self); // false
		AddStat(self, STAT_WEAPONFIRED, WPN_AXE);

		
		if (trace_fraction == 1.0)
			return;
		
	
		org = trace_endpos - v_forward*8;

		
		
		if (trace_ent.takedamage)
		{
			if(trace_ent.classname == "player" && trace_ent.team_no != self.team_no)
				AddStat(self, STAT_WEAPONHIT, WPN_AXE);
			
			trace_ent.axhitme = 1;
			SpawnBlood (org, 20);
			if(self.role == ROLE_ASSASSIN)
				T_Damage (trace_ent, self, self, DMG_MELEE_ASSASSIN);
			else
			T_Damage (trace_ent, self, self, 20);
		}
		else
		{       // hit wall
			FO_Sound(self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);

			WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
			WriteByte (MSG_MULTICAST, TE_GUNSHOT);
			WriteByte (MSG_MULTICAST, 3);
			WriteCoord (MSG_MULTICAST, org_x);
			WriteCoord (MSG_MULTICAST, org_y);
			WriteCoord (MSG_MULTICAST, org_z);
			multicast (org, MULTICAST_PVS);
		}
	}
	else if (wpn == WPN_SHOTGUN)
	{
		self.attack_finished = time + 0.5;
		player_shot1();
		
		self.clip_curr_tertiary = self.clip_curr_tertiary - 1;
		ChangeHudAmmo(self,WPN_SHOTGUN);
		
		local vector dir;

		FO_Sound(self, CHAN_WEAPON, "weapons/guncock.wav", 1, ATTN_NORM); 

		msg_entity = self;
		WriteByte (MSG_ONE, SVC_SMALLKICK);

		dir = aim (self, 100000);
		AddStat(self, STAT_WEAPONFIRED, WPN_SHOTGUN);
		FireBullets (6, dir, '0.04 0.04 0');
		
		if(self.clip_curr_tertiary == 0)
		{
			ReloadWeapon(WPN_SHOTGUN);
		}
	
	}
	else if (wpn == WPN_SUPERSHOTGUN)
	{
		/*
		self.attack_finished = time + 0.7;
		player_shot1();
		
		self.clip_curr_secondary = self.clip_curr_secondary - 1;
		ChangeHudAmmo(self,WPN_SUPERSHOTGUN);
		
		local vector dir2;

		FO_Sound(self ,CHAN_WEAPON, "weapons/shotgn2.wav", 1, ATTN_NORM); 

		msg_entity = self;
		WriteByte (MSG_ONE, SVC_BIGKICK);
	
		dir2 = aim (self, 100000);
		FireBullets (14, dir2, '0.14 0.08 0');
		if(self.clip_curr_secondary == 0)
		{
			ReloadWeapon(WPN_SUPERSHOTGUN);
		}
		*/
		
		self.attack_finished = time + FIRERATE_SUPERSHOTGUN;
		player_shot1();
		
		self.clip_curr_secondary = self.clip_curr_secondary - 1;
		ChangeHudAmmo(self,WPN_SUPERSHOTGUN);
		
		local vector dir2;

		FO_Sound(self ,CHAN_WEAPON, "weapons/shotgn2.wav", 1, ATTN_NORM); 

		msg_entity = self;
		WriteByte (MSG_ONE, SVC_BIGKICK);
	
		dir2 = aim (self, 100000);
		
		AddStat(self, STAT_WEAPONFIRED, WPN_SUPERSHOTGUN);
		FireBullets (14, dir2, '0.14 0.08 0');
		if(self.role == ROLE_RECON)
		{
			if(self.v_angle_x > 25)
			{
				
				local float lookdown = self.v_angle_x/60 * 350;
				self.velocity.z = lookdown;
			}
		}
		
		if(self.clip_curr_secondary == 0)
		{
			ReloadWeapon(WPN_SUPERSHOTGUN);
		}
	}
	else if (wpn == WPN_NAILGUN)
	{
			player_nail1();

	}
	else if (wpn == WPN_MINIGUN)
	{
		if(self.minigunstate == MINIGUNSTATE_NONE)
		{
			FO_Sound(self, CHAN_WEAPON, "beta1/minigun_spinup.wav", 1, ATTN_NORM);
			self.mgun_spinup_finish = time + MINIGUN_SPINUP_TIME;
			self.minigunstate = MINIGUNSTATE_SPINNINGUP;
			player_minigunup();
			SetPlayerSpeed();
			
		}

	}
	else if (wpn == WPN_ROCKETLAUNCHER)
	{
		player_rocket1();
		self.attack_finished = time + 0.8;

		self.clip_curr_primary = self.clip_curr_primary - 1;
		ChangeHudAmmo(self,WPN_ROCKETLAUNCHER);
	
		FO_Sound(self, CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM);

		msg_entity = self;
		WriteByte (MSG_ONE, SVC_SMALLKICK);

		SpawnMissile();
		if(self.clip_curr_primary == 0)
		{
			ReloadWeapon(WPN_ROCKETLAUNCHER);
		}
	}
	else if(wpn == WPN_SHAFT)
	{
		player_light1();
		//self.attack_finished = time + 0.1;
		FO_Sound(self, CHAN_AUTO, "weapons/lstart.wav", 1, ATTN_NORM);
	}
	else if(wpn == WPN_PIPELAUNCHER)
	{
		player_rocket1();
		self.attack_finished = time + 0.6; //0.6
		
		self.clip_curr_primary = self.clip_curr_primary - 1;
		ChangeHudAmmo(self,WPN_PIPELAUNCHER);
	
		FO_Sound(self, CHAN_WEAPON, "weapons/grenade.wav", 1, ATTN_NORM);

		msg_entity = self;
		WriteByte (MSG_ONE, SVC_SMALLKICK);

		//SpawnSticky();
		SpawnClusterGren();
		
		if(self.clip_curr_primary == 0)
		{
			ReloadWeapon(WPN_PIPELAUNCHER);
		}
	}
	else if(wpn == WPN_RAILGUN)
	{
		player_rocket1();
		self.attack_finished = time + 0.5;
		self.clip_curr_primary = self.clip_curr_primary - 1;
		ChangeHudAmmo(self,WPN_RAILGUN);
	
		FO_Sound(self, CHAN_WEAPON, "beta1/railgun.wav", 1, ATTN_NORM);

		msg_entity = self;
		WriteByte (MSG_ONE, SVC_SMALLKICK);
		ReloadWeapon(WPN_RAILGUN);
		
		makevectors (self.v_angle);
		source = self.origin + '0 0 16';
		AddStat(self, STAT_WEAPONFIRED, WPN_RAILGUN);
		traceline (source, source + v_forward*5000, FALSE, self);
		if (trace_fraction == 1.0)
			return;
	
		org = trace_endpos - v_forward*4;
		if (trace_ent.takedamage)
		{

				
			local float maxdamage = 60;
			local float mindamage = 20;
			local float mindistance = 300;
			local float maxdistance = 1200;
			local float dmg;
			local vector difference = self.origin - trace_ent.origin;
			local float distance = rint(sqrt(pow(difference.x, 2) + pow(difference.y, 2) + pow(difference.z, 2)));
			if(distance < mindistance)
				distance = mindistance;
			if (distance > maxdistance)
				distance = maxdistance;
			distance = distance - mindistance;
			local float dmgrange = maxdistance-mindistance;
			dmg = maxdamage * (1-(distance/dmgrange));
			dmg = rint(dmg);
			if(dmg < mindamage)
				dmg = mindamage;
				
			//sprint(self, PRINT_HIGH, strcat("distance:",ftos(distance), " dmgrange:", ftos(dmgrange), " damage:", ftos(dmg), ".\n"));
			if(trace_ent.classname == "player" && trace_ent.team_no != self.team_no)
			{
				self.heat = self.heat + 1;
				AddStat(self, STAT_WEAPONHIT, self.heat);
				if(self.heat > 3)
					self.heat = 3;
				dmg = dmg * self.heat;
				local string multiplier = "";
				if(self.heat == 1)
					multiplier = " damage.\n";
				if(self.heat == 2)
				{	
					stuffcmd(self, "play beta1/voice_impressive.wav\n");
					multiplier = " damage (doubled).\n";
				}
				if(self.heat == 3)
				{
					SoundTeam (TEAM_BLUE, world, "beta1/voice_accuracy.wav");
					SoundTeam (TEAM_RED, world, "beta1/voice_accuracy.wav");
					multiplier = " damage (tripled).\n";
				}
				
				sprint(self, PRINT_HIGH, strcat("you rail ",trace_ent.netname, " for ", ftos(dmg), multiplier));
				
			}
			else
			{	
				if(self.heat > 0)
				{	
					self.heat = 0;
					stuffcmd(self, "play beta1/hitsound_rail0.wav\n");
					sprint(self, PRINT_HIGH, strcat("consecutive hit multiplier lost.\n"));
				}
			}
			trace_ent.axhitme = 1;
			SpawnBlood (org, 20);
			T_Damage (trace_ent, self, self, dmg);
		}
		else
		{       // hit wall
			//sound (self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);

			WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
			WriteByte (MSG_MULTICAST, TE_GUNSHOT);
			WriteByte (MSG_MULTICAST, 3);
			WriteCoord (MSG_MULTICAST, org_x);
			WriteCoord (MSG_MULTICAST, org_y);
			WriteCoord (MSG_MULTICAST, org_z);
			multicast (org, MULTICAST_PVS);
			if(self.heat > 0)
			{	
				self.heat = 0;
				stuffcmd(self, "play beta1/hitsound_rail0.wav\n");
				sprint(self, PRINT_HIGH, strcat("consecutive hit multiplier lost.\n"));
			}
		}

		org = self.origin + '0 0 16';

		traceline (org, org + v_forward*5000, TRUE, self);
		if(self.team_no == TEAM_RED)
		{
		WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
		WriteByte (MSG_MULTICAST, TE_LIGHTNING2);
		WriteEntity (MSG_MULTICAST, self);
		WriteCoord (MSG_MULTICAST, org_x);
		WriteCoord (MSG_MULTICAST, org_y);
		WriteCoord (MSG_MULTICAST, org_z);
		WriteCoord (MSG_MULTICAST, trace_endpos_x);
		WriteCoord (MSG_MULTICAST, trace_endpos_y);
		WriteCoord (MSG_MULTICAST, trace_endpos_z);
		multicast (org, MULTICAST_PHS);
		}
		else
		{
		WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
		WriteByte (MSG_MULTICAST, TE_LIGHTNING1);
		WriteEntity (MSG_MULTICAST, self);
		WriteCoord (MSG_MULTICAST, org_x);
		WriteCoord (MSG_MULTICAST, org_y);
		WriteCoord (MSG_MULTICAST, org_z);
		WriteCoord (MSG_MULTICAST, trace_endpos_x);
		WriteCoord (MSG_MULTICAST, trace_endpos_y);
		WriteCoord (MSG_MULTICAST, trace_endpos_z);
		multicast (org, MULTICAST_PHS);
		}
	}


};


void () t_climbingnail = {

	if (time < self.bubble_count)
		return;
		
	self.bubble_count = time + 0.1;

	if (other.classname != "player")
		return;
		
	if(other.team_no != self.owner.team_no)
		return;


	if (self.origin_z > other.origin_z)
	{
		other.velocity_z = CLIMBINGNAIL_BOOST;
		remove(self);
	}
};

void (entity e) ConvertToClimbingNail =
{
	e.origin = self.origin + ( normalize(self.velocity) * -5);
	e.movetype = MOVETYPE_NONE;
	e.velocity = '0 0 0';
	e.solid = SOLID_TRIGGER;
	e.touch = t_climbingnail;
	e.think = SUB_Remove;
	e.nextthink = time + CLIMBINGNAIL_DURATION;
	e.bubble_count = time;
};



void() superspike_touch =
{
//local float rand;
	if (other == self.owner)
		return;

	if (self.voided) {
		return;
	}
	self.voided = 1;


	if (other.solid == SOLID_TRIGGER)
		return; // trigger field, do nothing

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	

// hit something that bleeds
	if (other.takedamage)
	{
		if(other.classname == "player" && other.team_no != self.owner.team_no)
			AddStat(self.owner, STAT_WEAPONHIT, WPN_NAILGUN);
			
		spawn_touchblood (18);
		other.deathtype = "supernail";
		T_Damage (other, self, self.owner, 12);
	}
	else
	{
		WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
		WriteByte (MSG_MULTICAST, TE_SUPERSPIKE);
		WriteCoord (MSG_MULTICAST, self.origin_x);
		WriteCoord (MSG_MULTICAST, self.origin_y);
		WriteCoord (MSG_MULTICAST, self.origin_z);
		multicast (self.origin, MULTICAST_PHS);
	}

	
	if(other.classname == "worldspawn")
	{
		ConvertToClimbingNail(self);
		return;
	}
	remove(self);

};

void SpawnNail()=
{
	local vector    dir;
	//local entity    old;
	AddStat(self, STAT_WEAPONFIRED, WPN_NAILGUN);
	FO_Sound(self, CHAN_WEAPON, "weapons/spike2.wav", 1, ATTN_NORM);
	self.attack_finished = time + 0.2;
	dir = aim (self, 1000);
	launch_spike (self.origin + '0 0 16', dir);
	newmis.touch = superspike_touch;
	newmis.classname = "nail";
	FO_SetModel(newmis, "progs/beta1/mcp_nail.mdl", DIM_WORLD);
	if(self.team_no == TEAM_BLUE)
		newmis.skin = 1;
	if(self.team_no == TEAM_RED)
		newmis.skin = 2;
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);               
	msg_entity = self;
	WriteByte (MSG_ONE, SVC_SMALLKICK);

};

void SpawnMissile()=
{
		AddStat(self, STAT_WEAPONFIRED, WPN_ROCKETLAUNCHER);
		newmis = spawn ();
		newmis.owner = self;
		newmis.movetype = MOVETYPE_FLYMISSILE;
		newmis.solid = SOLID_BBOX;
		
		// set newmis speed     
		makevectors (self.v_angle);
		newmis.velocity = v_forward;
		newmis.velocity = newmis.velocity * ROCKET_SPEED; //1000
		newmis.angles = vectoangles(newmis.velocity);
	
		newmis.touch = T_MissileTouch;
		newmis.voided = 0;
	
		// set newmis duration
		newmis.nextthink = time + 5;
		newmis.think = SUB_Remove;
		newmis.classname = "rocket";

		FO_SetModel(newmis, "progs/beta1/mcp_missile.mdl",DIM_WORLD);
		if(self.team_no == TEAM_BLUE)
			newmis.skin = 1;
		if(self.team_no == TEAM_RED)
			newmis.skin = 2;
		setsize (newmis, '0 0 0', '0 0 0');             
		setorigin (newmis, self.origin + v_forward*8 + '0 0 16');
		
};


void ClusterMiniTouch() =
{
	
	if (other == self.owner)
	{
		return;
	}
	if (other.takedamage == DAMAGE_AIM) {
		ClusterMiniDirectExplode();
		return;
	}
	FO_Sound(self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);
	
	//bprint(2,strcat(ftos(self.bubble_count), "bubba\n"));

/*	if(other.classname == "worldspawn" && time > self.bubble_count)
	{

		
		self.bubble_count = time + 0.05;
		//local entity targ = GetMarker();
		////if(targ != world)
		//{
			self.velocity_x = self.velocity_x * 0.5;
			self.velocity_y = self.velocity_y * 0.5;
			SpawnMiniCluster(0);
			remove(self);
		//}
		
		
	}
	*/
    
  
};

void SpawnMiniCluster(float x, entity stattrack) =
{
	local entity targ = GetMarker();
	local vector dir;
	if(targ == world)
	{
		dir = normalize(self.velocity);	
	}
	else
	{
		//dir = normalize(targ.origin - self.origin);
		dir = normalize(((targ.origin + '0 0 64') + (normalize(targ.velocity) * 100)) - self.origin);
	}
	
	local float speed = vlen(self.velocity);
	
	local entity newmis1 = spawn ();
	newmis1.voided = 0;
	newmis1.owner = self.owner;
	newmis1.movetype = MOVETYPE_BOUNCE;
	newmis1.solid = SOLID_TRIGGER;
	newmis1.classname = "clustermini";
	FO_SetModel(newmis1, "progs/beta1/mcp_pinesmall.mdl", DIM_WORLD);
	if(self.owner.team_no == TEAM_BLUE)
		newmis1.skin = 1;
	if(self.owner.team_no == TEAM_RED)
		newmis1.skin = 2;
	setsize (newmis1, '0 0 0', '0 0 0');              
	setorigin (newmis1, self.origin);
	newmis1.touch = ClusterMiniTouch;
	newmis1.think = ClusterMiniExplode;
	newmis1.nextthink = self.cnt;
	newmis1.cnt = self.cnt;
	newmis1.bubble_count = time + 0.1;
	newmis1.gren = stattrack;
	local vector dir2 = vectoangles(dir);
	dir2_y = dir2_y + x * 6;

	makevectors (dir2);
	
	local vector vec = normalize (v_forward);
	vec_z = 0 - vec_z + (random() - 0.5) * 0.1;
	//vec_z = vec_z + 32;
	
	
	newmis1.velocity = vec * speed;

};

void ClusterBigSplit() =
{
	local entity te = spawn();
	te.classname = "clusterstat";
	te.think = SUB_Remove;
	te.nextthink = time + 5;
	
	self.cnt = time + 1.5;
	self.bubble_count = 0;
	SpawnMiniCluster(-1,te);
	SpawnMiniCluster(0,te);
	SpawnMiniCluster(1,te);
	
	remove(self);
};



/*void SpawnSticky()=
{
	
		newmis = spawn ();
		newmis.voided=0;
		newmis.owner = self;
		newmis.movetype = MOVETYPE_BOUNCE;
		newmis.solid = SOLID_BBOX;
		newmis.classname = "sticky_direct";

		
		makevectors (self.v_angle);

		if (self.v_angle_x)
			newmis.velocity = v_forward*600 + v_up * 200 + crandom()*v_right*10 + crandom()*v_up*10;
		else
		{
			newmis.velocity = aim(self, 10000);
			newmis.velocity = newmis.velocity * 600;
			newmis.velocity_z = 200;
		}

		newmis.avelocity = '300 300 300';

		newmis.angles = vectoangles(newmis.velocity);
	
		newmis.touch = StickyTouch;
		//newmis.touch = MultiGrenTouch;

		newmis.think = SUB_Remove;
		newmis.nextthink = time + 5;

		FO_SetModel(newmis, "progs/beta1/mcp_sticky.mdl", DIM_WORLD);
		if(self.team_no == TEAM_BLUE)
			newmis.skin = 1;
		if(self.team_no == TEAM_RED)
			newmis.skin = 2;
		setsize (newmis, '0 0 0', '0 0 0');             
		setorigin (newmis, self.origin);
};*/

void SpawnClusterGren()=
{
		AddStat(self, STAT_WEAPONFIRED, WPN_PIPELAUNCHER);
		newmis = spawn ();
		newmis.voided=0;
		newmis.owner = self;
		newmis.movetype = MOVETYPE_BOUNCE;
		newmis.solid = SOLID_BBOX;
		newmis.classname = "clusterbig";

		
		makevectors (self.v_angle);

		if (self.v_angle_x)
			newmis.velocity = v_forward*600 + v_up * 200 + crandom()*v_right*10 + crandom()*v_up*10;
		else
		{
			newmis.velocity = aim(self, 10000);
			newmis.velocity = newmis.velocity * 600;
			newmis.velocity_z = 200;
		}

		newmis.avelocity = '300 300 300';

		newmis.angles = vectoangles(newmis.velocity);
	
		//newmis.touch = StickyTouch;
		newmis.touch = ClusterBigTouch;

		newmis.think = SUB_Remove;
		newmis.nextthink = time + 5;

		FO_SetModel(newmis, "progs/beta1/mcp_pinebig.mdl", DIM_WORLD);
		if(self.team_no == TEAM_BLUE)
			newmis.skin = 1;
		if(self.team_no == TEAM_RED)
			newmis.skin = 2;
		setsize (newmis, '0 0 0', '0 0 0');             
		setorigin (newmis, self.origin);
};


