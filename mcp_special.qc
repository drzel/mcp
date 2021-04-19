
/*void DetStickys()=
{
	local float playsound = 0;
	local entity te = find(world, classname, "sticky_trap");
	while (te) 
	{
		if (te.owner == self && te != world) 
		{
			te.think = StickyTrapGroundExplode;
			te.nextthink = time;
			playsound = 1;
		}
		te = find(te, classname, "sticky_trap");
        }
        
        local entity te2 = find(world, classname, "sticky_direct");
	while (te2) 
	{
		if (te2.owner == self && te2 != world) 
		{
			te2.think = StickyTrapAirExplode;
			te2.nextthink = time;
			playsound = 1;
		}
		te2 = find(te2, classname, "sticky_direct");
		
        }
        
        if(playsound == 1)
		FO_Sound(self, CHAN_BODY, "beta1/detsticky.wav", 1, ATTN_NORM);
};*/

void Cloak_Think()=
{
	
	self.bubble_count = self.bubble_count + 1;
	if(self.bubble_count == 3)
		stuffcmd(self.owner, "play items/inv3.wav\n");
	if(self.bubble_count == 3)
		stuffcmd(self.owner, "play items/inv2.wav\n");
	

	if(self.bubble_count >= SPECIAL_DURATION_ASSASSIN)
	{
		self.owner.cloak_complete = 1;
		FO_SetModel(self.owner, FPATH_PLAYERMDL, DIM_WORLD);
		setsize (self.owner, VEC_HULL_MIN, VEC_HULL_MAX);
		FO_Sound(self.owner, CHAN_ITEM, "beta1/uncloak.wav", 1, ATTN_NORM);
		sprint(self.owner, PRINT_HIGH, "cloak removed.\n");
		
		WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
		WriteByte (MSG_MULTICAST, TE_TELEPORT);
		WriteCoord (MSG_MULTICAST, self.owner.origin_x);
		WriteCoord (MSG_MULTICAST, self.owner.origin_y);
		WriteCoord (MSG_MULTICAST, self.owner.origin_z);
		multicast (self.owner.origin, MULTICAST_PHS);
		remove(self);
	}
	else
	{
		self.nextthink = time + 1;
	}	
	
};

void Cloak() =
{
	if(self.iscloaked == 1)
	{
		stuffcmd(self, "play beta1/error.wav\n");
		sprint(self, PRINT_HIGH, "already cloaked!\n");
		return;
	}
	if(self.ammo_cells < 100)
	{
		stuffcmd(self, "play beta1/error.wav\n");
		sprint(self, PRINT_HIGH, "insufficient energy, 100 needed.\n");
		return;
	}
		
	self.ammo_cells = 0;
		
	self.cloak_complete = 0;
	self.iscloaked = 1;

		
	local entity te = spawn();			
	te.classname = "cloak";
	te.owner = self;
	te.think = Cloak_Think;
	te.nextthink = time + 1;
	te.bubble_count = 0;
	setmodel(self, string_null);
	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	sprint(self, PRINT_HIGH, "cloak enabled.\n");

	stuffcmd(self, "play items/inv3.wav\n");
	FO_Sound(self, CHAN_ITEM, "beta1/cloak.wav", 1, ATTN_NORM);
	
	WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte (MSG_MULTICAST, TE_TELEPORT);
	WriteCoord (MSG_MULTICAST, self.origin_x);
	WriteCoord (MSG_MULTICAST, self.origin_y);
	WriteCoord (MSG_MULTICAST, self.origin_z);
	multicast (self.origin, MULTICAST_PHS);
	
	ChangeWeaponModel(self.weapon);
	ChangeHudAmmo(self,self.weapon);
};

void teleball_touch() =
{
	if(other.classname != "worldspawn")
		return;
	if(time < self.cnt)
		return;
	self.cnt = time + 0.2;
	local float rng = MyRNG(2);
		
	if (rng == 1)
	{
		FO_Sound(self, CHAN_ITEM, "beta1/teleball_idle.wav", 1, ATTN_NORM);
	}
	else
	{
		FO_Sound(self, CHAN_ITEM, "beta1/teleball_idle2.wav", 1, ATTN_NORM);
	}
		
};

void TeleBall_Think() =
{
	self.bubble_count = self.bubble_count + 1;
	self.nextthink = time + 1;
	
	if(self.bubble_count == 1 || self.bubble_count == 3 || self.bubble_count == 6 || self.bubble_count == 9)
	{
		local float rng = MyRNG(2);
		if (rng == 1)
		{
			FO_Sound(self, CHAN_ITEM, "beta1/teleball_idle.wav", 1, ATTN_NORM);
		}
		else
		{
			FO_Sound(self, CHAN_ITEM, "beta1/teleball_idle2.wav", 1, ATTN_NORM);
		}
	}

	if(self.bubble_count >= TELEBALL_DURATION)
	{
		self.owner.ammo_cells = self.owner.ammo_cells + 50;
		sprint(self.owner, PRINT_HIGH, "teleport fizzled.\n");
		FO_Sound(self, CHAN_ITEM, "beta1/teleball_end.wav", 1, ATTN_NORM);
		if(self.owner.ammo_cells >= 100)
		{
			self.owner.ammo_cells = 100;
			stuffcmd(self, "play beta1/specialready_support.wav\n");
		}
		remove(self);
	}
};

