void ReloadThink_SuperShotgun() =
{
	stuffcmd(self.owner, "play beta1/reload_supershotgun.wav\n");
	self.owner.clip_curr_secondary = self.owner.clip_curr_secondary + 1;
	//self.owner.currentammo = self.owner.clip_curr_secondary;
	ChangeHudAmmo(self.owner,WPN_SUPERSHOTGUN);
	//self.owner.items = self.owner.items - ( self.owner.items & ( IT_SHELLS | IT_NAILS | IT_ROCKETS | IT_CELLS) );
	//self.owner.items = self.owner.items | IT_SHELLS;
	
	self.nextthink = time + RELOADTIME_SUPERSHOTGUN;
	
	if (self.owner.clip_curr_secondary >= CLIP_MAX_SUPERSHOTGUN)
	{
		sprint(self.owner, PRINT_HIGH, "super shotgun reloaded.\n");
		self.think = SUB_Remove;
		self.nextthink = time + 0.1;
		self.owner.reload_complete = 1;
		self.owner.attack_finished = time + 0.3;	//slight buffer for hud cosmetic reasons
	}
};

void ReloadThink_RocketLauncher() =
{

	stuffcmd(self.owner, "play beta1/reload_rocket.wav\n");
	self.owner.clip_curr_primary = self.owner.clip_curr_primary + 1;
	//self.owner.currentammo = self.owner.clip_curr_primary;
	ChangeHudAmmo(self.owner,WPN_ROCKETLAUNCHER);
	//self.owner.items = self.owner.items - ( self.owner.items & ( IT_SHELLS | IT_NAILS | IT_ROCKETS | IT_CELLS) );
	//self.owner.items = self.owner.items | IT_ROCKETS;
	
	self.nextthink = time + RELOADTIME_ROCKETLAUNCHER;
	
	if (self.owner.clip_curr_primary >= CLIP_MAX_ROCKETLAUNCHER)
	{
		sprint(self.owner, PRINT_HIGH, "rocket launcher reloaded.\n");
		self.think = SUB_Remove;
		self.nextthink = time + 0.1;
		self.owner.reload_complete = 1;
		self.owner.attack_finished = time + 0.3;	//slight buffer for hud cosmetic reasons
	}
};

void ReloadThink_PipeLauncher() =
{
	stuffcmd(self.owner, "play beta1/reload_sticky.wav\n");
	self.owner.clip_curr_primary = self.owner.clip_curr_primary + 1;
	//self.owner.currentammo = self.owner.clip_curr_primary;
	ChangeHudAmmo(self.owner,WPN_PIPELAUNCHER);
	//self.owner.items = self.owner.items - ( self.owner.items & ( IT_SHELLS | IT_NAILS | IT_ROCKETS | IT_CELLS) );
	//self.owner.items = self.owner.items | IT_ROCKETS;
	
	self.nextthink = time + RELOADTIME_PIPELAUNCHER;
	
	if (self.owner.clip_curr_primary >= CLIP_MAX_PIPELAUNCHER)
	{
		sprint(self.owner, PRINT_HIGH, "grenade launcher reloaded.\n");
		self.think = SUB_Remove;
		self.nextthink = time + 0.1;
		self.owner.reload_complete = 1;
		self.owner.attack_finished = time + 0.3;	//slight buffer for hud cosmetic reasons
	}
};

void ReloadThink_Shotgun() =
{
	stuffcmd(self.owner, "play beta1/reload_shotgun.wav\n");
	self.owner.clip_curr_tertiary = self.owner.clip_curr_tertiary + 1;
	//self.owner.currentammo = self.owner.clip_curr_tertiary;
	ChangeHudAmmo(self.owner,WPN_SHOTGUN);
	//self.owner.items = self.owner.items - ( self.owner.items & ( IT_SHELLS | IT_NAILS | IT_ROCKETS | IT_CELLS) );
	//self.owner.items = self.owner.items | IT_SHELLS;
	
	self.nextthink = time + RELOADTIME_SHOTGUN;
	
	if (self.owner.clip_curr_tertiary >= CLIP_MAX_SHOTGUN)
	{
		sprint(self.owner, PRINT_HIGH, "shotgun reloaded.\n");
		self.think = SUB_Remove;
		self.nextthink = time + 0.1;
		self.owner.reload_complete = 1;
		self.owner.attack_finished = time + 0.3;	//slight buffer for hud cosmetic reasons
	}
};

