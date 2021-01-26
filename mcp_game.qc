
void sprite_touch() =
{
	if(other.classname != "player")
		return;
	if(self.bubble_count > time)
		return;
	if(matchstate != MATCHSTATE_WAITINGFORPLAYERS)
		return;
		
	if(self.classname == "sprite_flagspawn")
	{
		sprint(other, PRINT_HIGH, "the \sflag will spawn here\s shortly after the match has begun\n");
		stuffcmd(other, "play beta1/notice.wav\n");
	}
	if(self.classname == "sprite_cappoint")
	{
		if(other.team_no == self.team_no)
			sprint(other, PRINT_HIGH, "\scapture flag\s here to start gaining points for your team\n");
		else
			sprint(other, PRINT_HIGH, "\sprevent enemy\s capturing flag and gaining points here\n");
			
		stuffcmd(other, "play beta1/notice.wav\n");	
	}
	if(self.classname == "sprite_playerspawn")
	{
		/* //todo: this was too spammy on spawn
		if(other.team_no == self.team_no)
			sprint(other, PRINT_HIGH, "\steam\s player spawn point\n");
		else
			sprint(other, PRINT_HIGH, "\senemy\s player spawn point\n");
			
		stuffcmd(other, "play beta1/notice.wav\n");	
		*/
	}
	if(self.classname == "sprite_classinfo")
	{
		local string l1, l2, l3, l4, l5;
		local string printstr;
		
		if(self.team_no == ROLE_RECON)
		{
			l1 = "\n\s[\srecon\s]\s\n";
			l2 = "\sweapon :\s (supernailgun) - shoot nails at walls to climb\n";
			l3 = "\sgrenade:\s (airblast) - knocks players away at high speed, useful for jumping\n";
			l4 = "\sspecial:\s (dash) - jump forward a small distance, usable in air for a double jump\n";
			l5 = "\spassive:\s (health regen) - slowly regens health whilst out of combat\n";	
		}
		else if(self.team_no == ROLE_ASSASSIN)
		{
			l1 = "\n\s[\sassassin\s]\s\n";
			l2 = "\sweapon :\s (railgun) - being closer does more damage, consecutive hits multiplies damage (3x max)\n";
			l3 = "\sgrenade:\s (flash) - temporarily blind targets, duration is longer closer to blast\n";
			l4 = "\sspecial:\s (cloak) - go invisible for a few seconds, cant shoot whilst invisible\n";
			l5 = "\spassive:\s (melee) - significant boost to axe damage\n";
		}
		else if(self.team_no == ROLE_FIGHTER)
		{
			l1 = "\n\s[\sfighter\s]\s\n";
			l2 = "\sweapon :\s (rocketlauncher) - 4 shots in clip, good for bouncing players\n";
			l3 = "\sgrenade:\s (frag) - high damage grenade\n";
			l4 = "\sspecial:\s (harpoon) - pull enemies towards you\n";
			l5 = "\spassive:\s (armour regen) -  slowly regens health whilst out of combat\n";	
		}
		else if(self.team_no == ROLE_BOMBER)
		{
			l1 = "\n\s[\sbomber\s]\s\n";
			l2 = "\sweapon :\s (stickylauncher) - explode on contact with enemy or detonated when 'special' is pressed\n";
			l3 = "\sgrenade:\s (beartrap) - does significant damage to enemies who step on it, can be shot and destroyed\n";
			l4 = "\sspecial:\s (detonate) - explodes any stickys you have\n";
			l5 = "\spassive:\s (health and armour regen) -  slowly regens health and armour\n";
				
		}
		else if(self.team_no == ROLE_SUPPORT)
		{
			l1 = "\n\s[\ssupport\s]\s\n";
			l2 = "\sweapon :\s (shaft) - shaft heals owner on damage, heals teammates (owner gets healed as well)\n";
			l3 = "\sgrenade:\s (leech) - portion of damage dealt to enemy heals owner\n";
			l4 = "\sspecial:\s (teleball) - press once to launch a teleball, again to teleport to the teleballs location\n";
			l5 = "\spassive:\s (overheal) -  leech gren and shaft can overheal user to 150 health (decays)\n";
		}
		else
		{
			l1 = "";
			l2 = "";
			l3 = ""; 
			l4 = ""; 
			l5 = "";
		}
		printstr = strcat(l1,l2,l3,l4,l5);
		if (printstr != "")
			{
				sprint(other, PRINT_HIGH, printstr);
				stuffcmd(other, "play beta1/notice.wav\n");	
			}
		
	}
	self.bubble_count = time + 1;
};

