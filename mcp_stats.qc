



string PrintFlagStats(entity e) =
{
	
	//sprint(e, PRINT_HIGH, strcat(strpad(25, "flags captured:"), strpad(-4,ftos(e.playerstats.flagcaps))      ,      "\n"));
	//sprint(e, PRINT_HIGH, strcat(strpad(25, "flags touched:"), strpad(-4,ftos(e.playerstats.flagtouches))      ,      "\n"));
	//sprint(e, PRINT_HIGH, strcat(strpad(25, "flags stolen:"), strpad(-4,ftos(e.playerstats.flagsteals))      ,      "\n"));
	//sprint(e, PRINT_HIGH, strcat(strpad(25, "flags thrown:"), strpad(-4,ftos(e.playerstats.flagthrows))      ,      "\n"));
	//sprint(e, PRINT_HIGH, strcat(strpad(25, "died carrying flag:"), strpad(-4,ftos(e.playerstats.flagdeaths))      ,      "\n"));
	//sprint(e, PRINT_HIGH, strcat(strpad(25, "flag carriers killed:"), strpad(-4,ftos(e.playerstats.flagsacks))      ,      "\n"));
	//sprint(e, PRINT_HIGH, strcat(strpad(25, "flag trail eaten:"), strpad(-4,ftos(e.playerstats.flagtrailtouches))      ,      "\n"));
	//sprint(e, PRINT_HIGH, "\n");
	
	local string result = "";
	result = strcat(result,strpad(25, "flags captured:"), strpad(-4,ftos(e.playerstats.flagcaps))      ,      "\n");
	result = strcat(result,strpad(25, "flags touched:"), strpad(-4,ftos(e.playerstats.flagtouches))      ,      "\n");
	result = strcat(result,strpad(25, "flags stolen:"), strpad(-4,ftos(e.playerstats.flagsteals))      ,      "\n");
	result = strcat(result,strpad(25, "flags thrown:"), strpad(-4,ftos(e.playerstats.flagthrows))      ,      "\n");
	result = strcat(result,strpad(25, "died carrying flag:"), strpad(-4,ftos(e.playerstats.flagdeaths))      ,      "\n");
	result = strcat(result,strpad(25, "flag carriers killed:"), strpad(-4,ftos(e.playerstats.flagsacks))      ,      "\n");
	result = strcat(result,strpad(25, "flag trail eaten:"), strpad(-4,ftos(e.playerstats.flagtrailtouches))      ,      "\n");
	result = strcat(result, "\n");
	//sprint(e, PRINT_HIGH, result);
	return result;
};

