
void DetStickys()=
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
};

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
		FO_SetModel(self.owner, "progs/player.mdl");
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
	
	W_SetCurrentWeaponModel();
	W_SetCurrentAmmo();
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

	FO_SetModel (newmis, "progs/beta1/mcp_teleball.mdl");
	if(self.team_no == TEAM_BLUE)
		newmis.skin = 1;
	if(self.team_no == TEAM_RED)
		newmis.skin = 2;
	setsize(newmis, self.mins, self.maxs);             
	//setorigin (newmis, self.origin + v_forward*8 + '0 0 16');
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
	//if (tb.bubble_count == -1)
	//{
	//	sprint(self, PRINT_HIGH, "not enough room to teleport.\n");
	//	return;
	//}
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
	FO_SetModel(newmis, "progs/armor.mdl");
	
    
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
	
	//DetLittleProxyInRadius (self.origin, 32, self, self.owner.team_no);
// hit something that bleeds
	if (other.takedamage)
	{
		spawn_touchblood (18);
		other.deathtype = "harpoon";
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
void HarpoonToward(entity targ, entity attacker) =
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

void LinkThink() =
{
	self.nextthink = time + 0.01;
	//bprint(2,strcat(self.gren.classname, "zzzf\n"));
	if(self.gren.classname != "harpoon" || self.gren.movetype == MOVETYPE_TOSS)
	{
		self.movetype = MOVETYPE_BOUNCE;
		self.nextthink = time + 1;
		self.think = SUB_Remove;
		return;
	}
	local vector temp;
	temp = self.gren.origin - self.owner.origin;
	setorigin (self,(self.owner.origin + (temp * self.bubble_count)));
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
		FO_SetModel(newmis, "progs/beta1/mcp_harpoon.mdl");
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
			FO_SetModel(newlink, "progs/beta1/mcp_nail.mdl");
			setsize (newlink, '0 0 0', '0 0 0');  
			links = links - 1;
			dist = dist + distincrement;
			
			local vector temp;
			temp = newmis.origin - self.origin;
			setorigin (newlink,(self.origin + (temp * self.bubble_count)));
			newlink.angles = vectoangles(normalize(temp));
			
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
	}
	if(self.role == ROLE_BOMBER)
	{
		DetStickys();
	}
	if(self.role == ROLE_SUPPORT)
	{
		TeleSkill();
	}
	return;
};
void RegenHealthArmour() =
{
	if (time <= self.next_healtharmourregen)
		return;
	
	self.next_healtharmourregen = time + 1;
	
	if(self.health > 100)			//health rot for support overheal
	{
		self.health = self.health - 1;
	}
	if(self.role == ROLE_FIGHTER && self.armorvalue < ARMOUR_MAX_FIGHTER)
	{
		if(infokey(self, "regensound") != "0")
			stuffcmd(self, "play beta1/regenarmour.wav\n");
		self.armorvalue  = self.armorvalue + 2;
		if(self.armorvalue > ARMOUR_MAX_FIGHTER)
			self.armorvalue = ARMOUR_MAX_FIGHTER;
	}
	if(self.role == ROLE_RECON && self.health < 100)
	{	
		if(infokey(self, "regensound") != "0")
			stuffcmd(self, "play beta1/regenhealth.wav\n");
		
		self.health = self.health + 2;
		if(self.health > 100)
			self.health = 100;
			
	}
	if(self.role == ROLE_BOMBER)
	{
		if(self.armorvalue  < ARMOUR_MAX_BOMBER || self.health < 100)
		{
			if(infokey(self, "regensound") != "0")
				stuffcmd(self, "play beta1/regenhealtharmour.wav\n");
		}
		if(self.health < 100)
		{
			self.health = self.health + 2;
			
			if(self.health > 100)
				self.health = 100;
		}
		if(self.armorvalue < ARMOUR_MAX_BOMBER)
		{
			self.armorvalue = self.armorvalue + 2;
			if(self.armorvalue > ARMOUR_MAX_BOMBER)
				self.armorvalue = ARMOUR_MAX_BOMBER;
		}
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
		self.ammo_cells = self.ammo_cells + 5;
		if(self.ammo_cells >= 100)
		{
			self.ammo_cells = 100;
			stuffcmd(self, "play beta1/specialready_support.wav\n");
		}
	}
	if(self.role == ROLE_FIGHTER)
	{
		self.next_cellregen = time + 1;
		self.ammo_cells = self.ammo_cells + 5;
		if(self.ammo_cells >= 100)
		{
			self.ammo_cells = 100;
			stuffcmd(self, "play beta1/specialready_fighter.wav\n");
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