void ReloadThink_Nailgun() =
{
	stuffcmd(self.owner, "play beta1/reload_supernailgun.wav\n");
	self.owner.clip_curr_primary = self.owner.clip_curr_primary + 1;
	//self.owner.currentammo = self.owner.clip_curr_primary;
	ChangeHudAmmo(self.owner,WPN_NAILGUN);
	//self.owner.items = self.owner.items - ( self.owner.items & ( IT_SHELLS | IT_NAILS | IT_ROCKETS | IT_CELLS) );
	//self.owner.items = self.owner.items | IT_NAILS;
	
	self.nextthink = time + RELOADTIME_NAILGUN;
	
	if (self.owner.clip_curr_primary >= CLIP_MAX_NAILGUN)
	{
		sprint(self.owner, PRINT_HIGH, "super nailgun reloaded.\n");
		self.think = SUB_Remove;
		self.nextthink = time + 0.1;
		self.owner.reload_complete = 1;
		self.owner.attack_finished = time + 0.3;	//slight buffer for hud cosmetic reasons
	}
};

void ReloadThink_Shaft() =
{
	stuffcmd(self.owner, "play beta1/reload_shaft.wav\n");
	self.owner.clip_curr_primary = self.owner.clip_curr_primary + 1;
	//self.owner.currentammo = self.owner.clip_curr_primary;
	ChangeHudAmmo(self.owner,WPN_SHAFT);
	//self.owner.items = self.owner.items - ( self.owner.items & ( IT_SHELLS | IT_NAILS | IT_ROCKETS | IT_CELLS) );
	//self.owner.items = self.owner.items | IT_CELLS;
	
	self.nextthink = time + RELOADTIME_SHAFT;
	
	if (self.owner.clip_curr_primary >= CLIP_MAX_SHAFT)
	{
		sprint(self.owner, PRINT_HIGH, "shaft reloaded.\n");
		self.think = SUB_Remove;
		self.nextthink = time + 0.1;
		self.owner.reload_complete = 1;
		self.owner.attack_finished = time + 0.3;	//slight buffer for hud cosmetic reasons
	}
};

void ReloadThink_Railgun() =
{

	if (self.owner.clip_curr_primary == 0)
	{
		self.owner.isreloading = 1;
		sprint(self.owner, PRINT_HIGH, "reloading railgun.\n");
		ChangeHudAmmo(self.owner,WPN_RAILGUN);
		//self.owner.items = self.owner.items - ( self.owner.items & ( IT_SHELLS | IT_NAILS | IT_ROCKETS | IT_CELLS) );
		//self.owner.items = self.owner.items | IT_NAILS;
		
		self.owner.weaponmodel = "";
		self.owner.weaponframe = 0;
		self.owner.clip_curr_primary = 1;
		self.nextthink = time + RELOADTIME_RAILGUN;

		return;
	}

	sprint(self.owner, PRINT_HIGH, "railgun reloaded.\n");

	self.think = SUB_Remove;
	self.nextthink = time + 0.1;
	self.owner.reload_complete = 1;
	self.owner.attack_finished = time + 0.3;	//slight buffer for hud cosmetic reasons

};

void ReloadNext() =
{
	self.impulse = 0;
	if (self.isreloading == 1)
	{
		return;
	}
	local float maxprimary = 0;
	local float primwpn = 0;
	
	if(self.role == ROLE_RECON)
	{
		primwpn = WPN_NAILGUN;
		maxprimary = CLIP_MAX_NAILGUN;
	}
	if(self.role == ROLE_ASSASSIN)
	{
		primwpn = WPN_RAILGUN;
		maxprimary = CLIP_MAX_RAILGUN;
	}
	if(self.role == ROLE_FIGHTER)
	{
		primwpn = WPN_ROCKETLAUNCHER;
		maxprimary = CLIP_MAX_ROCKETLAUNCHER;
	}
	if(self.role == ROLE_BOMBER)
	{
		primwpn = WPN_PIPELAUNCHER;
		maxprimary = CLIP_MAX_PIPELAUNCHER;
	}
	if(self.role == ROLE_SUPPORT)
	{
		primwpn = WPN_SHAFT;
		maxprimary = CLIP_MAX_SHAFT;
	}
		
		
	if(self.clip_curr_primary < maxprimary)
	{
		ReloadWeapon(primwpn);
		return;
	}
	else if (self.clip_curr_secondary < CLIP_MAX_SUPERSHOTGUN)
	{
		ReloadWeapon(WPN_SUPERSHOTGUN);
		return;
	}
	else if (self.clip_curr_tertiary < CLIP_MAX_SHOTGUN)
	{
		ReloadWeapon(WPN_SHOTGUN);
		return;
	}
	
	sprint(self, PRINT_HIGH, "all weapons already full.\n");
	
};