void info_mcp_classinfo() =
{
		local entity sp = spawn();
		sp.classname = "sprite_classinfo";		
		FO_SetModel(sp,"progs/beta1/s_mcp.spr");
		setorigin(sp,self.origin + '0 0 16');
		sp.solid = SOLID_TRIGGER;
		sp.touch = sprite_touch;
		sp.movetype = MOVETYPE_NONE;
		sp.team_no = self.team_no;
		if(self.team_no == ROLE_RECON)
			sp.frame = SPRITE_RECONINFO;
		if(self.team_no == ROLE_ASSASSIN)
			sp.frame = SPRITE_ASSASSININFO;
		if(self.team_no == ROLE_FIGHTER)
			sp.frame = SPRITE_FIGHTERINFO;
		if(self.team_no == ROLE_BOMBER)
			sp.frame = SPRITE_BOMBERINFO;
		if(self.team_no == ROLE_SUPPORT)
			sp.frame = SPRITE_SUPPORTINFO;
		setsize (sp, '-16 -16 -32', '16 16 32');
	
};

void info_player_teamspawn() =
{
		local entity sp = spawn();
		sp.classname = "sprite_playerspawn";		
		FO_SetModel(sp,"progs/beta1/s_mcp.spr");
		setorigin(sp,self.origin + '0 0 0');
		sp.solid = SOLID_TRIGGER;
		sp.touch = sprite_touch;
		sp.movetype = MOVETYPE_BOUNCE;
		sp.team_no = self.team_no;
		if(self.team_no == TEAM_BLUE)
			sp.frame = SPRITE_BLUESPAWN;
		else
			sp.frame = SPRITE_REDSPAWN;
		setsize (sp, '-16 -16 -32', '16 16 32');
};

void info_mcpflag_spawn () = 
{
		local entity sp = spawn();
		sp.classname = "sprite_flagspawn";		
		FO_SetModel(sp,"progs/beta1/s_mcp.spr");
		setorigin(sp,self.origin + '0 0 32');
		sp.solid = SOLID_TRIGGER;
		sp.touch = sprite_touch;
		sp.movetype = MOVETYPE_NONE;
		sp.frame = SPRITE_FLAGSPAWN;
		setsize (sp, '-16 -16 -32', '16 16 32');
};

void info_mcpflag_capture () =
{
	self.solid = SOLID_TRIGGER;
	self.touch = mcpflagcap_touch;
	setsize (self, '-16 -16 -32', '16 16 32');
	
	local entity te = spawn();
	te.classname = "sprite_cappoint";
	FO_SetModel(te,"progs/beta1/s_mcp.spr");
	te.team_no = self.team_no;
	if (self.team_no == TEAM_BLUE)
		te.frame =  SPRITE_BLUECAP;
	if (self.team_no == TEAM_RED)
		te.frame = SPRITE_REDCAP;
	te.solid = SOLID_TRIGGER;
	te.movetype = MOVETYPE_NONE;
	te.touch = sprite_touch;
	setorigin(te,self.origin + '0 0 32');
	setsize (te, '-16 -16 -32', '16 16 32');
};


void DeathMCPFlag () =
{
	self.impulse = 0;
	if(self.classname != "player")
		return;
	if(mcpflag.owner != self)
		return;
		
	ChangeMCPFlagState(MCPFLAGSTATE_DROPPED, self);
	self.items = self.items - (self.items & IT_KEY1);
};

void ThrowMCPFlag () =
{
	self.impulse = 0;
	if(self.classname != "player")
		return;
	if(mcpflag.owner != self)
		return;
		
	ChangeMCPFlagState(MCPFLAGSTATE_THROWN, self);
	self.items = self.items - (self.items & IT_KEY1);
};

void mcpflagcap_touch() =
{
	if (other.classname != "player")
		return;	
	if(mcpflag.owner == other)
	{
		if(mcpflag.owner.team_no == self.team_no)
		{
			ChangeMCPFlagState(MCPFLAGSTATE_CAPPED, self);
		}
	}
};
void mcpflag_touch() =
{	
	if(matchstate != MATCHSTATE_LIVE)
		return;
	if (other.classname != "player")
		return;	
	if (other.team_no == TEAM_NONE)
		return;
	if(other.team_no == mcpflag.owner.team_no)
		return;

		
	ChangeMCPFlagState(MCPFLAGSTATE_CARRIED, other);
};



