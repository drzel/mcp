void ClearPlayerState() =
{
	KillReloadEnt();
	KillCloakEnt();
	KillTeleball();
	KillGrenTimer();
	//KillLittleProxy();
	DisableGrenEffectOnDeath();
	DisableHarpoonPull();
	DestroyBeartraps();
	DetStickys();
	DeathMCPFlag();
	self.reload_complete = 0;
	self.isreloading = 0;
	self.cloak_complete = 0;
	self.iscloaked = 0;
	self.gren = world;
	self.heat = 0;
	self.killstreakcount = 0;
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

void SpawnPlayerZut () =
{
	self.dimension_see = DMN_NOFLASH;
	self.dimension_seen = DMN_NOFLASH - (DMN_NOFLASH & DMN_FLASH);
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

		FO_SetModel(self, "progs/player.mdl");
		modelindex_player = self.modelindex;

		self.items = 0;
		
		self.weapon = WPN_NONE;
		self.ammo_rockets = 0;
		self.ammo_nails = 0;
		self.ammo_shells = 0;
		self.ammo_cells = 0;

		self.health = 1;
		self.armortype = 0;
		self.armorvalue = 0;
		setmodel (self, "");
		ShowMenu(MENU_SELECTTEAM);
	}
	
	if(self.nextrole == ROLE_RECON)
	{
		self.role = ROLE_RECON;
		self.nextrole = ROLE_RECON;
		sprint(self,PRINT_HIGH, "playing as recon.\n");
		self.weapon = WPN_NAILGUN;
		self.items = self.items | IT_ARMOR2;
		self.armorvalue = ARMOUR_MAX_RECON;
		FO_SetModel(self, "progs/player.mdl");
		modelindex_player = self.modelindex;
		self.clip_curr_primary = CLIP_MAX_NAILGUN;
		self.clip_curr_secondary = CLIP_MAX_SUPERSHOTGUN;
		self.clip_curr_tertiary = CLIP_MAX_SHOTGUN;
		self.ammo_cells = 100;
		self.grencount = MAX_GRENCOUNT;
		self.ammo_nails = self.grencount;
	}
	
	if(self.nextrole == ROLE_ASSASSIN)
	{
		self.role = ROLE_ASSASSIN;
		self.nextrole = ROLE_ASSASSIN;
		sprint(self, PRINT_HIGH, "playing as assassin.\n");
		self.weapon = WPN_RAILGUN;
		self.items = self.items | IT_ARMOR2;
		self.armorvalue = ARMOUR_MAX_ASSASSIN;
		FO_SetModel(self, "progs/player.mdl");
		modelindex_player = self.modelindex;
		self.clip_curr_primary = CLIP_MAX_RAILGUN;
		self.clip_curr_secondary = CLIP_MAX_SUPERSHOTGUN;
		self.clip_curr_tertiary = CLIP_MAX_SHOTGUN;
		self.ammo_cells = 75;
		self.grencount = MAX_GRENCOUNT;
		self.ammo_nails = self.grencount;
	}
	if(self.nextrole == ROLE_FIGHTER)
	{
		self.role = ROLE_FIGHTER;
		self.nextrole = ROLE_FIGHTER;
		sprint(self, PRINT_HIGH, "playing as fighter.\n");
		self.weapon = WPN_ROCKETLAUNCHER;
		self.items = self.items | IT_ARMOR2;
		self.armorvalue = ARMOUR_MAX_FIGHTER;
		FO_SetModel(self, "progs/player.mdl");
		modelindex_player = self.modelindex;
		self.clip_curr_primary = CLIP_MAX_ROCKETLAUNCHER;
		self.clip_curr_secondary = CLIP_MAX_SUPERSHOTGUN;
		self.clip_curr_tertiary = CLIP_MAX_SHOTGUN;
		self.ammo_cells = 75;
		self.grencount = MAX_GRENCOUNT;
		self.ammo_nails = self.grencount;
	}
	if(self.nextrole == ROLE_BOMBER)
	{
		self.role = ROLE_BOMBER;
		self.nextrole = ROLE_BOMBER;
		sprint(self, PRINT_HIGH, "playing as a bomber.\n");
		self.weapon = WPN_PIPELAUNCHER;
		self.items = self.items | IT_ARMOR2;
		self.armorvalue = ARMOUR_MAX_BOMBER;
		FO_SetModel(self, "progs/player.mdl");
		modelindex_player = self.modelindex;
		self.clip_curr_primary = CLIP_MAX_PIPELAUNCHER;
		self.clip_curr_secondary = CLIP_MAX_SUPERSHOTGUN;
		self.clip_curr_tertiary = CLIP_MAX_SHOTGUN;
		self.ammo_cells = 100;
		self.grencount = MAX_GRENCOUNT;
		self.ammo_nails = self.grencount;
	}	
	if(self.nextrole == ROLE_SUPPORT)
	{
		self.role = ROLE_SUPPORT;
		self.nextrole = ROLE_SUPPORT;
		sprint(self, PRINT_HIGH, "playing as support.\n");
		self.weapon = WPN_SHAFT;
		self.items = self.items | IT_ARMOR2;
		self.armorvalue = ARMOUR_MAX_SUPPORT;
		FO_SetModel(self, "progs/player.mdl");
		modelindex_player = self.modelindex;
		self.clip_curr_primary = CLIP_MAX_SHAFT;
		self.clip_curr_secondary = CLIP_MAX_SUPERSHOTGUN;
		self.clip_curr_tertiary = CLIP_MAX_SHOTGUN;
		self.ammo_cells = 75;
		self.grencount = MAX_GRENCOUNT;
		self.ammo_nails = self.grencount;
	}
	player_stand1();
	SetTeamFragsColourName();
	W_SetCurrentWeaponModel();
	W_SetCurrentAmmo();
	ClearPlayerState();
	SpawnAliasHelper();
	SetPlayerSkin();
	ExecTeamConfig();
	ExecClassConfig();
	SetPlayerSpeed();
	
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
