void ClearPlayerState() =
{
	KillReloadEnt();
	KillCloakEnt();
	KillTeleball();
	KillGrenTimer();
	//KillLittleProxy();
	DisableGrenEffectOnDeath();
	DisableHarpoonPull();
	KillHarpoonTimers();
	KillMgunnerSpeedTracker();
	KillC4();
	KillMCPFlashTimer();
	KillMidairEnt();
	//DestroyBeartraps();
	//DetStickys();
	DeathMCPFlag();
	
	self.reload_complete = 0;
	self.isreloading = 0;
	self.FlashTime = 0;
	self.cloak_complete = 0;
	self.iscloaked = 0;
	self.gren = world;
	self.heat = 0;
	self.killstreakcount = 0;
	self.minigunstate = MINIGUNSTATE_NONE;
	ResetVisDimensions(self);
};

void SetTeamFragsColourName() =
{
	if(self.team_no == TEAM_BLUE)
		{
			stuffcmd(self, "team blue\n");
			stuffcmd(self, "color 13 13\n");
			self.frags = bluescore;
			return;
		}	
	if(self.team_no == TEAM_RED)
		{
			stuffcmd(self, "team red\n");
			stuffcmd(self, "color 4 4\n");
			self.frags = redscore;
			return;
		}
	else
		{
			stuffcmd(self, "team none\n");
			stuffcmd(self, "color 0 0 \n");
			self.frags = 0;
			return;
		}
};

float GetInfo (entity e, string setting, string defaultValue) =
{
	local string st;

	st = infokey(e, setting);
			
	if (st == string_null) 
	{
		st = defaultValue;
	}

	switch (st)
	{
		case "on":
			return TRUE;
		case "off":
			return FALSE;
		default:            
			return stof(st);
	}
};

void ExecTeamConfig() =
{
	local string et = infokey(self, "et");
	
	if(et == "1" || et == "on")
	{
		if(self.team_no == TEAM_BLUE)
			stuffcmd(self, "exec teamblue.cfg\n");
		if(self.team_no == TEAM_RED)
			stuffcmd(self, "exec teamred.cfg\n");
		if(self.team_no == TEAM_NONE)
			stuffcmd(self, "exec teamnone.cfg\n");
	}
};

void ExecClassConfig() =
{
	local string ec = infokey(self, "ec");
		
	if(ec == "1" || ec == "on")
		{
			if(self.role == ROLE_RECON)
				stuffcmd(self, "exec recon.cfg\n");
			if(self.role == ROLE_ASSASSIN)
				stuffcmd(self, "exec assassin.cfg\n");
			if(self.role == ROLE_FIGHTER)
				stuffcmd(self, "exec fighter.cfg\n");
			if(self.role == ROLE_BOMBER)
				stuffcmd(self, "exec bomber.cfg\n");
			if(self.role == ROLE_SUPPORT)
				stuffcmd(self, "exec support.cfg\n");
			return;	
		}
	if(ec == "2")
		{
			if(self.role == ROLE_RECON)
				stuffcmd(self, "exec scout.cfg\n");
			if(self.role == ROLE_ASSASSIN)
				stuffcmd(self, "exec sniper.cfg\n");
			if(self.role == ROLE_FIGHTER)
				stuffcmd(self, "exec soldier.cfg\n");
			if(self.role == ROLE_BOMBER)
				stuffcmd(self, "exec demoman.cfg\n");
			if(self.role == ROLE_SUPPORT)
				stuffcmd(self, "exec medic.cfg\n");
			return;
		}
};


