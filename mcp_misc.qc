void CheckStickyLimit() = 
{
	local entity oldest = world;
	local float stickycount = 0;
	local float limit = 6;
    
	local entity te = find(world, classname, "sticky_trap");
	while (te) 
	{
		if (te.owner == self.owner) 
		{
			stickycount = stickycount + 1;
			if (oldest == world)
				oldest = te;
			if(oldest.nextthink > te.nextthink)
				oldest = te;
		}
		te = find(te, classname, "sticky_trap");
        }

	if (oldest == world)
		return;
		
	if (stickycount > limit)
	{
		oldest.nextthink = time + 0.2;
	}
};

string GenSpace (float strLengthCurrent, float strLengthDesired) 
{
	
	local float numberOfSpaces = strLengthDesired - strLengthCurrent;
	local string whitespaceString;
	local float i;
	for (i = 0; i < numberOfSpaces; i = i + 1)
	{
		whitespaceString = strcat(whitespaceString," ");
	}
	return whitespaceString;
};

float GetRoleCount(float r, float t) =
{
	local float x = 0;
	local entity te = find (world, classname, "player");
	while (te) 
	{
		if (te.role == r) 
		{
			if(te.team_no == t)
				x = x + 1;
		}
		te = find (te, classname, "player");
		
	}
	
	return x;
};

float GetTeamCountCurrent(float team) =
{
	local float x = 0;
	local entity te = find (world, classname, "player");
	while (te) 
	{
		if (te.team_no == team) 
		{
			x = x + 1;
			
		}
		te = find (te, classname, "player");
	}
	
	return x;
};

void RefreshIdentifyString() =
{
	self.cprint_id = "\n\n";
	
	if(self.FlashTime > 0)
		return;
		
	local string ai;
	ai = infokey(self, "ai");
	
	if(ai == "0")
		return;
		
	makevectors (self.v_angle);
	local vector source = self.origin + '0 0 16';
	traceline (source, source + v_forward*5000, FALSE, self);
	if (trace_fraction == 1.0)
		return;

	if (trace_ent.classname != "player")
		return;
		
	if (trace_ent.iscloaked == 1)
		return;
	
	if(trace_ent.team_no == self.team_no)
	{
		self.cprint_id = strcat("(team) ", trace_ent.netname,"\n",ftos(trace_ent.health),"h ",ftos(trace_ent.armorvalue),"a\n");
	}
	else	
	{
		self.cprint_id = strcat("(enemy) ", trace_ent.netname,"\n\n");
	}
};

void RefreshObjectiveString() =
{
	if(infokey(self, "obj") == "0" || infokey(self, "obj") == "off" || self.team_no  == TEAM_NONE)
	{
		self.cprint_obj = "\n\n";
		return;
	}
	local string line1 = "\n";
	local string line2 = "\n";
	
	if(matchstate == MATCHSTATE_LIVE)
	{
	
		if (mcpflag.playerstate == MCPFLAGSTATE_NONE)
		{
			line1 = "the flag has not spawned yet!\n";
			line2 = "wait for flag to spawn in middle!\n";
		}
		else if (mcpflag.playerstate == MCPFLAGSTATE_RESET)
		{
			line1 = "the flag has spawned!\n";
			line2 = "get the flag from middle!\n";
		}
		else if (mcpflag.playerstate == MCPFLAGSTATE_CARRIED)
		{
			if(mcpflag.owner == self)
			{
				line1 = "you have the flag!\n";
				line2 = "capture flag in your base!\n";
			}
			else if(mcpflag.owner.team_no == self.team_no)
			{
				line1 = "a teammate has the flag!\n";
				line2 = strcat("protect ", mcpflag.owner.netname, "!\n");
			}
			else if(mcpflag.owner.team_no != self.team_no)
			{
				line1 = "the enemy carries the flag!\n";
				line2 = strcat("kill ", mcpflag.owner.netname, "!\n");
			}
			
		}
		else if (mcpflag.playerstate == MCPFLAGSTATE_THROWN || mcpflag.playerstate == MCPFLAGSTATE_DROPPED)
		{
			line1 = "the flag has been dropped somewhere!\n";
			line2 = "find the flag!\n";
			
		}
		else if (mcpflag.playerstate == MCPFLAGSTATE_CAPPED)
		{
			if(mcpflag.team_no == self.team_no)
			{
				line1 ="your team controls the flag!\n";
				line2 = "defend your base!\n";
			}
			else
			{
				line1 ="enemy controls the flag!\n";
				line2 = "attack enemy base!\n";
			}
		}
		
		if(self.FlashTime > 0)
		{
			line1 = "\n";
			line2 = "\n";
		}
		
	}
	
	if(infokey(self, "obj") == "2")
		line1 = "\n";
	if(infokey(self, "obj") == "3")
		line2 = "\n";
	self.cprint_obj = strcat(line1,"\n", line2);
	
};



void CPrintRefresh() =
{
	if(self.menu != MENU_NONE)
		return;
	if(self.FlashTime > 0)
		return;
	if(self.cprint_time > time)
		return;
		
	local float sb1count; 
	if(infokey(self,"sb1") == "")
		sb1count = 15;
	else

		sb1count = floor(stof(infokey(self,"sb1")));
		
	if (sb1count > 300)
		sb1count = 300;
        
	local string sb1space = "";
	while(sb1count > 0)
	{
		sb1space = strcat(sb1space,"\n");
		sb1count = sb1count - 1;
	}

	local float sb2count;
	if(infokey(self,"sb2") == "")
		sb2count = 30;
	else
		sb2count = floor(stof(infokey(self, "sb2")));
		
	if (sb2count > 300)
		sb2count = 300;
        
	local string sb2space = "";
	while(sb2count > 0)
	{
		sb2space = strcat(sb2space,"\n");
		sb2count = sb2count - 1;
	}
	
	RefreshIdentifyString();
	RefreshObjectiveString();
	
	if(matchstate == MATCHSTATE_LIVE)
	{
		if(infokey(self, "sbflip") == "1")
			centerprint(self, strcat(sb1space, self.cprint_obj, sb2space, self.cprint_id));
		else

			centerprint(self, strcat(sb1space, self.cprint_id, sb2space, self.cprint_obj));
	}
	else if(matchstate == MATCHSTATE_WAITINGFORPLAYERS)
	{
		if(infokey(self, "sbflip") == "1")
			centerprint(self, strcat(sb1space, cprint_waitingforplayers, sb2space, self.cprint_id));
		else
			centerprint(self, strcat(sb1space, self.cprint_id, sb2space, "waiting for the following players:\n\n", cprint_waitingforplayers));
	}
	self.cprint_time = time + 0.2;
};

void SoundTeam (float team, entity exclude, string file) =
{

	local entity te = find(world, classname, "player");
	while (te) 
	{

		if (te.team_no == team && te != exclude) 
		{
			stuffcmd(te, strcat("play ", file, "\n"));
		}
		te = find(te, classname, "player");
	}
};

void ResetVisDimensions(entity e) =
{
	e.dimension_see = DIM_WORLD;
	
	if(mcpflag.owner != e)
		e.dimension_see = e.dimension_see | DIM_FLAG;
	
	if(e.team_no == TEAM_BLUE)
		e.dimension_see = e.dimension_see | DIM_BLUETEAM;
	if(e.team_no == TEAM_RED)
		e.dimension_see = e.dimension_see | DIM_REDTEAM;
	if(e.pdim != 0)
		e.dimension_see = e.dimension_see | e.pdim;
	
		
	
};