void SpawnTeleBall() =
{
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_BOUNCEMISSILE;
	newmis.solid = SOLID_TRIGGER;
		
	// set newmis speed     
	makevectors (self.v_angle);
	newmis.velocity = aim(self, 1000);
	newmis.velocity = newmis.velocity * TELEBALL_SPEED; 
	newmis.angles = vectoangles(newmis.velocity);
	
	newmis.voided = 0;
	
	// set newmis duration
	newmis.nextthink = time + 0.1;
	newmis.think = TeleBall_Think;
	newmis.classname = "teleball";
	newmis.touch = teleball_touch;

	FO_SetModel (newmis, "progs/beta1/mcp_teleball.mdl", DIM_WORLD);
	if(self.team_no == TEAM_BLUE)
		newmis.skin = 1;
	if(self.team_no == TEAM_RED)
		newmis.skin = 2;

	//setsize (newmis, '-8 -8 -8', '8 8 8');
	setsize(newmis,'0 0 0', '0 0 0');
	setorigin (newmis, self.origin + '0 0 16');
	FO_Sound(newmis, CHAN_ITEM, "beta1/teleball_start.wav", 1, ATTN_NORM);
};

float CheckArea (entity obj, entity builder) = {
    local vector src;
    local vector end;
    local float pos;
    local entity te;

    pos = pointcontents(obj.origin);
    if ((pos == -2) || (pos == -6)) {
        return (0);
    }
    src_x = (obj.origin_x + obj.maxs_x) + 24;
    src_y = (obj.origin_y + obj.maxs_y) + 24;
    src_z = (obj.origin_z + obj.maxs_z) + 16;
    pos = pointcontents(src);
    if ((pos == -2) || (pos == -6)) {
        return (0);
    }
    end_x = (obj.origin_x + obj.mins_x) - 16;
    end_y = (obj.origin_y + obj.mins_y) - 16;
    end_z = (obj.origin_z + obj.mins_z) - 16;
    traceline(src, end, 1, obj);
    if (trace_fraction != 1) {
        return (0);
    }
    pos = pointcontents(end);
    if ((pos == -2) || (pos == -6)) {
        return (0);
    }
    src_x = (obj.origin_x + obj.mins_x) - 16;
    src_y = (obj.origin_y + obj.maxs_y) + 16;
    src_z = (obj.origin_z + obj.maxs_z) + 16;
    pos = pointcontents(src);
    if ((pos == -2) || (pos == -6)) {
        return (0);
    }
    end_x = (obj.origin_x + obj.maxs_x) + 16;
    end_y = (obj.origin_y + obj.mins_y) - 16;
    end_z = (obj.origin_z + obj.mins_z) - 16;
    traceline(src, end, 1, obj);
    if (trace_fraction != 1) {
        return (0);
    }
    pos = pointcontents(end);
    if ((pos == -2) || (pos == -6)) {
        return (0);
    }
    traceline(builder.origin, obj.origin, 1, builder);
    if (trace_fraction != 1) {
        return (0);
    }
    te = findradius(obj.origin, 64);
    if (te != world) {
        return (0);
    }
    return (1);
};