void CreateMCPFlag() =
{
		mcpflag = spawn();
		mcpflag.classname = "item_mcpflag";
		mcpflag.owner = gm;		
		mcpflag.solid = SOLID_NOT;
		mcpflag.touch = SUB_Null;
		mcpflag.think = SUB_Null;
		mcpflag.nextthink = time + 1;
		FO_SetModel(mcpflag,"progs/beta1/mcp_flag.mdl");
		mcpflag.skin = 0;
		setsize(mcpflag, VEC_HULL_MIN, VEC_HULL_MAX);
		ChangeMCPFlagState(MCPFLAGSTATE_RESET, gm);
};

void PlayerScoreTick(entity p) =
{
			if (p.team_no == mcpflag.team_no) 
			{
				if(infokey(p, "scoreticktext") != "0")
					sprint(p,PRINT_HIGH, "your team controls flag (+1 point)\n");
				if(infokey(p, "scoreticksound") != "0")
					stuffcmd(p, "play beta1/scoretick_team.wav\n");
			}
			else
			{
				if(infokey(p, "scoreticktext") != "0")
					sprint(p,PRINT_HIGH, "enemy team controls flag (+1 point)\n");
				if(infokey(p, "scoreticksound") != "0")
					stuffcmd(p, "play beta1/scoretick_enemy.wav\n");
			}
};

void mcpflag_capped() =
{
	if(matchstate != MATCHSTATE_LIVE)
		return;
		
	mcpflag.nextthink = time + POINTINTERVAL;
	if(mcpflag.owner.team_no == TEAM_BLUE)
	{
		bluescore = bluescore + 1;

	}
	if(mcpflag.owner.team_no == TEAM_RED)
	{
		redscore = redscore + 1;
	}
	
	if(mcpflag.owner.team_no == TEAM_BLUE && (bluescore - redscore) == 1)
		bprint(2, "the \sblue team\s has taken the lead!\n");
	if(mcpflag.owner.team_no == TEAM_RED && (redscore - bluescore) == 1)
		bprint(2, "the \sred team\s has taken the lead!\n");
	if(bluescore == redscore)
		bprint(2, "the teams are tied!\n");
	
	local entity te = find(world, classname, "player");
	while (te) 
	{
		if(mcpflag.owner.team_no == TEAM_BLUE && (bluescore - redscore) == 1)
			stuffcmd(te, "play beta1/voice_blueleads.wav\n");
		if(mcpflag.owner.team_no == TEAM_RED && (redscore - bluescore) == 1)
			stuffcmd(te, "play beta1/voice_redleads.wav\n");
		if(bluescore == redscore)
			stuffcmd(te, "play beta1/voice_teamstied.wav\n");
		
		if (te.team_no == TEAM_BLUE) 
		{
			te.frags = bluescore;
			PlayerScoreTick(te);
		}
		
		if (te.team_no == TEAM_RED)
		{
			te.frags = redscore;
			PlayerScoreTick(te);
		}
		
		te = find(te, classname, "player");
        }
        if(redscore == MAXSCORE || bluescore == MAXSCORE)
        {
		matchstate = MATCHSTATE_FINISH;
		
		local entity p = find(world, classname, "player");
		while (p != world) 
		{
			if (p.netname != "") 
			{
				stuffcmd(p, "play beta1/buzzer.wav\n");
			}
			p = find(p, classname, "player");
		}
		
		if(redscore == MAXSCORE)
		{
			bprint(2, strcat("\sred team wins! \s", ftos(redscore) , "\s - \s", ftos(bluescore), "\n"));
		}
		else
		{
			bprint(2, strcat("\sblue team wins! ", ftos(bluescore) , " - ", ftos(redscore), "\s\n"));
		}
	}
        
};

void mcpflag_loose() =
{
	self.touch = mcpflag_touch;
	self.nextthink = time + 1;
	if(time > self.cnt)
		{
			ChangeMCPFlagState(MCPFLAGSTATE_RESET, gm);
		}
};

void mcpflag_carried()=
{
	self.nextthink = time + 0.1;
	
	if(self.owner.ismoving == 0)
		return;

	//particle(self.owner.origin, '0 0 0', 288, 32);
	//multicast(
};