void ReloadWeapon(float wpn) =
{
	self.impulse = 0;
	
	if (self.isreloading == 1)
		return;

	if(self.role == ROLE_NONE)
		return;
	
	local entity te;

	
	
	if(wpn == WPN_SHOTGUN)
	{
		if (self.clip_curr_tertiary >= CLIP_MAX_SHOTGUN)
		{
			sprint(self, PRINT_HIGH, "already full.\n");
			return;
		}

		te = spawn();			
		te.classname = "reload";
		te.owner = self;
		te.weapon = wpn;
		te.think = ReloadThink_Shotgun;
		te.nextthink = time + RELOADTIME_SHOTGUN;
		self.isreloading = 1;
		sprint(self, PRINT_HIGH, "reloading shotgun.\n");
		self.weaponmodel = "";
		self.weaponframe = 0;
		self.reloadingweapon = WPN_SHOTGUN;
	}
	
	if(wpn == WPN_SUPERSHOTGUN)
	{
		if (self.clip_curr_secondary >= CLIP_MAX_SUPERSHOTGUN)
		{
			sprint(self, PRINT_HIGH, "already full.\n");
			return;
		}

		te = spawn();			
		te.classname = "reload";
		te.owner = self;
		te.weapon = wpn;
		te.think = ReloadThink_SuperShotgun;
		te.nextthink = time + RELOADTIME_SUPERSHOTGUN;
		self.isreloading = 1;
		sprint(self, PRINT_HIGH, "reloading super shotgun.\n");
		self.weaponmodel = "";
		self.weaponframe = 0;
		self.reloadingweapon = WPN_SUPERSHOTGUN;

	}
	
	if(wpn == WPN_NAILGUN)
	{
		if (self.clip_curr_primary >= CLIP_MAX_NAILGUN)
		{
			sprint(self, PRINT_HIGH, "already full.\n");
			return;
		}	

		te = spawn();			
		te.classname = "reload";
		te.owner = self;
		te.weapon = wpn;
		te.think = ReloadThink_Nailgun;
		te.nextthink = time + RELOADTIME_NAILGUN;
		self.isreloading = 1;
		sprint(self, PRINT_HIGH, "reloading super nailgun.\n");
		self.weaponmodel = "";
		self.weaponframe = 0;	
		self.reloadingweapon = WPN_NAILGUN;

	}
	
	if(wpn == WPN_ROCKETLAUNCHER)
	{
		if (self.clip_curr_primary >= CLIP_MAX_ROCKETLAUNCHER)
		{
			sprint(self, PRINT_HIGH, "already full.\n");
			return;
		}
		te = spawn();			
		te.classname = "reload";
		te.owner = self;
		te.weapon = wpn;
		te.think = ReloadThink_RocketLauncher;
		te.nextthink = time + RELOADTIME_ROCKETLAUNCHER;
		self.isreloading = 1;
		sprint(self, PRINT_HIGH, "reloading rocket launcher.\n");
		self.weaponmodel = "";
		self.weaponframe = 0;
		self.reloadingweapon = WPN_ROCKETLAUNCHER;

	}
	if(wpn == WPN_PIPELAUNCHER)
	{
		if (self.clip_curr_primary >= CLIP_MAX_PIPELAUNCHER)
		{
			sprint(self, PRINT_HIGH, "already full.\n");
			return;
		}

		te = spawn();			
		te.classname = "reload";
		te.owner = self;
		te.weapon = wpn;
		te.think = ReloadThink_PipeLauncher;
		te.nextthink = time + RELOADTIME_PIPELAUNCHER;
		self.isreloading = 1;
		sprint(self, PRINT_HIGH, "reloading grenade launcher.\n");
		self.weaponmodel = "";
		self.weaponframe = 0;
		self.reloadingweapon = WPN_PIPELAUNCHER;
	}
	if(wpn == WPN_SHAFT)
	{
		if (self.clip_curr_primary >= CLIP_MAX_SHAFT)
		{
			sprint(self, PRINT_HIGH, "already full.\n");
			return;
		}	

		te = spawn();			
		te.classname = "reload";
		te.owner = self;
		te.weapon = wpn;
		te.think = ReloadThink_Shaft;
		te.nextthink = time + RELOADTIME_SHAFT;
		self.isreloading = 1;
		sprint(self, PRINT_HIGH, "reloading shaft.\n");
		self.weaponmodel = "";
		self.weaponframe = 0;
		self.reloadingweapon = WPN_SHAFT;

	}
	if(wpn == WPN_RAILGUN)
	{
		if (self.clip_curr_primary >= CLIP_MAX_RAILGUN)
		{
			sprint(self, PRINT_HIGH, "already loaded.\n");
			return;
		}
		//think before hiding weapon to give animation chance to play

		te = spawn();			
		te.classname = "reload";
		te.owner = self;
		te.weapon = wpn;
		te.think = ReloadThink_Railgun;
		te.nextthink = time + 0.5;
		self.isreloading = 1;
		self.reloadingweapon = WPN_RAILGUN;

	}


};