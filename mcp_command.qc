
void TogglePlayerReady(float ps) =
{
	self.impulse = 0;
	if(self.team_no == TEAM_NONE)
		return;
	if(self.team_no == ROLE_NONE)
		return;

	if(matchstate == MATCHSTATE_LIVE)
	{
		stuffcmd(self, "play beta1/error.wav\n");
		sprint(self,PRINT_HIGH,"match is already live.\n");
		return;
	}
	
	if(ps == PLAYERSTATE_NOTREADY || ps == PLAYERSTATE_READY)
	{
		if(self.playerstate == PLAYERSTATE_NOTREADY)
		{
			self.playerstate = PLAYERSTATE_READY;
			bprint(2, strcat(self.netname," is \sready\s to play!\n"));
			stuffcmd(self, "play beta1/ready.wav\n");
		}
		else
		{
			self.playerstate = PLAYERSTATE_NOTREADY;
			bprint(2, strcat(self.netname," is now \snot ready\s. boo! hiss!\n"));
			stuffcmd(self, "play beta1/notready.wav\n");
		}
	}
	else if (ps == PLAYERSTATE_FORCESTART)
	{
		if(self.playerstate == PLAYERSTATE_FORCESTART)
		{
			self.playerstate = PLAYERSTATE_NOTREADY;
			bprint(2, strcat(self.netname," is now \snot ready\s. boo! hiss!\n"));
			stuffcmd(self, "play beta1/notready.wav\n");
		}
		else
		{
			self.playerstate = PLAYERSTATE_FORCESTART;
			local float forcestarters = 0;
			local float totalplayers = 0;
			local entity te = find(world, classname, "player");
			while(te)
			{
				if(te != world && te.isconnected == 1)
				{
					totalplayers = totalplayers + 1;
					if(te.playerstate == PLAYERSTATE_FORCESTART)
					{

						forcestarters = forcestarters + 1;
					}

				}
				te = find(te,classname,"player");
			}
			local float fsneeded = floor(((totalplayers / 2) + 1) - forcestarters);
			if (fsneeded == 0)
			{
				bprint(2, strcat(self.netname," is \sready\s and wants to \sforcestart\s!\nforcestart successful, good luck!.\n"));
				stuffcmd(self, "play beta1/ready.wav\n");
			}
			else
			{
				bprint(2, strcat(self.netname," is \sready\s and wants to \sforcestart\s! [", ftos(fsneeded),"] more needed.\n"));
				stuffcmd(self, "play beta1/ready.wav\n"); 
			}
		}
	}

};

void DownloadShit(float imp) =
{
	self.impulse = 0;
	
	if(imp == IMP_GB1)
	{
		stuffcmd(self, "download skins/blue_rec.pcx\n");
	}
	else if(imp == IMP_GB2)
	{
		stuffcmd(self, "download skins/blue_ass.pcx\n");
	}
	if(imp == IMP_GB3)
	{
		stuffcmd(self, "download skins/blue_fig.pcx\n");
	}
	else if(imp == IMP_GB4)
	{
		stuffcmd(self, "download skins/blue_bom.pcx\n");
	}
	if(imp == IMP_GB5)
	{
		stuffcmd(self, "download skins/blue_sup.pcx\n");
	}
	else if(imp == IMP_GR1)
	{
		stuffcmd(self, "download skins/red_rec.pcx\n");
	}
	else if(imp == IMP_GR2)
	{
		stuffcmd(self, "download skins/red_ass.pcx\n");
	}
	else if(imp == IMP_GR3)
	{
		stuffcmd(self, "download skins/red_fig.pcx\n");
	}
	else if(imp == IMP_GR4)
	{
		stuffcmd(self, "download skins/red_bom.pcx\n");
	}
	else if(imp == IMP_GR5)
	{
		stuffcmd(self, "download skins/red_sup.pcx\n");
	}
	else if(imp == IMP_GM1)
	{
		stuffcmd(self, "download progs/bolt.mdl\n");
	}
	else if(imp == IMP_GM2)
	{
		stuffcmd(self, "download progs/bolt2.mdl\n");
	}
	else if(imp == IMP_GM3)
	{
		stuffcmd(self, "download progs/bolt3.mdl\n");
	}
};