void ChangeMCPFlagState(float zfstate,entity o) = 
{
	if (mcpflag.playerstate == zfstate)
		return;
	
	if(zfstate == MCPFLAGSTATE_RESET)
	{
		SoundTeam (TEAM_RED, world, "beta1/flagevent.wav");
		SoundTeam (TEAM_BLUE, world, "beta1/flagevent.wav");
		bprint(2, "\sthe flag has spawned!\s\n");
		setorigin(mcpflag,mcpflagspawn.origin);
		spawn_tfog(mcpflagspawn.origin);
		mcpflag.owner = gm;
		mcpflag.skin = MCPFLAG_SKIN_WHITE;
		mcpflag.solid = SOLID_TRIGGER;
		mcpflag.movetype = MOVETYPE_TOSS;
		mcpflag.touch = mcpflag_touch;
		mcpflag.angles = '0 0 0';
		mcpflag.think = SUB_Null;
		mcpflag.effects = 0;
		mcpflag.effects = mcpflag.effects | EF_BRIGHTLIGHT;
		mcpflag.effects = mcpflag.effects | EF_DIMLIGHT;
		mcpflag.effects = mcpflag.effects | EF_GREEN;

	}
	if(zfstate == MCPFLAGSTATE_THROWN)
	{

		if(o.team_no == TEAM_BLUE)
		{
				SoundTeam (TEAM_RED, world, "beta1/flagevent.wav");
				SoundTeam (TEAM_BLUE, world, "beta1/flagevent.wav");
				mcpflag.effects = 0;
				mcpflag.effects = mcpflag.effects | EF_BRIGHTLIGHT;
				mcpflag.effects = mcpflag.effects | EF_DIMLIGHT;
				mcpflag.effects = mcpflag.effects | EF_GREEN;
		}
		if(o.team_no == TEAM_RED)
		{
				SoundTeam (TEAM_RED, world, "beta1/flagevent.wav");
				SoundTeam (TEAM_BLUE, world, "beta1/flagevent.wav");
				mcpflag.effects = 0;
				mcpflag.effects = mcpflag.effects | EF_BRIGHTLIGHT;
				mcpflag.effects = mcpflag.effects | EF_DIMLIGHT;
				mcpflag.effects = mcpflag.effects | EF_GREEN;
		}
		bprint(2, strcat(mcpflag.owner.netname, " \shas thrown the flag!\s\n"));
		
		
		mcpflag.velocity_z = 400;
		mcpflag.velocity_x = -50 + (random() * 100);
		mcpflag.velocity_y = -50 + (random() * 100);
		if (o.v_angle_x < 25) 
		{
			mcpflag.velocity = (v_forward * FLAG_TOSSSPEED) + (v_up * 200); //400
		} 
		else 
		{
			mcpflag.velocity = aim(o, 10000);
			mcpflag.velocity = mcpflag.velocity * FLAG_TOSSSPEED; //400
			mcpflag.velocity_z = 200;
		}
		
		mcpflag.angles = '0 0 0';
		mcpflag.owner = gm;
		mcpflag.skin = MCPFLAG_SKIN_WHITE;
		mcpflag.solid = SOLID_TRIGGER;
		mcpflag.movetype = MOVETYPE_TOSS;
		mcpflag.touch = SUB_Null;
		mcpflag.think = mcpflag_loose;	//changes touch to give a buffer
		mcpflag.nextthink = time + 1;
		mcpflag.cnt = time + FLAG_RESET;
		

	}	
	if(zfstate == MCPFLAGSTATE_DROPPED)
	{
		if(o.team_no == TEAM_BLUE)
		{
				SoundTeam (TEAM_RED, world, "beta1/flagevent.wav");
				SoundTeam (TEAM_BLUE, world, "beta1/flagevent.wav");
				mcpflag.effects = 0;
				mcpflag.effects = mcpflag.effects | EF_BRIGHTLIGHT;
				mcpflag.effects = mcpflag.effects | EF_DIMLIGHT;
				mcpflag.effects = mcpflag.effects | EF_GREEN;
		}
		if(o.team_no == TEAM_RED)
		{
				SoundTeam (TEAM_RED, world, "beta1/flagevent.wav");
				SoundTeam (TEAM_BLUE, world, "beta1/flagevent.wav");
				mcpflag.effects = 0;
				mcpflag.effects = mcpflag.effects | EF_BRIGHTLIGHT;
				mcpflag.effects = mcpflag.effects | EF_DIMLIGHT;
				mcpflag.effects = mcpflag.effects | EF_GREEN;
		}
		bprint(2, strcat(mcpflag.owner.netname, " \sdropped the flag!\s\n"));
		mcpflag.owner = gm;
		mcpflag.skin = MCPFLAG_SKIN_WHITE;
		

		mcpflag.origin = o.origin;

		mcpflag.velocity_z = 300;
		mcpflag.velocity_x = -100 + random() * 200;
		mcpflag.velocity_y = -100 + random() * 200;

		mcpflag.angles = '0 0 0';
		mcpflag.solid = SOLID_TRIGGER;
		mcpflag.movetype = MOVETYPE_TOSS;
		
		mcpflag.touch = SUB_Null;
		mcpflag.think = mcpflag_loose; //changes touch to give a buffer
		mcpflag.nextthink = time + 1; 
		mcpflag.cnt = time + FLAG_RESET;
		makevectors(v_up);
	
	}
	if(zfstate == MCPFLAGSTATE_CARRIED)
	{
		stuffcmd(o, "play beta1/voice_youhaveflag.wav\n");
		if(o.team_no == TEAM_BLUE)
		{

				SoundTeam (TEAM_RED, o, "beta1/voice_enemyhasflag.wav");
				SoundTeam (TEAM_BLUE, o, "beta1/voice_teamhasflag.wav");
				mcpflag.effects = 0;
				mcpflag.effects = mcpflag.effects | EF_BRIGHTLIGHT;
				mcpflag.effects = mcpflag.effects | EF_DIMLIGHT;
				mcpflag.effects = mcpflag.effects | EF_BLUE;
		}
		if(o.team_no == TEAM_RED)
		{
				SoundTeam (TEAM_RED, o, "beta1/voice_teamhasflag.wav");
				SoundTeam (TEAM_BLUE, o, "beta1/voice_enemyhasflag.wav");
				mcpflag.effects = 0;
				mcpflag.effects = mcpflag.effects | EF_BRIGHTLIGHT;
				mcpflag.effects = mcpflag.effects | EF_DIMLIGHT;
				mcpflag.effects = mcpflag.effects | EF_RED;
		}
		bprint(2, strcat(o.netname, " \shas picked up the flag!\s\n"));
		mcpflag.owner = o;
		local vector org = o.origin + '-15 0 0';
		setorigin (mcpflag, org);
		
		mcpflag.view_ofs = mcpflag.origin - o.origin;
		o.items = o.items | IT_KEY1;
		mcpflag.skin = MCPFLAG_SKIN_WHITE;
		
		mcpflag.movetype = MOVETYPE_FOLLOW;
		mcpflag.aiment = o;
		mcpflag.solid = SOLID_NOT;
			
		mcpflag.touch = SUB_Null;
		mcpflag.think = mcpflag_carried;
		mcpflag.nextthink = time + 0.1;
	}
	if(zfstate == MCPFLAGSTATE_CAPPED)
	{
		mcpflag.owner.items = mcpflag.owner.items - (mcpflag.owner.items & IT_KEY1);
		
		if(o.team_no == TEAM_BLUE)
		{
			mcpflag.skin = MCPFLAG_SKIN_BLUE;
			bprint(2, strcat(mcpflag.owner.netname, " \scaptured the flag for blue!\s\n"));
			SoundTeam (TEAM_RED, world, "beta1/voice_bluescores.wav");
			SoundTeam (TEAM_BLUE, world, "beta1/voice_bluescores.wav");
			mcpflag.team_no = TEAM_BLUE;
			mcpflag.effects = 0;
			mcpflag.effects = mcpflag.effects | EF_BRIGHTLIGHT;
			mcpflag.effects = mcpflag.effects | EF_DIMLIGHT;
			mcpflag.effects = mcpflag.effects | EF_BLUE;
		}
		if(o.team_no == TEAM_RED)
		{
			mcpflag.skin = MCPFLAG_SKIN_RED;
			bprint(2, strcat(mcpflag.owner.netname, " \scaptured the flag for red!\s\n"));
			SoundTeam (TEAM_BLUE, world, "beta1/voice_redscores.wav");
			SoundTeam (TEAM_RED, world, "beta1/voice_redscores.wav");
			mcpflag.team_no = TEAM_RED;
			mcpflag.effects = 0;
			mcpflag.effects = mcpflag.effects | EF_BRIGHTLIGHT;
			mcpflag.effects = mcpflag.effects | EF_DIMLIGHT;
			mcpflag.effects = mcpflag.effects | EF_RED;
		}
		
		mcpflag.owner = o;
		mcpflag.angles = '0 0 0';
		
		setorigin(mcpflag,o.origin);
		spawn_tfog(o.origin);	
		
		mcpflag.movetype = MOVETYPE_NONE;
		mcpflag.solid = SOLID_TRIGGER;
		
		mcpflag.touch = mcpflag_touch;
		mcpflag.think = mcpflag_capped;
		mcpflag.nextthink = time + POINTINTERVAL;
	}

	mcpflag.playerstate = zfstate;
};

