void ReloadThink_SuperShotgun() =
{
	//sound (self.owner, CHAN_WEAPON, "beta1/reload_supershotgun.wav", 1, ATTN_NORM);
	stuffcmd(self.owner, "play beta1/reload_supershotgun.wav\n");
	self.owner.clip_curr_secondary = self.owner.clip_curr_secondary + 1;
	self.owner.currentammo = self.owner.clip_curr_secondary;
	W_SetCurrentAmmo();
	self.nextthink = time + RELOADTIME_SUPERSHOTGUN;
	
	if (self.owner.clip_curr_secondary >= CLIP_MAX_SUPERSHOTGUN)
	{
		sprint(self.owner, PRINT_HIGH, "super shotgun reloaded.\n");
		W_SetCurrentWeaponModel();
		W_SetCurrentAmmo();

		
		self.think = SUB_Remove;
		self.nextthink = time + 0.1;
		self.owner.reload_complete = 1;
		self.owner.attack_finished = time + 0.3;	//slight buffer for hud cosmetic reasons
	}
};

void ReloadThink_RocketLauncher() =
{

	//sound (self.owner, CHAN_WEAPON, "beta1/reload_rocket.wav", 1, ATTN_NORM);
	stuffcmd(self.owner, "play beta1/reload_rocket.wav\n");
	self.owner.clip_curr_primary = self.owner.clip_curr_primary + 1;
	self.owner.currentammo = self.owner.clip_curr_primary;
	W_SetCurrentAmmo();
	self.nextthink = time + RELOADTIME_ROCKETLAUNCHER;
	
	if (self.owner.clip_curr_primary >= CLIP_MAX_ROCKETLAUNCHER)
	{
		sprint(self.owner, PRINT_HIGH, "rocket launcher reloaded.\n");
		W_SetCurrentWeaponModel();
		W_SetCurrentAmmo();

		self.think = SUB_Remove;
		self.nextthink = time + 0.1;
		self.owner.reload_complete = 1;
		self.owner.attack_finished = time + 0.3;	//slight buffer for hud cosmetic reasons
	}
};

void ReloadThink_PipeLauncher() =
{
	//sound (self.owner, CHAN_WEAPON, "beta1/reload_sticky.wav", 1, ATTN_NORM);
	stuffcmd(self.owner, "play beta1/reload_sticky.wav\n");
	self.owner.clip_curr_primary = self.owner.clip_curr_primary + 1;
	self.owner.currentammo = self.owner.clip_curr_primary;
	W_SetCurrentAmmo();
	self.nextthink = time + RELOADTIME_PIPELAUNCHER;
	
	if (self.owner.clip_curr_primary >= CLIP_MAX_PIPELAUNCHER)
	{
		sprint(self.owner, PRINT_HIGH, "sticky launcher reloaded.\n");
		W_SetCurrentWeaponModel();
		W_SetCurrentAmmo();

		self.think = SUB_Remove;
		self.nextthink = time + 0.1;
		self.owner.reload_complete = 1;
		self.owner.attack_finished = time + 0.3;	//slight buffer for hud cosmetic reasons
	}
};

void ReloadThink_Shotgun() =
{
	//sound (self.owner, CHAN_WEAPON, "beta1/reload_shotgun.wav", 1, ATTN_NORM);
	stuffcmd(self.owner, "play beta1/reload_shotgun.wav\n");
	self.owner.clip_curr_tertiary = self.owner.clip_curr_tertiary + 1;
	self.owner.currentammo = self.owner.clip_curr_tertiary;
	W_SetCurrentAmmo();
	self.nextthink = time + RELOADTIME_SHOTGUN;
	
	if (self.owner.clip_curr_tertiary >= CLIP_MAX_SHOTGUN)
	{
		sprint(self.owner, PRINT_HIGH, "shotgun reloaded.\n");
		W_SetCurrentWeaponModel();
		W_SetCurrentAmmo();

		self.think = SUB_Remove;
		self.nextthink = time + 0.1;
		self.owner.reload_complete = 1;
		self.owner.attack_finished = time + 0.3;	//slight buffer for hud cosmetic reasons
	}
};

void ReloadThink_Nailgun() =
{
	//sound (self.owner, CHAN_WEAPON, "beta1/reload_supernailgun.wav", 1, ATTN_NORM);
	stuffcmd(self.owner, "play beta1/reload_supernailgun.wav\n");
	self.owner.clip_curr_primary = self.owner.clip_curr_primary + 1;
	self.owner.currentammo = self.owner.clip_curr_primary;
	W_SetCurrentAmmo();
	self.nextthink = time + RELOADTIME_NAILGUN;
	
	if (self.owner.clip_curr_primary >= CLIP_MAX_NAILGUN)
	{
		sprint(self.owner, PRINT_HIGH, "super nailgun reloaded.\n");
		W_SetCurrentWeaponModel();
		W_SetCurrentAmmo();

		self.think = SUB_Remove;
		self.nextthink = time + 0.1;
		self.owner.reload_complete = 1;
		self.owner.attack_finished = time + 0.3;	//slight buffer for hud cosmetic reasons
	}
};