float IsTeleBlocked(entity tb) =
{

	
	//points looking down 
	// t1  t2  t3
	// t4  t5  t6
	// t7  t8  t9
	
	
	
	//VEC_HULL_MAX = '16 16 32';
	//VEC_HULL_MIN = '-16 -16 -24';

	
	local vector t1 = tb.origin + '16 16 32';
	local vector t2 = tb.origin + '0 16 32';
	local vector t3 = tb.origin + '16 16 32';
	
	local vector t4 = tb.origin + '-16 0 32';
	local vector t5 = tb.origin + '0 0 32';
	local vector t6 = tb.origin + '16 0 32';
	
	local vector t7 = tb.origin + '-16 -16 32';
	local vector t8 = tb.origin + '0 -16 32';
	local vector t9 = tb.origin + '16 -16 32';
	
	local vector b1 = tb.origin + '16 16 -24';
	local vector b2 = tb.origin + '0 16 -24';
	local vector b3 = tb.origin + '16 16 -24';
	
	local vector b4 = tb.origin + '-16 0 -24';
	local vector b5 = tb.origin + '0 0 -24';
	local vector b6 = tb.origin + '16 0 -24';
	
	local vector b7 = tb.origin + '-16 -16 -24';
	local vector b8 = tb.origin + '0 -16 -24';
	local vector b9 = tb.origin + '16 -16 -24';
	
	local float pct1 = pointcontents(t1);
	local float pct2 = pointcontents(t2);
	local float pct3 = pointcontents(t3);
	
	local float pct4 = pointcontents(t4);
	local float pct5 = pointcontents(t5);
	local float pct6 = pointcontents(t6);
	
	local float pct7 = pointcontents(t7);
	local float pct8 = pointcontents(t8);
	local float pct9 = pointcontents(t9);
	
	local float pcb1 = pointcontents(b1);
	local float pcb2 = pointcontents(b2);
	local float pcb3 = pointcontents(b3);
	
	local float pcb4 = pointcontents(b4);
	local float pcb5 = pointcontents(b5);
	local float pcb6 = pointcontents(b6);
	
	local float pcb7 = pointcontents(b7);
	local float pcb8 = pointcontents(b8);
	local float pcb9 = pointcontents(b9);
	
	/*
	bprint(2,strcat(ftos(pointcontents(t1)),"t1\n"));
	bprint(2,strcat(ftos(pointcontents(t2)),"t2\n"));
	bprint(2,strcat(ftos(pointcontents(t3)),"t3\n"));
	bprint(2,strcat(ftos(pointcontents(t4)),"t4\n"));
	bprint(2,strcat(ftos(pointcontents(t5)),"t5\n"));
	bprint(2,strcat(ftos(pointcontents(t6)),"t6\n"));
	
	bprint(2,strcat(ftos(pointcontents(b1)),"b1\n"));
	bprint(2,strcat(ftos(pointcontents(b2)),"b2\n"));
	bprint(2,strcat(ftos(pointcontents(b3)),"b3\n"));
	bprint(2,strcat(ftos(pointcontents(b4)),"b4\n"));
	bprint(2,strcat(ftos(pointcontents(b5)),"b5\n"));
	bprint(2,strcat(ftos(pointcontents(b6)),"b6\n"));
	*/
	
	if(pct1 == CONTENT_SOLID || pct1 == CONTENT_SKY)
		return 1;
	if(pct2 == CONTENT_SOLID || pct2 == CONTENT_SKY)
		return 1;
	if(pct3 == CONTENT_SOLID || pct3 == CONTENT_SKY)
		return 1;
		
	if(pct4 == CONTENT_SOLID || pct4 == CONTENT_SKY)
		return 1;
	if(pct5 == CONTENT_SOLID || pct5 == CONTENT_SKY)
		return 1;
	if(pct6 == CONTENT_SOLID || pct6 == CONTENT_SKY)
		return 1;
		
	if(pct7 == CONTENT_SOLID || pct7 == CONTENT_SKY)
		return 1;
	if(pct8 == CONTENT_SOLID || pct8 == CONTENT_SKY)
		return 1;
	if(pct9 == CONTENT_SOLID || pct9 == CONTENT_SKY)
		return 1;
		
	if(pcb1 == CONTENT_SOLID || pcb1 == CONTENT_SKY)
		return 1;
	if(pcb2 == CONTENT_SOLID || pcb2 == CONTENT_SKY)
		return 1;
	if(pcb3 == CONTENT_SOLID || pcb3 == CONTENT_SKY)
		return 1;
		
	if(pcb4 == CONTENT_SOLID || pcb4 == CONTENT_SKY)
		return 1;
	if(pcb5 == CONTENT_SOLID || pcb5 == CONTENT_SKY)
		return 1;
	if(pcb6 == CONTENT_SOLID || pcb6 == CONTENT_SKY)
		return 1;
		
	if(pcb7 == CONTENT_SOLID || pcb7 == CONTENT_SKY)
		return 1;
	if(pcb8 == CONTENT_SOLID || pcb8 == CONTENT_SKY)
		return 1;
	if(pcb9 == CONTENT_SOLID || pcb9 == CONTENT_SKY)
		return 1;

	
	traceline(t1,b1,0,tb);
	if(trace_fraction != 1 && !trace_ent.takedamage)
		return 1;
		
	traceline(t2,b2,0,tb);
	if(trace_fraction != 1 && !trace_ent.takedamage)
		return 1;
		
	traceline(t3,b3,0,tb);
	if(trace_fraction != 1 && !trace_ent.takedamage)
		return 1;
	
	traceline(t4,b4,0,tb);
	if(trace_fraction != 1 && !trace_ent.takedamage)
		return 1;
		
	traceline(t5,b5,0,tb);
	if(trace_fraction != 1 && !trace_ent.takedamage)
		return 1;
		
	traceline(t6,b6,0,tb);
	if(trace_fraction != 1 && !trace_ent.takedamage)
		return 1;
		
	traceline(t7,b7,0,tb);
	if(trace_fraction != 1 && !trace_ent.takedamage)
		return 1;
		
	traceline(t8,b8,0,tb);
	if(trace_fraction != 1 && !trace_ent.takedamage)
		return 1;
		
	traceline(t9,b9,0,tb);
	if(trace_fraction != 1 && !trace_ent.takedamage)
		return 1;

	return 0;

	
};