void mcpplayer_touch()=
{
	if(self.deadflag != DEAD_NO)
		return;
	
		

		
	if(other.classname == "player" && other.team_no != self.team_no && other.deadflag == DEAD_NO)
	{
		if(other.takedamage)
		{
			local float zdist = (other.origin_z + 32)  - (self.origin_z - 24);
			
			if(zdist <= 0)
			{
				//bprint(2,strcat(ftos(dist),self.netname,"gomb", other.netname,"\n"));
			
				other.deathtype = "goomba_stomp";
				T_Damage (other, self, self, GSTOMP_DAMAGE);
				FO_Sound(self, CHAN_AUTO, "beta1/gstomp_hurt.wav", 1, ATTN_NORM);
				return;
			}
		}
		

		if(self.role != ROLE_MGUNNER)
			return;
		
		local float MGUNNERTOUCH_MAXDAMAGE = 400;
		local float MGUNNERTOUCH_MINDAMAGE = 10;
		local float MGUNNERTOUCH_MINVELOCITY = 300;
		local float MGUNNERTOUCH_MAXVELOCITY = 1000;
		

		if(self.mgunnerspeed < MGUNNERTOUCH_MINVELOCITY)
			return;
		
		local entity te = find(world, classname, "mgunner_col");
		while (te) 
		{
			if (te.enemy == other && te.owner == self) 
			{
				return;
			}
			te = find(te, classname, "mgunner_col");
		}
		
		

		
		local entity mcol = spawn();
		mcol.classname = "mgunner_col";
		mcol.enemy = other;
		mcol.owner = self;
		mcol.team_no = self.team_no;
		mcol.think = SUB_Remove;
		mcol.origin = self.origin;
		mcol.nextthink = time + 0.2;
		mcol.angles = vectoangles(self.velocity);
		
		local float impactdamage = (self.mgunnerspeed - MGUNNERTOUCH_MINVELOCITY) / MGUNNERTOUCH_MAXVELOCITY;
		impactdamage = rint(impactdamage * MGUNNERTOUCH_MAXDAMAGE);
		if(impactdamage < MGUNNERTOUCH_MINDAMAGE)
			impactdamage = MGUNNERTOUCH_MINDAMAGE;
		
		sprint(self, PRINT_HIGH, strcat("you shoulder charge ", other.netname, " at a speed of ", ftos(rint(self.mgunnerspeed)), " causing ", ftos(impactdamage), " damage.\n"));	
		other.deathtype = "shouldercharge";
		T_Damage (other, mcol, self, impactdamage );

	}
};

void speedtracker_think() =
{
	self.owner.mgunnerspeed = vlen(self.owner.velocity);
	self.nextthink = time + 0.05;
};
void MgunnerSpeedTracker() = 
{
		local entity te = find(world, classname, "speedtracker");
		while (te) 
		{
			if (te.owner == self && te != world) 
			{
				return;
			}
			te = find(te, classname, "speedtracker");
		}
		
	
		local entity st = spawn();
		st.classname = "speedtracker";
		st.owner = self;
		st.think = speedtracker_think;
		st.nextthink = time + 0.05;
};