string PrintGrenStats(entity e) =
{
	local string shattergren, flashgren, fraggren, markergren, leechgren, pushupgren;
	local float hits, shots, perc, kills;
	
	local string s_hits;
	local string s_shots;
	local string s_perc;
	local string percsuffix = "% ";
	local string killssuffix = " kills";
	local string s_kills;
	local string statname;
	local string weapname;

	local float p_title = 16;	//15
	local float p_hits = -6;
	local float p_shots = 6;
	local float p_perc = -6;
	local float p_kills = -10;
	
	//shattergren
	statname = strpad(p_title,"shatter gren:");
	hits = e.weapstats[ROLE_RECON].grenhits;
	shots = e.weapstats[ROLE_RECON].grenprimes;
	kills = e.weapstats[ROLE_RECON].grenkills;	
	if(shots == 0)
		perc = 0;
	else
		perc = rint(hits/shots * 100);
	
	if(shots == 0)
		perc = 0;
	else
		perc = rint(hits/shots * 100);
		
	s_hits = strpad(p_hits,ftos(hits));
	s_shots = strpad(p_shots,ftos(shots));
	s_perc = strpad(p_perc,strcat(ftos(perc),percsuffix));
	s_kills = strpad(p_kills,strcat(ftos(kills), killssuffix));
	
	shattergren = strcat(statname, s_hits,"/",s_shots,s_perc,s_kills);
	
	//flashgren
	statname = strpad(p_title,"flash gren:");
	hits = e.weapstats[ROLE_ASSASSIN].grenhits;
	shots = e.weapstats[ROLE_ASSASSIN].grenprimes;
	kills = e.weapstats[ROLE_ASSASSIN].grenkills;	
	if(shots == 0)
		perc = 0;
	else
		perc = rint(hits/shots * 100);
	
	if(shots == 0)
		perc = 0;
	else
		perc = rint(hits/shots * 100);
		
	s_hits = strpad(p_hits,ftos(hits));
	s_shots = strpad(p_shots,ftos(shots));
	s_perc = strpad(p_perc,strcat(ftos(perc),percsuffix));
	s_kills = strpad(p_kills,strcat(ftos(kills), killssuffix));
	
	flashgren = strcat(statname, s_hits,"/",s_shots,s_perc,s_kills);
	
	//fraggren
	statname = strpad(p_title,"frag gren:");
	hits = e.weapstats[ROLE_FIGHTER].grenhits;
	shots = e.weapstats[ROLE_FIGHTER].grenprimes;
	kills = e.weapstats[ROLE_FIGHTER].grenkills;	
	if(shots == 0)
		perc = 0;
	else
		perc = rint(hits/shots * 100);
	
	if(shots == 0)
		perc = 0;
	else
		perc = rint(hits/shots * 100);
		
	s_hits = strpad(p_hits,ftos(hits));
	s_shots = strpad(p_shots,ftos(shots));
	s_perc = strpad(p_perc,strcat(ftos(perc),percsuffix));
	s_kills = strpad(p_kills,strcat(ftos(kills), killssuffix));
	
	fraggren = strcat(statname, s_hits,"/",s_shots,s_perc,s_kills);
	
	//markergren
	statname = strpad(p_title,"marker gren:");
	hits = e.weapstats[ROLE_BOMBER].grenhits;
	shots = e.weapstats[ROLE_BOMBER].grenprimes;
	kills = e.weapstats[ROLE_BOMBER].grenkills;	
	if(shots == 0)
		perc = 0;
	else
		perc = rint(hits/shots * 100);
	
	if(shots == 0)
		perc = 0;
	else
		perc = rint(hits/shots * 100);
		
	s_hits = strpad(p_hits,ftos(hits));
	s_shots = strpad(p_shots,ftos(shots));
	s_perc = strpad(p_perc,strcat(ftos(perc),percsuffix));
	s_kills = strpad(p_kills,strcat(ftos(kills), killssuffix));
	
	markergren = strcat(statname, s_hits,"/",s_shots,s_perc,s_kills);
	
	//leechgren
	statname = strpad(p_title,"leech gren:");
	hits = e.weapstats[ROLE_SUPPORT].grenhits;
	shots = e.weapstats[ROLE_SUPPORT].grenprimes;
	kills = e.weapstats[ROLE_SUPPORT].grenkills;	
	if(shots == 0)
		perc = 0;
	else
		perc = rint(hits/shots * 100);
	
	if(shots == 0)
		perc = 0;
	else
		perc = rint(hits/shots * 100);
		
	s_hits = strpad(p_hits,ftos(hits));
	s_shots = strpad(p_shots,ftos(shots));
	s_perc = strpad(p_perc,strcat(ftos(perc),percsuffix));
	s_kills = strpad(p_kills,strcat(ftos(kills), killssuffix));
	
	leechgren = strcat(statname, s_hits,"/",s_shots,s_perc,s_kills);
	
	//pushupgren
	statname = strpad(p_title,"pushup gren:");
	hits = e.weapstats[ROLE_MGUNNER].grenhits;
	shots = e.weapstats[ROLE_MGUNNER].grenprimes;
	kills = e.weapstats[ROLE_MGUNNER].grenkills;	
	if(shots == 0)
		perc = 0;
	else
		perc = rint(hits/shots * 100);
	
	if(shots == 0)
		perc = 0;
	else
		perc = rint(hits/shots * 100);
		
	s_hits = strpad(p_hits,ftos(hits));
	s_shots = strpad(p_shots,ftos(shots));
	s_perc = strpad(p_perc,strcat(ftos(perc),percsuffix));
	s_kills = strpad(p_kills,strcat(ftos(kills), killssuffix));
	
	pushupgren = strcat(statname, s_hits,"/",s_shots,s_perc,s_kills);
	
	local string result2 = "";
	result2 = strcat(result2,shattergren,"\n");
	result2 = strcat(result2,flashgren,"\n");
	result2 = strcat(result2,fraggren,"\n");
	result2 = strcat(result2,markergren,"\n");
	result2 = strcat(result2,leechgren,"\n");
	result2 = strcat(result2,pushupgren,"\n");
	result2 = strcat(result2,"\n");
	return result2;
	
};