void Charge() =
{

	if(self.ammo_cells < 100)
	{
		stuffcmd(self, "play beta1/error.wav\n");
		sprint(self, PRINT_HIGH, "insufficient energy, 100 needed.\n");
		return;
	}
	self.ammo_cells = 0;
	FO_Sound(self, CHAN_ITEM, "beta1/charge.wav", 1, ATTN_NORM);
	
	//makevectors (self.v_angle);
        //self.velocity = v_forward * CHARGE_VELOCITY;

	//makevectors (self.v_angle);
	//newmis.velocity = v_forward;
	//newmis.velocity = newmis.velocity * ROCKET_SPEED; //1000
	
        makevectors (self.v_angle);
        local vector org = self.origin;
	local vector targ = (org + '0 0 96') + (v_forward * 600);
	local vector midpoint = ((targ + org) / 2) + '0 0 64';
	local vector dir = normalize(midpoint - org);
	self.velocity = dir * CHARGE_VELOCITY;
      
        /* FIEND
                makevectors(self.v_angle);
        self.velocity = aim(self, 1000);
        
        self.velocity_z = self.velocity_z * 1.2;
        self.velocity = self.velocity * 1000;
        self.angles = vectoangles(self.velocity);
        */
	
};
void Teleport2Ball () =
{
	local entity tb = world;
	local entity te = find(world, classname, "teleball");
	while (te) 
	{
		if (te.owner == self && te != world) 
		{
			tb = te;
		}
		te = find(te, classname, "teleball");
	}
	if(tb == world)
		return;

	

	//tracebox(tb.origin, VEC_HULL_MIN, VEC_HULL_MAX, tb.origin, FALSE, tb);

	//if (trace_fraction != 1)
	if(IsTeleBlocked(tb) == 1)
	{
		if (trace_ent.classname == "worldspawn")
		{
			sprint(self, PRINT_HIGH, "teleport obstructed.\n");
			stuffcmd(self, "play beta1/error.wav\n");
			return;
		}
	}

	
	spawn_tfog(self.origin);
	spawn_tfog(tb.origin + 32 * v_forward);
	spawn_tdeath (tb.origin, self);

	
	

	setorigin(self, tb.origin);
	remove(tb);
};

void TeleSkill() =
{
	if(self.role != ROLE_SUPPORT)
		return;
		
	local entity tb = world;
	local entity te = find(world, classname, "teleball");
	while (te) 
	{
		if (te.owner == self && te != world) 
		{
			tb = te;
		}
		te = find(te, classname, "teleball");
	}
	if (tb == world)
	{
		if (self.ammo_cells < 100)
		{
		sprint(self, PRINT_HIGH, "insufficient energy, 100 needed.\n");
		stuffcmd(self, "play beta1/error.wav\n");
		return;
		}
		self.ammo_cells = 0;
		SpawnTeleBall();
		return;
	}
	Teleport2Ball();
	
};

void RecDash() =
{
	if(self.role != ROLE_RECON)
		return;
	
	if (self.ammo_cells < 100)
		return;

        self.ammo_cells = self.ammo_cells - 100;
        makevectors(self.angles);
        self.velocity = v_forward * 540;
        self.velocity_z = 181;
        FO_Sound(self, CHAN_BODY, "beta1/dash.wav", 1, ATTN_NORM);
};



void ThrownArmour_Touch() =
{
	if(other.classname != "player")
	return;
	
	local float THROWNARMOUR_VALUE = 100;
	
	
	local float maxarm = 0;
	
	
	if(other.role == ROLE_RECON)
		maxarm = ARMOUR_MAX_RECON;
	if(other.role == ROLE_ASSASSIN)
		maxarm = ARMOUR_MAX_ASSASSIN;
	if(other.role == ROLE_FIGHTER)
		maxarm = ARMOUR_MAX_FIGHTER;
	if(other.role == ROLE_BOMBER)
		maxarm = ARMOUR_MAX_BOMBER;
	if(other.role == ROLE_SUPPORT)
		maxarm = ARMOUR_MAX_SUPPORT;
		
	if(other.armorvalue < maxarm)
	{
		
		other.armorvalue = other.armorvalue + THROWNARMOUR_VALUE;
		if(other.armorvalue > maxarm)
			other.armorvalue = maxarm;

		FO_Sound(other, CHAN_ITEM, "items/armor1.wav", 1, 1);
		remove(self);
	}
	
};

void ThrownArmour_Think() =
{
	self.touch = ThrownArmour_Touch;
	self.nextthink = time + 120;
	self.think = SUB_Remove;
};

void DropArmour() =
{

	if(self.armorvalue < 100)
	{
		sprint(self, PRINT_HIGH, "insufficient armour, 100 needed.\n");
		stuffcmd(self, "play beta1/error.wav\n");
		return;
	}
	
	self.armorvalue = self.armorvalue - 100;	
	newmis = spawn();
	newmis.movetype = MOVETYPE_TOSS;
	newmis.classname = "thrownarmour";
	newmis.solid = SOLID_TRIGGER;
	newmis.owner = self;

	newmis.team_no = self.team_no;

	newmis.nextthink = time + 1;
	newmis.think = ThrownArmour_Think;

	newmis.touch = SUB_Null;
	setorigin(newmis, self.origin);
	setsize(newmis, '-16 -16 0', '16 16 56');
	newmis.skin = 2;
	FO_SetModel(newmis, "progs/armor.mdl", DIM_WORLD);
	
    
	if (self.v_angle_x) 
	{
		newmis.velocity = v_forward * 300 + v_up * 200 + crandom() * v_right * 10 + crandom() * v_up * 10;
	}
	else 
	{
		newmis.velocity = aim(self, 10000);
		newmis.velocity = newmis.velocity * 300;
		newmis.velocity_z = 200;
	}
	newmis.angles = vectoangles(newmis.velocity);
};

