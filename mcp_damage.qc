// CanDamage
//Returns true if the inflictor can directly damage the target.  Used for explosions and melee attacks.

float(entity targ, entity inflictor) CanDamage =
{
// bmodels need special checking because their origin is 0,0,0
	if (targ.movetype == MOVETYPE_PUSH)
	{
		traceline(inflictor.origin, 0.5 * (targ.absmin + targ.absmax), TRUE, self);
		if (trace_fraction == 1)
			return TRUE;
		if (trace_ent == targ)
			return TRUE;
		return FALSE;
	}
	
	traceline(inflictor.origin, targ.origin, TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '15 15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '-15 -15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '-15 15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '15 -15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;

	return FALSE;
};

// Killed
void SetNextRespawn (entity ent, float sui) =
{
	if(matchstate == MATCHSTATE_LIVE)
	{
		if(sui == 1)
		{
			ent.nextrespawn = time + RESPAWNPENALTY_SUICIDE;
			sprint(ent, PRINT_HIGH, strcat("you can respawn in ", ftos(RESPAWNPENALTY_SUICIDE), " seconds.\n"));
			return;
		}
		if(mcpflag.playerstate == MCPFLAGSTATE_CAPPED && mcpflag.team_no == ent.team_no)
		{
			ent.nextrespawn = time + RESPAWNPENALTY_INCONTROL;
			sprint(ent, PRINT_HIGH, strcat("you can respawn in ", ftos(RESPAWNPENALTY_INCONTROL), " seconds.\n"));
			return;
		}
	}
		
	ent.nextrespawn = time + RESPAWNPENALTY_OUTOFCONTROL;
};

void(entity targ, entity attacker) Killed =
{
	KillSound(targ, attacker);
	SetNextRespawn(targ, 0);

	
	
	local entity oself;
	
	oself = self;
	self = targ;
	
	if (self.health < -99)
		self.health = -99;              // don't let sbar look bad if a player

	if (self.movetype == MOVETYPE_PUSH || self.movetype == MOVETYPE_NONE)
	{       // doors, triggers, etc
		self.th_die ();
		self = oself;
		return;
	}

	self.enemy = attacker;

// bump the monster counter
	if (self.flags & FL_MONSTER)
	{
		killed_monsters = killed_monsters + 1;
		WriteByte (MSG_ALL, SVC_KILLEDMONSTER);
	}

	ClientObituary(self, attacker);
	
	self.takedamage = DAMAGE_NO;
	self.touch = SUB_Null;
	self.effects = 0;

/*SERVER
	monster_death_use();
*/
	self.th_die ();
	
	self = oself;
};

void Knockback(entity targ, entity inflictor, entity attacker, float damage) =
{
// figure momentum add
	if ( (inflictor != world) && (targ.movetype == MOVETYPE_WALK) )
	{

		local vector dir = targ.origin - (inflictor.absmin + inflictor.absmax) * 0.5;
		dir = normalize(dir);

		// Set kickback for smaller weapons
//Zoid -- use normal NQ kickback
//		// Read: only if it's not yourself doing the damage
//		if ( (damage < 60) & ((attacker.classname == "player") & (targ.classname == "player")) & ( attacker.netname != targ.netname)) 
//			targ.velocity = targ.velocity + dir * damage * 11;
//		else                        
		// Otherwise, these rules apply to rockets and grenades                        
		// for blast velocity
			targ.velocity = targ.velocity + dir * damage * 8;
		
		// Rocket Jump modifiers
		if ( (rj > 1) & ((attacker.classname == "player") & (targ.classname == "player")) & ( attacker.netname == targ.netname)) 
			targ.velocity = targ.velocity + dir * damage * rj;

	}
};

void(entity targ, entity inflictor, entity attacker, float damage) T_Damage =
{
	local   vector  dir;
	local   entity  oldself;
	local   float   save;
	local   float   take;
	local   string  s;

	if (!targ.takedamage)
		return;

	HitSound(targ, inflictor, attacker, damage);
	if(targ.classname == "player")
		targ.next_healtharmourregen = time + 3;
// used by buttons and triggers to set activator for target firing
	damage_attacker = attacker;

// save damage based on the target's armor level
	damage = ceil(damage);
	if(damage >= targ.armorvalue)
	{
		save = targ.armorvalue;
		
	}
	else
	{
		save = damage;
	}
	take = (damage - save);

// add to the damage total for clients, which will be sent as a single
// message at the end of the frame
// FIXME: remove after combining shotgun blasts?
	if (targ.flags & FL_CLIENT)
	{
		targ.dmg_take = targ.dmg_take + take;
		targ.dmg_save = targ.dmg_save + save;
		targ.dmg_inflictor = inflictor;
	}

	damage_inflictor = inflictor;        


// figure momentum add
		if(inflictor.classname == "harpoon" && targ.team_no != attacker.team_no && inflictor.voided == 0)
		{
			HarpoonToward(targ, attacker);
			local float rng = MyRNG(2);
			if(rng == 1)
				FO_Sound(attacker, CHAN_AUTO, "beta1/harpoon_enemy1.wav", 1, ATTN_NORM);
			if(rng == 2)
				FO_Sound(attacker, CHAN_AUTO, "beta1/harpoon_enemy2.wav", 1, ATTN_NORM);
		}
		else
		{
			Knockback(targ, inflictor, attacker, damage);
		}


// check for godmode or invincibility
	if (targ.flags & FL_GODMODE)
		return;
	if (targ.invincible_finished >= time)
	{
		if (self.invincible_sound < time)
		{
			FO_Sound(targ, CHAN_ITEM, "items/protect3.wav", 1, ATTN_NORM);
			self.invincible_sound = time + 2;
		}
		return;
	}

// team play damage avoidance
	if (targ.team_no == attacker.team_no && inflictor.classname != "door" && attacker != targ)
	{

		return;
	}

		
// do the damage
	if (save >= targ.armorvalue)
	{
		save = targ.armorvalue;
		if(targ.armorvalue > 0)
			{
				//FO_Sound(targ, CHAN_ITEM, "beta1/armour_break.wav", 1, ATTN_NORM);
			}
	}
	
	targ.armorvalue = targ.armorvalue - save;
	targ.health = targ.health - take;
			
	if (targ.health <= 0)
	{
		Killed (targ, attacker);
		return;
	}

// react to the damage
	oldself = self;
	self = targ;


	if (self.th_pain)
	{
		self.th_pain (attacker, take);
	}

	self = oldself;
};


//T_RadiusDamage
void(entity inflictor, entity attacker, float damage, entity ignore, string dtype) T_RadiusDamage =
{
	local   float   points;
	local   entity  head;
	local   vector  org;

	head = findradius(inflictor.origin, damage+40);
	local float leech;
	
	while (head)
	{
		//bprint (PRINT_HIGH, head.classname);
		//bprint (PRINT_HIGH, " | ");
		//bprint (PRINT_HIGH, head.netname);
		//bprint (PRINT_HIGH, "\n");
		

		if (head != ignore)
		{
			if (head.takedamage)
			{
				org = head.origin + (head.mins + head.maxs)*0.5;
				points = 0.5*vlen (inflictor.origin - org);
				if (points < 0)
					points = 0;
				points = damage - points;
				
				if (head == attacker)
					points = points * 0.75;
				if (points > 0)
				{
					if (CanDamage (head, inflictor))
					{
						head.deathtype = dtype;
						T_Damage (head, inflictor, attacker, points);
						
						if(attacker.team_no != head.team_no && head.classname == "player" && dtype == "grenade_leech" && inflictor.cnt != 1)
						{

							leech = points / 2;
							sound(attacker, CHAN_ITEM, "beta1/grenade_leech.wav", 1, ATTN_NORM);
							attacker.health = attacker.health + leech;
							if(attacker.health >= 150)
								attacker.health = 150;

						}
					}
				}
			}
		}
		head = head.chain;
	}
	
};

//T_BeamDamage
void(entity attacker, float damage) T_BeamDamage =
{
	local   float   points;
	local   entity  head;
	
	head = findradius(attacker.origin, damage+40);
	
	while (head)
	{
		if (head.takedamage)
		{
			points = 0.5*vlen (attacker.origin - head.origin);
			if (points < 0)
				points = 0;
			points = damage - points;
			if (head == attacker)
				points = points * 0.5;
			if (points > 0)
			{
				if (CanDamage (head, attacker))
					T_Damage (head, attacker, attacker, points);
			}
		}
		head = head.chain;
	}
};

void GoombaStomp() =
{
	if(self.hasstomped == 1)
		return;
	
	self.hasstomped = 1;

	local entity head;
	head = findradius(self.origin + '0 0 -32', 32);
	
	while (head)
	{

		if (head.classname == "player" && head.team_no != self.team && head != self)
		{
			if(head.takedamage)
			{
				head.deathtype = "goomba_stomp";
				T_Damage (head, self, self, 10);
				FO_Sound(self, CHAN_AUTO, "beta1/gstomp_hurt.wav", 1, ATTN_NORM);
			}
		}
		head = head.chain;
	}
};

void (entity targ, entity inflictor, entity attacker, float damage) HitSound = 
{


	if ((attacker.classname == "player") || (attacker.classname == "building_sentrygun") || (attacker.classname == "building_dispenser"))
    {
        if ((targ.classname == "player") )
        {
            if (attacker == targ)
            {
                return;
            }

            local string hitsound;
            hitsound = infokey(attacker, "hitsound");
		
            if(hitsound == "0")
		return;
            

		local float crit;
		if(targ.armorvalue <= 0)
			crit = 1;
/*
		
                if((inflictor.weapon == DMSG_ROCKETL) && (damage >= 80)) {
                    crit = 1;
                }
                if ((inflictor.weapon == DMSG_SSHOTGUN) && (damage >= 40)) {
                    crit = 1;
                }
                if ((inflictor.weapon == DMSG_GRENADEL) && (damage >= 85)) {
                    crit = 1;
                }
                if ((inflictor.weapon == DMSG_INCENDIARY) && (damage >= 40)) {
                    crit = 1;
                }
*/
		//sprint(self, PRINT_HIGH, strcat(inflictor.classname, " infcn ", attacker.classname, " attrcn\n"));
                
                if (targ.team_no != attacker.team_no) {
			if(attacker.weapon == WPN_RAILGUN)
			{
				if(attacker.heat == 1)
					stuffcmd(attacker, "play beta1/hitsound_rail1.wav\n");
				if(attacker.heat == 2)
					stuffcmd(attacker, "play beta1/hitsound_rail2.wav\n");
				if(attacker.heat == 3)
					stuffcmd(attacker, "play beta1/hitsound_rail3.wav\n");
				return;
			}
			if (crit == 1){
                        stuffcmd(attacker, "play beta1/hitsound_crit.wav\n");		
			}
			else { 
                        stuffcmd(attacker, "play beta1/hitsound.wav\n");		
                    }
                }
                else 
                {
			stuffcmd(attacker, "play beta1/hitsound_team.wav\n");		
                    
                }	
            }

	}
};


void (entity targ, entity attacker) KillSound = 
{

	if (attacker.classname == "player" && targ.classname == "player")
	{
		local string killsound = infokey(attacker, "killsound");
		
		if(killsound == "0")
			return;

			
		if (targ.team_no != attacker.team_no) 
		{
			stuffcmd(attacker, "play beta1/killsound.wav\n");
		}
		else 
		{
			stuffcmd(attacker, "play beta1/killsound_team.wav\n");	
		}
	}
		
};

void(vector org, float radius, entity ignore, float team) ZutRadiusCheck =
{


	local entity head;
	head = findradius(org, radius);
	
	while (head)
	{
		//if (head.classname == "littleproxy" && head.team_no != team)
		//{
		//	head.nextthink = time + 0.1;
		//	head.think = DisarmLittleProxy;
		//	head.touch = SUB_Null;
		//}
		if (head.classname == "beartrap" && head.team_no != team)
		{
			head.nextthink = time;
			head.touch = SUB_Null;
		}
		head = head.chain;
	}
	
};