void AddVisDimension (entity e, float dim) =
{
	e.dimension_see = e.dimension_see | dim;
};

void RemoveVisDimension (entity e, float dim) =
{
	e.dimension_see = e.dimension_see - (e.dimension_see & dim);
};

float ContainsVisDimension (entity e, float dim) =
{
	local float res = 0;
	
	if (e.dimension_see & dim)
		res = 1;
	
	return res;
};

void AssignPlayerDim() =
{
	if(self.pdim != 0)
		return;
	if(self.role == ROLE_NONE || self.nextrole == ROLE_NONE)
		return;
		
	local float res = 0;
	local float i;
	for (i = DIM_PLAYER1; i < DIM_PLAYER20; i = i * 2)
	{
		if(!(playerdims & i))
		{
			self.pdim = i;
			playerdims = playerdims | i;
			bprint(2,strcat(self.netname, " assigned dimension ", ftos(i), "\n"));
			res = 1;
			break;
		}
		
	}
	if(res == 0)
	{
		bprint(2,strcat("warning: couldnt find empty dimension for ", self.netname, "\n"));
		return;
	}

	
};

void UnassignPlayerDim() =
{
	if(self.pdim == 0)
		return;
	playerdims = playerdims - (playerdims & self.pdim);
};

void CreateDamageNumber(float damage, entity targ, entity attacker) =
{
	if(attacker.classname != "player")
		return;
	if(attacker.team_no == targ.team_no)
		return;
	if(attacker.pdim == 0)
		return;
		
	if(infokey(attacker, "nohitnumbers") == "1")
		return;
	damage = floor(damage);
	if(damage <= 0)
		return;

	if(damage > 999)
	{
		damage = 999;
	}
	
	local entity sp = spawn();
	sp.classname = "damagenumber";
	
	if(damage <= 512)
	{

		FO_SetModel(sp,"progs/beta1/mcp_dmgnum512.spr", attacker.pdim);
		sp.frame = damage-1;
	}
	else
	{
		FO_SetModel(sp,"progs/beta1/mcp_dmgnum999.spr", attacker.pdim);
		sp.frame = damage-512-1;
	}
	
		setsize (sp, '-16 -16 -32', '16 16 32');
		setorigin(sp, targ.origin + '0 0 64');
		sp.think = SUB_Remove;
		sp.nextthink = time + 2;
		sp.movetype = MOVETYPE_FLY;
		sp.solid = SOLID_NOT;
		sp.velocity = '0 0 1' * 150;
	
	
};

void pingvisual_think() =
{
	if(time > self.bubble_count)
	{

		remove(self);
		return;
	}
	if(self.model == "" && self.owner.pdim != 0)
	{

		FO_SetModel(self,"progs/beta1/mcp_pingt1.spr", self.owner.pdim);

	}
		
	traceline(self.owner.origin, self.gren.origin, 1, self);
	local float len = vlen(trace_endpos - self.owner.origin);
	
	local vector dir = normalize(trace_endpos - self.owner.origin);
	local float dist1 = vlen(trace_endpos - self.gren.origin);
	local float dist2 = vlen(self.gren.origin - self.owner.origin);
	//local float dist3 = vlen(t
	//local float dist3 = (disttoendpos/disttopoint);
	
	local float playertoping = vlen(self.gren.origin - self.owner.origin);
	local float tracetoping = vlen(self.gren.origin - trace_endpos);
	local float playertotrace = vlen(trace_endpos - self.owner.origin);
	
	local float playertopingperc = playertoping;
	if(playertopingperc >= 1500)
		playertopingperc = 1500;
	playertopingperc = 1 - (playertopingperc/1500);
	//bprint(2, strcat(ftos(playertopingperc),"trfrac\n"));
	
	if(trace_fraction != 1)
	{

		if(playertopingperc <= 0.1)
			self.frame = 0;
		else if (playertopingperc <= 0.2)
			self.frame = 1;
		else if (playertopingperc <= 0.3)
			self.frame = 2;
		else if (playertopingperc <= 0.4)
			self.frame = 3;
		else if (playertopingperc <= 0.5)
			self.frame = 4;
		else if (playertopingperc <= 0.6)
			self.frame = 5;
		else if (playertopingperc <= 0.7)
			self.frame = 6;
		else if (playertopingperc <= 0.8)
			self.frame = 7;
		else if (playertopingperc <= 0.9)
			self.frame = 8;
		else 
			self.frame = 9;
	}
	else
		self.frame = 9;
		
	
	local vector pos = self.owner.origin + (dir * (len * 0.9));	//doing this to pull sprite back a little bit
	
	pos = pos + '0 0 32';
	setorigin(self,pos);
	
	self.nextthink = time + 0.1;
	
	
};

void CreatePingPoint() =
{
	self.impulse = 0;
	if(self.nextpingpoint > time)
		return;
	//localcmd("say test\n");
	self.nextpingpoint = time + 0.5;
	makevectors (self.v_angle);
	//local vector org = self.origin + '0 0 16';
	local vector org = self.origin;
	traceline(org, org + v_forward * 3000, 1, self);
	//traceline
	
	local entity h = spawn();
	h.classname = "pingpoint";
	h.owner = self;
	h.nextthink = time + 3;
	h.think = SUB_Remove;
	
	setorigin(h, trace_endpos);
	SoundTeam (self.team_no, world, "beta1/alert.wav");
	//FO_SetModel(h,"progs/beta1/s_mcp.spr", self.pdim);
	//h.frame = SPRITE_BLUESPAWN;
	
	local entity te = find(world, classname, "player");
	while(te)
	{
		if(te.team_no == self.team_no)
		{
			local entity pingvis = spawn();
			pingvis.owner = te;
			pingvis.gren = h;
			pingvis.classname = "pingvisual";
			pingvis.think = pingvisual_think;
			pingvis.nextthink = time;
			pingvis.bubble_count = time + 3;
			setorigin(pingvis, trace_endpos);
		}
		te = find(te,classname,"player");
	}
};

vector ZutSubtract(vector a, vector b)
{
    	local vector res;
    	res_x = a_x-b_x;
    	res_y = a_y-b_y;
    	res_z = a_z-b_z;
        //return (a.x-b.x, a.y-b.y, a.z-b.z);
        return res;
};
    
vector ZutScale(float f, vector a)
    {
    	local vector res;
    	res_x = f * a_x;
    	res_y = f * a_y;
    	res_z = f * a_z;
    	return res;
        //return (f*a.x, f*a.y, f*a.z);
    };

float ZutDot(vector a, vector b)
    {
        return (a.x*b.x)+(a.y*b.y)+(a.z*b.z);
    };

vector ZutProjection(vector a, vector b)
    {
        return ZutScale(ZutDot(a, b)/ZutDot(b, b), b);
    };
    
vector ZutRejection(vector a, vector b)
    {
        return ZutSubtract(a, ZutProjection(a, b));
    };
    
vector ZutReflection(vector v, vector n)
{
    	local vector res = -2 * ZutDot(v,n) * n + v;
    	return res;
};