void SpawnPlayerZut () =
{
	//self.dimension_see = DMN_NOFLASH;
	//self.dimension_seen = DMN_NOFLASH - (DMN_NOFLASH & DMN_FLASH);
	self.dimension_see = DIM_WORLD;
	self.dimension_seen = DIM_WORLD;
	self.velocity = '0 0 0';
	self.health = 100;
	self.armortype = 0.8;
	self.items = 0;
        self.ammo_rockets = 0;
        self.ammo_nails = 0;
        self.ammo_shells = 0;
        self.ammo_cells = 0;
	self.modelindex = 0;
	self.takedamage = DAMAGE_AIM;
	
	local entity spot = MCPSpawnPoint ();
	makevectors(self.angles);
	self.origin = spot.origin + '0 0 1';
	self.angles = spot.angles;
	self.fixangle = TRUE;
	modelindex_player = self.modelindex;
	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	self.view_ofs = '0 0 22';
	
	if(self.nextrole == ROLE_NONE)
	{
		self.team_no = TEAM_NONE;
		self.nextrole = ROLE_NONE;
		stuffcmd(self, "team \"\"\n");
		stuffcmd(self, "color 0 0\n");
		
		self.solid = SOLID_NOT;
		self.movetype = MOVETYPE_NOCLIP;
		self.takedamage = DAMAGE_NO;
		setmodel(self, string_null);
		modelindex_null = self.modelindex;

		setmodel(self, "progs/eyes.mdl");
		modelindex_eyes = self.modelindex;

		FO_SetModel(self, FPATH_PLAYERMDL, DIM_WORLD);
		modelindex_player = self.modelindex;

		self.items = 0;
		
		self.weapon = WPN_NONE;
		self.ammo_rockets = 0;
		self.ammo_nails = 0;
		self.ammo_shells = 0;
		self.ammo_cells = 0;

		self.health = 1;
		self.armortype = 0;
		self.maxarmour = 0;
		setmodel (self, "");
		ShowMenu(MENU_SELECTTEAM);
		self.touch = SUB_Null;
	}
	
	if(self.nextrole == ROLE_RECON)
	{
		self.role = ROLE_RECON;
		self.nextrole = ROLE_RECON;
		sprint(self,PRINT_HIGH, "playing as recon.\n");
		self.weapon = WPN_NAILGUN;
		self.items = self.items | IT_ARMOR2;
		self.maxarmour = ARMOUR_MAX_RECON;
		FO_SetModel(self, FPATH_PLAYERMDL, DIM_WORLD);
		modelindex_player = self.modelindex;
		self.clip_curr_primary = CLIP_MAX_NAILGUN;
		self.clip_curr_secondary = CLIP_MAX_SUPERSHOTGUN;
		self.clip_curr_tertiary = CLIP_MAX_SHOTGUN;
		self.ammo_cells = 75;
		self.grencount = MAX_GRENCOUNT;
		self.ammo_nails = self.grencount;
		self.touch = mcpplayer_touch;
	}
	
	if(self.nextrole == ROLE_ASSASSIN)
	{
		self.role = ROLE_ASSASSIN;
		self.nextrole = ROLE_ASSASSIN;
		sprint(self, PRINT_HIGH, "playing as assassin.\n");
		self.weapon = WPN_RAILGUN;
		self.items = self.items | IT_ARMOR2;
		self.maxarmour = ARMOUR_MAX_ASSASSIN;
		FO_SetModel(self, FPATH_PLAYERMDL, DIM_WORLD);
		modelindex_player = self.modelindex;
		self.clip_curr_primary = CLIP_MAX_RAILGUN;
		self.clip_curr_secondary = CLIP_MAX_SUPERSHOTGUN;
		self.clip_curr_tertiary = CLIP_MAX_SHOTGUN;
		self.ammo_cells = 75;
		self.grencount = MAX_GRENCOUNT;
		self.ammo_nails = self.grencount;
		self.touch = mcpplayer_touch;
	}
	if(self.nextrole == ROLE_FIGHTER)
	{
		self.role = ROLE_FIGHTER;
		self.nextrole = ROLE_FIGHTER;
		sprint(self, PRINT_HIGH, "playing as fighter.\n");
		self.weapon = WPN_ROCKETLAUNCHER;
		self.items = self.items | IT_ARMOR2;
		self.maxarmour = ARMOUR_MAX_FIGHTER;
		FO_SetModel(self, FPATH_PLAYERMDL, DIM_WORLD);
		modelindex_player = self.modelindex;
		self.clip_curr_primary = CLIP_MAX_ROCKETLAUNCHER;
		self.clip_curr_secondary = CLIP_MAX_SUPERSHOTGUN;
		self.clip_curr_tertiary = CLIP_MAX_SHOTGUN;
		self.ammo_cells = 75;
		self.grencount = MAX_GRENCOUNT;
		self.ammo_nails = self.grencount;
		self.touch = mcpplayer_touch;
	}
	if(self.nextrole == ROLE_BOMBER)
	{
		self.role = ROLE_BOMBER;
		self.nextrole = ROLE_BOMBER;
		sprint(self, PRINT_HIGH, "playing as a bomber.\n");
		self.weapon = WPN_PIPELAUNCHER;
		self.items = self.items | IT_ARMOR2;
		self.maxarmour = ARMOUR_MAX_BOMBER;
		FO_SetModel(self, FPATH_PLAYERMDL, DIM_WORLD);
		modelindex_player = self.modelindex;
		self.clip_curr_primary = CLIP_MAX_PIPELAUNCHER;
		self.clip_curr_secondary = CLIP_MAX_SUPERSHOTGUN;
		self.clip_curr_tertiary = CLIP_MAX_SHOTGUN;
		self.ammo_cells = 75;
		self.grencount = MAX_GRENCOUNT;
		self.ammo_nails = self.grencount;
		self.touch = mcpplayer_touch;
	}	
	if(self.nextrole == ROLE_SUPPORT)
	{
		self.role = ROLE_SUPPORT;
		self.nextrole = ROLE_SUPPORT;
		sprint(self, PRINT_HIGH, "playing as support.\n");
		self.weapon = WPN_SHAFT;
		self.items = self.items | IT_ARMOR2;
		self.maxarmour = ARMOUR_MAX_SUPPORT;
		FO_SetModel(self, FPATH_PLAYERMDL, DIM_WORLD);
		modelindex_player = self.modelindex;
		self.clip_curr_primary = CLIP_MAX_SHAFT;
		self.clip_curr_secondary = CLIP_MAX_SUPERSHOTGUN;
		self.clip_curr_tertiary = CLIP_MAX_SHOTGUN;
		self.ammo_cells = 75;
		self.grencount = MAX_GRENCOUNT;
		self.ammo_nails = self.grencount;
		self.touch = mcpplayer_touch;
	}
	if(self.nextrole == ROLE_MGUNNER)
	{
		self.role = ROLE_MGUNNER;
		self.nextrole = ROLE_MGUNNER;
		sprint(self, PRINT_HIGH, "playing as minigunner.\n");
		self.weapon = WPN_MINIGUN;
		self.items = self.items | IT_ARMOR2;
		self.maxarmour = ARMOUR_MAX_MGUNNER;
		FO_SetModel(self, FPATH_PLAYERMDL, DIM_WORLD);
		modelindex_player = self.modelindex;
		self.clip_curr_primary = CLIP_MAX_MINIGUN;
		self.clip_curr_secondary = CLIP_MAX_SUPERSHOTGUN;
		self.clip_curr_tertiary = CLIP_MAX_SHOTGUN;
		self.ammo_cells = 75;
		self.grencount = MAX_GRENCOUNT;
		self.ammo_nails = self.grencount;
		self.touch = mcpplayer_touch;
	}
	self.armorvalue = self.maxarmour;
	AssignPlayerDim();
	player_stand1();
	SetTeamFragsColourName();
	ChangeWeaponModel(self.weapon);
	ChangeHudAmmo(self, self.weapon);
	ClearPlayerState();
	SpawnAliasHelper();
	SetPlayerModelSkin();
	ExecTeamConfig();
	ExecClassConfig();
	SetPlayerSpeed();
	
	
	if(self.role == ROLE_MGUNNER)
		MgunnerSpeedTracker();
	
	if(self.role != ROLE_NONE)
	{
		spawn_tfog (self.origin + v_forward*20);
		spawn_tdeath (self.origin, self);
	}
};