void gm_think_finish()=
{
	local float winningteam;
	if(bluescore > redscore)
		winningteam = TEAM_BLUE;
	else
		winningteam = TEAM_RED;
		
	if(self.bubble_count == 0)
	{
		local entity p = find(world, classname, "player");
		while (p != world) 
		{
			if (p.team_no == TEAM_BLUE || p.team_no == TEAM_RED) 
			{
				if(p.team_no == winningteam)
				{
					stuffcmd(p, "play beta1/voice_youwin.wav\n");
					stuffcmd(p, "play beta1/clap.wav\n");
				}
				else
				{
					stuffcmd(p, "play beta1/voice_youlose.wav\n");
					stuffcmd(p, "play beta1/boo.wav\n");
				}
			}
			p = find(p, classname, "player");
		}
		self.bubble_count = self.bubble_count + 1;
		self.nextthink = time + 2;
		return;
	}
	if(self.bubble_count == 1)
	{
		local entity p2 = find(world, classname, "player");
		while (p2 != world) 
		{
			if(bluescore == 0 || redscore == 0) //flawless
			{
				if (p2.team_no == winningteam) 
					stuffcmd(p2, "play beta1/voice_flawless.wav\n");
				else
					stuffcmd(p2, "play beta1/voice_yousuck.wav\n");
			}
			else if(fabs(bluescore - redscore) == 1) //holyshit 100-99
			{
				stuffcmd(p2, "play beta1/voice_holyshit.wav\n");
			}
			p2 = find(p2, classname, "player");
		}
		
		self.bubble_count = self.bubble_count + 1;
		self.nextthink = time + 9999;
		return;
	}
	
	
};