void MCPHelp(float imp) =
{
	local string line1, line2, line3, line4 = "";

	self.impulse = 0;
	sprint(self, PRINT_HIGH, "\s*******************************\s\n\n");
	if(imp == IMP_GETMISSING)
	{
		sprint(self, PRINT_HIGH, "type in console to download missing skins and models :\n\n\sget1\s [press enter key]\n\sget2\s [press enter key]\n\sget3\s [press enter key]\n\nmake sure to \srestart your client\s when finished.\n");
		
	}
	if(imp == IMP_MCPHELP)
	{
		sprint(self, PRINT_HIGH, "type in console followed by [enter key] for more info :\n\n\smcp-goal\s -  whats the point of the game\n\smcp-commands\s - list of commands (how to change team/class etc)\n\smcp-binds\s - extra keys you will need to setup that are not found in the menu\n\smcp-setinfos\s - list of customization options\n\sgetmissing\s - instructions to get missing models and skins\n");
	}
	if(imp == IMP_BINDS)
	{
		sprint(self, PRINT_HIGH,"\sreload\s - reloads your weapon\n\sprimegren\s - primes a grenade, press again will throw (alternatives: \sprimeone\s , \sprimetwo\s)\n\sthrowgren\s - throws a primed grenade\n\sspecial\s - uses classes special ability\n\sthrowflag\s - throws flag if you have it (alternatives: \sdropitems\s , \sdropflag\s)\n\sflaginfo\s - prints the flag status top of screen\n\sinv\s - prints how many grenades you have, your team, and if you carry flag\n\s+slotX\s - quickfire weapon in X slot. eg +slot1\n\sreloadnext\s - reloads next weapon\n\sweapnext\s - next weapon\n\sweapprev\s - previous weapon\n\sweaplast\s - last fired weapon\n");
	}
	if(imp == IMP_SETINFOS)
	{
		sprint(self, PRINT_HIGH,"\ssetinfo grentimer 0\s - 1-26 different sounds, 0 turns off\n\ssetinfo grentimerdelay x.xx\s - delay the start of grentimer sound\n\ssetinfo ec 1\s - auto exec class cfgs in mcp folder (2 uses tf names)\n\ssetinfo et 1\s - auto exec teamblue.cfg, teamred.cfg, teamnone.cfg in mcp folder\n\ssetinfo tf2slots 1\s - changes 1-4 keys to be like tf2\n\ssetinfo hitsound 0\s - turns off hitsounds\n\ssetinfo killsound 0\s - turns off killsound\n\ssetinfo regensound 0\s - turns off regen sounds\n\ssetinfo scoreticksound 0\s - turns off scoretick sound\n\ssetinfo scoreticktext 0\s - turns off scoretick text\n\ssetinfo ai 0\s - turns off identify text\n\ssetinfo obj 0\s - turns off objective text (2/3 change level of detail)\n\ssetinfo sb1 x\s - how many lines from top of screen before printing identify text\n\ssetinfo sb2 x\s - how many lines between identify and objective text\n\ssetinfo sbflip 1\s - flips positions of id and obj text\n");
	}
	if(imp == IMP_COMMANDS)
	{
		sprint(self, PRINT_HIGH,"\schangeteam\s - bring up change team menu\n\sswapteam\s - swaps team\n\schangeclass\s - brings up changeclass menu\n\sjoinblue\s - joins blue team (alternative: \sgoblue\s)\n\sjoinred\s - join red team (alternative: \sgored\s)\n\sready\s - toggle your ready status\n\sforcestart\s - vote to forcestart match\n");
	}
	if(imp == IMP_GOAL)
	{
		sprint(self, PRINT_HIGH,"flag will spawn in middle shorlty after all players are ready.\ncapture and defend the flag in your teams base to gain points.\nfirst team to 100 wins!\n");
	}
	if(imp == IMP_CLASSES)
	{
		//sprint(self, PRINT_HIGH,"\srecon\s\n\sweapon:\s (supernailgun) - shoot at walls and climb the nails\n\sgren:\s (airblast) - pushes people away from blast at high speed with no damage\n\sspecial:\s (dash) - jump forward a short distace\n\spassive\s (health regen) - slowly regens health out of combat\n\n\sassassin\s\n\sweapon:\s (railgun) - damage scales with distance (closer is higher)\n\sgren:\s (flash) - blinds players (closer is longer)\n\sspecial:\s (cloak) - go invisible for a short time (100 energy needed)\n\spassive:\s (melee) - melee damage is increased\n\n\sfighter\s\n\sweapon:\s (rocketlauncher) - yep, 4 shots before reload\n\sgren:\s (frag) - standard grenade\n\sspecial\s (harpoon) - pulls enemy closer (100 energy needed)\n\spassive:\s (armour) - regens armour out of combat\n\n\strapper\s\n\sweapon:\s (stickylauncher) - shoot sticky grenades at wall and use special key to detonate them (direct hits auto detonate)\n\sgren:\s (beartrap) - set a maximum of 2 traps that hurt enemys who stand on them for alot (enemy can shoot to destroy trap)\n\special:\s (detonate) - detonate all your sticky grenades\n\spassive:\s (damage) - reduced self damage\n\n\ssupport\s\n\sweapon:\s lightning gun - hurts enemy, heals friendly\n\sgren:\s leech - heals user for small amount of damage gren does to enemy\n\sspecial:\s teleball - press once to launch a teleport ball (100 energy needed), press again to teleport there\n\spassive:\s cant rememeber\n");
	}
	if(imp == IMP_HELP_RECON)
	{
		
	}
	if(imp == IMP_HELP_ASSASSIN)
	{
		
	}
	if(imp == IMP_HELP_FIGHTER)
	{
		
	}
	if(imp == IMP_HELP_BOMBER)
	{
		
	}
	if(imp == IMP_HELP_SUPPORT)
	{
		
	}
	sprint(self, PRINT_HIGH, "\n\s*******************************\s\n");
	stuffcmd(self, "play beta1/notice.wav\n");
		
};