void HarpoonTouch() =
{
	if (other == self.owner)
		return;

	if (other.solid == SOLID_TRIGGER)
		return; // trigger field, do nothing

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

// hit something that bleeds
	if (other.takedamage)
	{
		spawn_touchblood (18);
		other.deathtype = "harpoon";
		FO_Sound(self,CHAN_WEAPON, "beta1/harpoon_hitmeat.wav", 1, ATTN_NORM);
		SpawnMeatSpray(self.origin, '30 -30 10');
		SpawnMeatSpray(self.origin, '-30 30 10');
		SpawnMeatSpray(self.origin, '30 30 10');
		
		T_Damage (other, self, self.owner, HARPOON_DAMAGE);
		self.velocity = '0 0 0';
		self.touch = SUB_Null;
		self.think = SUB_Remove;
		
		if(other.classname == "player" && other.team_no != self.owner.team_no)
		{
			self.nextthink = time + 0.6;
			self.movetype = MOVETYPE_FOLLOW;
			self.aiment = other;
			self.ammo_cells = 0;
		}
		else
		{
			self.nextthink = time + 1;
			self.movetype = MOVETYPE_TOSS;
		}
	}
	else
	{
		
		WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
		WriteByte (MSG_MULTICAST, TE_SUPERSPIKE);
		WriteCoord (MSG_MULTICAST, self.origin_x);
		WriteCoord (MSG_MULTICAST, self.origin_y);
		WriteCoord (MSG_MULTICAST, self.origin_z);
		multicast (self.origin, MULTICAST_PHS);
		self.touch = SUB_Null;
		self.nextthink = time + 1;
		self.velocity = '0 0 0';
		self.think = SUB_Remove;
		self.movetype = MOVETYPE_TOSS;
	}
	
};



void HarpoonTowardOld(entity targ, entity inflictor, entity attacker) =
{
	if(targ.classname != "player")
		return;
	
	if ( (attacker != world) && (targ.movetype == MOVETYPE_WALK) )
	{
		
			local float maxkb = 350;
			local float minkb = 100;
			local float mindistance = 100;
			local float maxdistance = 800;
			local float kb;
			local vector difference = targ.origin - attacker.origin;
			local float distance = rint(sqrt(pow(difference.x, 2) + pow(difference.y, 2) + pow(difference.z, 2)));
			if(distance < mindistance)
				distance = mindistance;
			if (distance > maxdistance)
				distance = maxdistance;
			distance = distance - mindistance;
			local float kbrange = maxdistance-mindistance;
			kb = maxkb * (distance/kbrange);
			kb = rint(kb);
			if(kb < minkb)
				kb = minkb;
		
		
		
		//sprint(attacker, PRINT_HIGH, strcat("you pull ",trace_ent.netname, " for ", ftos(kb), " kb.\n"));
		local vector dir = targ.origin - attacker.origin;
		dir = normalize(dir) * -1;
		//dir = dir + '0 0 0.1';
		if (targ.flags & FL_ONGROUND)
			targ.velocity.z = targ.velocity.z + 250;

		targ.velocity = targ.velocity + dir * kb * 8;
	}

};
void harpoonremove() =
{
	remove(self);
};
void HarpoonToward(entity targ, entity inflictor, entity attacker) =
{
	
		if(targ.classname != "player")
		return;
		if ( (attacker != world) && (targ.movetype == MOVETYPE_WALK) )
		{

			local float mindistance = 100;
			local float maxdistance = 800;
			local vector difference = targ.origin - attacker.origin;
			local float distance = rint(sqrt(pow(difference.x, 2) + pow(difference.y, 2) + pow(difference.z, 2)));
			if(distance < mindistance)
				distance = mindistance;
			if (distance > maxdistance)
				distance = maxdistance;
			distance = distance - mindistance;
			
			local float kb;
			local float maxkb = 900;
			local float minkb = 500;
			local float kbrange = maxdistance-mindistance;
			kb = maxkb * (distance/kbrange);
			kb = rint(kb);
			if(kb < minkb)
				kb = minkb;
	
			//local vector offset = '0 0 0';
			//local float zoff =
			//offset_z = zoff;
			local vector midpoint = ((targ.origin + attacker.origin) / 2) + '0 0 128';

			
			local vector dir = targ.origin - midpoint;
			dir = normalize(dir) * -1;
			//bprint(2,strcat(ftos(kb),"kb ", ftos(distance/kbrange),"perc\n"));
			targ.velocity = dir * kb;
			targ.velocity_z = kb;
			
			local entity harpoontimer = spawn();
			harpoontimer.classname = "harpoontimer";
			harpoontimer.owner = targ;
			harpoontimer.gren = attacker; //using this to track attacker
			harpoontimer.think = harpoonremove;
			harpoontimer.nextthink = time + HARPOON_QUADWINDOW;
			
			remove(self);
		}
	
};