string PrintWeaponStats(entity e) =
{
	local string sng, rail, rl, gl, shaft, mgun;
	
	local float hits, shots, perc, kills;
	
	local string ssg, shotgun, melee;

	//local string gren;
	//local string special;

	local string s_hits;
	local string s_shots;
	local string s_perc;
	local string percsuffix = "% ";
	local string killssuffix = " kills";
	local string s_kills;
	local string statname;
	local string weapname;

	local float p_title = 16;	//15
	local float p_hits = -6;
	local float p_shots = 6;
	local float p_perc = -6;
	local float p_kills = -10;
	//sng
	statname = strpad(p_title,"supernailgun:");
	hits = e.weapstats[ROLE_RECON].primaryhits;
	shots = e.weapstats[ROLE_RECON].primaryshots;
	kills = e.weapstats[ROLE_RECON].primarykills;
	if(shots == 0)
		perc = 0;
	else
		perc = rint(hits/shots * 100);
		
	s_hits = strpad(p_hits,ftos(hits));
	s_shots = strpad(p_shots,ftos(shots));
	s_perc = strpad(p_perc,strcat(ftos(perc),percsuffix));
	s_kills = strpad(p_kills,strcat(ftos(kills), killssuffix));
	
	sng = strcat(statname, s_hits,"/",s_shots,s_perc,s_kills);
	
	//rail
	statname = strpad(p_title,"railgun:");
	hits = e.weapstats[ROLE_ASSASSIN].primaryhits;
	shots = e.weapstats[ROLE_ASSASSIN].primaryshots;
	kills = e.weapstats[ROLE_ASSASSIN].primarykills;
	
	if(shots == 0)
		perc = 0;
	else
		perc = rint(hits/shots * 100);
		
	s_hits = strpad(p_hits,ftos(hits));
	s_shots = strpad(p_shots,ftos(shots));
	s_perc = strpad(p_perc,strcat(ftos(perc),percsuffix));
	s_kills = strpad(p_kills,strcat(ftos(kills), killssuffix));

	
	rail = strcat(statname, s_hits,"/",s_shots,s_perc,s_kills);
	
	//rocket
	statname = strpad(p_title,"rocketlauncher:");
	hits = e.weapstats[ROLE_FIGHTER].primaryhits;
	shots = e.weapstats[ROLE_FIGHTER].primaryshots;
	kills = e.weapstats[ROLE_FIGHTER].primarykills;
	
	if(shots == 0)
		perc = 0;
	else
		perc = rint(hits/shots * 100);
		
	s_hits = strpad(p_hits,ftos(hits));
	s_shots = strpad(p_shots,ftos(shots));
	s_perc = strpad(p_perc,strcat(ftos(perc),percsuffix));
	s_kills = strpad(p_kills,strcat(ftos(kills), killssuffix));
	
	rl = strcat(statname, s_hits,"/",s_shots,s_perc,s_kills);
		
	//glauncher
	statname = strpad(p_title,"grenlauncher:");
	hits = e.weapstats[ROLE_BOMBER].primaryhits;
	shots = e.weapstats[ROLE_BOMBER].primaryshots;
	kills = e.weapstats[ROLE_BOMBER].primarykills;	
	
	if(shots == 0)
		perc = 0;
	else
		perc = rint(hits/shots * 100);
		
	s_hits = strpad(p_hits,ftos(hits));
	s_shots = strpad(p_shots,ftos(shots));
	s_perc = strpad(p_perc,strcat(ftos(perc),percsuffix));
	s_kills = strpad(p_kills,strcat(ftos(kills), killssuffix));
	
	gl = strcat(statname, s_hits,"/",s_shots,s_perc,s_kills);

	//shaft
	statname = strpad(p_title,"shaft:");
	hits = e.weapstats[ROLE_SUPPORT].primaryhits;
	shots = e.weapstats[ROLE_SUPPORT].primaryshots;
	kills = e.weapstats[ROLE_SUPPORT].primarykills;
	
	if(shots == 0)
		perc = 0;
	else
		perc = rint(hits/shots * 100);
		
	s_hits = strpad(p_hits,ftos(hits));
	s_shots = strpad(p_shots,ftos(shots));
	s_perc = strpad(p_perc,strcat(ftos(perc),percsuffix));
	s_kills = strpad(p_kills,strcat(ftos(kills), killssuffix));
	
	shaft = strcat(statname, s_hits,"/",s_shots,s_perc,s_kills);	
	
	//minigun
	statname = strpad(p_title,"minigun:");
	hits = e.weapstats[ROLE_MGUNNER].primaryhits;
	shots = e.weapstats[ROLE_MGUNNER].primaryshots;
	kills = e.weapstats[ROLE_MGUNNER].primarykills;	
	
	if(shots == 0)
		perc = 0;
	else
		perc = rint(hits/shots * 100);
		
	s_hits = strpad(p_hits,ftos(hits));
	s_shots = strpad(p_shots,ftos(shots));
	s_perc = strpad(p_perc,strcat(ftos(perc),percsuffix));
	s_kills = strpad(p_kills,strcat(ftos(kills), killssuffix));
	
	mgun = strcat(statname, s_hits,"/",s_shots,s_perc,s_kills);
	
	//super shotgun
	statname = strpad(p_title,"super shotgun:");
	hits = e.weapstats[ROLE_RECON].secondaryhits + e.weapstats[ROLE_ASSASSIN].secondaryhits + e.weapstats[ROLE_FIGHTER].secondaryhits + e.weapstats[ROLE_BOMBER].secondaryhits + e.weapstats[ROLE_SUPPORT].secondaryhits + e.weapstats[ROLE_MGUNNER].secondaryhits;
	shots = e.weapstats[ROLE_RECON].secondaryshots + e.weapstats[ROLE_ASSASSIN].secondaryshots + e.weapstats[ROLE_FIGHTER].secondaryshots + e.weapstats[ROLE_BOMBER].secondaryshots + e.weapstats[ROLE_SUPPORT].secondaryshots + e.weapstats[ROLE_MGUNNER].secondaryshots;
	kills = e.weapstats[ROLE_RECON].secondarykills + e.weapstats[ROLE_ASSASSIN].secondarykills + e.weapstats[ROLE_FIGHTER].secondarykills + e.weapstats[ROLE_BOMBER].secondarykills + e.weapstats[ROLE_SUPPORT].secondarykills + e.weapstats[ROLE_MGUNNER].secondarykills;
	if(shots == 0)
		perc = 0;
	else
		perc = rint(hits/shots * 100);
		
	s_hits = strpad(p_hits,ftos(hits));
	s_shots = strpad(p_shots,ftos(shots));
	s_perc = strpad(p_perc,strcat(ftos(perc),percsuffix));
	s_kills = strpad(p_kills,strcat(ftos(kills), killssuffix));
	
	ssg = strcat(statname, s_hits,"/",s_shots,s_perc,s_kills);
	
	//single shotgun
	statname = strpad(p_title,"shotgun:");
	hits = e.weapstats[ROLE_RECON].tertiaryhits + e.weapstats[ROLE_ASSASSIN].tertiaryhits + e.weapstats[ROLE_FIGHTER].tertiaryhits + e.weapstats[ROLE_BOMBER].tertiaryhits + e.weapstats[ROLE_SUPPORT].tertiaryhits + e.weapstats[ROLE_MGUNNER].tertiaryhits;
	shots = e.weapstats[ROLE_RECON].tertiaryshots + e.weapstats[ROLE_ASSASSIN].tertiaryshots + e.weapstats[ROLE_FIGHTER].tertiaryshots + e.weapstats[ROLE_BOMBER].tertiaryshots + e.weapstats[ROLE_SUPPORT].tertiaryshots + e.weapstats[ROLE_MGUNNER].tertiaryshots;
	kills = e.weapstats[ROLE_RECON].tertiarykills + e.weapstats[ROLE_ASSASSIN].tertiarykills + e.weapstats[ROLE_FIGHTER].tertiarykills + e.weapstats[ROLE_BOMBER].tertiarykills + e.weapstats[ROLE_SUPPORT].tertiarykills + e.weapstats[ROLE_MGUNNER].tertiarykills;
	if(shots == 0)
		perc = 0;
	else
		perc = rint(hits/shots * 100);
		
	s_hits = strpad(p_hits,ftos(hits));
	s_shots = strpad(p_shots,ftos(shots));
	s_perc = strpad(p_perc,strcat(ftos(perc),percsuffix));
	s_kills = strpad(p_kills,strcat(ftos(kills), killssuffix));
	
	shotgun = strcat(statname, s_hits,"/",s_shots,s_perc,s_kills);
	
	//melee
	statname = strpad(p_title,"melee:");
	hits = e.weapstats[ROLE_RECON].meleehits + e.weapstats[ROLE_ASSASSIN].meleehits + e.weapstats[ROLE_FIGHTER].meleehits + e.weapstats[ROLE_BOMBER].meleehits + e.weapstats[ROLE_SUPPORT].meleehits + e.weapstats[ROLE_MGUNNER].meleehits;
	shots = e.weapstats[ROLE_RECON].meleeshots + e.weapstats[ROLE_ASSASSIN].meleeshots + e.weapstats[ROLE_FIGHTER].meleeshots + e.weapstats[ROLE_BOMBER].meleeshots + e.weapstats[ROLE_SUPPORT].meleeshots + e.weapstats[ROLE_MGUNNER].meleeshots;
	kills = e.weapstats[ROLE_RECON].meleekills + e.weapstats[ROLE_ASSASSIN].meleekills + e.weapstats[ROLE_FIGHTER].meleekills + e.weapstats[ROLE_BOMBER].meleekills + e.weapstats[ROLE_SUPPORT].meleekills + e.weapstats[ROLE_MGUNNER].meleekills;
	if(shots == 0)
		perc = 0;
	else
		perc = rint(hits/shots * 100);
		
	s_hits = strpad(p_hits,ftos(hits));
	s_shots = strpad(p_shots,ftos(shots));
	s_perc = strpad(p_perc,strcat(ftos(perc),percsuffix));
	s_kills = strpad(p_kills,strcat(ftos(kills), killssuffix));
	
	melee = strcat(statname, s_hits,"/",s_shots,s_perc,s_kills);
	
	
	
	
	
	
	
	
	
	//result
	local string result ="";

	result = strcat(result,sng,"\n");
	result = strcat(result,rail,"\n");
	result = strcat(result,rl,"\n");
	result = strcat(result,gl,"\n");
	result = strcat(result,shaft,"\n");
	result = strcat(result,mgun,"\n");
	result = strcat(result,ssg,"\n");
	result = strcat(result,shotgun,"\n");
	result = strcat(result,melee,"\n");
	result = strcat(result,"\n");
	

	//sprint(e, PRINT_HIGH, result);
	return result;
	
	
	//sprint(e, PRINT_HIGH, strcat(sng,"\n"));
	//sprint(e, PRINT_HIGH, strcat(rail,"\n"));
	//sprint(e, PRINT_HIGH, strcat(rl,"\n"));
	//sprint(e, PRINT_HIGH, strcat(gl,"\n"));
	//sprint(e, PRINT_HIGH, strcat(shaft,"\n"));
	//sprint(e, PRINT_HIGH, strcat(mgun,"\n"));
	//sprint(e, PRINT_HIGH, strcat(ssg,"\n"));
	//sprint(e, PRINT_HIGH, strcat(shotgun,"\n"));
	//sprint(e, PRINT_HIGH, strcat(melee,"\n"));
	//sprint(e, PRINT_HIGH, "\n");
	//sprint(e, PRINT_HIGH, strcat(shattergren,"\n"));
	//sprint(e, PRINT_HIGH, strcat(flashgren,"\n"));
	//sprint(e, PRINT_HIGH, strcat(fraggren,"\n"));
	//sprint(e, PRINT_HIGH, strcat(markergren,"\n"));
	//sprint(e, PRINT_HIGH, strcat(leechgren,"\n"));
	//sprint(e, PRINT_HIGH, strcat(pushupgren,"\n"));
	//sprint(e, PRINT_HIGH, "\n");
};