void gm_think_live() =
{
	if(matchstate == MATCHSTATE_COUNTDOWN)
	{
		matchstate = MATCHSTATE_LIVE;
		KillAllDrops();
	}
	self.nextthink = time + 1;

	if(self.bubble_count >= 0)
		self.bubble_count = self.bubble_count - 1;
		

		if(self.bubble_count <= 10 && self.bubble_count > 0)
		{
			local entity p = find(world, classname, "player");
			while (p != world) 
			{
				
				if (p.netname != "") 
				{
					local string n = ftos(self.bubble_count);
					stuffcmd(p, strcat("play misc/menu2.wav\n"));
				}
				p = find(p, classname, "player");
				
				local entity fs;				
				fs = find(world, classname, "sprite_flagspawn");
				while (fs != world) 
				{
					fs.frame = self.bubble_count;
					fs = find(fs, classname, "sprite_flagspawn");
				}
			}
		}

		if (self.bubble_count == 1)
			bprint(2, strcat("flag spawning in \s[\s",ftos(self.bubble_count),"\s]\s second.\n"));
		else if (self.bubble_count > 0 && self.bubble_count <= 10)
			bprint(2, strcat("flag spawning in \s[\s",ftos(self.bubble_count),"\s]\s seconds.\n"));

	if(self.bubble_count == 0)
	{
		fs = find(world, classname, "sprite_flagspawn");
		while (fs != world) 
		{
			remove(fs);
			fs = find(fs, classname, "sprite_flagspawn");
		}
		CreateMCPFlag();
	}
	if(matchstate == MATCHSTATE_FINISH)
	{
		self.think = gm_think_finish;
		self.bubble_count = 0;
		self.nextthink = time + 1;
		NextLevel ();
	}
};

