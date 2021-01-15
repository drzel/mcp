// called by ClientKill and DeadThink
void() respawn =
{
	// make a copy of the dead body for appearances sake
	CopyToBodyQue (self);
	// set default spawn parms
	SetNewParms ();
	// respawn              
	PutClientInServer ();
};

void() ClientKill =
{
	if(self.role == ROLE_NONE)
		return;


	if(self.deadflag)
		return;

	if(matchstate == MATCHSTATE_LIVE)
	{
		bprint (PRINT_MEDIUM, self.netname);
		bprint (PRINT_MEDIUM, " suicides\n");
	}
	set_suicide_frame ();
	self.health = 0;
	self.modelindex = modelindex_player;
	self.movetype = MOVETYPE_NONE;
	
	//logfrag (self, self);
	//self.frags = self.frags - 1;    // extra penalty
	self.th_die ();
	//respawn ();
};