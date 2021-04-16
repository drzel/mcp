
/*
============
IntermissionThink

When the player presses attack or jump, change to the next level
============
*/
void() IntermissionThink =
{
	if (time < intermission_exittime)
		return;

	//if (!self.button0 && !self.button1 && !self.button2)
	//	return;
	
	GotoNextMap ();
};














void() PlayerDeathThink =
{
	local entity    old_self;
	local float             forward;
	
	if ((self.flags & FL_ONGROUND))
	{
		forward = vlen (self.velocity);
		forward = forward - 20;
		if (forward <= 0)
			self.velocity = '0 0 0';
		else    
			self.velocity = forward * normalize(self.velocity);
	}
	//bprint(2,"zzzzapdeath\n");
	MenuInputImpulses();
	DeadOrAliveImpulses();


// wait for all buttons released
	if (self.deadflag == DEAD_DEAD)
	{
		if (self.button2 || self.button1 || self.button0)
			return;
		self.deadflag = DEAD_RESPAWNABLE;
		return;
	}
	if(self.role == ROLE_NONE || self.nextrole == ROLE_NONE)
		return;
	


// wait for any button down
	if (!self.button2 && !self.button1 && !self.button0 && !isQuickShotting())
		return;

	self.button0 = 0;
	self.button1 = 0;
	self.button2 = 0;
	if(time > self.nextrespawn)
		respawn();
	else
	{
		if(time < self.cnt)
			return; 
			
		local float rtimeleft = ceil(self.nextrespawn - time);
		self.cnt = time + 0.75;	//next avail check
		if(rtimeleft == 1)
			sprint(self,PRINT_HIGH, strcat("you can respawn in: ",ftos(rtimeleft)," second.\n"));
		else
			sprint(self,PRINT_HIGH, strcat("you can respawn in: ",ftos(rtimeleft)," second.\n"));
		stuffcmd(self, "play beta1/error.wav\n");
	}
};




/*
================
PlayerPreThink

Called every frame before physics are run
================
*/
void() PlayerPreThink =
{
	local   float   mspeed, aspeed;
	local   float   r;
	
	if (intermission_running)
	{
		IntermissionThink ();   // otherwise a button could be missed between
		return;                                 // the think tics
	}

	if (self.view_ofs == '0 0 0')
		return;         // intermission or finale

	makevectors (self.v_angle);             // is this still used

        self.deathtype = "";

	CheckRules ();
	WaterMove ();
/*
	if (self.waterlevel == 2)
		CheckWaterJump ();
*/

	if (self.deadflag >= DEAD_DEAD)
	{
		PlayerDeathThink ();
		return;
	}
	
	if (self.deadflag == DEAD_DYING)
	{
		return; // dying, so do nothing
	}

	if (self.button2)
	{
		PlayerJump ();
	}
	else
		self.flags = self.flags | FL_JUMPRELEASED;

// teleporters can force a non-moving pause time        
	if (time < self.pausetime)
		self.velocity = '0 0 0';

	//if(time > self.attack_finished && self.currentammo == 0 && self.weapon != IT_AXE)
	//{
		//self.weapon = W_BestWeapon ();
		//W_SetCurrentAmmo ();
	//}
	
};
	

/*
================
PlayerPostThink

Called every frame after physics are run
================
*/
void() PlayerPostThink =
{
	local   float   mspeed, aspeed;
	local   float   r;

//dprint ("post think\n");
	if (self.view_ofs == '0 0 0')
		return;         // intermission or finale
	if (self.deadflag)
		return;
	//bprint(2,strcat(ftos(self.v_angle_x),"dirgg\n"));
// check to see if player landed and play landing sound 
	//if ((self.jump_flag < -20) && (self.flags & FL_ONGROUND) )
	//{
	//		GoombaStomp();
	//}
	if (self.flags & FL_ONGROUND && self.hasbeenmidaired)
	{
		KillMidairEnt();
		self.hasbeenmidaired = 0;
	}
	if ((self.jump_flag < -300) && (self.flags & FL_ONGROUND) )
	{
		if (self.watertype == CONTENT_WATER)
			FO_Sound(self, CHAN_BODY, "player/h2ojump.wav", 1, ATTN_NORM);
		else if (self.jump_flag < -650)
		{
			self.deathtype = "falling";
			T_Damage (self, world, world, 5); 
			FO_Sound(self, CHAN_VOICE, "player/land2.wav", 1, ATTN_NORM);
		}
		else
			FO_Sound(self, CHAN_VOICE, "player/land.wav", 1, ATTN_NORM);
	}

	self.jump_flag = self.velocity_z;
	
	if (fabs(self.velocity_x) >= 10 || fabs(self.velocity_y) >= 10)
	{
		self.ismoving = 1;
	}
	else
	{
		self.ismoving = 0;
	}
	
	W_WeaponFrame ();
	RegenCells ();
	RegenHealthArmour();
	CPrintRefresh();
	
	
};