void LinkThink() =
{
	self.nextthink = time + 0.01;
	if(self.gren.classname != "harpoon" || self.gren.movetype == MOVETYPE_TOSS)
	{
		self.movetype = MOVETYPE_BOUNCE;
		self.nextthink = time + 1;
		self.think = SUB_Remove;
		return;
	}
	local vector temp;
	temp = self.gren.origin - self.gren.owner.origin;
	setorigin (self,(self.gren.owner.origin + (temp * self.bubble_count)));
	self.angles = vectoangles(normalize(temp));
};

void ThrowHarpoon() = 
{
	
	if(self.role != ROLE_FIGHTER)
		return;
	
	
	if (self.ammo_cells < 100)
	{
		sprint(self, PRINT_HIGH, "insufficient energy, 100 needed.\n");
		stuffcmd(self, "play beta1/error.wav\n");
		return;
	}

		self.ammo_cells = 50;
        
		newmis = spawn ();
		newmis.owner = self;
		newmis.movetype = MOVETYPE_FLYMISSILE;
		newmis.solid = SOLID_BBOX;
		
		// set newmis speed     
		makevectors (self.v_angle);
		newmis.velocity = v_forward;
		newmis.velocity = newmis.velocity * HARPOON_SPEED; //1000
		newmis.angles = vectoangles(newmis.velocity);
	
		newmis.touch = HarpoonTouch;
		newmis.voided = 0;
	
		// set newmis duration
		newmis.nextthink = time + 5;
		newmis.think = SUB_Remove;
		newmis.classname = "harpoon";
		FO_Sound(self, CHAN_ITEM, "beta1/harpoon_throw.wav", 1, ATTN_NORM);
		FO_SetModel(newmis, "progs/beta1/mcp_harpoon.mdl", DIM_WORLD);
		if(self.team_no == TEAM_BLUE)
			newmis.skin = 1;
		if(self.team_no == TEAM_RED)
			newmis.skin = 2;
		setsize (newmis, '0 0 0', '0 0 0');             
		setorigin (newmis, self.origin + '0 0 16');
		//setorigin (newmis, self.origin + v_forward*8 + '0 0 16');
		
		local float links = 5;
		local float distincrement = 1 / links; 
		local float dist = 0;
		while (links >= 0)
		{
			local entity newlink = spawn ();
			newlink.solid = SOLID_NOT;
			newlink.gren = newmis;		//using .gren to keep track of harpoon 'head'
			newlink.bubble_count = dist;	//using bubble_count to keep track of distance modifier
			newlink.owner = self;
			newlink.think = LinkThink;
			newlink.nextthink = time + 0.01;
			FO_SetModel(newlink, "progs/beta1/mcp_nail.mdl", DIM_WORLD);
			setsize (newlink, '0 0 0', '0 0 0');  
			links = links - 1;
			dist = dist + distincrement;
			
			local vector temp;
			temp = newmis.origin - self.origin;
			setorigin (newlink,(self.origin + (temp * self.bubble_count)));
			newlink.angles = vectoangles(normalize(temp));
			
		}
	
};


void C4_Explode() =
{
	if (self.voided) 
	{
		return;
	}
	self.voided = 1;

	MCP_RadiusDamage (self, self.owner, C4DAMAGE_EXPLODE, world, "c4", 1);

	FO_Sound(self, CHAN_ITEM, "beta1/c4_explode.wav", 1, ATTN_NORM);
	WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte (MSG_MULTICAST, TE_EXPLOSION);
	WriteCoord (MSG_MULTICAST, self.origin_x);
	WriteCoord (MSG_MULTICAST, self.origin_y);
	WriteCoord (MSG_MULTICAST, self.origin_z);
	multicast (self.origin, MULTICAST_PHS);

	remove (self);
};

void C4_Fizzle() =
{
	sprint(self.owner, PRINT_HIGH, "your detpack fizzled.\n");
	WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte (MSG_MULTICAST, TE_EXPLOSION);
	WriteCoord (MSG_MULTICAST, self.origin_x);
	WriteCoord (MSG_MULTICAST, self.origin_y);
	WriteCoord (MSG_MULTICAST, self.origin_z);
	multicast (self.origin, MULTICAST_PHS);
	remove(self);
};

void C4_AirTouch() =
{
	if(other.classname == "worldspawn" || other.classname == "player")
	{
		if(other == self.owner)
			return;
		self.velocity = '0 0 0';
		
		self.movetype = MOVETYPE_BOUNCE;
		self.touch = SUB_Null;
	}
};

void C4_Arm() =
{
	self.think = C4_Fizzle;
	self.nextthink = time + 500;
	FO_Sound(self, CHAN_ITEM, "beta1/c4_armed.wav", 1, ATTN_NORM);
	stuffcmd(self.owner, "play beta1/c4_armed.wav\n");
};