void aliashelper_think() =
{

	if (self.bubble_count == 1)
	{
		SetAliases1(self.owner);
	}
	if (self.bubble_count == 2)
	{
		SetAliases2(self.owner);
	}
	if (self.bubble_count == 3)
	{
		SetAliases3(self.owner);
	}
	if(self.bubble_count > 3)
		remove(self);
		
	self.bubble_count = self.bubble_count + 1;
	self.nextthink = time + 0.2;
	
};

void SpawnAliasHelper()
{
	local entity aliashelper = spawn();
	aliashelper.nextthink = time + 0.2;
	aliashelper.think = aliashelper_think;
	aliashelper.bubble_count = 1;
	aliashelper.owner = self;
	aliashelper.classname = "aliashelper";
};
	
	


	
	

float GetSpawnCount(float teamno) =
{
	local float spawnCount;
	local entity spot = find(world, classname, "info_player_teamspawn");
	while (spot)
	{

		if (spot.team_no == teamno)
		{
			spawnCount++;
		}
		spot = find(spot, classname, "info_player_teamspawn");
	}
	return spawnCount;
};

entity MCPSpawnPoint () =
{

	local entity spot = find(world, classname, "info_player_start");
	if(GetSpawnCount(TEAM_BLUE) < 2 || GetSpawnCount(TEAM_RED) < 2)
	{
		bprint(2, "this map needs more info_player_teamspawn entitys\n");
		return spot;
	}
	
	if(self.team_no == TEAM_NONE)
	{
		local float cyc;
		spot = find (world, classname, "info_intermission");
		if (spot)
		{       // pick a random one
			cyc = random() * 4;
			while (cyc > 1)
			{
				spot = find (spot, classname, "info_intermission");
				if (!spot)
					spot = find (spot, classname, "info_intermission");
				cyc = cyc - 1;
			}

		}
	}

	if(self.team_no	== TEAM_BLUE)
	{
		spot = lastspawn_blue;
		if(lastspawn_blue == world)
		{
			spot = find(world,classname, "info_player_teamspawn");
		}

		while (spot)
		{
			if(spot.team_no == TEAM_BLUE && spot != lastspawn_blue)
			{
				lastspawn_blue = spot;
				return spot;
			}
			spot = find(spot, classname, "info_player_teamspawn");
			if (!spot)
			{
				spot = find(world,classname, "info_player_teamspawn");
			}
		}
	
	}

	if(self.team_no	== TEAM_RED)
	{	
		spot = lastspawn_red;
		if(lastspawn_red == world)
		{
			spot = find(world,classname, "info_player_teamspawn");
		}

		while (spot)
		{
			if(spot.team_no == TEAM_RED && spot != lastspawn_red)
			{
				lastspawn_red = spot;
				return spot;
			}
			spot = find(spot, classname, "info_player_teamspawn");
			if (!spot)
			{
				spot = find(world,classname, "info_player_teamspawn");
			}
		}
	}

	return spot;
};


