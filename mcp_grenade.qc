

void ThrownGrenade_Think() = {
	self.nextthink = time;
	self.owner.ammo_rockets = floor(time - self.bubble_count);
	if(time >= self.bubble_count)
	{
		self.owner.gren = world;

		if(self.role == ROLE_ASSASSIN)
		{
			self.think = ExplodeFlashGrenade;
		}
		else if(self.role == ROLE_FIGHTER)
		{
			self.think = ExplodeFragGrenade;
		}
		else if(self.role == ROLE_SUPPORT)
		{
			self.think = ExplodeLeechGrenade;
		}
		else if(self.role == ROLE_BOMBER)
		{
			//self.think = ExplodeBearTrap;
			self.think = ExplodeMarkerGrenade;
		}
		else if(self.role == ROLE_RECON)
		{
			self.think = ExplodeShatterGrenade;
		}
		else if(self.role == ROLE_MGUNNER)
		{
			//self.think = ExplodeFragGrenade;
			self.think = ExplodePushupGrenade;
		}
		else
		{
			bprint(2,"somethingswronnnng\n");
		}
	}
};

void PrimeGrenade_Think() = {
	self.nextthink = time;
	self.owner.ammo_rockets = floor(time - self.bubble_count);
	if(time >= self.bubble_count)
	{
		StickyGrenade();
		self.owner.gren = world;
		remove(self);

	}
};

