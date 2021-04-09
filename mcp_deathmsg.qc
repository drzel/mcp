
// ClientObituary - called when a player dies

void(entity targ, entity attacker) ClientObituary =
{
	if(matchstate != MATCHSTATE_LIVE)
		return;
	
	local   float rnum;
	local   string deathstring, deathstring2;
	local   string s;
	local   string  attackerteam, targteam;

	rnum = random();
	//ZOID 12-13-96: self.team doesn't work in QW.  Use keys
	attackerteam = infokey(attacker, "team");
	targteam = infokey(targ, "team");

	if (targ.classname == "player")
	{

		if (deathmatch > 3)	
		{
			if (targ.deathtype == "selfwater")
			{
				bprint (PRINT_MEDIUM, targ.netname);
				bprint (PRINT_MEDIUM," electrocutes himself.\n ");
				//targ.frags = targ.frags - 1;
				return;
			}
		}

		if (attacker.classname == "teledeath")
		{

			bprint (PRINT_MEDIUM,targ.netname);
			if(targ.team_no == attacker.team_no)
			{
				bprint (PRINT_MEDIUM," was telefragged by teammate ");
			}
			else
			{
				bprint (PRINT_MEDIUM," was telefragged by ");
				KillStreak(attacker.owner);
				SoundTeam (TEAM_RED, world, "beta1/insideout.wav");
				SoundTeam (TEAM_BLUE, world, "beta1/insideout.wav");
			}
				
			bprint (PRINT_MEDIUM,attacker.owner.netname);
			bprint (PRINT_MEDIUM,"\n");
			KillSound(targ,attacker);
			//logfrag (attacker.owner, targ);

			//attacker.owner.frags = attacker.owner.frags + 1;
			return;
		}

		if (attacker.classname == "teledeath2")
		{
			bprint (PRINT_MEDIUM,"Satan's power deflects ");
			bprint (PRINT_MEDIUM,targ.netname);
			bprint (PRINT_MEDIUM,"'s telefrag\n");

			//targ.frags = targ.frags - 1;
			//logfrag (targ, targ);
			return;
		}

		// double 666 telefrag (can happen often in deathmatch 4)
		if (attacker.classname == "teledeath3") 
		{
			bprint (PRINT_MEDIUM,targ.netname);
			bprint (PRINT_MEDIUM," was telefragged by ");
			bprint (PRINT_MEDIUM,attacker.owner.netname);
			bprint (PRINT_MEDIUM, "'s Satan's power\n");
			//targ.frags = targ.frags - 1;
			//logfrag (targ, targ);
			return;
		}
	

		if (targ.deathtype == "squish")
		{
			if (teamplay && targteam == attackerteam && attackerteam != "" && targ != attacker)
			{
				//logfrag (attacker, attacker);
				//attacker.frags = attacker.frags - 1; 
				bprint (PRINT_MEDIUM,attacker.netname);
				bprint (PRINT_MEDIUM," squished a teammate\n");
				return;
			}
			else if (attacker.classname == "player" && attacker != targ)
			{
				bprint (PRINT_MEDIUM, attacker.netname);
				bprint (PRINT_MEDIUM," squishes ");
				bprint (PRINT_MEDIUM,targ.netname);
				bprint (PRINT_MEDIUM,"\n");
				//logfrag (attacker, targ);
				//attacker.frags = attacker.frags + 1;
				return;
			}
			else
			{
				//logfrag (targ, targ);
				//targ.frags = targ.frags - 1;            // killed self
				bprint (PRINT_MEDIUM,targ.netname);
				bprint (PRINT_MEDIUM," was squished\n");
				return;
			}
		}

		if (attacker.classname == "player")
		{
			if (targ == attacker)
			{
				// killed self
				//logfrag (attacker, attacker);
				//attacker.frags = attacker.frags - 1;
				bprint (PRINT_MEDIUM,targ.netname);
				if (targ.deathtype == "grenade")
					bprint (PRINT_MEDIUM," tries to put the pin back in\n");
				else if (targ.deathtype == "rocket")
					bprint (PRINT_MEDIUM," becomes bored with life\n");
				else if (targ.deathtype == "sticky_direct")
					bprint (PRINT_MEDIUM," got too close with his sticky launcher\n");
				else if (targ.deathtype == "sticky_trap")
					bprint (PRINT_MEDIUM," got caught in their own sticky trap\n");
				else if (targ.deathtype == "grenade_leech")
					bprint (PRINT_MEDIUM," succumbed to their own leeches\n");
				else if (targ.deathtype == "grenade_frag")
					bprint (PRINT_MEDIUM," regrets using a frag grenade\n");
				else if (targ.deathtype == "grenade_flash")
					bprint (PRINT_MEDIUM," was incinerated by their own flash grenade\n");
				else if (targ.deathtype == "clustermini_aoe")
					bprint (PRINT_MEDIUM," got too close to his own spam\n");
				else if (targ.deathtype == "clustermini_direct")
					bprint (PRINT_MEDIUM," got too close to his own spam\n");
				else if (targ.deathtype == "clusterbig_direct")
					bprint (PRINT_MEDIUM," got too close to his own spam\n");
				else if (targ.deathtype == "c4")
					bprint (PRINT_MEDIUM," set the detpack and forgot to run\n");
				else
					bprint (PRINT_MEDIUM," becomes bored with life\n");
				return;
			}
			else if ( (teamplay == 2) && (targteam == attackerteam) &&
				(attackerteam != "") )
			{
				if (rnum < 0.25)
					deathstring = " mows down a teammate\n";
				else if (rnum < 0.50)
					deathstring = " checks his glasses\n";
				else if (rnum < 0.75)
					deathstring = " gets a frag for the other team\n";
				else
					deathstring = " loses another friend\n";
				bprint (PRINT_MEDIUM, attacker.netname);
				bprint (PRINT_MEDIUM, deathstring);
				//attacker.frags = attacker.frags - 1;
				//ZOID 12-13-96:  killing a teammate logs as suicide
				//logfrag (attacker, attacker);
				return;
			}
			else
			{
				//logfrag (attacker, targ);
				//attacker.frags = attacker.frags + 1;
				KillStreak(attacker);
				rnum = attacker.weapon;
				if (targ.deathtype == "nail")
				{
					deathstring = " was nailed by ";
					deathstring2 = "\n";
				}
				else if (targ.deathtype == "supernail")
				{
					deathstring = " was punctured by ";
					deathstring2 = "\n";
				}
				else if (targ.deathtype == "grenade")
				{
					deathstring = " eats ";
					deathstring2 = "'s pineapple\n";
					if (targ.health < -40)
					{
						deathstring = " was gibbed by ";
						deathstring2 = "'s grenade\n";
					}
				}
				else if (targ.deathtype == "rocket")
				{
					if (attacker.super_damage_finished > 0 && targ.health < -40)
					{
						rnum = random();
						if (rnum < 0.3)
							deathstring = " was brutalized by ";
						else if (rnum < 0.6)
							deathstring = " was smeared by ";
						else
						{
							bprint (PRINT_MEDIUM, attacker.netname);
							bprint (PRINT_MEDIUM, " rips ");
							bprint (PRINT_MEDIUM, targ.netname);
							bprint (PRINT_MEDIUM, " a new one\n");
							return;
						}
						deathstring2 = "'s quad rocket\n";
					}
					else
					{
						deathstring = " rides ";
						deathstring2 = "'s rocket\n";
						if (targ.health < -40)
						{
							deathstring = " was gibbed by ";
							deathstring2 = "'s rocket\n" ;
						}
					}
				}
				else if (targ.deathtype == "harpoon")
				{
					deathstring = " was harpooned by ";
					deathstring2 = "\n";
					SoundTeam (TEAM_RED, world, "beta1/humiliation.wav");
					SoundTeam (TEAM_BLUE, world, "beta1/humiliation.wav");
				}
				else if (targ.deathtype == "beartrap")
				{
					deathstring = " stepped on ";
					deathstring2 = "'s bear trap\n";
				}
				else if (targ.deathtype == "c4")
				{
					deathstring = " reaches orbit via ";
					deathstring2 = "'s detpack\n";
				}
				else if (targ.deathtype == "rocket_direct")
				{
					deathstring = " eats a direct rocket from ";
					deathstring2 = "\n";
				}
				else if (targ.deathtype == "rocket_directquad")
				{
					deathstring = " was combo'd by ";
					deathstring2 = "\n";
					SoundTeam (TEAM_RED, world, "beta1/voice_combowhore.wav");
					SoundTeam (TEAM_BLUE, world, "beta1/voice_combowhore.wav");
				}

				/*else if (targ.deathtype == "sticky_trap")
				{
					deathstring = " is caught by ";
					deathstring2 = "'s sticky trap\n" ;
				
				}
				else if (targ.deathtype == "sticky_direct")
				{
					deathstring = " caught a direct sticky from ";
					deathstring2 = "\n" ;
				
				}*/
				else if (targ.deathtype == "clusterbig_direct")
				{
					deathstring = " caught a direct pineapple from ";
					deathstring2 = "\n" ;

				}
				else if (targ.deathtype == "shouldercharge")
				{
					deathstring = " was shoulder charged by ";
					deathstring2 = "\n" ;
					SoundTeam (TEAM_RED, world, "beta1/thomas.wav");
					SoundTeam (TEAM_BLUE, world, "beta1/thomas.wav");

				}

				else if (targ.deathtype == "clustermini_direct")
				{
					deathstring = " caught a direct mini-pineapple from ";
					deathstring2 = "\n" ;
				
				}

				else if (targ.deathtype == "clustermini_aoe")
				{
					deathstring = " succumbed to ";
					deathstring2 = "'s mini-pineapple spam\n" ;
				
				}


				else if (targ.deathtype == "grenade_leech")
				{
					deathstring = " was sucked dry by ";
					deathstring2 = "'s leech grenade\n" ;
				
				}

				else if (targ.deathtype == "grenade_frag")
				{
					deathstring = " played catch with ";
					deathstring2 = "'s frag grenade\n" ;
				
				}

				
				
				
				
				else if (targ.deathtype == "grenade_flash")
				{
					deathstring = " is charred by ";
					deathstring2 = "'s flash grenade\n" ;
					SoundTeam (TEAM_RED, world, "beta1/toasty.wav");
					SoundTeam (TEAM_BLUE, world, "beta1/toasty.wav");
				}

				/*else if (targ.deathtype == "grenade_bigproxy")
				{
					deathstring = " couldnt outrun ";
					deathstring2 = "'s proxy grenade\n" ;
				
				}
				else if (targ.deathtype == "grenade_littleproxy")
				{
					deathstring = " got too close to ";
					deathstring2 = "'s proxy grenade\n" ;
				
				}*/
				else if (targ.deathtype == "goomba_stomp")
				{
					deathstring = " was goomba stomped by ";
					deathstring2 = "\n" ;
					SoundTeam (TEAM_RED, world, "beta1/gstomp_kill.wav");
					SoundTeam (TEAM_BLUE, world, "beta1/gstomp_kill.wav");
				}
				else if (rnum == WPN_AXE)
				{
				if(attacker.role == ROLE_ASSASSIN)
				{
					deathstring = " was executed by ";
					deathstring2 = "\n";
					SoundTeam (TEAM_RED, world, "beta1/humiliation.wav");
					SoundTeam (TEAM_BLUE, world, "beta1/humiliation.wav");
					
				}
				else
				{
					deathstring = " was ax-murdered by ";
					deathstring2 = "\n";
					SoundTeam (TEAM_RED, world, "beta1/humiliation.wav");
					SoundTeam (TEAM_BLUE, world, "beta1/humiliation.wav");
				}
				}
				else if (rnum == WPN_SHOTGUN)
				{
					deathstring = " chewed on ";
					deathstring2 = "'s boomstick\n";
				}
				else if (rnum == WPN_SUPERSHOTGUN)
				{
					deathstring = " ate 2 loads of ";
					deathstring2 = "'s buckshot\n";
				}
				else if (rnum == WPN_SHAFT)
				{
					deathstring = " accepts ";
					deathstring2 = "'s shaft\n";
				}
				else if (rnum == WPN_RAILGUN)
				{
					deathstring = " was railed by ";
					deathstring2 = "\n";
				}
				else if (rnum == WPN_MINIGUN)
				{
					
					deathstring = " was gunned down by ";
					deathstring2 = "'s minigun\n";
				}
				bprint (PRINT_MEDIUM,targ.netname);
				bprint (PRINT_MEDIUM,deathstring);
				bprint (PRINT_MEDIUM,attacker.netname);
				bprint (PRINT_MEDIUM,deathstring2);
			}
			return;
		}
		else
		{
			//logfrag (targ, targ);
			//targ.frags = targ.frags - 1;            // killed self
			rnum = targ.watertype;

			bprint (PRINT_MEDIUM,targ.netname);
			if (rnum == -3)
			{
				if (random() < 0.5)
					bprint (PRINT_MEDIUM," sleeps with the fishes\n");
				else
					bprint (PRINT_MEDIUM," sucks it down\n");
				return;
			}
			else if (rnum == -4)
			{
				if (random() < 0.5)
					bprint (PRINT_MEDIUM," gulped a load of slime\n");
				else
					bprint (PRINT_MEDIUM," can't exist on slime alone\n");
				return;
			}
			else if (rnum == -5)
			{
				if (targ.health < -15)
				{
					bprint (PRINT_MEDIUM," burst into flames\n");
					return;
				}
				if (random() < 0.5)
					bprint (PRINT_MEDIUM," turned into hot slag\n");
				else
					bprint (PRINT_MEDIUM," visits the Volcano God\n");
				return;
			}

			if (attacker.classname == "explo_box")
			{
				bprint (PRINT_MEDIUM," blew up\n");
				return;
			}
			if (targ.deathtype == "falling")
			{
				bprint (PRINT_MEDIUM," fell to his death\n");
				SoundTeam (TEAM_RED, world, "beta1/pancake.wav");
				SoundTeam (TEAM_BLUE, world, "beta1/pancake.wav");
				return;
			}
			if (targ.deathtype == "nail" || targ.deathtype == "supernail")
			{
				bprint (PRINT_MEDIUM," was spiked\n");
				return;
			}
			if (targ.deathtype == "laser")
			{
				bprint (PRINT_MEDIUM," was zapped\n");
				return;
			}
			if (attacker.classname == "fireball")
			{
				bprint (PRINT_MEDIUM," ate a lavaball\n");
				return;
			}
			if (attacker.classname == "trigger_changelevel")
			{
				bprint (PRINT_MEDIUM," tried to leave\n");
				return;
			}

			bprint (PRINT_MEDIUM," died\n");
		}
	}
};


