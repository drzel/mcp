//
/*
===========
PutClientInServer

called each time a player enters a new level
============
*/
void() PutClientInServer =
{

	self.classname = "player";
	//self.health = 100;
	//self.takedamage = DAMAGE_AIM;
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_WALK;
	self.show_hostile = 0;
	//self.max_health = 100;
	self.flags = FL_CLIENT;
	self.air_finished = time + 12;
	self.dmg = 2;                   // initial water damage
	self.super_damage_finished = 0;
	self.radsuit_finished = 0;
	self.invisible_finished = 0;
	self.invincible_finished = 0;
	self.effects = 0;
	self.invincible_time = 0;

	setmodel(self, string_null);
	modelindex_null = self.modelindex;

	setmodel(self, "progs/eyes.mdl");
	modelindex_eyes = self.modelindex;

	setmodel(self, "progs/player.mdl");
	modelindex_player = self.modelindex;

	DecodeLevelParms ();
	
	//W_SetCurrentAmmo ();

	self.attack_finished = time+0.5;
	self.th_pain = player_pain;
	self.th_die = PlayerDie;
	
	self.deadflag = DEAD_NO;
// paustime is set by teleporters to keep the player from moving a while
	self.pausetime = 0;
	
	//spot = SelectSpawnPoint ();
	//spot = SelectZutSpawnPoint();
	//self.origin = spot.origin + '0 0 1';
	//self.angles = spot.angles;
	//self.fixangle = TRUE;           // turn this way immediately

	SpawnPlayerZut();
// oh, this is a hack!
	//setmodel (self, "progs/eyes.mdl");
	//modelindex_eyes = self.modelindex;

	//setmodel (self, "progs/player.mdl");
	//modelindex_player = self.modelindex;

	//setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	
	
	//self.view_ofs = '0 0 22';

// Mod - Xian (May.20.97)
// Bug where player would have velocity from their last kill


};

/*
===========
ClientConnect

called when a player connects to a server
============
*/



void() ClientConnect =
{
	bprint (PRINT_HIGH, self.netname);
	bprint (PRINT_HIGH, " entered the game\n");
	self.isconnected = 1;
// a client connecting during an intermission can cause problems

	if (intermission_running)
		GotoNextMap ();
};


/*
===========
ClientDisconnect

called when a player disconnects from a server
============
*/
void() ClientDisconnect =
{
	// let everyone else know
	bprint (PRINT_HIGH, self.netname);
		bprint (PRINT_HIGH, " left the game\n");
		//bprint (PRINT_HIGH, ftos(self.frags));
		//bprint (PRINT_HIGH, " frags\n");
	FO_Sound(self, CHAN_BODY, "player/tornoff2.wav", 1, ATTN_NONE);
	set_suicide_frame ();
	ClearPlayerState();
	self.netname = string_null;
	self.team_no = TEAM_NONE;
	self.role = ROLE_NONE;
	self.solid = SOLID_NOT;
	setsize(self, '0 0 0', '0 0 0');
	self.isconnected = 0;
	//remove(self);
};