void ThrownGrenade_Touch() = {
	
	FO_Sound(self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';

};

void ThrowGrenade() = {
	self.impulse = 0;

	if(self.gren.classname == "throwngrenade")
		return;
	if(self.gren == world)
		return;

	newmis = spawn();
	newmis.movetype = MOVETYPE_BOUNCE;
	newmis.classname = "throwngrenade";
	newmis.solid = SOLID_BBOX;
	newmis.owner = self;
	newmis.role = self.role;
	newmis.team_no = self.team_no;
	newmis.bubble_count = self.gren.bubble_count;
	newmis.nextthink = time;
	newmis.think = ThrownGrenade_Think;
	newmis.touch = ThrownGrenade_Touch;
	setorigin(newmis, self.origin);
	setsize(newmis,'0 0 0', '0 0 0');
	
	self.gren.think = SUB_Null;
	self.gren.nextthink = time;
	self.gren = newmis;
    
	if (self.v_angle_x) 
	{
		newmis.velocity = v_forward * 600 + v_up * 200 + crandom() * v_right * 10 + crandom() * v_up * 10;
	}
	else 
	{
		newmis.velocity = aim(self, 10000);
		newmis.velocity = newmis.velocity * 600;
		newmis.velocity_z = 200;
	}
	newmis.angles = vectoangles(newmis.velocity);
	
	if(self.role == ROLE_RECON)
	{
		newmis.avelocity = '300 300 300';
		FO_SetModel(newmis, "progs/beta1/mcp_gren_airblast.mdl", DIM_WORLD);
		if(self.team_no == TEAM_BLUE)
		newmis.skin = 1;
		else
		newmis.skin = 2;		
	}
	if(self.role == ROLE_ASSASSIN)
	{

		newmis.avelocity = '300 300 300';
		FO_SetModel(newmis, "progs/beta1/mcp_gren_flash.mdl", DIM_WORLD);
		if(self.team_no == TEAM_BLUE)
		newmis.skin = 1;
		else
		newmis.skin = 2;	
	}
	if(self.role == ROLE_FIGHTER)
	{
		newmis.avelocity = '300 300 300';
		FO_SetModel(newmis, "progs/beta1/mcp_gren_frag.mdl", DIM_WORLD);
		if(self.team_no == TEAM_BLUE)
		newmis.skin = 1;
		else
		newmis.skin = 2;	
	}
	if(self.role == ROLE_BOMBER)
	{

		newmis.avelocity = '300 300 300';
		FO_SetModel(newmis, "progs/beta1/mcp_gren_frag.mdl", DIM_WORLD);
		
		//newmis.avelocity = '0 300 0';
		//newmis.angles = '0 0 0';
		//FO_SetModel(newmis, "progs/beta1/mcp_gren_beartrap_shut.mdl");
		if(self.team_no == TEAM_BLUE)
		newmis.skin = 1;
		else
		newmis.skin = 2;
	}
	if(self.role == ROLE_SUPPORT)
	{
		newmis.avelocity = '300 300 300';
		FO_SetModel(newmis, "progs/beta1/mcp_gren_leech.mdl", DIM_WORLD);
		if(self.team_no == TEAM_BLUE)
		newmis.skin = 1;
		else
		newmis.skin = 2;
	}
	if(self.role == ROLE_MGUNNER)
	{
		newmis.avelocity = '0 0 300';
		FO_SetModel(newmis, "progs/beta1/mcp_gren_frag.mdl", DIM_WORLD);
		if(self.team_no == TEAM_BLUE)
		newmis.skin = 1;
		else
		newmis.skin = 2;	
	}
};



/*void DestroyBearTrap() =
{
	FO_Sound(self, CHAN_WEAPON, "beta1/beartrap_break.wav", 1, ATTN_NORM);
	local	entity gib1 = spawn();
	gib1.origin = self.origin;
	FO_SetModel(gib1, "progs/beta1/mcp_gren_beartrap_shut.mdl", DIM_WORLD);
	setsize (gib1, '0 0 0', '0 0 0');
	if(self.owner.team_no == TEAM_BLUE)
		gib1.skin = 1;
	else
		gib1.skin = 2;
	gib1.velocity = VelocityForDamage (150);
	gib1.movetype = MOVETYPE_BOUNCE;
	gib1.solid = SOLID_NOT;
	gib1.avelocity_x = random()*600;
	gib1.avelocity_y = random()*600;
	gib1.avelocity_z = random()*600;
	gib1.think = SUB_Remove;
	gib1.nextthink = time + 2;

	
	remove(self);
};*/

void ExplodePushupGrenade() =
{
	local entity head = findradius(self.origin, PUSHUPGREN_RADIUS + 40);
	local float points;
	local float enemyhit = 0;
	while (head)
	{
		if (head.takedamage && head.classname == "player")
		{
			if(head.team_no != self.owner.team_no)
			{
				enemyhit = 1;
				HitSound(head, self, self.owner, 0);
			}
			points = vlen (self.origin - head.origin);
			points = PUSHUPGREN_RADIUS - points;
			if (points > PUSHUPGREN_RADIUS)
				points = PUSHUPGREN_RADIUS;
			points = points / PUSHUPGREN_RADIUS;

			if (points > 0)
			{
				local float z = PUSHUPGREN_MAXPLAYERPUSH * points;
				
				
				if(z < PUSHUPGREN_MINPLAYERPUSH)
					z = PUSHUPGREN_MINPLAYERPUSH;
				head.velocity_z = z;
				
				local float xy = 1 - points;
				head.velocity_x = head.velocity_x * xy;
				head.velocity_y = head.velocity_y * xy;
			}
		}
		head = head.chain;
	}
	if(enemyhit)
	{
		AddStat(self.owner, STAT_GRENHIT, ROLE_MGUNNER);

	}
	WriteByte(MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte(MSG_MULTICAST, TE_TAREXPLOSION);
	WriteCoord(MSG_MULTICAST, self.origin_x);
	WriteCoord(MSG_MULTICAST, self.origin_y);
	WriteCoord(MSG_MULTICAST, self.origin_z);
	multicast(self.origin, MULTICAST_PHS);

	remove(self);
};

void () ExplodeFragGrenade = {

	MCP_RadiusDamage(self, self.owner, 180, world,"grenade_frag", 1);

    WriteByte(MSG_MULTICAST, SVC_TEMPENTITY);
    WriteByte(MSG_MULTICAST, TE_EXPLOSION);
    WriteCoord(MSG_MULTICAST, self.origin_x);
    WriteCoord(MSG_MULTICAST, self.origin_y);
    WriteCoord(MSG_MULTICAST, self.origin_z);

    multicast(self.origin, MULTICAST_PHS);
    remove(self);
};

void marker_think() =
{
	if(time > self.bubble_count)
	{
		sprint(self.owner, PRINT_HIGH, "you are no longer marked.\n");
		remove(self);
		return;
	}
	if(self.model == "" && self.gren.pdim != 0)
	{
		FO_SetModel(self,"progs/beta1/mcp_pingt1.spr", self.gren.pdim);
		self.frame = 5;
	}
	setorigin(self, self.owner.origin + '0 0 48');
	self.nextthink = time + 0.05;
};

void MarkPlayer(entity targ, entity attacker) =
{
	local entity found;
	local entity te = find(world, classname, "marker");
	while (te) 
	{
		if (te != world) 
		{
			if(te.owner == targ && te.gren == attacker)
				found = te;
		}
		te = find(te, classname, "marker");
	}	
	if(found != world)
	{
		found.bubble_count = time + 5;
		return;
	}
	
	local entity mark = spawn();
	mark.classname = "marker";
	mark.bubble_count = time + 5;
	mark.think = marker_think;
	mark.nextthink = time;
	mark.owner = targ;
	mark.gren = attacker;
	sprint(targ, PRINT_HIGH, "you are marked.\n");
};

void () ExplodeMarkerGrenade = 
{
	
	local entity head = findradius(self.origin, 180+40);
	local float foundone = 0;
	
	while (head)
	{
		if (head != world)
		{
			if (head.takedamage && CanDamage(head,self))
			{
				
				if(head.classname == "player" && head.team_no != self.owner.team_no)
				{
					MarkPlayer(head, self.owner);
					
					
					foundone = foundone + 1;
				}
				local vector org = head.origin + (head.mins + head.maxs)*0.5;
				local float points = 0.5*vlen (self.origin - org);
				if (points < 0)
					points = 0;
				points = (100 - points) / 2;
				
				if (head == self.owner)
					points = points * 0.75;
				if (points > 0)
				{
					if (CanDamage (head, self))
					{
						head.deathtype = "grenade_marker";
						T_Damage (head, self, self.owner, points);
					}
				}
			}
		}
		head = head.chain;
	}
    if(foundone > 0)
    {
	FO_Sound(self, CHAN_WEAPON, "beta1/markplayer.wav", 1, ATTN_NORM);
	AddStat(self.owner, STAT_GRENHIT, ROLE_BOMBER);
    }
    
    WriteByte(MSG_MULTICAST, SVC_TEMPENTITY);
    WriteByte(MSG_MULTICAST, TE_EXPLOSION);
    WriteCoord(MSG_MULTICAST, self.origin_x);
    WriteCoord(MSG_MULTICAST, self.origin_y);
    WriteCoord(MSG_MULTICAST, self.origin_z);

    multicast(self.origin, MULTICAST_PHS);
    remove(self);
};

void () ExplodeLeechGrenade = {


	MCP_RadiusDamage(self, self.owner, 180, world,"grenade_leech", 1);
		
 

    
    WriteByte(MSG_MULTICAST, SVC_TEMPENTITY);
    WriteByte(MSG_MULTICAST, TE_TAREXPLOSION);
    WriteCoord(MSG_MULTICAST, self.origin_x);
    WriteCoord(MSG_MULTICAST, self.origin_y);
    WriteCoord(MSG_MULTICAST, self.origin_z);
    multicast(self.origin, MULTICAST_PHS);

    remove(self);
};

void StuffFlash(entity te, float amt)
{	

    local string st = strcat(ftos(amt)," ",ftos(amt));
    //string cmd = strcat("v_cshift ", st, " ", st);
    //cmd = strcat(cmd, " ", st, " ", "100", "\n");
    local string cmd = strcat("v_cshift ",st ," 0 100\n");
    stuffcmd(te, cmd);
}

float CalcFlash(entity te) =
{
	float timeleft = te.FlashTime;
    //float flashAmtMax = 240;
    //float flashAmtMin = 100;
    //float flashAmtMaxMult = stof(infokey(te, "maxflash"));
    //float flashAmtMinMult = stof(infokey(te, "minflash"));
    float flashAmt= 100;
    
    
    //flashAmt = (flashAmtMaxMult > 0) ? flashAmtMax * flashAmtMaxMult : flashAmtMax;
    //flashAmtMin = (flashAmtMinMult > 0) ? flashAmtMin * flashAmtMinMult : flashAmtMin;
    
    float perc = timeleft / FLASH_DURATION;

    flashAmt = flashAmt * perc;
    if(flashAmt < 30)
	flashAmt = 30;
    //flashAmt = flashAmt < flashAmtMin ? flashAmtMin : flashAmt;
    return flashAmt;
	//return 100;
};

void mcpflash_think() =
{
    local entity te;

    te = self.owner;
    te.FlashTime = te.FlashTime - .1;
    if (te.FlashTime <= 0) {
        sprint(te, PRINT_HIGH, "Flash has worn off\n");
        stuffcmd(te, "v_cshift; wait; bf\n");
        remove(self);
        self = te;
        ResetVisDimensions(self);
        return;
    }

    float flashamount = CalcFlash(te);
    StuffFlash(te, flashamount);

    self.nextthink = time + .1;
	
};

void ExplodeFlashGrenade() =
{

	self.effects = self.effects | EF_BRIGHTLIGHT;
	WriteByte(MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte(MSG_MULTICAST, TE_TAREXPLOSION);
	WriteCoord(MSG_MULTICAST, self.origin_x);
	WriteCoord(MSG_MULTICAST, self.origin_y);
	WriteCoord(MSG_MULTICAST, self.origin_z);
	multicast(self.origin, MULTICAST_PHS);
	local float enemyhit = 0;
	local float rad = 300;
	local entity te = findradius(self.origin, rad);
	while (te) 
	{
		if (te.classname == "player" && te.deadflag == DEAD_NO) 
		{
			if(te.team_no != self.owner.team_no && te.deadflag == DEAD_NO)
			{
				traceline(self.origin, te.origin, 1, self);
				if (trace_fraction == 1) {
					
					local vector org = te.origin + (te.mins + te.maxs) * 0.5;
					local float frac = (rad - vlen(self.origin - org)) / rad;
					
					
					sprint(te, PRINT_HIGH, "you have been flashed!\n");
					
					stuffcmd(te, "play beta1/grenade_flash.wav\n");
					stuffcmd(te, "bf\n");
					te.deathtype = "grenade_flash";
					enemyhit = 1;
					
					T_Damage (te, self, self.owner, 20);
					
	
					
					local entity ft;
					local float found = 0;
					ft = find(world, classname, "mcpflashtimer");	
					while (ft) 
					{
						if (te != world && ft.owner == te ) 
						{
							found = found + 1;
							//ft.bubble_count = time + ftime;
							ft.nextthink = time + .1;
							
						}
						ft = find(ft, classname, "mcpflashtimer");
					}
					if(found == 0)
					{
						
						newmis = spawn();
						newmis.classname = "mcpflashtimer";

						newmis.owner = te;
						newmis.think = mcpflash_think;
						newmis.nextthink = time;
						//newmis.bubble_count = time + ftime;
						
					}
					
					//float flashamount = CalcFlash(te);
					local float ftime = FLASH_DURATION;
					ftime = ftime * (frac + frac * 0.5);
					te.FlashTime = ftime;
					local float flashamount = CalcFlash(te);
					StuffFlash(te, flashamount);
					te.dimension_see = 0;
				}
			}
			
		}
		te = te.chain;
	}
	if(enemyhit)
		AddStat(self.owner, STAT_GRENHIT, ROLE_ASSASSIN);
	remove(self);
};


void () StickyGrenade = {
    local entity newmis2;	//was te?

    //KickPlayer(-2, self.owner);
	newmis2 = spawn();
	newmis2.movetype = MOVETYPE_BOUNCE;
	newmis2.solid = SOLID_BBOX;
	newmis2.owner = self.owner;
	newmis2.velocity = '0 0 0';
	newmis2.angles = vectoangles(newmis.velocity);
	newmis2.think = SUB_Null;
	newmis2.nextthink = time + 0.1;

	if(self.role == ROLE_RECON)
	{
		bprint(PRINT_MEDIUM, strcat("No ", self.owner.netname,", swallowing the grenade isn't very effective!\n"));
		newmis2.think = ExplodeShatterGrenade;
	}
	
	if(self.role == ROLE_ASSASSIN)
	{
		bprint(PRINT_MEDIUM, strcat("Well ", self.owner.netname,", don't quit your day job!\n"));
		newmis2.think = ExplodeFlashGrenade;
	}
	
	if(self.role == ROLE_FIGHTER)
	{
		bprint(PRINT_MEDIUM, strcat("Ummm, ", self.owner.netname,", you're supposed to THROW the grenade!\n"));	
	

		newmis2.think = ExplodeFragGrenade;
		newmis2.avelocity = '300 300 300';

	}
	if(self.role == ROLE_BOMBER)
	{
		//bprint(PRINT_MEDIUM, strcat("Ack! ", self.owner.netname,"! you're meant to trap the enemy!\n"));	
		//newmis.think = ExplodeBearTrap;
		//newmis.angles = '0 0 0';
		//newmis.avelocity = '0 300 0';
		//FO_SetModel(newmis, "progs/beta1/mcp_gren_beartrap_shut.mdl");
		
		bprint(PRINT_MEDIUM, strcat("Ummm, ", self.owner.netname,", it's best if you mark the enemy!\n"));	
		newmis2.think = ExplodeMarkerGrenade;
		newmis2.avelocity = '300 300 300';
		
		if(self.owner.team_no == TEAM_BLUE)
		newmis2.skin = 1;
		else
		newmis2.skin = 2;
	}
	
	if(self.role == ROLE_SUPPORT)
	{
		bprint(PRINT_MEDIUM, strcat("Yes ", self.owner.netname,", eating leeches is bad!\n"));
		newmis2.think = ExplodeLeechGrenade;
		newmis2.avelocity = '300 300 300';
		
	}
	if(self.role == ROLE_MGUNNER)
	{
		bprint(PRINT_MEDIUM, strcat("It seems, ", self.owner.netname,", needs to learn how to count!\n"));	
	

		newmis2.think = ExplodePushupGrenade;
		newmis2.avelocity = '0 0 300';

	}
    
	setsize(newmis2, '0 0 0', '0 0 0');
	setorigin(newmis2, self.owner.origin);
   
	remove(self);
};

void (entity inflictor, entity attacker, float bounce, entity ignore) T_RadiusBounce = 
{
		local float points;
		local entity head;
		local entity te;
		local vector org;

		head = findradius(inflictor.origin, bounce + 40);
		while (head) 
		{
			if (head != ignore) 
			{
				if (head.takedamage) 
				{
					org = head.origin + (head.mins + head.maxs) * 0.5;
					points = 0.5 * vlen(org - inflictor.origin);
					if (points < 0)
					{
						points = 0;	
					}
					points = bounce - points;
					if (points > 0) 
					{
						head.velocity = org - inflictor.origin;
						head.velocity = head.velocity * (points / 20);

					}
					//HitSound(head, inflictor, attacker, 0);
				}
		}
		head = head.chain;
	}
};

void ExplodeShatterGrenade() = 
{
	T_RadiusBounce(self, self.owner, 240, world);
	
	local float hitenemy = 0;
	local   float   points;
	local   entity  head;
	local   vector  org;
	head = findradius(self.origin, 240);
	local float leech;
	local float SHATTER_MAXDAMAGE = 100;
	while (head)
	{
		if (head.classname == "player" && head.team_no != self.owner.team_no && head.deadflag == DEAD_NO)
		{
			hitenemy = 1;
			if (head.takedamage)
			{
				
				org = head.origin + (head.mins + head.maxs)*0.5;
				points = 0.5*vlen (self.origin - org);
				if (points < 0)
					points = 0;
				points = SHATTER_MAXDAMAGE - points;

				head.deathtype = "grenade_shatter";
				T_Damage (head, self, self.owner, points);
				
			}
		}
		head = head.chain;
	}
	if(hitenemy)
	{
		AddStat(self.owner, STAT_GRENHIT, ROLE_RECON);
	}

	WriteByte(MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte(MSG_MULTICAST, TE_EXPLOSION);
	WriteCoord(MSG_MULTICAST, self.origin_x);
	WriteCoord(MSG_MULTICAST, self.origin_y);
	WriteCoord(MSG_MULTICAST, self.origin_z);

	multicast(self.origin, MULTICAST_PHS);
	remove(self);
};



void PlayGrenTimerSound () = {
	
	local string grentimer = infokey(self.owner, "grentimer");
	if(grentimer == "0")
		return;
	if(grentimer == "off")
		return;
	if(grentimer == "")
		grentimer = "1";
	stuffcmd(self.owner, strcat("play beta1/mcp_grentimer",grentimer,"\n"));
	remove(self);
};


void PrimeGrenade() = {

	self.impulse = 0;
	//if (self.ispriming == 1)
	//	return;
	if(self.gren != world)
		return;
	if(self.team_no == TEAM_NONE)
		return;
	if(self.role == ROLE_NONE)
		return;
		
	if(self.grencount <= 0)
	{
		stuffcmd(self, "play beta1/error.wav\n");
		sprint(self, PRINT_HIGH, "no grenades left.\n");
		return;
	}
	
	
	//local entity grentimer = spawn();
	AddStat(self, STAT_GRENPRIMED, self.role);
	self.gren = spawn();
        self.gren.nextthink = time;
        self.gren.think = PrimeGrenade_Think;
	self.gren.owner = self;
	self.gren.role = self.role;
	self.gren.classname = "grentimer";
	self.gren.bubble_count = time + 3.8;

	
	self.grencount = self.grencount - 1;
	self.ammo_nails = self.ammo_nails - 1;
	
	local float offset = stof(infokey(self,"grentimerdelay"));
	
	
	local entity grentimersound = spawn();
	grentimersound.owner = self;
	grentimersound.think = PlayGrenTimerSound;
	grentimersound.nextthink = time + offset;
	
	if(self.role == ROLE_RECON)
	{
		sprint(self, PRINT_HIGH, "priming shatter grenade...\n");	
	}
	if(self.role == ROLE_ASSASSIN)
	{
		sprint(self, PRINT_HIGH, "priming flash grenade...\n");		
	}
	if(self.role == ROLE_FIGHTER)
	{	
		sprint(self, PRINT_HIGH, "priming frag grenade...\n");		
	}
	if(self.role == ROLE_BOMBER)
	{
		//sprint(self, PRINT_HIGH, "priming beartrap grenade...\n");	
		sprint(self, PRINT_HIGH, "priming marker grenade...\n");		
	}
	if(self.role == ROLE_SUPPORT)
	{
		sprint(self, PRINT_HIGH, "priming leech grenade...\n");		
	}
	if(self.role == ROLE_MGUNNER)
	{
		sprint(self, PRINT_HIGH, "priming pushup grenade...\n");		
	}

};


/*void DisarmLittleProxy() =
{	
	T_RadiusDamage(self, self.owner, 10, world,"grenade_littleproxy");
	WriteByte(MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte(MSG_MULTICAST, TE_EXPLOSION);
	WriteCoord(MSG_MULTICAST, self.origin_x);
	WriteCoord(MSG_MULTICAST, self.origin_y);
	WriteCoord(MSG_MULTICAST, self.origin_z);

	multicast(self.origin, MULTICAST_PHS);
	remove(self);
};*/

/*
void ExplodeLittleProxy() =
{	
	T_RadiusDamage(self, self.owner, 150, world,"grenade_littleproxy");

	WriteByte(MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte(MSG_MULTICAST, TE_EXPLOSION);
	WriteCoord(MSG_MULTICAST, self.origin_x);
	WriteCoord(MSG_MULTICAST, self.origin_y);
	WriteCoord(MSG_MULTICAST, self.origin_z);

	multicast(self.origin, MULTICAST_PHS);
	remove(self);
};
*/


/*
void LittleProxy_Touch() = 
{
	if(other.classname != "player")
		return;
	if(other.team_no == self.team_no)
		return;

	FO_Sound(self, CHAN_WEAPON, "beta1/grenade_littleproxy.wav", 1, ATTN_NORM);
	self.nextthink = time + 0.1;
	self.think = ExplodeLittleProxy;
	self.touch = SUB_Null;
	
};
*/

/*
void LittleProxy_Think() = {
    self.nextthink = time + 0.2;
    if (self.velocity == '0 0 0') {
        if (self.flags & FL_ONGROUND) {
            self.nextthink = time + 999;
            self.solid = SOLID_TRIGGER;
            self.movetype = MOVETYPE_TOSS;
            self.touch = LittleProxy_Touch;
            self.angles = '0 0 0';
            //FO_Sound(self, CHAN_AUTO, "weapons/tink1.wav", 1, ATTN_NORM);
            setorigin(self, self.origin);
            
            if(self.owner.team_no == TEAM_BLUE)
		self.skin = 1;
		else
		self.skin = 2;
	
            return;
        } else {
            self.nextthink = time + 6;
            self.think = SUB_Remove;
            self.solid = SOLID_TRIGGER;
            self.movetype = MOVETYPE_TOSS;
            self.touch = LittleProxy_Touch;
            setorigin(self, self.origin);
            return;
        }
    }

    traceline(self.movedir, self.origin, 1, self);
    if (trace_fraction == 1) {
        self.movedir = self.origin;
        return;
    }
    self.velocity = self.velocity * -1;
};
*/
/*
void CheckBearTrapLimit() = 
{
	local entity oldest = world;
	local float btrapcount = 0;
	local float limit = 2;
    
	local entity te = find(world, classname, "beartrap");
	while (te) 
	{
		if (te.owner == self.owner) 
		{
			btrapcount = btrapcount + 1;
			if (oldest == world)
				oldest = te;
			if(oldest.nextthink > te.nextthink)
				oldest = te;
		}
		te = find(te, classname, "beartrap");
        }

	if (oldest == world)
		return;
		
	if (btrapcount > limit)
	{
		oldest.nextthink = time;
	}
};
*/
/*
void BearTrapShut_Touch() = {
	if(other.classname == "player")
		return;
		
	FO_Sound(self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);
};
*/
/*
void BearTrapOpen_Touch() = {
	if(other.classname != "player")
		return;
	if(other.team_no == self.owner.team_no)
		return;
	self.touch = BearTrapShut_Touch;
	self.velocity = self.velocity + '0 0 250';
	
	self.movetype = MOVETYPE_BOUNCE;
	FO_SetModel(self, "progs/beta1/mcp_gren_beartrap_shut.mdl", DIM_WORLD);
	FO_Sound(self, CHAN_ITEM, "beta1/beartrap_shut.wav", 1, ATTN_NORM);
	setsize(self, '0 0 0', '0 0 0');
	self.think = BearTrap_Think;
	self.nextthink = time + 3;
	other.deathtype = "beartrap";
	T_Damage(other, self, self.owner, 300);
};
*/
/*
void BearTrap_Think() = {
    self.nextthink = time + 0.05;

    if (self.velocity == '0 0 0') {
        if (self.flags & FL_ONGROUND) {
		self.classname = "beartrap";
        	self.nextthink = time + 999;
		CheckBearTrapLimit();
		if(self.cnt != 1)
			self.nextthink = time + 999;
		else
			self.nextthink = time;
		self.think = DestroyBearTrap;
		self.solid = SOLID_TRIGGER;
		self.movetype = MOVETYPE_TOSS;

		FO_SetModel(self, "progs/beta1/mcp_gren_beartrap_open.mdl", DIM_WORLD);
		FO_Sound(self, CHAN_WEAPON, "beta1/beartrap_open.wav", 1, ATTN_NORM);
		setsize(self, '-16 -16 0', '16 16 56');

            self.touch = BearTrapOpen_Touch;

            setorigin(self, self.origin);
            
            if(self.owner.team_no == TEAM_BLUE)
		self.skin = 1;
		else
		self.skin = 2;
	
            return;
        } else {
            self.nextthink = time + 6;
            self.think = SUB_Remove;
            self.solid = SOLID_TRIGGER;
            self.movetype = MOVETYPE_TOSS;
            //self.touch = BearTrap_Touch;
            setorigin(self, self.origin);
            return;
        }
    }

    //traceline(self.movedir, self.origin, 1, self);
    //if (trace_fraction == 1) {
     //   self.movedir = self.origin;
    //    return;
   // }
   // self.velocity = self.velocity * -1;
   
};*/

/*
void ExplodeBearTrap()=
{
	self.nextthink = time + 0.05;
	self.think = BearTrap_Think;
};
*/
/*
void ExplodeBigProxy() = 
{
	local entity te = find(world, classname, "littleproxy");
	while(te)
	{
		if(te.owner == self.owner && te != world)
		{
			FO_Sound(te, CHAN_WEAPON, "beta1/grenade_littleproxy.wav", 1, ATTN_NORM);
			te.nextthink = time + 0.2;
			te.think = ExplodeLittleProxy;
		}
		te = find(te,classname,"littleproxy");
	}
	
	T_RadiusDamage(self, self.owner, 64, world,"grenade_bigproxy");

	WriteByte(MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte(MSG_MULTICAST, TE_EXPLOSION);
	WriteCoord(MSG_MULTICAST, self.origin_x);
	WriteCoord(MSG_MULTICAST, self.origin_y);
	WriteCoord(MSG_MULTICAST, self.origin_z);

	multicast(self.origin, MULTICAST_PHS);
	local float num = 6;
	local entity e;

	if(self.cnt != 1)
	{
		while (num > 0) 
		{
			e = spawn();
			e.classname = "littleproxy";
			e.owner = self.owner;
			e.team_no = self.owner.team_no;
			FO_SetModel(e, "progs/beta1/mcp_gren_littleproxy.mdl", DIM_WORLD);
			e.mins = '-6 -6 -8';
			e.maxs = '6 6 4';
			e.angles = '0 0 0';
			e.angles_x = random() * 360;
			e.velocity_x = crandom() * 100;
			e.velocity_y = crandom() * 100;
			e.velocity_z = 200 + random() * 100;
			//e.avelocity_x = crandom() * 400;
			//e.avelocity_y = crandom() * 400;
			//e.avelocity_z = crandom() * 400;
			//e.avelocity = '0 300 0';
			setorigin(e, self.origin);
			e.movedir = e.origin;
			e.movetype = MOVETYPE_BOUNCE;
			e.solid = SOLID_NOT;
			e.nextthink = time + 0.2;
			e.think = LittleProxy_Think;
			e.touch = SUB_Null;
			e.skin = 0;
			num = num - 1;
		}
	}
	
	remove(self);
};
*/
