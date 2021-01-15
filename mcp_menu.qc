

void() MenuThink = 
{
	self.nextthink = time + 0.1;
	
	if(self.owner.menu == MENU_NONE)
	{
		self.think = SUB_Remove;
		centerprint(self.owner, MenuString(MENU_NONE));
		return;
	}
	
	centerprint(self.owner, MenuString(self.owner.menu));
};

void(float imp) MenuInput = 
{
	self.impulse = 0;
	local string s_fullteam	= "that team is full.\n";

	local string s_fullrole	= "too many of that class already.\n";
	local string s_unavail = "not yet implemented.\n";

	
	if(self.menu == MENU_SELECTTEAM)
	{
		if(imp == 1)
		{
			if(self.team_no == TEAM_BLUE)
			{
				sprint(self, PRINT_HIGH, "you are already on that team.\n");
				stuffcmd(self, "play beta1/error.wav\n");
				return;
			}
			else
			{	
				if(self.deadflag == DEAD_NO)
					ClientKill();
				self.team_no = TEAM_BLUE;
				bprint(2, strcat(self.netname, " has joined the \sblue\s team.\n"));
				self.role = ROLE_NONE;
				self.nextrole = ROLE_NONE;
				SetTeamFragsColourName();
				ShowMenu(MENU_SELECTROLE);
				return;
			}
		}
		if(imp == 2)
		{
			if(self.team_no == TEAM_RED)
			{
				sprint(self, PRINT_HIGH, "you are already on that team.\n");
				stuffcmd(self, "play beta1/error.wav\n");
				return;	
			}
			else
			{
				if(self.deadflag == DEAD_NO)
					ClientKill();
				self.team_no = TEAM_RED;
				bprint(2, strcat(self.netname, " has joined the \sred\s team.\n"));
				self.role = ROLE_NONE;
				self.nextrole = ROLE_NONE;
				SetTeamFragsColourName();
				ShowMenu(MENU_SELECTROLE);
				return;
			}
		}
		if(imp == 5)
		{
			if(self.team_no == TEAM_RED || self.team_no == TEAM_BLUE)
				return;
			self.team_no = AutoPickTeam();
			if(self.team_no == TEAM_BLUE)
			{
				bprint(2, strcat(self.netname, " was automagically put on the \sblue\s team.\n"));
			}
			if(self.team_no == TEAM_RED)
			{
				bprint(2, strcat(self.netname, " was automagically put on the \sred\s team.\n"));
			}
			self.role = ROLE_NONE;
			self.nextrole = ROLE_NONE;
			SetTeamFragsColourName();
			ShowMenu(MENU_SELECTROLE);
			return;
			
		}
	}
	
	
	if(self.menu == MENU_SELECTROLE)
	{
		if(imp == 1)
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
			sprint(self, PRINT_HIGH, s_fullrole);
		}
		if(imp == 2)
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
			sprint(self, PRINT_HIGH, s_fullrole);
		}
		if(imp == 3)
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
			sprint(self, PRINT_HIGH, s_fullrole);
		}
		if(imp == 4)
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
			sprint(self, PRINT_HIGH, s_fullrole);
		}
		if(imp == 5)
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
			sprint(self, PRINT_HIGH, s_fullrole);
		}

	}
};