string PrintKillStats(entity e) =
{
	float kills, deaths, suicides, worlddeaths;
	float dmggive,dmgtake,dmgself,dmgworld;
	
	kills = e.playerstats.kills;
	deaths = e.playerstats.deaths;
	suicides = e.playerstats.suicides;
	worlddeaths = e.playerstats.worlddeaths;
	
	dmggive = e.playerstats.dmggiven;
	dmgtake = e.playerstats.dmgtaken;
	dmgself = e.playerstats.dmgself;
	dmgworld = e.playerstats.dmgworld;
	
	string s_kills, s_deaths, s_suicides, s_worlddeaths;
	string s_give, s_take, s_self, s_world;
	
	s_kills = strcat(strpad(25, "kills:"), strpad(-4,ftos(kills)));
	s_deaths = strcat(strpad(25, "deaths:"), strpad(-4,ftos(deaths)));
	s_suicides = strcat(strpad(25, "suicides:"), strpad(-4,ftos(suicides)));
	s_worlddeaths = strcat(strpad(25, "world deaths:"), strpad(-4,ftos(worlddeaths)));
	
	s_give = strcat(strpad(23, "damage given:"), strpad(-6,ftos(dmggive)));
	s_take = strcat(strpad(23, "damage taken:"), strpad(-6,ftos(dmgtake)));
	s_self = strcat(strpad(23, "damage to self:"), strpad(-6,ftos(dmgself)));
	s_world = strcat(strpad(23, "damage from world:"), strpad(-6,ftos(dmgworld)));
	
	local string spacer = strpad(10,"");

	//sprint(e, PRINT_HIGH, strcat(s_kills,"\n"));
	//sprint(e, PRINT_HIGH, strcat(s_deaths,"\n"));
	//sprint(e, PRINT_HIGH, strcat(s_suicides,"\n"));
	//sprint(e, PRINT_HIGH, strcat(s_worlddeaths,"\n"));
	//sprint(e, PRINT_HIGH, "\n");
	//sprint(e, PRINT_HIGH, strcat(s_give,"\n"));
	//sprint(e, PRINT_HIGH, strcat(s_take,"\n"));
	//sprint(e, PRINT_HIGH, strcat(s_self,"\n"));
	//sprint(e, PRINT_HIGH, strcat(s_world,"\n"));
	//sprint(e, PRINT_HIGH, "\n");
	
	local string result = "";
	result = strcat(result,s_kills,"\n");
	result = strcat(result,s_deaths,"\n");
	result = strcat(result,s_suicides,"\n");
	result = strcat(result,s_worlddeaths,"\n");
	result = strcat(result,"\n");
	result = strcat(result,s_give,"\n");
	result = strcat(result,s_take,"\n");
	result = strcat(result,s_self,"\n");
	result = strcat(result,s_world,"\n");
	result = strcat(result,"\n");
	//sprint(e, PRINT_HIGH, result);
	return result;
	
};