void ThrowC4() =
{
	if(self.ammo_cells < 100)
	{
		sprint(self, PRINT_HIGH, "insufficient cells, 100 needed.\n");
		stuffcmd(self, "play beta1/error.wav\n");
		return;
	}
	
	FO_Sound(self, CHAN_ITEM, "beta1/c4_throw.wav", 1, ATTN_NORM);
	self.ammo_cells = 50;
		
	newmis = spawn();
	newmis.movetype = MOVETYPE_TOSS;
	newmis.classname = "c4";
	newmis.solid = SOLID_BBOX;
	newmis.owner = self;
	
	newmis.team_no = self.team_no;
	newmis.bubble_count = time + C4_ARMTIME;
	newmis.nextthink = time + C4_ARMTIME;
	newmis.think = C4_Arm;
	newmis.touch = C4_AirTouch;
	setorigin(newmis, self.origin);
	setsize(newmis, '-16 -16 0', '16 16 8');

	
	FO_SetModel(newmis, "progs/beta1/mcp_c4.mdl", DIM_WORLD);
	if(self.team_no == TEAM_BLUE)
		newmis.skin = 1;
	else
		newmis.skin = 2;
	
    
	if (self.v_angle_x) 
	{
		newmis.velocity = v_forward * 600 + v_up * 200 + crandom() * v_right * 10 + crandom() * v_up * 10;
	}
	else 
	{
		newmis.velocity = aim(self, 10000);
		newmis.velocity = newmis.velocity * 300;
		newmis.velocity_z = 200;
	}
	//newmis.angles = vectoangles(newmis.velocity);
	newmis.avelocity = '0 300 0';
	newmis.angles = '90 0 0';
};

void Airblast() =
{
	if(self.ammo_cells < 100)
	{
		sprint(self, PRINT_HIGH, "insufficient cells, 100 needed.\n");
		stuffcmd(self, "play beta1/error.wav\n");
		return;
	}
	self.ammo_cells = 0;
	
	FO_Sound(self,CHAN_ITEM, "beta1/airblast_shoot.wav", 1, ATTN_NORM);
	makevectors(self.v_angle);

	traceline (self.origin + '0 0 16', self.origin + + '0 0 16' + v_forward * 2048, 0, self);		//using trace_endpos for projectiles
	local vector targpos = self.origin + '0 0 16' + v_forward * 1000;					//using this for players
	local vector targdir;
	
	//targvec = normalize(targvec - self.origin);
	
        local entity head = findradius(self.origin + (v_forward * (AIRBLAST_RADIUS/2)), AIRBLAST_RADIUS);
      
        while (head)
	{

		targdir = normalize(trace_endpos - head.origin);
		 
		if (head.classname == "player" && head != self)
		{


			local float push = vlen (self.origin + v_forward*32 - head.origin);
			if(push > 170)
				push = 170;

			push = push/170;
			push = 1 - push;
			push = AIRBLAST_MAXPLAYERPUSH * push;
			if(push < AIRBLAST_MINPLAYERPUSH)
				push = AIRBLAST_MINPLAYERPUSH;
			
			//if(distance < mindistance)
			//	distance = mindistance;
			//if (distance > maxdistance)
			//	distance = maxdistance;
			//distance = distance - mindistance;
			//bprint(2,strcat(ftos(dist),"dust\n"));
			
			head.velocity = normalize(targpos - head.origin) * push;
			//head.velocity = head.velocity + '0 0 32';
		}
		
		
		
		else if (head.classname == "teleball")
		{
			head.velocity = targdir * vlen(head.velocity);
			head.angles = vectoangles(head.velocity);
		}
		else if (head.classname == "rocket" || head.classname == "throwngrenade" || head.classname == "nail" || head.classname == "c4" || head.classname == "clusterbig" || head.classname == "clustermini" || head.classname == "harpoon")
		{
			//local entity targent = spawn();
			//FO_SetModel(targent, "progs/beta1/mcp_teleball.mdl");
			//setorigin(targent, trace_endpos);
			//targent.nextthink = time + 2;
			//targent.think = SUB_Remove;
			head.gren = head.owner;
			
			if(head.owner.team_no != self.team_no)
			{
				head.owner = self;
				if(self.team_no == TEAM_BLUE)
					head.skin = 1;
				else
					head.skin = 2;
				
				if(head.classname == "c4")
				{
					FO_Sound(head, CHAN_ITEM, "beta1/c4_armed.wav", 1, ATTN_NORM);
					stuffcmd(head.owner, "play beta1/c4_armed.wav\n");
					
					head.think = C4_Explode;
					head.nextthink = time+1;	
				}
				
			}
				
			
			head.velocity = targdir * vlen(head.velocity);
			head.angles = vectoangles(head.velocity);
		}
		head = head.chain;
	}

};
void C4Skill() =
{
	local entity c4e = world;
	local entity te = find(world, classname, "c4");
	while (te) 
	{
		if (te.owner == self && te != world) 
		{
			c4e = te;
		}
		te = find(te, classname, "c4");
	}
	
	if(c4e == world)
	{
		ThrowC4();
	}
	else
	{
		if(time > c4e.bubble_count)
		{
			stuffcmd(self, "play beta1/c4_detonate.wav\n");
			c4e.think = C4_Explode;
			c4e.nextthink = time;
			return;
		}
		else
		{
			stuffcmd(self, "play beta1/error.wav\n");
			sprint(self, PRINT_HIGH, "you cant detonate it yet.\n");
			return;
		}
	}
};