void KillStreak(entity player) =
{
	player.killstreakcount = player.killstreakcount + 1;
	if(player.killstreakcount < 3)
		return;
		
	local string text = "";
	local string file = "";
	
	if(player.killstreakcount == 3)	//killingspree
	{
		text = strcat(player.netname, " is on a \skilling spree\s (3 kills).\n");
		file = "beta1/voice_killingspree.wav";
	}
	if(player.killstreakcount == 4)	//dominating
	{
		text = strcat(player.netname, " is \sdominating\s (4 kills).\n");
		file = "beta1/voice_dominating.wav";
	}
	if(player.killstreakcount == 5)	//megakill
	{
		text = strcat(player.netname, " achieved a \smega kill\s (5 kills).\n");
		file = "beta1/voice_megakill.wav";
	}
	if(player.killstreakcount == 6)	//unstoppable
	{
		text = strcat(player.netname, " is \sunstoppable\s (6 kills).\n");
		file = "beta1/voice_unstoppable.wav";
	}
	if(player.killstreakcount == 7)	//wicked sick? ultrakill
	{
		text = strcat(player.netname, " achieved an \sultra kill\s (7 kills).\n");
		file = "beta1/voice_ultrakill.wav";
	}
	if(player.killstreakcount == 8)	//monster kill
	{
		text = strcat(player.netname, " achieved a \sm-m-monster kill\s (8 kills).\n");
		file = "beta1/voice_monsterkill.wav";
	}
	if(player.killstreakcount == 9)	//godlike
	{
		text = strcat(player.netname, " is \sgodlike\s (9 kills).\n");
		file = "beta1/voice_godlike.wav";
	}
	if(player.killstreakcount >= 10) //holy shit beyond godlike
	{
		text = strcat(player.netname, " is \sbeyond godlike\s (",ftos(player.killstreakcount)," kills).\n");
		file = "beta1/voice_holyshit.wav";
	}
	
	local entity te = find(world, classname, "player");
	while (te) 
	{
		if (infokey(te, "killstreaks") != "0")
		{
			stuffcmd(te, strcat("play ", file, "\n"));
			sprint(te, PRINT_HIGH, text);
		}
		te = find(te, classname, "player");
	}
	
};