string PrintFunStats(entity e) =
{
	//float stompkills;
	//float bestkillstreak;
	//float ghostsbusted;
	//float accuracyawards;
	//float harpooncombokills;
	//float directrockets;
	//float directpineapples;
	//float midairrockets;
	//float midairpineapples;
	//float highestrocketmid;
	//float highestpinemid;
	
	
	
	local string beststreak = strcat(strpad(25, "best killstreak:"), strpad(-4,ftos(e.playerstats.bestkillstreak)));
	local string ghosts = strcat(strpad(25, "ghosts busted:"), strpad(-4,ftos(e.playerstats.ghostsbusted)));
	local string stomp = strcat(strpad(25, "stomp kills:"), strpad(-4,ftos(e.playerstats.stompkills)));
	local string acc = strcat(strpad(25, "accuracy awards:"), strpad(-4,ftos(e.playerstats.accuracyawards)));
	local string harp = strcat(strpad(25, "harpoon combo kills:"), strpad(-4,ftos(e.playerstats.harpooncombokills)));
	
	local string thomas = strcat(strpad(25, "shoulder charge kills:"), strpad(-4,ftos(e.weapstats[ROLE_MGUNNER].specialkills)));
	local string tele = strcat(strpad(25, "telefrag kills:"), strpad(-4,ftos(e.weapstats[ROLE_SUPPORT].specialkills)));
	local string c4 = strcat(strpad(25, "c4 kills:"), strpad(-4,ftos(e.weapstats[ROLE_BOMBER].specialkills)));
	
	local string directrockets = strcat(strpad(25, "direct rockets:"), strpad(-4,ftos(e.playerstats.directrockets)));
	local string midairrockets = strcat(strpad(25, "midair rockets:"), strpad(-4,ftos(e.playerstats.midairrockets)));
	local string highestmidairrocket = strcat(strpad(25, "highest midair rocket:"), strpad(-4,ftos(e.playerstats.bestrocketmidairdist)));
	local string directpineapples = strcat(strpad(25, "direct pineapples:"), strpad(-4,ftos(e.playerstats.directpineapples)));
	
	//sprint(e, PRINT_HIGH, strcat(beststreak,"\n"));
	//sprint(e, PRINT_HIGH, strcat(ghosts,"\n"));
	//sprint(e, PRINT_HIGH, strcat(stomp,"\n"));
	//sprint(e, PRINT_HIGH, strcat(acc,"\n"));
	//sprint(e, PRINT_HIGH, strcat(harp,"\n"));
	//sprint(e, PRINT_HIGH, strcat(thomas,"\n"));
	//sprint(e, PRINT_HIGH, strcat(c4,"\n"));
	//sprint(e, PRINT_HIGH, strcat(tele,"\n"));
	//sprint(e, PRINT_HIGH, strcat(directrockets,"\n"));
	//sprint(e, PRINT_HIGH, strcat(midairrockets,"\n"));
	//sprint(e, PRINT_HIGH, strcat(highestmidairrocket,"\n"));
	//sprint(e, PRINT_HIGH, strcat(directpineapples,"\n"));
	//sprint(e, PRINT_HIGH, "\n");
	
	local string result = "";
	result = strcat(result,beststreak,"\n");
	result = strcat(result,ghosts,"\n");
	result = strcat(result,stomp,"\n");
	result = strcat(result,acc,"\n");
	result = strcat(result,harp,"\n");
	result = strcat(result,thomas,"\n");
	result = strcat(result,c4,"\n");
	result = strcat(result,tele,"\n");
	result = strcat(result,directrockets,"\n");
	result = strcat(result,midairrockets,"\n");
	result = strcat(result,highestmidairrocket,"\n");
	result = strcat(result,directpineapples,"\n");
	result = strcat(result,"\n");
	//sprint(e, PRINT_HIGH, result);
	return result;
	
};