void gm_think_countdown() =
{
	self.nextthink = time + 1;
	if(self.bubble_count <= 0)
	{
		bprint(2,"\sthe match is now live!\s\n");
		self.bubble_count = 15;
		local entity p1 = find(world, classname, "player");
		while (p1 != world) 
		{
			if (p1.netname != "") 
			{
				stuffcmd(p1, "play beta1/voice_fight.wav\n");
				stuffcmd(p1, "kill\n");
			}
			p1 = find(p1, classname, "player");
		}
		
		local entity cp = find(world, classname, "sprite_cappoint");
		while (cp != world) 
		{
			remove(cp);
			cp = find(cp, classname, "sprite_cappoint");
		}
		
		local entity ps = find(world, classname, "sprite_playerspawn");
		while (ps != world) 
		{
			remove(ps);
			ps = find(cp, classname, "sprite_playerspawn");
		}
		local entity si = find(world,classname, "sprite_classinfo");
		while (si != world)
		{
			remove(si);
			si = find(si, classname, "sprite_classinfo");
		}
		
		self.think = gm_think_live;
		return;
	}
	if(self.bubble_count == 1)
		bprint(2,strcat("\s[\s",ftos(self.bubble_count),"\s]\s second.\n"));
	else
		bprint(2, strcat("\s[\s",ftos(self.bubble_count),"\s]\s seconds.\n"));
		
	if(self.bubble_count > 0 && self.bubble_count <= 5)
	{
		local entity p = find(world, classname, "player");
		while (p != world) 
		{
			if (p.netname != "") 
			{
				local string n = ftos(self.bubble_count);
				stuffcmd(p, strcat("play beta1/voice_",ftos(self.bubble_count),".wav\n"));
			}
			p = find(p, classname, "player");
		}
	}
	

			
	self.bubble_count = self.bubble_count - 1;
};


void gm_think_waitforplayers() =
{
	self.nextthink = time + 1;
	local float readyplayers = 0;
	local float forcestarters = 0;
	local float totalplayers = 0;
	cprint_waitingforplayers = "";
	
	local entity te = find(world, classname, "player");
	while(te)
	{
		if(te != world && te.isconnected == 1)
		{
			totalplayers = totalplayers + 1;
			if(te.playerstate == PLAYERSTATE_READY)
				readyplayers = readyplayers + 1;
			if(te.playerstate == PLAYERSTATE_FORCESTART)
			{
				readyplayers = readyplayers + 1;
				forcestarters = forcestarters + 1;
			}
			if(te.playerstate == PLAYERSTATE_NOTREADY)
			{

				cprint_waitingforplayers = strcat(cprint_waitingforplayers, te.netname, " ");	
			}
		}
		te = find(te,classname,"player");
	}
	
	if(totalplayers == 0)
		return;
		
	if(readyplayers == totalplayers || forcestarters > (totalplayers/2))
	{
		matchstate = MATCHSTATE_COUNTDOWN;
		self.think = gm_think_countdown;
		self.bubble_count = 5;
		self.nextthink = time + 1;
		bprint(2,"\sall players ready! get psyched!\s\n");
		
		local entity p = find(world, classname, "player");
		while (p != world) 
		{
			
			if (p.netname != "") 
			{
				stuffcmd(p, "play beta1/readyall.wav\n");
			}
			p = find(p, classname, "player");
		}
		return;
	}	
};