void SetPlayerModelSkin() =
{
	// 0 - base  
	// 1 - b_recon 		// 9 - r recon
	// 2 - b assasssin	// 10 - r assassin
	// 3 - b fighter	// 11 - r fighter
	// 4 - b bomber		// 12 - r bomber
	// 5 - b support	// 13 - r support
	// 6 - b mgunner	// 14 - r mgunner
	// 7 - b pyro		// 15 - r pyro
	// 8 - b engineer	// 16 - r eng
	
	if(self.team_no == TEAM_BLUE)
	{
		if(self.role == ROLE_RECON)
			self.skin = 1;
		if(self.role == ROLE_ASSASSIN)
			self.skin = 2;
		if(self.role == ROLE_FIGHTER)
			self.skin = 3;
		if(self.role == ROLE_BOMBER)
			self.skin = 4;
		if(self.role == ROLE_SUPPORT)
			self.skin = 5;
		if(self.role == ROLE_MGUNNER)
			self.skin = 6;
	}
	if(self.team_no == TEAM_RED)
	{
		if(self.role == ROLE_RECON)
			self.skin = 9;
		if(self.role == ROLE_ASSASSIN)
			self.skin = 10;
		if(self.role == ROLE_FIGHTER)
			self.skin = 11;
		if(self.role == ROLE_BOMBER)
			self.skin = 12;
		if(self.role == ROLE_SUPPORT)
			self.skin = 13;
		if(self.role == ROLE_MGUNNER)
			self.skin = 14;
	}

};
void SetPlayerModelSkin2() =
{
	// 0 - base  
	// 1 - b_recon 		// 6 - r recon
	// 2 - b assasssin	// 7 - r assassin
	// 3 - b fighter	// 8 - r fighter
	// 4 - b bomber		// 9 - r bomber
	// 5 - b support	// 10 - r support
	if(self.team_no == TEAM_BLUE)
	{
		if(self.role == ROLE_RECON)
			self.skin = 1;
		if(self.role == ROLE_ASSASSIN)
			self.skin = 2;
		if(self.role == ROLE_FIGHTER)
			self.skin = 3;
		if(self.role == ROLE_BOMBER)
			self.skin = 4;
		if(self.role == ROLE_SUPPORT)
			self.skin = 5;
		if(self.role == ROLE_MGUNNER)
			self.skin = 0;
	}
	if(self.team_no == TEAM_RED)
	{
		if(self.role == ROLE_RECON)
			self.skin = 6;
		if(self.role == ROLE_ASSASSIN)
			self.skin = 7;
		if(self.role == ROLE_FIGHTER)
			self.skin = 8;
		if(self.role == ROLE_BOMBER)
			self.skin = 9;
		if(self.role == ROLE_SUPPORT)
			self.skin = 10;
		if(self.role == ROLE_MGUNNER)
			self.skin = 0;
	}

};