void PrintStats(entity e) =
{
	sprint(e, PRINT_HIGH, "==================================================\n");
	local string res = "";

 	
	res = strcat(PrintKillStats(e),PrintFlagStats(e));
	sprint(e, PRINT_HIGH, res);
	//res = "";
	stuffcmd(self, "wait");
	
	res = strcat(PrintFunStats(e),PrintWeaponStats(e));
	sprint(e, PRINT_HIGH, res);
	//res = ""
	res = strcat(PrintGrenStats(e));
	
	
	sprint(e, PRINT_HIGH, res);
	sprint(e, PRINT_HIGH, "==================================================\n");
	
};

void AddRadiusHitStat(entity attacker, string dtype) =
{
	if(dtype == "rocket")
		AddStat(attacker, STAT_WEAPONHIT, WPN_ROCKETLAUNCHER);
};

void AddDamageStat(entity targ, entity inflictor, entity attacker, float damage) =
{

		if (damage >= targ.health + targ.armorvalue)
			damage = targ.health + targ.armorvalue;
			
		if(targ.deathtype == "grenade_shatter" && damage >= targ.armorvalue && targ.classname == "player" && attacker.team_no != targ.team_no)
		{
			CreateDamageNumber(targ.armorvalue, targ, attacker);
		
			AddStat(attacker, STAT_DMGGIVEN, targ.armorvalue);
			AddStat(targ, STAT_DMGTAKEN, targ.armorvalue);
		}
		
		else if(attacker.classname == "player" && targ.classname == "player" && targ != attacker && attacker.team_no != targ.team_no)	//pvp damage
		{
			CreateDamageNumber(damage, targ, attacker);

			AddStat(attacker, STAT_DMGGIVEN, damage);
			AddStat(targ, STAT_DMGTAKEN, damage);
		}	
		else if(attacker == targ && attacker.classname == "player")						//self damage
		{
			AddStat(targ, STAT_DMGSELF, damage);
		}
		else if (targ.classname == "player" && attacker.classname != "player")				//world damage
		{	
			AddStat(targ, STAT_DMGWORLD, damage);
		}
}; 