void readyupspammer_think() =
{
	if(matchstate != MATCHSTATE_WAITINGFORPLAYERS)
	{
		remove(self);
		return;
	}
	local float readyplayers = 0;
	local float totalplayers = 0;
	
	local entity te = find(world, classname, "player");
	while(te)
	{
		if(te != world && te.isconnected == 1)
		{
			totalplayers = totalplayers + 1;
			if(te.playerstate == PLAYERSTATE_READY)
				readyplayers = readyplayers + 1;
			if(te.playerstate == PLAYERSTATE_FORCESTART)
			{
				readyplayers = readyplayers + 1;
			}
			if(te.playerstate == PLAYERSTATE_NOTREADY)
			{
	
			}
		}
		te = find(te,classname,"player");
	}
	
	if(totalplayers > 0)
	{
	bprint(2, strcat("[", ftos(readyplayers) , "/", ftos(totalplayers) , "] players are ready.\nwaiting for: ", cprint_waitingforplayers , "\n")); 
	te = find(world, classname, "player");
	while(te)
		{
			if(te != world && te.isconnected == 1)
			{
				if(te.playerstate == PLAYERSTATE_READY)
				{
					sprint(te, PRINT_HIGH, "you are \sready\s, good work\n");
				}

				if(te.playerstate == PLAYERSTATE_FORCESTART)
				{
					sprint(te, PRINT_HIGH, "you are \sready\s and want to \sforcestart\s\n");
				}
				if(te.playerstate == PLAYERSTATE_NOTREADY)
				{
		
					if((readyplayers/totalplayers) <= 0.5)
					{
						stuffcmd(te, "play beta1/error.wav\n");
						sprint(te, PRINT_HIGH, "you are \snot ready\s. type ready in console\n");
					}
					else if((readyplayers/totalplayers) < 0.75)
					{
						stuffcmd(te, "play beta1/hurryup1.wav\n");
						sprint(te, PRINT_HIGH, "you are \snot ready\s and holding people up. type ready in console\n");
					}
					else 
					{
						stuffcmd(te, "play beta1/hurryup2.wav\n");
						sprint(te, PRINT_HIGH, "you are \snot ready\s and getting spammed until you type ready in console\n");
					}
				}
			}
			te = find(te,classname,"player");
		}
	}
	
	if((readyplayers/totalplayers) <= 0.5)
		self.nextthink = time + 10;
	else if((readyplayers/totalplayers) < 0.75)
		self.nextthink = time + 8;
	else
		self.nextthink = time + 5;
};

void CreateReadyUpSpammer() =
{
	local entity te;
	te = spawn();			
	te.classname = "readyupspammer";
	te.think = readyupspammer_think;
	te.nextthink = time + 5;
};

void cheatchecker_think()=
{
	self.nextthink = time + 2;
	
	local entity te = find(world, classname, "player");
	while (te) 
	{
		if (te.isconnected)
		{
			if(te.team_no == TEAM_BLUE)
			{	
				if (infokey(te, "topcolor") == "4")
				{
					stuffcmd(te, "topcolor 13\n");
				}
				if (infokey(te, "bottomcolor") != "13")
				{
					stuffcmd(te, "bottomcolor 13\n");
				}
				if( infokey(te, "team") != "blue")
				{
					stuffcmd(te, "team blue\n");
				}
			}
			else if(te.team_no == TEAM_RED)
			{
				if (infokey(te, "bottomcolor") != "4")
				{
					stuffcmd(te, "bottomcolor 4\n");
				}
				if (infokey(te, "topcolor") == "13")
				{
					stuffcmd(te, "topcolor 4\n");
				}
				if( infokey(te, "team") != "red")
				{
					stuffcmd(te, "team red\n");
				}
			}
			else
			{
				if( infokey(te, "color") != "0 0")
				{
					stuffcmd(te, "color 0 0\n");
				}
				if( infokey(te, "team") != "none")
				{
					stuffcmd(te, "team none\n");
				}
			}
		}
		te = find(te, classname, "player");
	}
};

void CreateCheatChecker() =
{
	local entity te;
	te = spawn();			
	te.classname = "cheatchecker";
	te.think = cheatchecker_think;
	te.nextthink = time + 2;
};

void gm_think_init() =
{
	matchstate = MATCHSTATE_WAITINGFORPLAYERS;
	self.nextthink = time + 1;
	self.think = gm_think_waitforplayers;

	//assign mcpflagspawn
	mcpflagspawn = find(world, classname, "info_mcpflag_spawn");

	if(mcpflagspawn == world)
	{
		self.think = SUB_Null;
		bprint(2,"error : no flag spawn found\n");
		return;
	}
	CreateReadyUpSpammer();
	CreateCheatChecker();
};



void CreateGameManager() =
{
	FO_FlashDimension = -1;
	dimension_send = DMN_NOFLASH;
	local entity te;
	te = spawn();			
	te.classname = "gamemanager";
	te.think = gm_think_init;
	te.nextthink = time + 2;
	gm = te;
	
	bluescore = 0;
	redscore = 0;
	role_recon_max 		= GetInfo(world, "role_recon_max", "9");
	role_assassin_max 	= GetInfo(world, "role_assassin_max", "9");
	role_fighter_max 	= GetInfo(world, "role_fighter_max", "9");
	role_bomber_max 	= GetInfo(world, "role_bomber_max", "9");
	role_support_max 	= GetInfo(world, "role_support_max", "9");
	
};