void SetPlayerSkin() =
{

	local string prefix = "";
	local string suffix = ""; 
	if(self.team_no == TEAM_BLUE)
	{
		prefix = "blue_";
	}
	if(self.team_no == TEAM_RED)
	{
		prefix = "red_";
	}
	if(self.role == ROLE_RECON)
	{
		suffix = "rec";
	}
	if(self.role == ROLE_ASSASSIN)
	{
		suffix = "ass";
	}
	if(self.role == ROLE_FIGHTER)
	{
		suffix = "fig";
	}
	if(self.role == ROLE_BOMBER)
	{
		suffix = "bom";
	}
	if(self.role == ROLE_SUPPORT)
	{
		suffix = "sup";
	}
	if(self.role == ROLE_NONE)
	{
		suffix = "base";
	}
	stuffcmd(self, strcat("skin ",prefix,suffix,"\n"));
};
void SetPlayerSpeed() =
{
	local float spd = 999;
	
	if(self.role == ROLE_NONE)
		spd = SPEED_MAX_GHOST;
		
	if(self.role == ROLE_RECON)
		spd = SPEED_MAX_RECON;
		
	if(self.role == ROLE_ASSASSIN)
		spd = SPEED_MAX_ASSASSIN;
		
	if(self.role == ROLE_FIGHTER)
		spd = SPEED_MAX_FIGHTER;
		
	if(self.role == ROLE_BOMBER)
		spd = SPEED_MAX_BOMBER;
		
	if(self.role == ROLE_SUPPORT)
		spd = SPEED_MAX_SUPPORT;
		
	if(self.role == ROLE_MGUNNER)
	{	
		if(self.minigunstate == MINIGUNSTATE_SPINNING || self.minigunstate == MINIGUNSTATE_SPINNINGDOWN || self.minigunstate == MINIGUNSTATE_SPINNINGUP)
			spd = SPEED_MAX_MGUNNER_SPINNING;
		//else if(VisualWeapon() == WPN_AXE)
		//	spd = SPEED_MAX_MGUNNER_FAST;
		else
			spd = SPEED_MAX_MGUNNER;
	}

	if(self.deadflag > 0)
		spd = 0;
	
	self.maxspeed = spd;
};


void ChangeRoleMenu() =
{
	self.impulse = 0;
	local float mt;
	
	if(self.team_no == TEAM_BLUE || self.team_no == TEAM_RED)
	{
		mt = MENU_SELECTROLE;
	}
	else
	{
		mt = MENU_NONE;
	}
	ShowMenu(mt);
};

void KillReloadEnt()=
{

	local entity te = find(world, classname, "reload");
	while (te) 
	{
		if (te.owner == self && te != world) 
		{
			remove(te);
		}
		te = find(te, classname, "reload");
        }
};

void KillMidairEnt()=
{

	local entity te = find(world, classname, "consecmidaircounter");
	while (te) 
	{
		if (te.owner == self && te != world) 
		{
			remove(te);
		}
		te = find(te, classname, "consecmidaircounter");
        }
};

void KillHarpoonTimers()=
{
	local entity te = find(world, classname, "harpoontimer");
	while (te) 
	{
		if (te.owner == self && te != world) 
		{
			te.nextthink = time;
			
		}
		te = find(te, classname, "harpoontimer");
        }
};

void KillC4()=
{
	local entity te = find(world, classname, "c4");
	while (te) 
	{
		if (te.owner == self && te != world) 
		{
			te.think = C4_Fizzle;
			te.nextthink = time;
			
		}
		te = find(te, classname, "c4");
        }
};