void InvInfo() =
{
	self.impulse = 0;
	if(self.team_no == TEAM_NONE)
		return;
	if(self.role == ROLE_NONE)
		return;
	if(self.team_no == TEAM_BLUE)
	{
		sprint(self, PRINT_HIGH, "blue team\n");

	}
	if(self.team_no == TEAM_RED)
	{
		sprint(self, PRINT_HIGH, "red team\n");
	}
		
	if(self.role == ROLE_RECON)
	{
		sprint(self, PRINT_HIGH, strcat(ftos(self.grencount)," shatter grenades\n"));	
	}
	if(self.role == ROLE_ASSASSIN)
	{
		sprint(self, PRINT_HIGH, strcat(ftos(self.grencount)," flash grenades\n"));	
	}
	if(self.role == ROLE_FIGHTER)
	{
		sprint(self, PRINT_HIGH, strcat(ftos(self.grencount)," frag grenades\n"));	
	}
	if(self.role == ROLE_BOMBER)
	{
		sprint(self, PRINT_HIGH, strcat(ftos(self.grencount)," frag grenades\n"));	
	}
	if(self.role == ROLE_SUPPORT)
	{
		sprint(self, PRINT_HIGH, strcat(ftos(self.grencount)," leech grenades\n"));		
	}
	if(mcpflag.owner == self)
		sprint(self, PRINT_HIGH, "the flag\n");	
};