void AddStat(entity e, float stat, float amt) =
{
	if(matchstate != MATCHSTATE_LIVE)
		return;
		
	local string debugstr;
	switch (stat)
	{	
		case STAT_DMGGIVEN:
			debugstr = strcat("dmggiven+",ftos(amt));
			e.playerstats.dmggiven = e.playerstats.dmggiven + amt;
			break;
		
		case STAT_DMGTAKEN:
			debugstr = strcat("dmgtaken+",ftos(amt));
			e.playerstats.dmgtaken = e.playerstats.dmgtaken + amt;
			break;
		
		case STAT_DMGSELF:
			debugstr = strcat("dmgself+",ftos(amt));
			e.playerstats.dmgself = e.playerstats.dmgself + amt;
			AddStat(e, STAT_DMGTAKEN, amt);
			break;
			
		case STAT_DMGWORLD:
			debugstr = strcat("dmgworld+",ftos(amt));
			e.playerstats.dmgworld = e.playerstats.dmgworld + amt;
			AddStat(e, STAT_DMGTAKEN, amt);
			break;
	
		case STAT_FLAGSTEAL:
			debugstr = "flagsteal++";
			e.playerstats.flagsteals++;
			AddStat(e,STAT_FLAGTOUCH, 1);
			break;
			
		case STAT_FLAGTOUCH:
			debugstr = "flagtouch++";
			e.playerstats.flagtouches++;
			break;
			
		case STAT_FLAGCAP:
			debugstr = "flagcap++";
			e.playerstats.flagcaps++;
			break;
			
		case STAT_FLAGTRAILTOUCH:
			debugstr = "flagtrailtouch++";
			e.playerstats.flagtrailtouches++;
			break;
			
		case STAT_FLAGCARRIERKILLED:
			debugstr = "flagcarrierkilled++";
			e.playerstats.flagsacks++;
			break;
			
		case STAT_FLAGTHROW:
			debugstr = "flagthrows++";
			e.playerstats.flagthrows++;
			break;
			
		case STAT_FLAGDIEDWITH:
			debugstr = "flagdeathwith++";
			e.playerstats.flagdeaths++;
			break;
			
		case STAT_KILLSTREAK:
			debugstr = "killstreakcheck";
			if(amt > e.playerstats.bestkillstreak)
			{
				e.playerstats.bestkillstreak = amt;
				debugstr = strcat("killstreakreplaced ",ftos(amt));
			}
			break;
			
		case STAT_GHOSTBUST:
			debugstr = "ghostbust++";
			e.playerstats.ghostsbusted++;
			break;
		
		case STAT_STOMPKILL:
			debugstr = "stompkill++";
			e.playerstats.stompkills++;
			AddStat(e,STAT_KILL, 1);
			break;
		
		case STAT_MELEEKILL:
			debugstr = strcat("meleekill++ class:",ftos(amt));
			e.weapstats[amt].meleekills++;
			AddStat(e,STAT_KILL, 1);
			break;
			
		case STAT_PRIMARYKILL:
			debugstr = strcat("primarykill++ class:",ftos(amt));
			e.weapstats[amt].primarykills++;
			AddStat(e,STAT_KILL, 1);
			break;
		
		case STAT_SECONDARYKILL:
			debugstr = strcat("secondarykill++ class:",ftos(amt));
			e.weapstats[amt].secondarykills++;
			AddStat(e,STAT_KILL, 1);
			break;
			
		case STAT_TERTIARYKILL:
			debugstr = strcat("tertiarykill++ class:",ftos(amt));
			e.weapstats[amt].tertiarykills++;
			AddStat(e,STAT_KILL, 1);
			break;
			
		case STAT_SPECIALKILL:
			debugstr = strcat("specialkill++ class:",ftos(amt));
			e.weapstats[amt].specialkills++;
			AddStat(e,STAT_KILL, 1);
			break;
			
		case STAT_GRENKILL:
			debugstr = strcat("grenkill++ class:",ftos(amt));
			e.weapstats[amt].grenkills++;
			AddStat(e,STAT_KILL, 1);
			break;
		
		case STAT_WORLDDEATH:
			debugstr = "worlddeath++";
			e.playerstats.worlddeaths++;
			AddStat(e,STAT_SUICIDE, 1);
			break;
		
		case STAT_DEATH:
			debugstr = "death++";
			e.playerstats.deaths++;
			break;
		
		case STAT_SUICIDE:
			debugstr = "suicide++";
			e.playerstats.suicides++;
			AddStat(e,STAT_DEATH, 1);
			break;
			
		case STAT_KILL:
			debugstr = "kill++";
			e.playerstats.kills++;
			break;
			
		case STAT_ROCKETDIRECT:
			debugstr = "directrockets++";
			e.playerstats.directrockets++;
			break;
		case STAT_ROCKETMIDAIR:
			debugstr = strcat("midairrockets++ consec: ",ftos(amt));
			e.playerstats.midairrockets++;
			if(amt > e.playerstats.bestrocketmidairconsec)
			{
				e.playerstats.bestrocketmidairconsec = amt;
				debugstr = strcat("rockermidairs newconsecbest: ",ftos(amt));
			}
			
			break;
		case STAT_ROCKETMIDAIRDIST:
			debugstr = strcat("midairrocketdist ",ftos(amt));
			if(amt > e.playerstats.bestrocketmidairdist)
			{
				e.playerstats.bestrocketmidairdist = amt;
				debugstr = strcat("bestmidairrocketdist newbest: ",ftos(amt));
			}
			break;
			
		case STAT_HARPOONCOMBOKILL:
			debugstr = "harpooncombokill++";
			e.playerstats.harpooncombokills++;
			AddStat(e,STAT_PRIMARYKILL, ROLE_FIGHTER);
			AddStat(e,STAT_KILL, 1);
			break;
			
		case STAT_WEAPONFIRED:
			//hitscans
			if(e.weapon == WPN_AXE)
			{
				debugstr = strcat("melee_shot++ class:",ftos(e.role));
				e.weapstats[e.role].meleeshots++;
			}
			else if(e.weapon == WPN_SHOTGUN)
			{
				debugstr = strcat("shotgun_shot++ class:",ftos(e.role));
				e.weapstats[e.role].tertiaryshots++;
			}
			else if(e.weapon == WPN_SUPERSHOTGUN)
			{
				debugstr = strcat("ssg_shot++ class:",ftos(e.role));
				e.weapstats[e.role].secondaryshots++;
			}
			else if(e.weapon == WPN_RAILGUN)
			{
				debugstr = "railgun_shot++";
				e.weapstats[ROLE_ASSASSIN].primaryshots++;
			}
			else if(e.weapon == WPN_SHAFT)
			{
				debugstr = "shaft_shot++";
				e.weapstats[ROLE_SUPPORT].primaryshots++;
			}
			else if(e.weapon == WPN_MINIGUN)
			{
				debugstr = "minigun_shot++";
				e.weapstats[ROLE_MGUNNER].primaryshots++;
			}
			
			//proj
			else if(e.weapon == WPN_NAILGUN)
			{
				debugstr = "nailgun_shot++";
				e.weapstats[ROLE_RECON].primaryshots++;
			}
			else if(e.weapon == WPN_ROCKETLAUNCHER)
			{
				debugstr = "rocket_shot++";
				e.weapstats[ROLE_FIGHTER].primaryshots++;
			}
			else if(e.weapon == WPN_PIPELAUNCHER)
			{
				debugstr = "launcher_shot++";
				e.weapstats[ROLE_BOMBER].primaryshots++;
			}
			break;
			
		case STAT_WEAPONHIT:
			//hitscan
			if(e.weapon == WPN_AXE)
			{
				debugstr = strcat("melee_hit++ class:",ftos(e.role));
				e.weapstats[e.role].meleehits++;
			}
			else if(e.weapon == WPN_SHOTGUN)
			{
				debugstr = strcat("shotgun_hit++ class:",ftos(e.role));
				e.weapstats[e.role].tertiaryhits++;
			}
			else if(e.weapon == WPN_SUPERSHOTGUN)
			{
				debugstr = strcat("ssg_hit++ class:",ftos(e.role));
				e.weapstats[e.role].secondaryhits++;
			}
			else if(e.weapon == WPN_RAILGUN)
			{
				debugstr = "railgun_hit++";
				e.weapstats[e.role].primaryhits++;
				if(amt >= 3)
					AddStat(e, STAT_ACCURACYAWARD, 1);
			}
			else if(e.weapon == WPN_SHAFT)
			{
				debugstr = "shaft_hit++";
				e.weapstats[e.role].primaryhits++;
			}
			else if(e.weapon == WPN_MINIGUN)
			{
				debugstr = "minigun_hit++";
				e.weapstats[e.role].primaryhits++;
			}
			//proj - using amt instead of .weapon
			else if(amt == WPN_NAILGUN)
			{
				debugstr = "nailgun_hit";
				e.weapstats[ROLE_RECON].primaryhits++;
			}
			else if(amt == WPN_ROCKETLAUNCHER)
			{
				debugstr = "rocket_hit";
				e.weapstats[ROLE_FIGHTER].primaryhits++;
			}
			else if(amt == WPN_PIPELAUNCHER)
			{
				debugstr = "launcher_hit";
				e.weapstats[ROLE_BOMBER].primaryhits++;
			}
			break;
			
		case STAT_GRENPRIMED:
			if(amt == ROLE_RECON)
			{
				debugstr = "shatter_prime++";
				e.weapstats[ROLE_RECON].grenprimes++;
			}
			else if(amt == ROLE_ASSASSIN)
			{
				debugstr = "flash_prime++";
				e.weapstats[ROLE_ASSASSIN].grenprimes++;
			}
			else if(amt == ROLE_FIGHTER)
			{
				debugstr = "frag_prime++";
				e.weapstats[ROLE_FIGHTER].grenprimes++;
			}
			else if(amt == ROLE_BOMBER)
			{
				debugstr = "marker_prime++";
				e.weapstats[ROLE_BOMBER].grenprimes++;
			}
			else if(amt == ROLE_SUPPORT)
			{
				debugstr = "leech_prime++";
				e.weapstats[ROLE_SUPPORT].grenprimes++;
			}
			else if(amt == ROLE_MGUNNER)
			{
				debugstr = "pushup_prime++";
				e.weapstats[ROLE_MGUNNER].grenprimes++;
			}
			break;
			
		case STAT_GRENHIT:
			if(amt == ROLE_RECON)
			{
				debugstr = "shatter_hit++";
				e.weapstats[ROLE_RECON].grenhits++;
			}
			else if(amt == ROLE_ASSASSIN)
			{
				debugstr = "flash_hit++";
				e.weapstats[ROLE_ASSASSIN].grenhits++;
			}
			else if(amt == ROLE_FIGHTER)
			{
				debugstr = "frag_hit++";
				e.weapstats[ROLE_FIGHTER].grenhits++;
			}
			else if(amt == ROLE_BOMBER)
			{
				debugstr = "marker_hit++";
				e.weapstats[ROLE_BOMBER].grenhits++;
			}
			else if(amt == ROLE_SUPPORT)
			{
				debugstr = "leech_hit++";
				e.weapstats[ROLE_SUPPORT].grenhits++;
			}
			else if(amt == ROLE_MGUNNER)
			{
				debugstr = "pushup_hit++";
				e.weapstats[ROLE_MGUNNER].grenhits++;
			}
			break;
			
		case STAT_ACCURACYAWARD:
			debugstr = "accuracyaward++";
			e.playerstats.accuracyawards++;
			break;
			
		case STAT_DIRECTPINEAPPLE:
			debugstr = " directpineapples++";
			e.playerstats.directpineapples++;
			AddStat(e, STAT_WEAPONHIT, WPN_PIPELAUNCHER);
			break;
			
			

			
						
		default:
			debugstr = strcat(ftos(stat),"???");            
			break;
	}
	
	local entity te = find(world, classname, "player");
	while(te)
	{
		if(infokey(te, "debugstats") == "1")
		{
			local string s = strcat("addstat: ", e.netname, " ", debugstr);
			sprint(te, PRINT_HIGH, strcat(s, "\n"));
		}
		te = find(te,classname,"player");
	}
};