string MenuString(float menuType)
{
	local string returnstring;
	local float desLength = 35;
	local string s_selectrole 	= "select class";
	local string s_endline		= "\n";
	//local string s_endline10	="\n\n\n\n\n\n\n\n\n\n";
	//local string s_endline120	="\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
	local string s_space		= " ";
	
	local string line1, line2, line3, line4, line5, line6, line7, line8;

	
	if (menuType == MENU_SELECTTEAM)
	{

		local float currblue = GetTeamCountCurrent(TEAM_BLUE);
		local float currred = GetTeamCountCurrent(TEAM_RED);
		
		local string s_selectteam 	= "select team";
		local string s_blueteam		= "\s[1]\s blue";
		local string s_redteam		= "\s[2]\s red";
		local string s_autoteam		= "\s[5]\s auto-assign";
		local string s_bluecount 	= TeamCountToString(currblue);
		local string s_redcount		= TeamCountToString(currred);

		line1		= strcat(s_selectteam,s_endline);
		line2		= strcat(s_endline,s_endline);
		line3 		= strcat(s_blueteam,GenSpace((strlen(s_blueteam)+strlen(s_bluecount)), desLength), s_bluecount, s_endline);
		line4		= strcat(s_redteam,	GenSpace((strlen(s_redteam)+strlen(s_redcount)), desLength), s_redcount, s_endline);
		line5		= strcat(s_endline,s_endline);
		if(self.owner.team_no == 0)
		{
			line6 		= strcat(s_autoteam,GenSpace(strlen(s_autoteam), desLength), s_endline);
		}
		else
		{
			line6		= s_endline;
		}
		line7 		= s_endline;
		line8 		= s_endline;

		returnstring = strcat(line1, line2, line3,line4,line5,line6,line7,line8);
		return returnstring;
	}
	if (menuType == MENU_NONE)
	{
		returnstring = " \n";
		return returnstring;
	}
	

	
	if(menuType == MENU_SELECTROLE)
	{
		
		local float currrecon		= GetRoleCount(ROLE_RECON, self.owner.team_no);
		local float currassassin	= GetRoleCount(ROLE_ASSASSIN, self.owner.team_no);
		local float currfighter		= GetRoleCount(ROLE_FIGHTER, self.owner.team_no);	
		local float currbomber		= GetRoleCount(ROLE_BOMBER, self.owner.team_no);	
		local float currsupport		= GetRoleCount(ROLE_SUPPORT, self.owner.team_no);
		local float maxrecon		= role_recon_max;
		local float maxassassin		= role_assassin_max;
		local float maxfighter 		= role_fighter_max;
		local float maxbomber 		= role_bomber_max;
		local float maxsupport		= role_support_max;	


		local string s_recon		= "\s[1]\s recon";
		local string s_assassin		= "\s[2]\s assassin";
		local string s_fighter		= "\s[3]\s fighter";
		local string s_bomber		= "\s[4]\s bomber";
		local string s_support		= "\s[5]\s support";
		
		local string s_reconcount	= RoleCountToString(currrecon, maxrecon);
		local string s_assassincount	= RoleCountToString(currassassin, maxassassin);
		local string s_fightercount	= RoleCountToString(currfighter, maxfighter);
		local string s_bombercount	= RoleCountToString(currbomber, maxbomber);
		local string s_supportcount	= RoleCountToString(currsupport, maxsupport);
		
		line1		= strcat(s_selectrole, s_endline);
		line2		= strcat(s_endline,s_endline);
		line3		= strcat(s_recon,	GenSpace((strlen(s_recon)+strlen(s_reconcount)), 	desLength), 	s_reconcount, 		s_endline);
		line4		= strcat(s_assassin,	GenSpace((strlen(s_assassin)+strlen(s_assassincount)),	desLength), 	s_assassincount, 	s_endline);
		line5		= strcat(s_fighter,	GenSpace((strlen(s_fighter)+strlen(s_fightercount)),	desLength), 	s_fightercount, 	s_endline);
		line6		= strcat(s_bomber,	GenSpace((strlen(s_bomber)+strlen(s_bombercount)),	desLength), 	s_bombercount, 		s_endline);
		line7 		= strcat(s_support,	GenSpace((strlen(s_support)+strlen(s_supportcount)),	desLength), 	s_supportcount, 	s_endline);
		line8 		= s_endline;
		
		returnstring = strcat(line1, line2, line3,line4,line5,line6,line7,line8);
		return returnstring;
	}
	
	return "";

};