void ReloadThink_Shaft() =
{
	//sound (self.owner, CHAN_WEAPON, "beta1/reload_shaft.wav", 1, ATTN_NORM);
	stuffcmd(self.owner, "play beta1/reload_shaft.wav\n");
	self.owner.clip_curr_primary = self.owner.clip_curr_primary + 1;
	self.owner.currentammo = self.owner.clip_curr_primary;
	W_SetCurrentAmmo();
	self.nextthink = time + RELOADTIME_SHAFT;
	
	if (self.owner.clip_curr_primary >= CLIP_MAX_SHAFT)
	{
		sprint(self.owner, PRINT_HIGH, "shaft reloaded.\n");
		W_SetCurrentWeaponModel();
		W_SetCurrentAmmo();

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
		self.owner.weaponmodel = "";
		self.owner.weaponframe = 0;
		self.owner.clip_curr_primary = 1;
		self.nextthink = time + RELOADTIME_RAILGUN;

		return;
	}


	//sound (self.owner, CHAN_WEAPON, "beta1/reload_railgun.wav", 1, ATTN_NORM);
	sprint(self.owner, PRINT_HIGH, "railgun reloaded.\n");
	W_SetCurrentWeaponModel();
	W_SetCurrentAmmo();

	self.think = SUB_Remove;
	self.nextthink = time + 0.1;
	self.owner.reload_complete = 1;
	self.owner.attack_finished = time + 0.3;	//slight buffer for hud cosmetic reasons

};



void ReloadWeapon() =
{
	self.impulse = 0;
	local float w = self.weapon;
	if (self.isreloading == 1)
	{
		return;
	}
	
	local entity te;
	
	if(w == WPN_SHOTGUN)
	{
		if (self.clip_curr_tertiary >= CLIP_MAX_SHOTGUN)
		{
			sprint(self, PRINT_HIGH, "already full.\n");
			return;
		}

		te = spawn();			
		te.classname = "reload";
		te.owner = self;
		te.weapon = w;
		te.think = ReloadThink_Shotgun;
		te.nextthink = time + RELOADTIME_SHOTGUN;
		self.isreloading = 1;
		sprint(self, PRINT_HIGH, "reloading shotgun.\n");
		self.weaponmodel = "";
		self.weaponframe = 0;
	}
	
	if(w == WPN_SUPERSHOTGUN)
	{
		if (self.clip_curr_secondary >= CLIP_MAX_SUPERSHOTGUN)
		{
			sprint(self, PRINT_HIGH, "already full.\n");
			return;
		}

		te = spawn();			
		te.classname = "reload";
		te.owner = self;
		te.weapon = w;
		te.think = ReloadThink_SuperShotgun;
		te.nextthink = time + RELOADTIME_SUPERSHOTGUN;
		self.isreloading = 1;
		sprint(self, PRINT_HIGH, "reloading super shotgun.\n");
		self.weaponmodel = "";
		self.weaponframe = 0;
	}
	
	if(w == WPN_NAILGUN)
	{
		if (self.clip_curr_primary >= CLIP_MAX_NAILGUN)
		{
			sprint(self, PRINT_HIGH, "already full.\n");
			return;
		}	
			
		te = spawn();			
		te.classname = "reload";
		te.owner = self;
		te.weapon = w;
		te.think = ReloadThink_Nailgun;
		te.nextthink = time + RELOADTIME_NAILGUN;
		self.isreloading = 1;
		sprint(self, PRINT_HIGH, "reloading super nailgun.\n");
		self.weaponmodel = "";
		self.weaponframe = 0;	
	}
	
	if(w == WPN_ROCKETLAUNCHER)
	{
		if (self.clip_curr_primary >= CLIP_MAX_ROCKETLAUNCHER)
		{
			sprint(self, PRINT_HIGH, "already full.\n");
			return;
		}

		te = spawn();			
		te.classname = "reload";
		te.owner = self;
		te.weapon = w;
		te.think = ReloadThink_RocketLauncher;
		te.nextthink = time + RELOADTIME_ROCKETLAUNCHER;
		self.isreloading = 1;
		sprint(self, PRINT_HIGH, "reloading rocket launcher.\n");
		self.weaponmodel = "";
		self.weaponframe = 0;
	}
	if(w == WPN_PIPELAUNCHER)
	{
		if (self.clip_curr_primary >= CLIP_MAX_PIPELAUNCHER)
		{
			sprint(self, PRINT_HIGH, "already full.\n");
			return;
		}

		te = spawn();			
		te.classname = "reload";
		te.owner = self;
		te.weapon = w;
		te.think = ReloadThink_PipeLauncher;
		te.nextthink = time + RELOADTIME_PIPELAUNCHER;
		self.isreloading = 1;
		sprint(self, PRINT_HIGH, "reloading sticky launcher.\n");
		self.weaponmodel = "";
		self.weaponframe = 0;
	}
	if(w == WPN_SHAFT)
	{
		if (self.clip_curr_primary >= CLIP_MAX_SHAFT)
		{
			sprint(self, PRINT_HIGH, "already full.\n");
			return;
		}	
			
		te = spawn();			
		te.classname = "reload";
		te.owner = self;
		te.weapon = w;
		te.think = ReloadThink_Shaft;
		te.nextthink = time + RELOADTIME_SHAFT;
		self.isreloading = 1;
		sprint(self, PRINT_HIGH, "reloading shaft.\n");
		self.weaponmodel = "";
		self.weaponframe = 0;	
	}
	if(w == WPN_RAILGUN)
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
		te.weapon = w;
		te.think = ReloadThink_Railgun;
		te.nextthink = time + 0.5;
		self.isreloading = 1;
	}
};