void W_SpecialSkill() =
{
	self.impulse = 0;
	if(self.deadflag != DEAD_NO)
		return;
	if(self.role == ROLE_RECON)
	{
		RecDash();
	}
	if(self.role == ROLE_ASSASSIN)
	{
		Cloak();
	}
	if(self.role == ROLE_FIGHTER)
	{
		//DropArmour();
		ThrowHarpoon();
		//LaunchHook();
	}
	if(self.role == ROLE_BOMBER)
	{
		//DetStickys();
		C4Skill();
	}
	if(self.role == ROLE_SUPPORT)
	{
		TeleSkill();
	}
	if(self.role == ROLE_MGUNNER)
	{
		Charge();
	}
	return;
};
void RegenHealthArmour() =
{
	//if(self.team_no != TEAM_RED || self.team_no != TEAM_BLUE)
	//	return;
	
	if(self.role == ROLE_NONE)
		return;
	
	if(self.deadflag != DEAD_NO)
		return;
	
	if(self.health > 100)			//health rot for support overheal
	{
		self.health = self.health - 1;
	}
	
	
	if (time <= self.next_healtharmourregen)
		return;
	
	self.next_healtharmourregen = time + 1;
	
	if(self.health < 100)
	{
		self.health = self.health + 2;
		if(self.health > 100)
			self.health = 100;
		if(infokey(self, "regensound") != "0")
			stuffcmd(self, "play beta1/regenhealth.wav\n");
	}
	
	if(self.armorvalue < self.maxarmour)
	{
		self.armorvalue = self.armorvalue + 2;
		if(self.armorvalue > self.maxarmour)
			self.armorvalue = self.maxarmour;
		if(infokey(self, "regensound") != "0")
			stuffcmd(self, "play beta1/regenarmour.wav\n");
	}

};

void RegenCells() =
{
	if(self.ammo_cells == 100)
		return;
	
	if(time < self.next_cellregen)
		return;
	
	if(self.role == ROLE_RECON)
	{
		self.next_cellregen = time + 0.25;
		self.ammo_cells = self.ammo_cells + 25;
		if(self.ammo_cells >= 100)
			{
				self.ammo_cells = 100;
				stuffcmd(self, "play beta1/specialready_recon.wav\n");
			}
	}
	if(self.role == ROLE_ASSASSIN)
	{
		self.next_cellregen = time + 1;
		if(self.iscloaked == 1)
			return;
		self.ammo_cells = self.ammo_cells + 5;
		if(self.ammo_cells >= 100)
		{
			self.ammo_cells = 100;
			stuffcmd(self, "play beta1/specialready_assassin.wav\n");
		}
	}
	if(self.role == ROLE_SUPPORT)
	{
		self.next_cellregen = time + 1;
		self.ammo_cells = self.ammo_cells + 10;
		if(self.ammo_cells >= 100)
		{
			self.ammo_cells = 100;
			stuffcmd(self, "play beta1/specialready_support.wav\n");
		}
	}
	if(self.role == ROLE_FIGHTER)
	{
		self.next_cellregen = time + 0.5;
		self.ammo_cells = self.ammo_cells + 5;
		if(self.ammo_cells >= 100)
		{
			self.ammo_cells = 100;
			stuffcmd(self, "play beta1/specialready_fighter.wav\n");
		}
	}
	if(self.role == ROLE_BOMBER)
	{
		self.next_cellregen = time + 0.5;
		self.ammo_cells = self.ammo_cells + 5;
		if(self.ammo_cells >= 100)
		{
			self.ammo_cells = 100;
			stuffcmd(self, "play beta1/specialready_bomber.wav\n");
		}
	}
	
	if(self.role == ROLE_MGUNNER)
	{
		self.next_cellregen = time + 1;
		self.ammo_cells = self.ammo_cells + 10;
		if(self.ammo_cells >= 100)
		{
			self.ammo_cells = 100;
			stuffcmd(self, "play beta1/chargeready.wav\n");
		}
	}
};

void (entity pe_player, float f_type) AutoIdentify = {
    
	local string ai;
	ai = infokey(pe_player, "ai");
		
	if(ai == "0")
		return;
   
    local vector v_source;
    
    makevectors(pe_player.v_angle);
    v_source = pe_player.origin + v_forward * 10;
    v_source_z = pe_player.absmin_z + pe_player.size_z * 0.7;

    traceline(v_source, v_source + v_forward * 2048, 0, pe_player);
    if (trace_ent != world) 
    {
	local string s_id_string = "", s_name = "";
        local float f_health = 0,  f_armor = 0 ;

        // don't identify targets above water if player is under water
        if (pe_player.waterlevel == 3 && !trace_ent.waterlevel)
            return;

        // don't identify targets under water if player is above water
        if (pe_player.waterlevel < 3 && trace_ent.waterlevel == 3)
            return;

        // alive player is found
        if (trace_ent.classname == "player" && trace_ent.health > 0) 
        {
            
            s_name = trace_ent.netname;
            f_health = trace_ent.health;
            f_armor = trace_ent.armorvalue;
            s_id_string = strcat(s_name, "\n", ftos(f_health), " - ", ftos(f_armor), "\n");
	}

        //pe_player.ident_time = time + 0.5;


    }
};