void ShowMenu (float menuType) =
{	
	self.impulse = 0;
	if (menuType == MENU_NONE)				//if there already is a menu entity changing this should kill itself on next menuthink
	{
		self.menu = MENU_NONE;
		return;
	}
		
	local entity menuent = find (world, classname, "menu");	//look for existing menuent
	while (menuent) 
	{
		if (menuent.owner == self) 
		{
			self.menu = menuType;
			return;
		}
		menuent = find (menuent, classname, "menu");
	}
	
	
	local entity te;					//create a menu ent
	te = spawn();			
	te.classname = "menu";
	te.owner = self;
	te.think = MenuThink;
	te.nextthink = time + 0.1;
	
	
	self.menu = menuType;

};

string TeamCountToString(float current) =
{
	
	local string s_current = ftos(current);	
	if (strlen(s_current) == 1)
	{
		s_current = strcat("0",s_current);
	}
	
	local string s_players = " players";
	if(current == 1)
	{
		s_players =" player ";
	}

	return strcat(s_current,s_players);		
};

string RoleCountToString(float current, float maximum) =
{
	local string s_prefix	= "";
	local string s_divider	= " / ";
	local string s_divider2 = "maximum";
	local string s_suffix	= "";
	
	if (current >= maximum)
	{
		return strcat(s_prefix,s_divider2,s_suffix);
	}
	
	local string s_current = ftos(current);
	local string s_maximum = ftos(maximum);
	
	if (strlen(s_current) == 1)
	{
		s_current = strcat("0",s_current);
	}
	
	if(strlen(s_maximum) == 1)
	{
		s_maximum = strcat("0",s_maximum);
	}
	return strcat(s_prefix,s_current,s_divider,s_maximum,s_suffix);	
};

float MyRNG (float x) =
{
	//x is n of choices, doesnt return 0
	local float rnd;
	rnd = rint((random() * x) + 0.5);
	return rnd;
	
};
void RNGTest () =
{
	local float i = 100;
	local float n0 = 0;
	local float n1 = 0;
	local float n2 = 0;
	while(i > 0)
	{
		i = i - 1;
		local float res = MyRNG(2);
		if(res == 1)
			n1 = n1 + 1;
		else if(res == 2)
			n2 = n2 + 1;
		else
			n0 = n0 + 1;
		 
	}
	bprint(2,strcat("n0: ",ftos(n0)," n1: ",ftos(n1), " n2: ", ftos(n2), "\n"));
};

float AutoPickTeam()
{
	local float bcount = GetTeamCountCurrent(TEAM_BLUE);
	local float rcount = GetTeamCountCurrent(TEAM_RED);
	
	if(bcount == rcount)
	{
		local float rng = MyRNG(2);
		return rng;
	}
	if(bcount > rcount)
	{
		return TEAM_RED;
	}
	else
	{
		return TEAM_BLUE;
	}
	
};

void JoinTeam(float t) =
{
	self.impulse = 0;
	
	if(t == self.team_no)
	{
		sprint(self, PRINT_HIGH, "you are already on that team.\n");
		stuffcmd(self, "play beta1/error.wav\n");
		return;
		
	}
	if(self.deadflag == DEAD_NO)
		ClientKill();
		
	if(t == TEAM_BLUE)
	{
		self.team_no = TEAM_BLUE;
		bprint(2, strcat(self.netname, " has joined the \sblue\s team.\n"));
		self.role = ROLE_NONE;
		self.nextrole = ROLE_NONE;
		SetTeamFragsColourName();
		ShowMenu(MENU_SELECTROLE);
		return;
		
	}
	if (t == TEAM_RED)
	{
		self.team_no = TEAM_RED;
		bprint(2, strcat(self.netname, " has joined the \sred\s team.\n"));
		self.role = ROLE_NONE;
		self.nextrole = ROLE_NONE;
		SetTeamFragsColourName();
		ShowMenu(MENU_SELECTROLE);
		return;
	}
};