void KillMCPFlashTimer()=
{
	local entity te = find(world, classname, "mcpflashtimer");
	while (te) 
	{
		if (te.owner == self && te != world) 
		{
			te.think = SUB_Remove;
			te.nextthink = time;
			
		}
		te = find(te, classname, "mcpflashtimer");
        }
        stuffcmd(self, "v_cshift 0 0 0 0; wait; bf\n");
	
};
void KillCloakEnt()=
{

	local entity te = find(world, classname, "cloak");
	while (te) 
	{
		if (te.owner == self && te != world) 
		{
			remove(te);
		}
		te = find(te, classname, "cloak");
        }
        self.iscloaked = 0;
        self.cloak_complete = 1;
};

void KillTeleball()=
{
	local entity te = find(world, classname, "teleball");
	while (te) 
	{
		if (te.owner == self && te != world) 
		{
			remove(te);
		}
		te = find(te, classname, "teleball");
        }
};

void DisableHarpoonPull()=
{
	local entity te = find(world, classname, "harpoon");
	while (te) 
	{
		if (te.owner == self && te != world) 
		{
			te.voided = 1;
		}
		te = find(te, classname, "harpoon");
        }
};
/*
void KillLittleProxy()=
{	
	local entity te = find(world, classname, "littleproxy");
	while(te)
	{
		if(te.owner == self && te != world)
		{
			FO_Sound(te, CHAN_WEAPON, "beta1/grenade_littleproxy.wav", 1, ATTN_NORM);
			te.nextthink = time + 0.1;
			te.think = ExplodeLittleProxy;
			te.touch = SUB_Null;
		}
		te = find(te,classname,"littleproxy");
	}
};
*/
/*
void DestroyBeartraps()=
{	
	local entity te = find(world, classname, "beartrap");
	while(te)
	{
		if(te.owner == self && te != world)
		{
			//FO_Sound(te, CHAN_WEAPON, "beta1/grenade_littleproxy.wav", 1, ATTN_NORM);
			te.nextthink = time;
			//te.think = ExplodeLittleProxy;
			//te.touch = SUB_Null;
		}
		te = find(te,classname,"beartrap");
	}
};
*/
void DisableGrenEffectOnDeath()=
{
	local entity te = find(world, classname, "throwngrenade");
	while(te)
	{
		if(te.owner == self && te != world)
		{
			te.cnt = 1;
		}
		te = find(te,classname,"throwngrenade");
	}
};



void KillGrenTimer() =
{
	local entity te = find(world, classname, "grentimer");
	while (te) 
	{
		if (te.owner == self && te != world) 
		{
			remove(te);
		}
		te = find(te, classname, "grentimer");
        }
};

void KillAllPlayers() =
{
	local entity te = find(world, classname, "player");
	while (te) 
	{
		if (te != world) 
		{
			stuffcmd(te, "kill\n");
		}
		te = find(te, classname, "player");
	}

};

void ClearMarkersAgainstMe()=
{
	local entity te = find(world, classname, "marker");
	while (te) 
	{
		if (te != world && te.owner == self) 
		{
			te.bubble_count = -1;
		}
		te = find(te, classname, "marker");
	}
};

void KillMgunnerSpeedTracker() =
{
		local entity te = find(world, classname, "speedtracker");
		while (te) 
		{
			if (te.owner == self && te != world) 
			{
				remove(te);
			}
			te = find(te, classname, "speedtracker");
		}
};

void KillAllDrops() =
{
	local entity te = find(world, classname, "grenpack");
	while (te) 
	{
		if (te != world) 
		{
			remove(te);
		}
		te = find(te, classname, "grenpack");
	}

	local entity te2 = find(world, classname, "healthpack");
	while (te2) 
	{
		if (te2 != world) 
		{
			remove(te2);
		}
		te2 = find(te2, classname, "healthpack");
	}
	
	local entity te3 = find(world, classname, "armourshard");
	while (te3) 
	{
		if (te3 != world) 
		{
			remove(te3);
		}
		te3 = find(te3, classname, "armourshard");
	}
};
