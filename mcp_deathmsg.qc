
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

		if (attacker.classname == "teledeath")
		{

			//bprint (PRINT_MEDIUM,targ.netname);
			if(targ.team_no == attacker.team_no)
			{
				//bprint (PRINT_MEDIUM," was telefragged by teammate ");
				bprint (PRINT_MEDIUM,strcat(targ.netname," was telefragged by teammate ",attacker.owner.netname,"\n"));
			}
			else
			{
				bprint (PRINT_MEDIUM,strcat(targ.netname," was telefragged by ",attacker.owner.netname,"\n"));
				KillStreak(attacker.owner);
				SoundTeam (TEAM_RED, world, "beta1/insideout.wav");
				SoundTeam (TEAM_BLUE, world, "beta1/insideout.wav");
				AddStat(attacker.owner, STAT_SPECIALKILL, ROLE_SUPPORT);
				AddStat(targ, STAT_DEATH, 1);
			}
				
			//bprint (PRINT_MEDIUM,attacker.owner.netname);
			//bprint (PRINT_MEDIUM,"\n");
			KillSound(targ,attacker);
			//logfrag (attacker.owner, targ);

			//attacker.owner.frags = attacker.owner.frags + 1;
			return;
		}

//		if (attacker.classname == "teledeath2")
//		{
//			bprint (PRINT_MEDIUM,"Satan's power deflects ");
//			bprint (PRINT_MEDIUM,targ.netname);
//			bprint (PRINT_MEDIUM,"'s telefrag\n");
//
//			//targ.frags = targ.frags - 1;
//			//logfrag (targ, targ);
//			return;
//		}
//
//		// double 666 telefrag (can happen often in deathmatch 4)
//		if (attacker.classname == "teledeath3") 
//		{
//			bprint (PRINT_MEDIUM,targ.netname);
//			bprint (PRINT_MEDIUM," was telefragged by ");
//			bprint (PRINT_MEDIUM,attacker.owner.netname);
//			bprint (PRINT_MEDIUM, "'s Satan's power\n");
//			//targ.frags = targ.frags - 1;
//			//logfrag (targ, targ);
//			return;
//		}
	

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

				
				AddStat(attacker, STAT_SUICIDE, 1);

				
			
				//CLASS GRENADES

				//ass											
				if (targ.deathtype == "grenade_flash")
					bprint (PRINT_MEDIUM,strcat(targ.netname, " was incinerated by their own flash grenade\n"));

					
				//fig
				else if (targ.deathtype == "grenade_frag")
					bprint (PRINT_MEDIUM,strcat(targ.netname, " regrets using a frag grenade\n"));
					
				//bomb
				else if (targ.deathtype == "grenade_marker")
					bprint (PRINT_MEDIUM,strcat(targ.netname, " accidentally marked themself\n"));

								
				//supp
				else if (targ.deathtype == "grenade_leech")
					bprint (PRINT_MEDIUM,strcat(targ.netname, " succumbed to their own leeches\n"));	
				
				
				//CLASS WEAPONS 1-4
				//fighter
				else if (targ.deathtype == "rocket")
					bprint (PRINT_MEDIUM,strcat(targ.netname, " becomes bored with life\n"));
				else if (targ.deathtype == "rocket_direct")
					bprint (PRINT_MEDIUM,strcat(targ.netname, " becomes bored with life\n"));
				else if (targ.deathtype == "rocket_directharp")
					bprint (PRINT_MEDIUM,strcat(targ.netname, " becomes bored with life\n"));	
				//bomber 
				else if (targ.deathtype == "clusterbig_direct")
					bprint (PRINT_MEDIUM,strcat(targ.netname, " ate his own pineapple\n"));
				else if (targ.deathtype == "clustermini_direct")
					bprint (PRINT_MEDIUM,strcat(targ.netname, " ate his own pineapple\n"));
				else if (targ.deathtype == "clustermini_aoe")
					bprint (PRINT_MEDIUM,strcat(targ.netname, " ate his own pineapple\n"));	

				
				//CLASS SPECIALS
				//bomber
				else if (targ.deathtype == "c4")
					bprint (PRINT_MEDIUM,strcat(targ.netname, " set the detpack and forgot to run\n"));


				else
					bprint (PRINT_MEDIUM,strcat(targ.netname, " hates life\n"));
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

				return;
			}
			else
			{

				KillStreak(attacker);
				rnum = attacker.weapon;
				
				//MISC
				if (targ.deathtype == "goomba_stomp")
				{
					deathstring = " was goomba stomped by ";
					deathstring2 = "\n" ;
					SoundTeam (TEAM_RED, world, "beta1/gstomp_kill.wav");
					SoundTeam (TEAM_BLUE, world, "beta1/gstomp_kill.wav");
					AddStat(attacker, STAT_STOMPKILL, attacker.role);
					AddStat(targ, STAT_DEATH, 1);
				}
				
				//GRENADES
				else if (targ.deathtype == "grenade_flash")
				{
					deathstring = " is charred by ";
					deathstring2 = "'s flash grenade\n" ;
					SoundTeam (TEAM_RED, world, "beta1/toasty.wav");
					SoundTeam (TEAM_BLUE, world, "beta1/toasty.wav");
					AddStat(attacker, STAT_GRENKILL, ROLE_ASSASSIN);
					AddStat(targ, STAT_DEATH, 1);
				}
				else if (targ.deathtype == "grenade_frag")
				{
					deathstring = " played catch with ";
					deathstring2 = "'s frag grenade\n" ;
					AddStat(attacker, STAT_GRENKILL, ROLE_FIGHTER);
					AddStat(targ, STAT_DEATH, 1);
				
				}
				else if (targ.deathtype == "grenade_marker")
				{
					deathstring = " couldnt handle being marked by ";
					deathstring2 ="'s marker grenade\n" ;
					AddStat(attacker, STAT_GRENKILL, ROLE_BOMBER);
					AddStat(targ, STAT_DEATH, 1);
					
				}
				else if (targ.deathtype == "grenade_leech")
				{
					deathstring = " was sucked dry by ";
					deathstring2 = "'s leech grenade\n" ;
					AddStat(attacker, STAT_GRENKILL, ROLE_SUPPORT);
					AddStat(targ, STAT_DEATH, 1);
				}
				
				//SPECIALS
				else if (targ.deathtype == "harpoon")
				{
					deathstring = " was harpooned by ";
					deathstring2 = "\n";
					SoundTeam (TEAM_RED, world, "beta1/humiliation.wav");
					SoundTeam (TEAM_BLUE, world, "beta1/humiliation.wav");
					AddStat(attacker, STAT_SPECIALKILL, ROLE_FIGHTER);
					AddStat(targ, STAT_DEATH, 1);
				}
				else if (targ.deathtype == "c4")
				{
					deathstring = " reaches orbit via ";
					deathstring2 = "'s detpack\n";
					AddStat(attacker, STAT_SPECIALKILL, ROLE_BOMBER);
					AddStat(targ, STAT_DEATH, 1);
				}
				else if (targ.deathtype == "shouldercharge")
				{
					deathstring = " was shoulder charged by ";
					deathstring2 = "\n" ;
					SoundTeam (TEAM_RED, world, "beta1/thomas.wav");
					SoundTeam (TEAM_BLUE, world, "beta1/thomas.wav");
					AddStat(attacker, STAT_SPECIALKILL, ROLE_MGUNNER);
					AddStat(targ, STAT_DEATH, 1);

				}
				
				//WEAPONS 1-4
				//MELEE
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
					AddStat(attacker, STAT_MELEEKILL, attacker.role);
					AddStat(targ, STAT_DEATH, 1);
				}
				
				//SHOTGUN
				else if (rnum == WPN_SHOTGUN)
				{
					deathstring = " chewed on ";
					deathstring2 = "'s boomstick\n";
					
					AddStat(attacker, STAT_TERTIARYKILL, attacker.role);
					AddStat(targ, STAT_DEATH, 1);

				}
				
				//SUPERSHOTGUN
				else if (rnum == WPN_SUPERSHOTGUN)
				{
					deathstring = " ate 2 loads of ";
					deathstring2 = "'s buckshot\n";
					AddStat(attacker, STAT_SECONDARYKILL, attacker.role);
					AddStat(targ, STAT_DEATH, 1);
				}

				//PRIMARY
				//recon
				else if (targ.deathtype == "supernail")
				{
					deathstring = " was punctured by ";
					deathstring2 = "\n";
					AddStat(attacker, STAT_PRIMARYKILL, ROLE_RECON);
					AddStat(targ, STAT_DEATH, 1);
				}
				//assassin
				else if (rnum == WPN_RAILGUN)
				{
					if(attacker.heat == 3)
					{
						deathstring = " was railed by ";
						deathstring2 = " (3x)\n";
					}
					else if (attacker.heat == 2)
					{
						deathstring = " was railed by ";
						deathstring2 = " (2x)\n";
					}
					else
					{
						deathstring = " was railed by ";
						deathstring2 = "\n";
					}
					AddStat(attacker, STAT_PRIMARYKILL, ROLE_ASSASSIN);
					AddStat(targ, STAT_DEATH, 1);
				}
				//figher
				else if (targ.deathtype == "rocket")
				{
					deathstring = " rides ";
					deathstring2 = "'s rocket\n";
					AddStat(attacker, STAT_PRIMARYKILL, ROLE_FIGHTER);
					AddStat(targ, STAT_DEATH, 1);

				}
				else if (targ.deathtype == "rocket_direct")
				{
					deathstring = " eats a direct rocket from ";
					deathstring2 = "\n";
					AddStat(attacker, STAT_PRIMARYKILL, ROLE_FIGHTER);
					AddStat(targ, STAT_DEATH, 1);
				}
				else if (targ.deathtype == "rocket_directharp")
				{
					deathstring = " was combo'd by ";
					deathstring2 = "\n";
					SoundTeam (TEAM_RED, world, "beta1/voice_combowhore.wav");
					SoundTeam (TEAM_BLUE, world, "beta1/voice_combowhore.wav");
					AddStat(attacker, STAT_HARPOONCOMBOKILL, 1);
					AddStat(targ, STAT_DEATH, 1);
				}
				//bomber
				else if (targ.deathtype == "clusterbig_direct")
				{
					deathstring = " caught a direct pineapple from ";
					deathstring2 = "\n" ;
					AddStat(attacker, STAT_PRIMARYKILL,ROLE_BOMBER);
					AddStat(targ, STAT_DEATH, 1);

				}
				else if (targ.deathtype == "clustermini_direct")
				{
					deathstring = " caught a direct mini-pineapple from ";
					deathstring2 = "\n" ;
					AddStat(attacker, STAT_PRIMARYKILL, ROLE_BOMBER);
					AddStat(targ, STAT_DEATH, 1);
				}

				else if (targ.deathtype == "clustermini_aoe")
				{
					deathstring = " succumbed to ";
					deathstring2 = "'s mini-pineapple spam\n" ;
					AddStat(attacker, STAT_PRIMARYKILL, ROLE_BOMBER);
					AddStat(targ, STAT_DEATH, 1);
				}
				//support
				else if (rnum == WPN_SHAFT)
				{
					deathstring = " accepts ";
					deathstring2 = "'s shaft\n";
					AddStat(attacker, STAT_PRIMARYKILL, ROLE_SUPPORT);
					AddStat(targ, STAT_DEATH, 1);
				}
				//minigunner
				else if (rnum == WPN_MINIGUN)
				{
					deathstring = " was gunned down by ";
					deathstring2 = "'s minigun\n";
					AddStat(attacker, STAT_PRIMARYKILL, ROLE_MGUNNER);
					AddStat(targ, STAT_DEATH, 1);
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
			AddStat(targ, STAT_WORLDDEATH, 1);
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
	AddStat(player, STAT_KILLSTREAK, player.killstreakcount);

		
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