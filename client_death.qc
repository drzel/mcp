// called by ClientKill and DeadThink
void() respawn =
{
	// make a copy of the dead body for appearances sake
	//CopyToBodyQue (self);
	CreateCorpse(self);
	
	// set default spawn parms
	SetNewParms ();
	// respawn              
	PutClientInServer ();
};

void() ClientKill =
{

	if(self.deadflag)
		return;

	
	if(matchstate == MATCHSTATE_LIVE)
	{
		bprint (PRINT_MEDIUM, self.netname);
		bprint (PRINT_MEDIUM, " suicides\n");
		AddStat(self, STAT_SUICIDE, 1);

	}
	set_suicide_frame ();
	self.health = -1;
	self.modelindex = modelindex_player;
	self.movetype = MOVETYPE_NONE;
	
	//logfrag (self, self);
	//self.frags = self.frags - 1;    // extra penalty
	
	self.th_die ();
	//respawn ();
	SetNextRespawn(self, 1);
};