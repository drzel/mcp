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
		if(self.owner.team_no == TEAM_BLUE)
			self.frame = 9;
		else
			self.frame = 9;
	}
		
	traceline(self.owner.origin, self.gren.origin, 0, self);
	local float len = vlen(trace_endpos - self.owner.origin);
	
	local vector dir = normalize(trace_endpos - self.owner.origin);
	local float dist1 = vlen(trace_endpos - self.owner.origin);
	local float dist2 = vlen(self.gren.origin - self.owner.origin);
	//local float dist3 = dist1/dist2;
	
	//bprint(2, strcat(ftos(dist2),"trfrac\n"));
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
		
	self.nextpingpoint = time + 0.5;
	makevectors (self.v_angle);
	local vector org = self.origin + '0 0 16';
	traceline(org, org + v_forward * 3000, 0, self);

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