float prettynumber(float n)
{
	if(n == 0)
		return 0;
	else
	{	
		local string s = ftos(n);
		s = substring(s,0,6);
		n = stof(s);	
		return n;
	}	
};

string zstr(string s, float len) =
{
	s = substring(s,0,fabs(len));
	s = strpad(len,s);
	return s;
}; 

string znum(float f, float len) =
{
	//if(f == 0)
	//	f = 0;

	local string res = ftos(f);
	res = substring(res,0,fabs(len));
	res = strpad(len,res);
	return res;

};
string nlines(float f) =
{
	local string res = "";
	local float i;
	for(i = 0; i < f; i++)
	{
		strcat(res,"\n");
		
	}
	return res;
};
void UpdateAwardString(entity e, float step, float rng) = 
{
	
	//local entity entres;
	local entity entsearch;
	local string awardname;
	local string awardto;
	local string amount;
	local string personalamount;
	local string personalresult;
	local string result;
	
	local entity mostkills, mostdeath, mostgiven, mosttaken;
	local entity killstreak, flagcaps, flagtrail, stomps, ghost;
	local entity accuracy, combo, telefrag, shoulder, c4;
	
	local string mhead;
	local string mkills, mdeaths, mgiven, mtaken, mstreak;
	local string mcaps, mtrail, mstomp, mghost, maccuracy;
	local string mcombo, mtelefrag, mshoulder, mc4;
	
	
			
		entsearch = find(world, classname, "player");
		while (entsearch) 
		{
			if (entsearch.classname == "player") 
			{
				if(mostkills == world)
				{
					mostkills = entsearch;
					mostdeath= entsearch;
					mostgiven= entsearch;
					mosttaken= entsearch;
					killstreak= entsearch;
					flagcaps= entsearch;
					flagtrail= entsearch;
					stomps= entsearch;
					ghost= entsearch;
					accuracy= entsearch;
					combo = entsearch;
					c4 = entsearch;
					telefrag = entsearch;
					shoulder = entsearch;
				}
				else
				{
					if(entsearch.playerstats.kills > mostkills.playerstats.kills)
						mostkills = entsearch;
					if(entsearch.playerstats.deaths > mostdeath.playerstats.deaths)
						mostdeath = entsearch;
					if(entsearch.playerstats.dmggiven > mostgiven.playerstats.dmggiven)
						mostgiven = entsearch;
					if(entsearch.playerstats.dmgtaken > mosttaken.playerstats.dmgtaken)
						mosttaken = entsearch;
					if(entsearch.playerstats.bestkillstreak > killstreak.playerstats.bestkillstreak)
						killstreak = entsearch;
					if(entsearch.playerstats.flagcaps > flagcaps.playerstats.flagcaps)
						flagcaps = entsearch;
					if(entsearch.playerstats.flagtrailtouches > flagtrail.playerstats.flagtrailtouches)
						flagtrail = entsearch;
					if(entsearch.playerstats.stompkills > stomps.playerstats.stompkills)
						stomps = entsearch;
					if(entsearch.playerstats.ghostsbusted > ghost.playerstats.ghostsbusted)
						ghost = entsearch;
					if(entsearch.playerstats.accuracyawards > accuracy.playerstats.accuracyawards)
						accuracy = entsearch;
					if(entsearch.playerstats.harpooncombokills > combo.playerstats.harpooncombokills)
						combo = entsearch;
					if(entsearch.weapstats[ROLE_BOMBER].specialkills > c4.weapstats[ROLE_BOMBER].specialkills)
						c4 = entsearch;
					if(entsearch.weapstats[ROLE_SUPPORT].specialkills > telefrag.weapstats[ROLE_SUPPORT].specialkills)
						telefrag = entsearch;
					if(entsearch.weapstats[ROLE_MGUNNER].specialkills > shoulder.weapstats[ROLE_MGUNNER].specialkills)
						shoulder = entsearch;
				}
			}
			entsearch = find(entsearch, classname, "player");
		}
		
		
		
		local float awardpad = 12;
		local float winamtpad = -6;
		local float namepad = 8;
		local float maxnamelength = 10;
		local float youamtpad = -6;
		
		/*
		local string test = strcat(strpad(awardpad,"ghostbuster"),strpad(winamtpad, ftos(123456))," ", strpad(namepad,substring("abcdefghijklmnopqrs",0,maxnamelength)), " u:", strpad(youamtpad,ftos(prettynumber(123456789))),"\n");
		mkills = strcat(strpad(awardpad,"kills"),strpad(winamtpad, ftos(prettynumber(mostkills.playerstats.kills)))," ", strpad(namepad,substring(mostkills.netname,0,maxnamelength)), " u:", strpad(youamtpad,ftos(prettynumber(e.playerstats.kills))),"\n");
		mdeaths = strcat(strpad(awardpad,"deaths"),strpad(winamtpad, ftos(prettynumber(mostdeath.playerstats.deaths)))," ", strpad(namepad,substring(mostdeath.netname,0,maxnamelength)), " u:", strpad(youamtpad,ftos(prettynumber(e.playerstats.deaths))),"\n");
		mgiven = strcat(strpad(awardpad,"dmg given"),strpad(winamtpad, ftos(prettynumber(mostgiven.playerstats.dmggiven)))," ", strpad(namepad,substring(mostgiven.netname,0,maxnamelength)), " u:", strpad(youamtpad,ftos(prettynumber(e.playerstats.dmggiven))),"\n");
		mtaken = strcat(strpad(awardpad,"dmg taken"),strpad(winamtpad, ftos(prettynumber(mosttaken.playerstats.dmgtaken)))," ", strpad(namepad,substring(mosttaken.netname,0,maxnamelength)), " u:", strpad(youamtpad,ftos(prettynumber(e.playerstats.dmgtaken))),"\n");
		mstreak = strcat(strpad(awardpad,"killstreak"),strpad(winamtpad, ftos(prettynumber(killstreak.playerstats.bestkillstreak)))," ", strpad(namepad,substring(killstreak.netname,0,maxnamelength)), " u:", strpad(youamtpad,ftos(prettynumber(e.playerstats.bestkillstreak))),"\n");
		mcaps = strcat(strpad(awardpad,"most caps"),strpad(winamtpad, ftos(prettynumber(flagcaps.playerstats.flagcaps)))," ", strpad(namepad,substring(flagcaps.netname,0,maxnamelength)), " u:", strpad(youamtpad,ftos(prettynumber(e.playerstats.flagcaps))),"\n");
		mtrail = strcat(strpad(awardpad,"pacman"),strpad(winamtpad, ftos(prettynumber(flagtrail.playerstats.flagtrailtouches)))," ", strpad(namepad,substring(flagtrail.netname,0,maxnamelength)), " u:", strpad(youamtpad,ftos(prettynumber(e.playerstats.flagtrailtouches))),"\n");
		mstomp = strcat(strpad(awardpad,"mario"),strpad(winamtpad, ftos(prettynumber(stomps.playerstats.stompkills)))," ", strpad(namepad,substring(stomps.netname,0,maxnamelength)), " u:", strpad(youamtpad,ftos(prettynumber(e.playerstats.stompkills))),"\n");
		mghost = strcat(strpad(awardpad,"ghostbuster"),strpad(winamtpad, ftos(prettynumber(ghost.playerstats.ghostsbusted)))," ", strpad(namepad,substring(ghost.netname,0,maxnamelength)), " u:", strpad(youamtpad,ftos(prettynumber(e.playerstats.ghostsbusted))),"\n");
		maccuracy = strcat(strpad(awardpad,"rail god"),strpad(winamtpad, ftos(prettynumber(accuracy.playerstats.accuracyawards)))," ", strpad(namepad,substring(accuracy.netname,0,maxnamelength)), " u:", strpad(youamtpad,ftos(prettynumber(e.playerstats.accuracyawards))),"\n");
		mcombo = strcat(strpad(awardpad,"combo whore"),strpad(winamtpad, ftos(prettynumber(combo.playerstats.harpooncombokills)))," ", strpad(namepad,substring(combo.netname,0,maxnamelength)), " u:", strpad(youamtpad,ftos(prettynumber(e.playerstats.harpooncombokills))),"\n");
		mc4 = strcat(strpad(awardpad,"detpacker"),strpad(winamtpad, ftos(prettynumber(c4.weapstats[ROLE_BOMBER].specialkills)))," ", strpad(namepad,substring(c4.netname,0,maxnamelength)), " u:", strpad(youamtpad,ftos(prettynumber(e.weapstats[ROLE_BOMBER].specialkills))),"\n");
		mtelefrag = strcat(strpad(awardpad,"inside out"),strpad(winamtpad, ftos(prettynumber(telefrag.weapstats[ROLE_SUPPORT].specialkills)))," ", strpad(namepad,substring(telefrag.netname,0,maxnamelength)), " u:", strpad(youamtpad,ftos(prettynumber(e.weapstats[ROLE_SUPPORT].specialkills))),"\n");
		mshoulder = strcat(strpad(awardpad,"thomas"),strpad(winamtpad, ftos(prettynumber(shoulder.weapstats[ROLE_MGUNNER].specialkills)))," ", strpad(namepad,substring(shoulder.netname,0,maxnamelength)), " u:", strpad(youamtpad,ftos(prettynumber(e.weapstats[ROLE_MGUNNER].specialkills))),"\n");
		*/
		local string s1,s2,s3,s4,s5,s6,s7,s8,s9,s10;
		local string s11,s12,s13,s14,s15,s16,s17,s18,s19,s20;
		local float catlen = 11;
		local float numlen = -7;
		local float namelen = 11;
		local string test1, test2, test3, test4;
		local string scores;
		local string teamres;
		local string teamresflav;
		local float winningteam;
		local string awardshow1 = "welcome to the post game awards show!\n";
		local string awardshow2 = "brought to you by:\n";
		
		if(bluescore > redscore)
			winningteam = TEAM_BLUE;
		else
			winningteam = TEAM_RED;
			
	
		if(e.team_no == winningteam)
			teamres = "\syou win!\s\n";
		else 
			teamres = "\syou lose!\s\n";
			
			
		
		if(bluescore == 0 || redscore == 0) //flawless
		{
			if (e.team_no == winningteam) 
			{
				
				teamresflav = "flawless victory\n";
			}	
			else 
			{
				teamresflav = "you really suck\n";
				
			}
			
		}
		else if(fabs(bluescore - redscore) <= 5) //holyshit 100-99
		{
			
			teamresflav = "close game!\n";
		}
		else
		{
				teamresflav = "\n";
		}
		
		
		
		
		scores = strcat("\n\n\n\nblue : ",ftos(bluescore) ," red : ",ftos(redscore),"\n");
		
														      
		mhead = strcat(zstr("category",catlen)," ",zstr(" ",numlen)," ",zstr("winner",namelen)," ",zstr("you",numlen),"\n");
		
		mkills = 	strcat(zstr("kills",catlen)		," ",znum(mostkills.playerstats.kills,numlen)			," ",zstr(mostkills.netname,namelen)		," ",znum(e.playerstats.kills,numlen)			,"\n");
		mdeaths = 	strcat(zstr("deaths",catlen)		," ",znum(mostdeath.playerstats.deaths,numlen)			," ",zstr(mostdeath.netname,namelen)		," ",znum(e.playerstats.deaths,numlen)			,"\n");
		mgiven  = 	strcat(zstr("dmg given",catlen)		," ",znum(mostgiven.playerstats.dmggiven,numlen)		," ",zstr(mostgiven.netname,namelen)		," ",znum(e.playerstats.dmggiven,numlen)		,"\n");
		mtaken  = 	strcat(zstr("dmg taken",catlen)		," ",znum(mosttaken.playerstats.dmgtaken,numlen)		," ",zstr(mosttaken.netname,namelen)		," ",znum(e.playerstats.dmgtaken,numlen)		,"\n");
		mstreak = 	strcat(zstr("killstreak",catlen)	," ",znum(killstreak.playerstats.bestkillstreak,numlen)		," ",zstr(killstreak.netname,namelen)		," ",znum(e.playerstats.bestkillstreak,numlen)		,"\n");
		mcaps = 	strcat(zstr("most caps",catlen)		," ",znum(flagcaps.playerstats.flagcaps,numlen)			," ",zstr(flagcaps.netname,namelen)		," ",znum(e.playerstats.flagcaps,numlen)		,"\n");
		mtrail  = 	strcat(zstr("pacman",catlen)		," ",znum(flagtrail.playerstats.flagtrailtouches,numlen)	," ",zstr(flagtrail.netname,namelen)		," ",znum(e.playerstats.flagtrailtouches,numlen)	,"\n");
		mstomp  = 	strcat(zstr("mariobros",catlen)		," ",znum(stomps.playerstats.stompkills,numlen)			," ",zstr(stomps.netname,namelen)		," ",znum(e.playerstats.stompkills,numlen)		,"\n");
		mghost  = 	strcat(zstr("ghostbuster",catlen)	," ",znum(ghost.playerstats.ghostsbusted,numlen)		," ",zstr(ghost.netname,namelen)		," ",znum(e.playerstats.ghostsbusted,numlen)		,"\n");
		maccuracy  = 	strcat(zstr("rail god",catlen)		," ",znum(accuracy.playerstats.accuracyawards,numlen)		," ",zstr(accuracy.netname,namelen)		," ",znum(e.playerstats.accuracyawards,numlen)		,"\n");
		mcombo  = 	strcat(zstr("combo whore",catlen)	," ",znum(combo.playerstats.harpooncombokills,numlen)		," ",zstr(combo.netname,namelen)		," ",znum(e.playerstats.harpooncombokills,numlen)	,"\n");
		mc4  = 		strcat(zstr("detpacker",catlen)		," ",znum(c4.weapstats[ROLE_BOMBER].specialkills,numlen)	," ",zstr(c4.netname,namelen)			," ",znum(e.weapstats[ROLE_BOMBER].specialkills,numlen)	,"\n");
		mtelefrag =	strcat(zstr("telefragger",catlen)	," ",znum(telefrag.weapstats[ROLE_SUPPORT].specialkills,numlen)	," ",zstr(telefrag.netname,namelen)		," ",znum(e.weapstats[ROLE_SUPPORT].specialkills,numlen),"\n");
		mshoulder =	strcat(zstr("thomas",catlen)		," ",znum(shoulder.weapstats[ROLE_MGUNNER].specialkills,numlen)	," ",zstr(shoulder.netname,namelen)		," ",znum(e.weapstats[ROLE_MGUNNER].specialkills,numlen),"\n");
		test1 =		strcat(zstr("sdjolfhbnkljsdfkljsdfkjbsdfkjbfsdjkb",catlen)		," ",znum(1234567890123456789,numlen)	," ",zstr("kjsdfksdjfbkjsdbfksdjbfksdjbfksdjbfksdjbfsdkfb",namelen)		," ",znum(1234567890123456789,numlen),"\n");
		test2 =		strcat(zstr("sdjolfhbnkljsdfkljsdfkjbsdfkjbfsdjkb",catlen)		," ",znum(1234567890123456789,numlen)	," ",zstr("kjsdfksdjfbkjsdbfksdjbfksdjbfksdjbfksdjbfsdkfb",namelen)		," ",znum(1234567890123456789,numlen),"\n");
		test3 =		strcat(zstr("sdjolfhbnkljsdfkljsdfkjbsdfkjbfsdjkb",catlen)		," ",znum(1234567890123456789,numlen)	," ",zstr("kjsdfksdjfbkjsdbfksdjbfksdjbfksdjbfksdjbfsdkfb",namelen)		," ",znum(1234567890123456789,numlen),"\n");
		test4 =		strcat(zstr("sdjolfhbnkljsdfkljsdfkjbsdfkjbfsdjkb",catlen)		," ",znum(1234567890123456789,numlen)	," ",zstr("kjsdfksdjfbkjsdbfksdjbfksdjbfksdjbfksdjbfsdkfb",namelen)		," ",znum(1234567890123456789,numlen),"\n");
		
	
	if(step == 0)
	{
		if(e.team_no == winningteam)
		{
			stuffcmd(e, "play beta1/voice_youwin.wav\n");
			stuffcmd(e, "play beta1/clap.wav\n");
		}
		else
		{
				
			stuffcmd(e, "play beta1/voice_youlose.wav\n");
			stuffcmd(e, "play beta1/boo.wav\n");
		}
		
		
		s1 = "\n";
		s2 = "\n";
		s3 = scores;
		s4 = "\n";
		s5 = teamres;
		s6 = "\n";
		s7 = "\n";
		s8 = "\n";
		s9 = "\n";
		s10 = "\n";
		s11 = "\n";
		s12 = "\n";
		s13 = "\n";
		s14 = "\n";
		s15 = "\n";
		s16 = "\n";
		s17 = "\n";
		s18 = "\n";
		s19 = "\n";
		s20 = "\n";
		e.awardstring = strcat(s1,s2,s3,s4,s5,s6,s7);
		e.awardstring = strcat(e.awardstring,s8,s9,s10,s11,s12,s13);
		e.awardstring = strcat(e.awardstring,s14,s15,s16,s17,s18,s19,s20);
	}
	if(step == 1)
	{
		if(bluescore == 0 || redscore == 0) //flawless
		{
			if (e.team_no == winningteam) 
				stuffcmd(e, "play beta1/voice_flawless.wav\n");
			else 
				stuffcmd(e, "play beta1/voice_yousuck.wav\n");
			
			
		}
		else if(fabs(bluescore - redscore) <= 5) //holyshit 100-99
		{
			stuffcmd(e, "play beta1/voice_holyshit.wav\n");
		}

		
		
		s1 = "\n";
		s2 = "\n";
		s3 = scores;
		s4 = "\n";
		s5 = teamres;
		s6 = "\n";
		s7 = teamresflav;
		s8 = "\n";
		s9 = "\n";
		s10 = "\n";
		s11 = "\n";
		s12 = "\n";
		s13 = "\n";
		s14 = "\n";
		s15 = "\n";
		s16 = "\n";
		s17 = "\n";
		s18 = "\n";
		s19 = "\n";
		s20 = "\n";
		e.awardstring = strcat(s1,s2,s3,s4,s5,s6,s7);
		e.awardstring = strcat(e.awardstring,s8,s9,s10,s11,s12,s13);
		e.awardstring = strcat(e.awardstring,s14,s15,s16,s17,s18,s19,s20);
		
	}

	
	if(step == 2)
	{
		stuffcmd(e, "play beta1/droll.wav\n");
		//e.awardstring = "\n\n\n\n\nwelcome to the post game awards show!\n\nbrought to you by:\n\n";
		s1 = "\n";
		s2 = "\n";
		s3 = awardshow1;
		s4 = "\n";
		s5 = awardshow2;
		s6 = "\n";
		s7 = "\n";
		s8 = "\n";
		s9 = "\n";
		s10 = "\n";
		s11 = "\n";
		s12 = "\n";
		s13 = "\n";
		s14 = "\n";
		s15 = "\n";
		s16 = "\n";
		s17 = "\n";
		s18 = "\n";
		s19 = "\n";
		s20 = "\n";
		e.awardstring = strcat(s1,s2,s3,s4,s5,s6,s7);
		e.awardstring = strcat(e.awardstring,s8,s9,s10,s11,s12,s13);
		e.awardstring = strcat(e.awardstring,s14,s15,s16,s17,s18,s19,s20);	
	}
	
	
	
	if(step == 3)
	{
		local string rngowner,rngdesc1,rngdesc2;
		
		stuffcmd(e, "play beta1/bdumtish.wav\n");
		if(rng == 1)
		{
			rngowner = "\szel's barber shop\s\n";
			rngdesc1 = "\sfor the closest shave, he's never had\s\n";
			rngdesc2 = "\n";
		}
		if(rng == 2)
		{
			rngowner = "\snicky's porn emporium\s\n";
			rngdesc1 = "\saustralia's 'largest' sex toy store\s\n";
			rngdesc2 = "\n";
			
		}
		if(rng == 3)
		{
			rngowner = "\sthe seano bottlo\s\n";
			rngdesc1 = "\sall products have been pre-sampled by\s\n";
			rngdesc2 = "\sthe owner....(for quality assurance)\s\n";
		}
		if(rng == 4)
		{
			rngowner = "\smeht's laundromat and internet cafe\s\n";
			rngdesc1 = "\sdo your washing while you game!\s\n";
			rngdesc2 = "\n";
		}
		if(rng == 5)
		{
			rngowner = "\szut's anger management centre\s\n";
			rngdesc1 = "\salcoholics and dumbcunts welcome\s\n";
			rngdesc2 = "\n";
		}
		if(rng == 6)
		{
			rngowner = "\snovate's school of flight\s\n";
			rngdesc1 = "\swhere 1000ups and a ramp\s\n";
			rngdesc2 = "\sis all thats required\s\n";
		}
		if(rng == 7)
		{
			rngowner = "\shydro's butchery\s\n";
			rngdesc1 = "\sranked top 10 in america\s\n";
			rngdesc2 = "\n";
		}
		if(rng == 8)
		{
			rngowner = "\shixon's strategy school\s\n";
			rngdesc1 = "\swhen you need to shake things up a bit\s\n";
			rngdesc2 = "\n";
		}
			
			
			
		s1 = "\n";
		s2 = "\n";
		s3 = awardshow1;
		s4 = "\n";
		s5 = awardshow2;
		s6 = "\n";
		s7 = "\n";
		s8 = "\n";
		s9 = "\n";
		s10 = rngowner;
		s11 = "\n";
		s12 = rngdesc1;
		s13 = "\n";
		s14 = rngdesc2;
		s15 = "\n";
		s16 = "\n";
		s17 = "\n";
		s18 = "\n";
		s19 = "\n";
		s20 = "\n";
		e.awardstring = strcat(s1,s2,s3,s4,s5,s6,s7);
		e.awardstring = strcat(e.awardstring,s8,s9,s10,s11,s12,s13);
		e.awardstring = strcat(e.awardstring,s14,s15,s16,s17,s18,s19,s20);	
												
		
	}
	
	if(step == 4)
	{
		
		//e.awardstring = strcat(mhead,"\n\n\n","\n","\n","\n");
		
		s1 = mhead;
		s2 = "\n";
		s3 = "\n";
		s4 = "\n";
		s5 = "\n";
		s6 = "\n";
		s7 = "\n";
		s8 = "\n";
		s9 = "\n";
		s10 = "\n";
		s11 = "\n";
		s12 = "\n";
		s13 = "\n";
		s14 = "\n";
		s15 = "\n";
		s16 = "\n";
		s17 = "\n";
		s18 = "\n";
		s19 = "\n";
		s20 = "\n";
		e.awardstring = strcat(s1,s2,s3,s4,s5,s6,s7);
		e.awardstring = strcat(e.awardstring,s8,s9,s10,s11,s12,s13);
		e.awardstring = strcat(e.awardstring,s14,s15,s16,s17,s18,s19,s20);
		
	}
	if(step == 5)
	{

		
		//e.awardstring = strcat(mhead,mkills,"\n\n\n","\n\n\n");
		stuffcmd(e, "play beta1/killsound.wav\n");
		
		s1 = mhead;
		s2 = "\n";
		s3 = mkills;
		s4 = "\n";
		s5 = "\n";
		s6 = "\n";
		s7 = "\n";
		s8 = "\n";
		s9 = "\n";
		s10 = "\n";
		s11 = "\n";
		s12 = "\n";
		s13 = "\n";
		s14 = "\n";
		s15 = "\n";
		s16 = "\n";
		s17 = "\n";
		s18 = "\n";
		s19 = "\n";
		s20 = "\n";
		e.awardstring = strcat(s1,s2,s3,s4,s5,s6,s7);
		e.awardstring = strcat(e.awardstring,s8,s9,s10,s11,s12,s13);
		e.awardstring = strcat(e.awardstring,s14,s15,s16,s17,s18,s19,s20);
		
	}
	if(step == 6)
	{
		//e.awardstring = strcat(mhead,mkills,mdeaths,"\n\n\n");
		stuffcmd(e, "play player/death1.wav\n");
		
		s1 = mhead;
		s2 = "\n";
		s3 = mkills;
		s4 = mdeaths;
		s5 = "\n";
		s6 = "\n";
		s7 = "\n";
		s8 = "\n";
		s9 = "\n";
		s10 = "\n";
		s11 = "\n";
		s12 = "\n";
		s13 = "\n";
		s14 = "\n";
		s15 = "\n";
		s16 = "\n";
		s17 = "\n";
		s18 = "\n";
		s19 = "\n";
		s20 = "\n";
		e.awardstring = strcat(s1,s2,s3,s4,s5,s6,s7);
		e.awardstring = strcat(e.awardstring,s8,s9,s10,s11,s12,s13);
		e.awardstring = strcat(e.awardstring,s14,s15,s16,s17,s18,s19,s20);
		

		
	}
	if(step == 7)
	{
		//e.awardstring = strcat(mhead,mkills,mdeaths,mgiven,"\n\n\n");
		stuffcmd(e, "play beta1/hitsound.wav\n");
		s1 = mhead;
		s2 = "\n";
		s3 = mkills;
		s4 = mdeaths;
		s5 = mgiven;
		s6 = "\n";
		s7 = "\n";
		s8 = "\n";
		s9 = "\n";
		s10 = "\n";
		s11 = "\n";
		s12 = "\n";
		s13 = "\n";
		s14 = "\n";
		s15 = "\n";
		s16 = "\n";
		s17 = "\n";
		s18 = "\n";
		s19 = "\n";
		s20 = "\n";
		e.awardstring = strcat(s1,s2,s3,s4,s5,s6,s7);
		e.awardstring = strcat(e.awardstring,s8,s9,s10,s11,s12,s13);
		e.awardstring = strcat(e.awardstring,s14,s15,s16,s17,s18,s19,s20);
		
	}
	if(step == 8)
	{
		
		//e.awardstring = strcat(mhead,mkills,mdeaths,mgiven,mtaken,"\n\n\n");
		stuffcmd(e, "play player/pain5.wav\n");
		s1 = mhead;
		s2 = "\n";
		s3 = mkills;
		s4 = mdeaths;
		s5 = mgiven;
		s6 = mtaken;
		s7 = "\n";
		s8 = "\n";
		s9 = "\n";
		s10 = "\n";
		s11 = "\n";
		s12 = "\n";
		s13 = "\n";
		s14 = "\n";
		s15 = "\n";
		s16 = "\n";
		s17 = "\n";
		s18 = "\n";
		s19 = "\n";
		s20 = "\n";
		e.awardstring = strcat(s1,s2,s3,s4,s5,s6,s7);
		e.awardstring = strcat(e.awardstring,s8,s9,s10,s11,s12,s13);
		e.awardstring = strcat(e.awardstring,s14,s15,s16,s17,s18,s19,s20);
	}
	if(step == 9)
	{
		local string file = "beta1/ready.wav";

		if(killstreak.playerstats.bestkillstreak == 3)	//killingspree
			file = "beta1/voice_killingspree.wav";
		
		if(killstreak.playerstats.bestkillstreak == 4)	//dominating
			file = "beta1/voice_dominating.wav";
			
		if(killstreak.playerstats.bestkillstreak == 5)	//megakill
			file = "beta1/voice_megakill.wav";

		if(killstreak.playerstats.bestkillstreak == 6)	//unstoppable
			file = "beta1/voice_unstoppable.wav";
			
		if(killstreak.playerstats.bestkillstreak == 7)	//wicked sick? ultrakill
			file = "beta1/voice_ultrakill.wav";
		
		if(killstreak.playerstats.bestkillstreak == 8)	//monster kill
			file = "beta1/voice_monsterkill.wav";
		
		if(killstreak.playerstats.bestkillstreak == 9)	//godlike
			file = "beta1/voice_godlike.wav";
			
		if(killstreak.playerstats.bestkillstreak >= 10) //holy shit beyond godlike
			file = "beta1/voice_holyshit.wav";
			
		//e.awardstring = strcat(mhead,mkills,mdeaths,mgiven,mtaken,mstreak);
		stuffcmd(e, strcat("play ",file,"\n"));
		
		s1 = mhead;
		s2 = "\n";
		s3 = mkills;
		s4 = mdeaths;
		s5 = mgiven;
		s6 = mtaken;
		s7 = mstreak;
		s8 = "\n";
		s9 = "\n";
		s10 = "\n";
		s11 = "\n";
		s12 = "\n";
		s13 = "\n";
		s14 = "\n";
		s15 = "\n";
		s16 = "\n";
		s17 = "\n";
		s18 = "\n";
		s19 = "\n";
		s20 = "\n";
		e.awardstring = strcat(s1,s2,s3,s4,s5,s6,s7);
		e.awardstring = strcat(e.awardstring,s8,s9,s10,s11,s12,s13);
		e.awardstring = strcat(e.awardstring,s14,s15,s16,s17,s18,s19,s20);
	}
	if(step == 10)
	{
		//e.awardstring = strcat(mhead,mkills,mdeaths,mgiven,mtaken,mstreak,mcaps);
		stuffcmd(e, "play beta1/flagevent.wav\n");
				stuffcmd(e, strcat("play ",file,"\n"));
		
		s1 = mhead;
		s2 = "\n";
		s3 = mkills;
		s4 = mdeaths;
		s5 = mgiven;
		s6 = mtaken;
		s7 = mstreak;
		s8 = mcaps;
		s9 = "\n";
		s10 = "\n";
		s11 = "\n";
		s12 = "\n";
		s13 = "\n";
		s14 = "\n";
		s15 = "\n";
		s16 = "\n";
		s17 = "\n";
		s18 = "\n";
		s19 = "\n";
		s20 = "\n";
		e.awardstring = strcat(s1,s2,s3,s4,s5,s6,s7);
		e.awardstring = strcat(e.awardstring,s8,s9,s10,s11,s12,s13);
		e.awardstring = strcat(e.awardstring,s14,s15,s16,s17,s18,s19,s20);
	}
	if(step == 11)
	{
		//e.awardstring = strcat(mhead,mkills,mdeaths,mgiven,mtaken,mstreak,mcaps);
		//e.awardstring = strcat(e.awardstring,mtrail);
		stuffcmd(e, "play beta1/pacman.wav\n");
		s1 = mhead;
		s2 = "\n";
		s3 = mkills;
		s4 = mdeaths;
		s5 = mgiven;
		s6 = mtaken;
		s7 = mstreak;
		s8 = mcaps;
		s9 = mtrail;
		s10 = "\n";
		s11 = "\n";
		s12 = "\n";
		s13 = "\n";
		s14 = "\n";
		s15 = "\n";
		s16 = "\n";
		s17 = "\n";
		s18 = "\n";
		s19 = "\n";
		s20 = "\n";
		e.awardstring = strcat(s1,s2,s3,s4,s5,s6,s7);
		e.awardstring = strcat(e.awardstring,s8,s9,s10,s11,s12,s13);
		e.awardstring = strcat(e.awardstring,s14,s15,s16,s17,s18,s19,s20);
		
	}
	if(step == 12)
	{
		//e.awardstring = strcat(mhead,mkills,mdeaths,mgiven,mtaken);
		//e.awardstring = strcat(e.awardstring,mstreak,mcaps,mtrail,mstomp);
		stuffcmd(e, "play beta1/gstomp_kill.wav\n");
		s1 = mhead;
		s2 = "\n";
		s3 = mkills;
		s4 = mdeaths;
		s5 = mgiven;
		s6 = mtaken;
		s7 = mstreak;
		s8 = mcaps;
		s9 = mtrail;
		s10 = mstomp;
		s11 = "\n";
		s12 = "\n";
		s13 = "\n";
		s14 = "\n";
		s15 = "\n";
		s16 = "\n";
		s17 = "\n";
		s18 = "\n";
		s19 = "\n";
		s20 = "\n";
		e.awardstring = strcat(s1,s2,s3,s4,s5,s6,s7);
		e.awardstring = strcat(e.awardstring,s8,s9,s10,s11,s12,s13);
		e.awardstring = strcat(e.awardstring,s14,s15,s16,s17,s18,s19,s20);
	}
	if(step == 13)
	{
		//e.awardstring = strcat(mhead,mkills,mdeaths,mgiven,mtaken);
		//e.awardstring = strcat(e.awardstring,mstreak,mcaps,mtrail,mstomp);
		//e.awardstring = strcat(e.awardstring,mghost);
		stuffcmd(e, "play beta1/gbuster.wav\n");
		s1 = mhead;
		s2 = "\n";
		s3 = mkills;
		s4 = mdeaths;
		s5 = mgiven;
		s6 = mtaken;
		s7 = mstreak;
		s8 = mcaps;
		s9 = mtrail;
		s10 = mstomp;
		s11 = mghost;
		s12 = "\n";
		s13 = "\n";
		s14 = "\n";
		s15 = "\n";
		s16 = "\n";
		s17 = "\n";
		s18 = "\n";
		s19 = "\n";
		s20 = "\n";
		e.awardstring = strcat(s1,s2,s3,s4,s5,s6,s7);
		e.awardstring = strcat(e.awardstring,s8,s9,s10,s11,s12,s13);
		e.awardstring = strcat(e.awardstring,s14,s15,s16,s17,s18,s19,s20);
	}
	if(step == 14)
	{
		//e.awardstring = strcat(mhead,mkills,mdeaths,mgiven,mtaken);
		//e.awardstring = strcat(e.awardstring,mstreak,mcaps,mtrail,mstomp);
		//e.awardstring = strcat(e.awardstring,mghost,maccuracy);
		stuffcmd(e, "play beta1/voice_accuracy.wav\n");
		s1 = mhead;
		s2 = "\n";
		s3 = mkills;
		s4 = mdeaths;
		s5 = mgiven;
		s6 = mtaken;
		s7 = mstreak;
		s8 = mcaps;
		s9 = mtrail;
		s10 = mstomp;
		s11 = mghost;
		s12 = maccuracy;
		s13 = "\n";
		s14 = "\n";
		s15 = "\n";
		s16 = "\n";
		s17 = "\n";
		s18 = "\n";
		s19 = "\n";
		s20 = "\n";
		e.awardstring = strcat(s1,s2,s3,s4,s5,s6,s7);
		e.awardstring = strcat(e.awardstring,s8,s9,s10,s11,s12,s13);
		e.awardstring = strcat(e.awardstring,s14,s15,s16,s17,s18,s19,s20);
	}
	if(step == 15)
	{
		//e.awardstring = strcat(mhead,mkills,mdeaths,mgiven,mtaken);
		//e.awardstring = strcat(e.awardstring,mstreak,mcaps,mtrail,mstomp);
		//e.awardstring = strcat(e.awardstring,mghost,maccuracy);
		//e.awardstring = strcat(e.awardstring,mcombo);
		stuffcmd(e, "play beta1/harpoon_enemy1.wav\n");
		s1 = mhead;
		s2 = "\n";
		s3 = mkills;
		s4 = mdeaths;
		s5 = mgiven;
		s6 = mtaken;
		s7 = mstreak;
		s8 = mcaps;
		s9 = mtrail;
		s10 = mstomp;
		s11 = mghost;
		s12 = maccuracy;
		s13 = mcombo;
		s14 = "\n";
		s15 = "\n";
		s16 = "\n";
		s17 = "\n";
		s18 = "\n";
		s19 = "\n";
		s20 = "\n";
		e.awardstring = strcat(s1,s2,s3,s4,s5,s6,s7);
		e.awardstring = strcat(e.awardstring,s8,s9,s10,s11,s12,s13);
		e.awardstring = strcat(e.awardstring,s14,s15,s16,s17,s18,s19,s20);
	}
	if(step == 16)
	{
		//e.awardstring = strcat(mhead,mkills,mdeaths,mgiven,mtaken);
		//e.awardstring = strcat(e.awardstring,mstreak,mcaps,mtrail,mstomp);
		//e.awardstring = strcat(e.awardstring,mghost,maccuracy,mcombo);
		//e.awardstring = strcat(e.awardstring,mc4);
		stuffcmd(e, "play beta1/c4_armed.wav\n");
		s1 = mhead;
		s2 = "\n";
		s3 = mkills;
		s4 = mdeaths;
		s5 = mgiven;
		s6 = mtaken;
		s7 = mstreak;
		s8 = mcaps;
		s9 = mtrail;
		s10 = mstomp;
		s11 = mghost;
		s12 = maccuracy;
		s13 = mcombo;
		s14 = mc4;
		s15 = "\n";
		s16 = "\n";
		s17 = "\n";
		s18 = "\n";
		s19 = "\n";
		s20 = "\n";
		e.awardstring = strcat(s1,s2,s3,s4,s5,s6,s7);
		e.awardstring = strcat(e.awardstring,s8,s9,s10,s11,s12,s13);
		e.awardstring = strcat(e.awardstring,s14,s15,s16,s17,s18,s19,s20);
	}
	if(step == 17)
	{
		//e.awardstring = strcat(mhead,mkills,mdeaths,mgiven,mtaken);
		//e.awardstring = strcat(e.awardstring,mstreak,mcaps,mtrail,mstomp);
		//e.awardstring = strcat(e.awardstring,mghost,maccuracy,mcombo,mc4);
		//e.awardstring = strcat(e.awardstring,mtelefrag);
		stuffcmd(e, "play beta1/insideout.wav\n");
		s1 = mhead;
		s2 = "\n";
		s3 = mkills;
		s4 = mdeaths;
		s5 = mgiven;
		s6 = mtaken;
		s7 = mstreak;
		s8 = mcaps;
		s9 = mtrail;
		s10 = mstomp;
		s11 = mghost;
		s12 = maccuracy;
		s13 = mcombo;
		s14 = mc4;
		s15 = mtelefrag;
		s16 = "\n";
		s17 = "\n";
		s18 = "\n";
		s19 = "\n";
		s20 = "\n";
		e.awardstring = strcat(s1,s2,s3,s4,s5,s6,s7);
		e.awardstring = strcat(e.awardstring,s8,s9,s10,s11,s12,s13);
		e.awardstring = strcat(e.awardstring,s14,s15,s16,s17,s18,s19,s20);
	}
	if(step == 18)
	{
		//e.awardstring = strcat(mhead,mkills,mdeaths,mgiven,mtaken);
		//e.awardstring = strcat(e.awardstring,mstreak,mcaps,mtrail,mstomp);
		//e.awardstring = strcat(e.awardstring,mghost,maccuracy,mcombo,mc4);
		//e.awardstring = strcat(e.awardstring,mtelefrag,mshoulder);
		stuffcmd(e, "play beta1/thomas.wav\n");
		s1 = mhead;
		s2 = "\n";
		s3 = mkills;
		s4 = mdeaths;
		s5 = mgiven;
		s6 = mtaken;
		s7 = mstreak;
		s8 = mcaps;
		s9 = mtrail;
		s10 = mstomp;
		s11 = mghost;
		s12 = maccuracy;
		s13 = mcombo;
		s14 = mc4;
		s15 = mtelefrag;
		s16 = mshoulder;
		s17 = "\n";
		s18 = "\n";
		s19 = "\n";
		s20 = "\n";
		e.awardstring = strcat(s1,s2,s3,s4,s5,s6,s7);
		e.awardstring = strcat(e.awardstring,s8,s9,s10,s11,s12,s13);
		e.awardstring = strcat(e.awardstring,s14,s15,s16,s17,s18,s19,s20);
	}
	if(step == 19)
	{
		//e.awardstring = strcat(mhead,mkills,mdeaths,mgiven,mtaken);
		//e.awardstring = strcat(e.awardstring,mstreak,mcaps,mtrail,mstomp);
		//e.awardstring = strcat(e.awardstring,mghost,maccuracy,mcombo,mc4);
		//e.awardstring = strcat(e.awardstring,mtelefrag,mshoulder, test1,  nlines(5));
		//stuffcmd(e, "play beta1/error.wav\n");
	}
	if(step == 20)
	{
		//e.awardstring = strcat(mhead,mkills,mdeaths,mgiven,mtaken);
		//e.awardstring = strcat(e.awardstring,mstreak,mcaps,mtrail,mstomp);
		//e.awardstring = strcat(e.awardstring,mghost,maccuracy,mcombo,mc4);
		//e.awardstring = strcat(e.awardstring,mtelefrag,mshoulder, test1);
		//e.awardstring = strcat(e.awardstring, test2,  nlines(4));
		
		//e.awardstring = strcat(e.awardstring, "\n\n", "check console for personal stats\n");
		stuffcmd(e, "play beta1/error.wav\n");
		s1 = mhead;
		s2 = "\n";
		s3 = mkills;
		s4 = mdeaths;
		s5 = mgiven;
		s6 = mtaken;
		s7 = mstreak;
		s8 = mcaps;
		s9 = mtrail;
		s10 = mstomp;
		s11 = mghost;
		s12 = maccuracy;
		s13 = mcombo;
		s14 = mc4;
		s15 = mtelefrag;
		s16 = mshoulder;
		s17 = "\n";
		s18 = "check console for personal stats\n";
		s19 = "\n";
		s20 = "\n";
		e.awardstring = strcat(s1,s2,s3,s4,s5,s6,s7);
		e.awardstring = strcat(e.awardstring,s8,s9,s10,s11,s12,s13);
		e.awardstring = strcat(e.awardstring,s14,s15,s16,s17,s18,s19,s20);
		PrintStats(e);
	}
	if(step == 21)
	{
		//e.awardstring = strcat(mhead,mkills,mdeaths,mgiven,mtaken);
		//e.awardstring = strcat(e.awardstring,mstreak,mcaps,mtrail,mstomp);
		//e.awardstring = strcat(e.awardstring,mghost,maccuracy,mcombo,mc4);
		//e.awardstring = strcat(e.awardstring,mtelefrag,mshoulder, test1);
		//e.awardstring = strcat(e.awardstring, test2, test3,  nlines(3));
		//stuffcmd(e, "play beta1/error.wav\n");
	}
	if(step == 22)
	{
		//e.awardstring = strcat(mhead,mkills,mdeaths,mgiven,mtaken);
		//e.awardstring = strcat(e.awardstring,mstreak,mcaps,mtrail,mstomp);
		//e.awardstring = strcat(e.awardstring,mghost,maccuracy,mcombo,mc4);
		//e.awardstring = strcat(e.awardstring,mtelefrag,mshoulder, test1);
		//e.awardstring = strcat(e.awardstring, test2, test3, test4, nlines(2));
		//stuffcmd(e, "play beta1/error.wav\n");
	}
};