void FlagInfo() =
{
	self.impulse = 0;
	if(mcpflag.owner == self)
	{
		sprint(self, PRINT_HIGH, "\syou\s have the flag!\n");	
		return;
	}
	if(mcpflag.playerstate == MCPFLAGSTATE_RESET)
	{	
		sprint(self, PRINT_HIGH, "the flag is at its \sspawnpoint\s!\n");	
		return;
	}
	if(mcpflag.playerstate == MCPFLAGSTATE_CARRIED)
	{
		if(self.team_no == TEAM_NONE)
		{
			sprint(self, PRINT_HIGH, strcat("flag carried by ",mcpflag.owner.netname,"!\n"));	
			return;
		}
		if(self.team_no == mcpflag.owner.team_no)
		{
			sprint(self, PRINT_HIGH, strcat("flag carried by \steammate\s ",mcpflag.owner.netname,"!\n"));	
			return;
		}
		else
		{
			
			sprint(self, PRINT_HIGH, strcat("flag carried by \senemy\s ",mcpflag.owner.netname,"!\n"));	
			return;
		}
	}
	
	if(mcpflag.playerstate == MCPFLAGSTATE_DROPPED)
	{
		sprint(self, PRINT_HIGH, strcat("flag \sdropped\s somewhere!\n"));	
		return;
	}
	if(mcpflag.playerstate == MCPFLAGSTATE_THROWN)
	{
		sprint(self, PRINT_HIGH, strcat("flag \sthrown\s somewhere!\n"));	
		return;
	}
	if(mcpflag.playerstate == MCPFLAGSTATE_CAPPED)
	{
		if(self.team_no == TEAM_NONE)
		{
			if(mcpflag.owner.team_no == TEAM_BLUE)
			{
				sprint(self, PRINT_HIGH, "the \sblue\s team controls the flag!\n");	
				return;
			}
			if(mcpflag.owner.team_no == TEAM_RED)
			{
				sprint(self, PRINT_HIGH, "the \sred\s team controls the flag!\n");	
				return;	
			}
		}
		if(self.team_no != mcpflag.owner.team_no)
		{
			sprint(self, PRINT_HIGH, "the \senemy\s team controls the flag!\n");	
			return;	
		}
		else
		{
			sprint(self, PRINT_HIGH, "\syour team\s controls the flag!\n");	
			return;
		}
	}
	if(matchstate == MATCHSTATE_WAITINGFORPLAYERS)
	{
		if(self.playerstate == PLAYERSTATE_READY)
		{
			sprint(self, PRINT_HIGH, "no flag. waiting for players. you are \sready\s\n");	
			return;	
		}
		if(self.playerstate == PLAYERSTATE_FORCESTART)
		{
			sprint(self, PRINT_HIGH, "no flag. waiting for players. you are \sready and forcestart\s\n");	
			return;	
		}
		if(self.playerstate == PLAYERSTATE_NOTREADY)
		{

			sprint(self, PRINT_HIGH, "no flag. waiting for players. you are \snot ready\s\n");	
			return;	

		}
	}
	if(mcpflag.playerstate == MCPFLAGSTATE_NONE)
	{
			sprint(self, PRINT_HIGH, "flag has \snot spawned\s yet!\n");	
			return;	
	}
};

void ChangeTeam() =
{		
	self.impulse = 0;
	ShowMenu(MENU_SELECTTEAM);
};
void SwapTeam() =
{		
	self.impulse = 0;
	if(self.deadflag == DEAD_NO)
		ClientKill();
	
	if(self.team_no == TEAM_RED)
		{
			self.team_no = TEAM_BLUE;

			bprint(2, strcat(self.netname, " has joined the \sblue\s team.\n"));
			self.role = ROLE_NONE;
			self.nextrole = ROLE_NONE;
			SetTeamFragsColourName();
			ShowMenu(MENU_SELECTROLE);
			return;
		}
	if(self.team_no == TEAM_BLUE)
		{
			self.team_no = TEAM_RED;

			bprint(2, strcat(self.netname, " has joined the \sred\s team.\n"));
			self.role = ROLE_NONE;
			self.nextrole = ROLE_NONE;
			SetTeamFragsColourName();
			ShowMenu(MENU_SELECTROLE);
			return;
		}	
	ShowMenu(MENU_SELECTTEAM);
};

