
void zPreCache() = 
{
// these are just commands the the prog compiler to copy these files

	precache_file ("progs.dat");
	precache_file ("gfx.wad");
	precache_file ("quake.rc");
	precache_file ("default.cfg");

	precache_file ("end1.bin");
	precache_file2 ("end2.bin");

	precache_file ("demo1.dem");
	precache_file ("demo2.dem");
	precache_file ("demo3.dem");

//
// these are all of the lumps from the cached.ls files
//
	precache_file ("gfx/palette.lmp");
	precache_file ("gfx/colormap.lmp");

	precache_file2 ("gfx/pop.lmp");

	precache_file ("gfx/complete.lmp");
	precache_file ("gfx/inter.lmp");

	precache_file ("gfx/ranking.lmp");
	precache_file ("gfx/vidmodes.lmp");
	precache_file ("gfx/finale.lmp");
	precache_file ("gfx/conback.lmp");
	precache_file ("gfx/qplaque.lmp");

	precache_file ("gfx/menudot1.lmp");
	precache_file ("gfx/menudot2.lmp");
	precache_file ("gfx/menudot3.lmp");
	precache_file ("gfx/menudot4.lmp");
	precache_file ("gfx/menudot5.lmp");
	precache_file ("gfx/menudot6.lmp");

	precache_file ("gfx/menuplyr.lmp");
	precache_file ("gfx/bigbox.lmp");
	precache_file ("gfx/dim_modm.lmp");
	precache_file ("gfx/dim_drct.lmp");
	precache_file ("gfx/dim_ipx.lmp");
	precache_file ("gfx/dim_tcp.lmp");
	precache_file ("gfx/dim_mult.lmp");
	precache_file ("gfx/mainmenu.lmp");
	
	precache_file ("gfx/box_tl.lmp");
	precache_file ("gfx/box_tm.lmp");
	precache_file ("gfx/box_tr.lmp");
	
	precache_file ("gfx/box_ml.lmp");
	precache_file ("gfx/box_mm.lmp");
	precache_file ("gfx/box_mm2.lmp");
	precache_file ("gfx/box_mr.lmp");
	
	precache_file ("gfx/box_bl.lmp");
	precache_file ("gfx/box_bm.lmp");
	precache_file ("gfx/box_br.lmp");
	
	precache_file ("gfx/sp_menu.lmp");
	precache_file ("gfx/ttl_sgl.lmp");
	precache_file ("gfx/ttl_main.lmp");
	precache_file ("gfx/ttl_cstm.lmp");
	
	precache_file ("gfx/mp_menu.lmp");
	
	precache_file ("gfx/netmen1.lmp");
	precache_file ("gfx/netmen2.lmp");
	precache_file ("gfx/netmen3.lmp");
	precache_file ("gfx/netmen4.lmp");
	precache_file ("gfx/netmen5.lmp");
	
	precache_file ("gfx/sell.lmp");
	
	precache_file ("gfx/help0.lmp");
	precache_file ("gfx/help1.lmp");
	precache_file ("gfx/help2.lmp");
	precache_file ("gfx/help3.lmp");
	precache_file ("gfx/help4.lmp");
	precache_file ("gfx/help5.lmp");

	precache_file ("gfx/pause.lmp");
	precache_file ("gfx/loading.lmp");

	precache_file ("gfx/p_option.lmp");
	precache_file ("gfx/p_load.lmp");
	precache_file ("gfx/p_save.lmp");
	precache_file ("gfx/p_multi.lmp");

// sounds loaded by C code
	precache_sound ("misc/menu1.wav");
	precache_sound ("misc/menu2.wav");
	precache_sound ("misc/menu3.wav");

	precache_sound ("ambience/water1.wav");
	precache_sound ("ambience/wind2.wav");

// shareware
	precache_file ("maps/start.bsp");

	precache_file ("maps/e1m1.bsp");
	precache_file ("maps/e1m2.bsp");
	precache_file ("maps/e1m3.bsp");
	precache_file ("maps/e1m4.bsp");
	precache_file ("maps/e1m5.bsp");
	precache_file ("maps/e1m6.bsp");
	precache_file ("maps/e1m7.bsp");
	precache_file ("maps/e1m8.bsp");

// registered
	precache_file2 ("gfx/pop.lmp");

	precache_file2 ("maps/e2m1.bsp");
	precache_file2 ("maps/e2m2.bsp");
	precache_file2 ("maps/e2m3.bsp");
	precache_file2 ("maps/e2m4.bsp");
	precache_file2 ("maps/e2m5.bsp");
	precache_file2 ("maps/e2m6.bsp");
	precache_file2 ("maps/e2m7.bsp");

	precache_file2 ("maps/e3m1.bsp");
	precache_file2 ("maps/e3m2.bsp");
	precache_file2 ("maps/e3m3.bsp");
	precache_file2 ("maps/e3m4.bsp");
	precache_file2 ("maps/e3m5.bsp");
	precache_file2 ("maps/e3m6.bsp");
	precache_file2 ("maps/e3m7.bsp");

	precache_file2 ("maps/e4m1.bsp");
	precache_file2 ("maps/e4m2.bsp");
	precache_file2 ("maps/e4m3.bsp");
	precache_file2 ("maps/e4m4.bsp");
	precache_file2 ("maps/e4m5.bsp");
	precache_file2 ("maps/e4m6.bsp");
	precache_file2 ("maps/e4m7.bsp");
	precache_file2 ("maps/e4m8.bsp");

	precache_file2 ("maps/end.bsp");

	precache_file2 ("maps/dm1.bsp");
	precache_file2 ("maps/dm2.bsp");
	precache_file2 ("maps/dm3.bsp");
	precache_file2 ("maps/dm4.bsp");
	precache_file2 ("maps/dm5.bsp");
	precache_file2 ("maps/dm6.bsp");
	
	//w_precache
	precache_sound ("weapons/r_exp3.wav");  // new rocket explosion
	precache_sound ("weapons/rocket1i.wav");        // spike gun
	precache_sound ("weapons/sgun1.wav");
	precache_sound ("weapons/guncock.wav"); // player shotgun
	precache_sound ("weapons/ric1.wav");    // ricochet (used in c code)
	precache_sound ("weapons/ric2.wav");    // ricochet (used in c code)
	precache_sound ("weapons/ric3.wav");    // ricochet (used in c code)
	precache_sound ("weapons/spike2.wav");  // super spikes
	precache_sound ("weapons/tink1.wav");   // spikes tink (used in c code)
	precache_sound ("weapons/grenade.wav"); // grenade launcher
	precache_sound ("weapons/bounce.wav");          // grenade bounce
	precache_sound ("weapons/shotgn2.wav"); // super shotgun
	// sounds used from C physics code
	precache_sound ("demon/dland2.wav");            // landing thud
	precache_sound ("misc/h2ohit1.wav");            // landing splash

// setup precaches allways needed
	precache_sound ("items/itembk2.wav");           // item respawn sound
	precache_sound ("player/plyrjmp8.wav");         // player jump
	precache_sound ("player/land.wav");                     // player landing
	precache_sound ("player/land2.wav");            // player hurt landing
	precache_sound ("player/drown1.wav");           // drowning pain
	precache_sound ("player/drown2.wav");           // drowning pain
	precache_sound ("player/gasp1.wav");            // gasping for air
	precache_sound ("player/gasp2.wav");            // taking breath
	precache_sound ("player/h2odeath.wav");         // drowning death

	precache_sound ("misc/talk.wav");                       // talk
	precache_sound ("player/teledth1.wav");         // telefrag
	precache_sound ("misc/r_tele1.wav");            // teleport sounds
	precache_sound ("misc/r_tele2.wav");
	precache_sound ("misc/r_tele3.wav");
	precache_sound ("misc/r_tele4.wav");
	precache_sound ("misc/r_tele5.wav");
	precache_sound ("weapons/lock4.wav");           // ammo pick up
	precache_sound ("weapons/pkup.wav");            // weapon up
	precache_sound ("items/armor1.wav");            // armor up
	precache_sound ("weapons/lhit.wav");            //lightning
	precache_sound ("weapons/lstart.wav");          //lightning start
	precache_sound ("items/damage3.wav");

	precache_sound ("misc/power.wav");                      //lightning for boss

// player gib sounds
	precache_sound ("player/gib.wav");                      // player gib sound
	precache_sound ("player/udeath.wav");           // player gib sound
	precache_sound ("player/tornoff2.wav");         // gib sound

// player pain sounds

	precache_sound ("player/pain1.wav");
	precache_sound ("player/pain2.wav");
	precache_sound ("player/pain3.wav");
	precache_sound ("player/pain4.wav");
	precache_sound ("player/pain5.wav");
	precache_sound ("player/pain6.wav");

// player death sounds
	precache_sound ("player/death1.wav");
	precache_sound ("player/death2.wav");
	precache_sound ("player/death3.wav");
	precache_sound ("player/death4.wav");
	precache_sound ("player/death5.wav");

	precache_sound ("boss1/sight1.wav");

// ax sounds    
	precache_sound ("weapons/ax1.wav");                     // ax swoosh
	precache_sound ("player/axhit1.wav");           // ax hit meat
	precache_sound ("player/axhit2.wav");           // ax hit world

	precache_sound ("player/h2ojump.wav");          // player jumping into water
	precache_sound ("player/slimbrn2.wav");         // player enter slime
	precache_sound ("player/inh2o.wav");            // player enter water
	precache_sound ("player/inlava.wav");           // player enter lava
	precache_sound ("misc/outwater.wav");           // leaving water sound

	precache_sound ("player/lburn1.wav");           // lava burn
	precache_sound ("player/lburn2.wav");           // lava burn

	precache_sound ("misc/water1.wav");                     // swimming
	precache_sound ("misc/water2.wav");                     // swimming

// Invulnerability sounds
	precache_sound ("items/protect.wav");
	precache_sound ("items/protect2.wav");
	precache_sound ("items/protect3.wav");


	precache_model ("progs/player.mdl");
	precache_model ("progs/eyes.mdl");
	precache_model ("progs/h_player.mdl");
	precache_model ("progs/gib1.mdl");
	precache_model ("progs/gib2.mdl");
	precache_model ("progs/gib3.mdl");

	precache_model ("progs/s_bubble.spr");  // drowning bubbles
	precache_model ("progs/s_explod.spr");  // sprite explosion

	precache_model ("progs/v_axe.mdl");
	precache_model ("progs/v_shot.mdl");
	precache_model ("progs/v_nail.mdl");
	precache_model ("progs/v_rock.mdl");
	precache_model ("progs/v_shot2.mdl");
	precache_model ("progs/v_nail2.mdl");
	precache_model ("progs/v_rock2.mdl");

	precache_model ("progs/bolt.mdl");              // for lightning gun
	precache_model ("progs/bolt2.mdl");             // for lightning gun
	precache_model ("progs/bolt3.mdl");             // for boss shock
	precache_model ("progs/lavaball.mdl");  	// for testing
	
	precache_model ("progs/missile.mdl");
	precache_model ("progs/grenade.mdl");
	precache_model ("progs/spike.mdl");
	precache_model ("progs/s_spike.mdl");

	precache_model ("progs/backpack.mdl");
	precache_model ("progs/armor.mdl");

	precache_model ("progs/zom_gib.mdl");

	precache_model ("progs/v_light.mdl");
	
	
	//MCP
	
	//MODELS

	//misc
	
	precache_model (FPATH_PLAYERMDL);

	precache_model("progs/beta1/mcp_flag.mdl");
	precache_model("progs/beta1/mcp_armourshard.mdl");
	precache_model("progs/beta1/mcp_healthpack.mdl");
	
	//projectiles
	precache_model("progs/beta1/mcp_missile.mdl");
	precache_model("progs/beta1/mcp_nail.mdl");
	
	precache_model("progs/beta1/mcp_sticky.mdl");
	precache_model("progs/beta1/mcp_pinebig.mdl");
	precache_model("progs/beta1/mcp_pinesmall.mdl");
	precache_model("progs/beta1/mcp_c4.mdl");
	
	precache_model("progs/beta1/mcp_teleball.mdl");
	precache_model("progs/beta1/mcp_harpoon.mdl");


	precache_model("progs/beta1/mcp_gren_flash.mdl");
	precache_model("progs/beta1/mcp_gren_frag.mdl");
	precache_model("progs/beta1/mcp_gren_leech.mdl");
	precache_model("progs/beta1/mcp_gren_airblast.mdl");
	precache_model("progs/beta1/mcp_gren_beartrap_open.mdl");
	precache_model("progs/beta1/mcp_gren_beartrap_shut.mdl");
	
	//view weapons
	precache_model("progs/beta1/wpn/grey_axe.mdl");
	precache_model("progs/beta1/wpn/blue_axe.mdl");
	precache_model("progs/beta1/wpn/red_axe.mdl");
	precache_model("progs/beta1/wpn/grey_shotgun.mdl");
	precache_model("progs/beta1/wpn/blue_shotgun.mdl");
	precache_model("progs/beta1/wpn/red_shotgun.mdl");
	precache_model("progs/beta1/wpn/grey_supershotgun.mdl");
	precache_model("progs/beta1/wpn/blue_supershotgun.mdl");
	precache_model("progs/beta1/wpn/red_supershotgun.mdl");
	precache_model("progs/beta1/wpn/grey_railgun.mdl");
	precache_model("progs/beta1/wpn/blue_railgun.mdl");
	precache_model("progs/beta1/wpn/red_railgun.mdl");
	precache_model("progs/beta1/wpn/blue_supernailgun.mdl");
	precache_model("progs/beta1/wpn/red_supernailgun.mdl");
	precache_model("progs/beta1/wpn/blue_rocketlauncher.mdl");
	precache_model("progs/beta1/wpn/red_rocketlauncher.mdl");
	precache_model("progs/beta1/wpn/blue_pipelauncher.mdl");
	precache_model("progs/beta1/wpn/red_pipelauncher.mdl");
	precache_model("progs/beta1/wpn/blue_shaft.mdl");
	precache_model("progs/beta1/wpn/red_shaft.mdl");
	precache_model("progs/beta1/wpn/blue_minigun.mdl");
	precache_model("progs/beta1/wpn/red_minigun.mdl");
	
	//sprites
	precache_model("progs/beta1/s_mcp.spr");
	precache_model("progs/beta1/mcp_flagtrail.spr");
	precache_model("progs/beta1/mcp_dmgnum512.spr");
	precache_model("progs/beta1/mcp_dmgnum999.spr");
	precache_model("progs/beta1/mcp_pingt1.spr");
	
	//SOUND
	
	//events
	precache_sound("beta1/voice_1.wav");
	precache_sound("beta1/voice_2.wav");
	precache_sound("beta1/voice_3.wav");
	precache_sound("beta1/voice_4.wav");
	precache_sound("beta1/voice_5.wav");
	precache_sound("beta1/voice_youwin.wav");
	precache_sound("beta1/voice_youlose.wav");
	precache_sound("beta1/voice_fight.wav");
	precache_sound("beta1/voice_blueleads.wav");
	precache_sound("beta1/voice_redleads.wav");
	//precache_sound("beta1/mlg.wav");
	//precache_sound("beta1/oof.wav");
	precache_sound("beta1/thomas.wav");
	precache_sound("beta1/insideout.wav");
	precache_sound("beta1/alert.wav");
	precache_sound("beta1/markplayer.wav");
	
	precache_sound("beta1/voice_enemyhasflag.wav");
	precache_sound("beta1/voice_teamhasflag.wav");
	precache_sound("beta1/voice_youhaveflag.wav");
	precache_sound("beta1/voice_teamstied.wav");
	precache_sound("beta1/voice_flawless.wav");
	precache_sound("beta1/voice_yousuck.wav");
	precache_sound("beta1/voice_bluescores.wav");
	precache_sound("beta1/voice_redscores.wav");
	precache_sound("beta1/voice_combowhore.wav");
	precache_sound("beta1/voice_killingspree.wav");
	precache_sound("beta1/voice_dominating.wav");
	precache_sound("beta1/voice_megakill.wav");
	precache_sound("beta1/voice_unstoppable.wav");
	precache_sound("beta1/voice_ultrakill.wav");
	precache_sound("beta1/voice_monsterkill.wav");
	precache_sound("beta1/voice_godlike.wav");
	precache_sound("beta1/voice_holyshit.wav");
	precache_sound("beta1/voice_impressive.wav");
	precache_sound("beta1/voice_accuracy.wav");
	precache_sound("beta1/voice_midair1.wav");
	precache_sound("beta1/voice_midair2.wav");
	precache_sound("beta1/voice_midair3.wav");
	
	precache_sound("beta1/humiliation.wav");
	precache_sound("beta1/toasty.wav");
	precache_sound("beta1/gbuster.wav");
	precache_sound("beta1/pancake.wav");
	
	precache_sound("beta1/pacman.wav");
	
	precache_sound("beta1/buzzer.wav");
	precache_sound("beta1/scoretick_team.wav");
	precache_sound("beta1/scoretick_enemy.wav");
	precache_sound("beta1/flagevent.wav");
	precache_sound("beta1/boo.wav");
	precache_sound("beta1/clap.wav");
	
	//readyup
	precache_sound("beta1/hurryup1.wav");
	precache_sound("beta1/hurryup2.wav");
	precache_sound("beta1/ready.wav");
	precache_sound("beta1/notready.wav");
	precache_sound("beta1/readyall.wav");
	
	//items
	precache_sound("beta1/pickup_armour.wav");
	precache_sound("beta1/pickup_health.wav");
	precache_sound("beta1/pickup_gren.wav");
	
	//reloads
	precache_sound("beta1/reload_rocket.wav");		//rckclip
	precache_sound("beta1/reload_sticky.wav");		//rckclip
	precache_sound("beta1/reload_shotgun.wav");		//shell_in
	precache_sound("beta1/reload_supershotgun.wav");	//shelpk1
	precache_sound("beta1/reload_supernailgun.wav");	//DSGRLOAD
	precache_sound("beta1/reload_shaft.wav");		//DSITEMUP
	precache_sound("beta1/reload_railgun.wav");
	precache_sound("beta1/reload_minigun.wav");
	
	//specials
	precache_sound("beta1/dash.wav");		//KICK
	precache_sound("beta1/detsticky.wav");
	precache_sound("beta1/beartrap_shut.wav");
	precache_sound("beta1/beartrap_open.wav");
	precache_sound("beta1/beartrap_break.wav");
	precache_sound("beta1/specialready_recon.wav");	//BEP
	precache_sound("beta1/specialready_assassin.wav");
	precache_sound("beta1/specialready_support.wav");
	precache_sound("beta1/specialready_fighter.wav");	
	precache_sound("beta1/specialready_bomber.wav");
	precache_sound("beta1/chargeready.wav");
	precache_sound("beta1/charge.wav");
	
	precache_sound("beta1/regenhealth.wav");
	precache_sound("beta1/regenarmour.wav");
	precache_sound("beta1/regenhealtharmour.wav");
	
	precache_sound("beta1/killsound.wav");
	precache_sound("beta1/killsound_team.wav");
	precache_sound("beta1/hitsound.wav");
	precache_sound("beta1/hitsound_crit.wav");
	precache_sound("beta1/hitsound_team.wav");
	precache_sound("beta1/healsound.wav");
	
	precache_sound("beta1/hitsound_rail0.wav");
	precache_sound("beta1/hitsound_rail1.wav");
	precache_sound("beta1/hitsound_rail2.wav");
	precache_sound("beta1/hitsound_rail3.wav");
	
	precache_sound("beta1/airblast_shoot.wav");
	precache_sound("beta1/cloak.wav");
	precache_sound("beta1/uncloak.wav");
	precache_sound("beta1/grenade_flash.wav");
	precache_sound("beta1/teleball_start.wav");
	precache_sound("beta1/teleball_end.wav");
	precache_sound("beta1/teleball_idle.wav");
	precache_sound("beta1/teleball_idle2.wav");
	precache_sound("beta1/grenade_leech.wav");
	precache_sound("beta1/sticky.wav");			//ROCKPKUP
	precache_sound("beta1/railgun.wav");
	precache_sound("beta1/error.wav");
	precache_sound("beta1/notice.wav");
	precache_sound("beta1/armour_break.wav");
	precache_sound("beta1/shaft_heal.wav");
	precache_sound("beta1/gstomp_hurt.wav");
	precache_sound("beta1/gstomp_kill.wav");
	precache_sound("beta1/harpoon_enemy1.wav");
	precache_sound("beta1/harpoon_enemy2.wav");
	precache_sound("beta1/harpoon_throw.wav");
	precache_sound("beta1/harpoon_hitmeat.wav");
	
	precache_sound("beta1/c4_throw.wav");
	precache_sound("beta1/c4_detonate.wav");
	precache_sound("beta1/c4_explode.wav");
	precache_sound("beta1/c4_armed.wav");
	
	precache_sound("beta1/minigun_spinup.wav");
	precache_sound("beta1/minigun_spindown.wav");
	precache_sound("beta1/minigun_spin.wav");
	precache_sound("beta1/minigun_shoot.wav");
	
	//grentimers
	precache_sound("beta1/mcp_grentimer1.wav");
	precache_sound("beta1/mcp_grentimer2.wav");
	precache_sound("beta1/mcp_grentimer3.wav");
	precache_sound("beta1/mcp_grentimer4.wav");
	precache_sound("beta1/mcp_grentimer5.wav");
	precache_sound("beta1/mcp_grentimer6.wav");
	precache_sound("beta1/mcp_grentimer7.wav");
	precache_sound("beta1/mcp_grentimer8.wav");
	precache_sound("beta1/mcp_grentimer9.wav");
	precache_sound("beta1/mcp_grentimer10.wav");
	precache_sound("beta1/mcp_grentimer11.wav");
	precache_sound("beta1/mcp_grentimer12.wav");
	precache_sound("beta1/mcp_grentimer13.wav");
	precache_sound("beta1/mcp_grentimer14.wav");
	precache_sound("beta1/mcp_grentimer15.wav");
	precache_sound("beta1/mcp_grentimer16.wav");
	precache_sound("beta1/mcp_grentimer17.wav");
	precache_sound("beta1/mcp_grentimer18.wav");
	precache_sound("beta1/mcp_grentimer19.wav");
	precache_sound("beta1/mcp_grentimer20.wav");
	precache_sound("beta1/mcp_grentimer21.wav");
	precache_sound("beta1/mcp_grentimer22.wav");
	precache_sound("beta1/mcp_grentimer23.wav");
	precache_sound("beta1/mcp_grentimer24.wav");
	precache_sound("beta1/mcp_grentimer25.wav");
	precache_sound("beta1/mcp_grentimer26.wav");
	
	


};