void ChangeRole(float r) =
{
	self.impulse = 0;
	if(self.team_no == TEAM_NONE)
	{
		ShowMenu(MENU_SELECTTEAM);
		sprint(self, PRINT_HIGH, "you must join a team first.\n");
		stuffcmd(self, "play beta1/error.wav\n");
		return;
	}
	
	if(r == ROLE_RECON)
	{
		if( GetRoleCount(ROLE_RECON, self.team_no) < role_recon_max )
		{
			self.nextrole = ROLE_RECON;
			ShowMenu(MENU_NONE);
			if(self.role == ROLE_NONE)
			{	
				respawn();
				return;
			}
			sprint(self, PRINT_HIGH, "you will respawn as a recon.\n");
			return;

		}
		sprint(self, PRINT_HIGH, "too many of that class already.\n");
		stuffcmd(self, "play beta1/error.wav\n");
		return;
	}
	
	if(r == ROLE_ASSASSIN)
	{
		if( GetRoleCount(ROLE_ASSASSIN, self.team_no) < role_assassin_max )
		{
			self.nextrole = ROLE_ASSASSIN;
			ShowMenu(MENU_NONE);
			if(self.role == ROLE_NONE)
			{	
				respawn();
				return;
			}
			sprint(self, PRINT_HIGH, "you will respawn as an assassin.\n");
			return;
		}
		sprint(self, PRINT_HIGH, "too many of that class already.\n");
		stuffcmd(self, "play beta1/error.wav\n");
		return;
	}
	
	if(r == ROLE_FIGHTER)
	{
		if( GetRoleCount(ROLE_FIGHTER, self.team_no) < role_fighter_max )
		{
			self.nextrole = ROLE_FIGHTER;
			ShowMenu(MENU_NONE);
			if(self.role == ROLE_NONE)
			{	
				respawn();
				return;
			}
			sprint(self, PRINT_HIGH, "you will respawn as a fighter.\n");
			return;
		}
		sprint(self, PRINT_HIGH, "too many of that class already.\n");
		stuffcmd(self, "play beta1/error.wav\n");
		return;
	}
	
	if(r == ROLE_BOMBER)
	{
		if( GetRoleCount(ROLE_BOMBER, self.team_no) < role_bomber_max )
		{
			self.nextrole = ROLE_BOMBER;
			ShowMenu(MENU_NONE);
			if(self.role == ROLE_NONE)
			{	
				respawn();
				return;
			}
			sprint(self, PRINT_HIGH, "you will respawn as a bomber.\n");
			return;
		}
		sprint(self, PRINT_HIGH, "too many of that class already.\n");
		stuffcmd(self, "play beta1/error.wav\n");
		return;
	}
	
	if(r == ROLE_SUPPORT)
	{
		if( GetRoleCount(ROLE_SUPPORT, self.team_no) < role_support_max )
		{
			self.nextrole = ROLE_SUPPORT;
			ShowMenu(MENU_NONE);
			if(self.role == ROLE_NONE)
			{	
				respawn();
				return;
			}
			sprint(self, PRINT_HIGH, "you will respawn as a support.\n");
			return;
		}
		sprint(self, PRINT_HIGH, "too many of that class already.\n");
		stuffcmd(self, "play beta1/error.wav\n");
		return;
	}
	
	if(r == ROLE_MGUNNER)
	{
		if( GetRoleCount(ROLE_MGUNNER, self.team_no) < role_mgunner_max )
		{
			self.nextrole = ROLE_MGUNNER;
			ShowMenu(MENU_NONE);
			if(self.role == ROLE_NONE)
			{	
				respawn();
				return;
			}
			sprint(self, PRINT_HIGH, "you will respawn as a minigunner.\n");
			return;
		}
		sprint(self, PRINT_HIGH, "too many of that class already.\n");
		stuffcmd(self, "play beta1/error.wav\n");
		return;
	}
};

void CreateAlias(entity e, string s, float imp) =
{
    local string aliasstring = strcat("alias ",s," impulse ",ftos(imp),"\n");
    stuffcmd(e, aliasstring);
};

void SetAliases3(entity e) = 
{
	if(e.team_no == TEAM_NONE && e.role == ROLE_NONE)
	{
		sprint(e, PRINT_HIGH, "\n\ntype \smcp-help\s in console for mod help topics.\n\n");
		stuffcmd(e, "play beta1/notice.wav\n");
	}
	
	CreateAlias(e,"getmissing", IMP_GETMISSING);
	CreateAlias(e,"mcp-help", IMP_MCPHELP);
	CreateAlias(e,"mcp-binds", IMP_BINDS);
	CreateAlias(e,"mcp-setinfos", IMP_SETINFOS);
	CreateAlias(e,"mcp-commands", IMP_COMMANDS);
	//CreateAlias(e,"mcp-classes", IMP_CLASSES);
	CreateAlias(e,"mcp-goal", IMP_GOAL);
	
	CreateAlias(e,"mcp-version", IMP_VERSION);
	
	CreateAlias(e,"+slot1", IMP_QSHOT1_START);
	CreateAlias(e,"+slot2", IMP_QSHOT2_START);
	CreateAlias(e,"+slot3", IMP_QSHOT3_START);
	CreateAlias(e,"+slot4", IMP_QSHOT4_START);
	CreateAlias(e,"-slot1", IMP_QSHOT1_STOP);
	CreateAlias(e,"-slot2", IMP_QSHOT2_STOP);
	CreateAlias(e,"-slot3", IMP_QSHOT3_STOP);
	CreateAlias(e,"-slot4", IMP_QSHOT4_STOP);
	CreateAlias(e,"1hp", IMP_1HP);
};

void SetAliases2(entity e) =
{

	//CreateAlias(e,"get1", IMP_GB1);
	//CreateAlias(e,"get2", IMP_GB2);
	//CreateAlias(e,"get3", IMP_GB3);
	//CreateAlias(e,"get4", IMP_GB4);
	//CreateAlias(e,"get5", IMP_GB5);
	//CreateAlias(e,"get6", IMP_GR1);
	//CreateAlias(e,"get7", IMP_GR2);
	//CreateAlias(e,"get8", IMP_GR3);
	//CreateAlias(e,"get9", IMP_GR4);
	//CreateAlias(e,"get10", IMP_GR5);
	CreateAlias(e,"get1", IMP_GM1);
	CreateAlias(e,"get2", IMP_GM2);
	CreateAlias(e,"get3", IMP_GM3);
	
	CreateAlias(e,"reloadnext", IMP_RELOADNEXT);
	CreateAlias(e,"weapnext", IMP_NEXTWEAPON);
	CreateAlias(e,"weapprev", IMP_PREVWEAPON);
	CreateAlias(e,"weaplast", IMP_LASTWEAPON);
	
	CreateAlias(e,"+gren1", IMP_PRIMEGREN);
	CreateAlias(e,"-gren1", IMP_THROWGREN);
	CreateAlias(e,"+gren", IMP_PRIMEGREN);
	CreateAlias(e,"-gren", IMP_THROWGREN);
	CreateAlias(e,"+gren2", IMP_PRIMEGREN);
	CreateAlias(e,"-gren2", IMP_THROWGREN);
	
	
	CreateAlias(e,"primeone", IMP_PRIMEGREN);
	CreateAlias(e,"primetwo", IMP_PRIMEGREN);
	CreateAlias(e,"primegren", IMP_PRIMEGREN);
	CreateAlias(e,"throwgren", IMP_THROWGREN);
	CreateAlias(e,"gren1", IMP_2TAPGREN);
	CreateAlias(e,"gren2", IMP_2TAPGREN);
	CreateAlias(e,"pingmap", IMP_CREATEPING);
};

void SetAliases1(entity e) =
{
	CreateAlias(e,"reload", IMP_RELOAD);
	CreateAlias(e,"swapteam", IMP_SWAPTEAM);
	CreateAlias(e,"changeteam", IMP_CHANGETEAM);
	CreateAlias(e,"changeclass", IMP_CHANGEROLE);
	CreateAlias(e,"special", IMP_SPECIAL);
	
	CreateAlias(e,"dropflag", IMP_THROWMCPFLAG);
	CreateAlias(e,"dropitems", IMP_THROWMCPFLAG);
	CreateAlias(e,"throwflag", IMP_THROWMCPFLAG);
	
	CreateAlias(e,"discard", IMP_NULL);
	CreateAlias(e,"joinred", IMP_JOINRED);
	CreateAlias(e,"joinblue", IMP_JOINBLUE);
	CreateAlias(e,"gored", IMP_JOINRED);
	CreateAlias(e,"goblue", IMP_JOINBLUE);
	CreateAlias(e,"recon", IMP_GORECON);
	CreateAlias(e,"assassin", IMP_GOASSASSIN);
	CreateAlias(e,"fighter", IMP_GOFIGHTER);
	CreateAlias(e,"bomber", IMP_GOBOMBER);
	CreateAlias(e,"support", IMP_GOSUPPORT);
	CreateAlias(e,"minigunner", IMP_GOMGUNNER);
	
	CreateAlias(e,"scout", IMP_GORECON);
	CreateAlias(e,"sniper", IMP_GOASSASSIN);
	CreateAlias(e,"soldier", IMP_GOFIGHTER);
	CreateAlias(e,"demoman", IMP_GOBOMBER);
	CreateAlias(e,"medic", IMP_GOSUPPORT);
	CreateAlias(e,"hwguy", IMP_GOMGUNNER);
	
	CreateAlias(e,"ready", IMP_PLAYER_READY);
	CreateAlias(e,"forcestart", IMP_PLAYER_FORCESTART);

	
	CreateAlias(e,"inv", IMP_INV);
	CreateAlias(e,"flaginfo", IMP_FLAGINFO);

};