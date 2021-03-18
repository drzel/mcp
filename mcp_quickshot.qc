float isQuickShotting () =
{
	if(self.qshot1 > 0)
		return 1;
	if(self.qshot2 > 0)
		return 1;
	if(self.qshot3 > 0)
		return 1;
	if(self.qshot4 > 0)
		return 1;
	
	return 0;
};

float LatestQuickShottingImp() =
{
	local float a = self.qshot1;
	local float b = self.qshot2;
	local float c = self.qshot3;
	local float d = self.qshot4;
	local float imp = 0;
	
	if(a>b) 
	{ 
		if(a>c) 
		{ 
			if(a>d) 
			{   
				imp = 1; 
			} 
			else 
			{ 
				imp = 4; 
			} 
		} 
	} 
	else if(b>c) 
        { 
		if(b>d) 
                { 
			imp = 2; 
                } 
		else 
                { 
			imp= 4; 
                } 
        } 
        else if(c>d) 
	{ 
		imp = 3; 
	} 
        else 
        { 
		imp = 4; 
        } 

	return imp;
};

void StartQuickShot(float imp) =
{
	self.impulse = 0;
	if(imp == 1)
		self.qshot1 = time;
	if(imp == 2)
		self.qshot2 = time;
	if(imp == 3)
		self.qshot3 = time;
	if(imp == 4)
		self.qshot4 = time;	
	//bprint(2,strcat("start: ",ftos(imp),"\n"));

	self.qsweapon = Imp2Weap(imp);
};

void StopQuickShot(float imp) =
{
	self.impulse = 0;
	if(imp == 1)
		self.qshot1 = -1;
	if(imp == 2)
		self.qshot2 = -1;
	if(imp == 3)
		self.qshot3 = -1;
	if(imp == 4)
		self.qshot4 = -1;	
	//bprint(2,strcat("end: ",ftos(imp),"\n"));
	
	if(!isQuickShotting())
		self.qsweapon = WPN_NONE;
	else
	{
		local float qs_imp = LatestQuickShottingImp();
		self.qsweapon = Imp2Weap(qs_imp);
	}
};

float VisualWeapon() =
{
	if(self.weaponmodel == "")
		return WPN_RELOAD;
		
	if(self.weaponmodel == "progs/beta1/wpn/blue_axe.mdl" || self.weaponmodel == "progs/beta1/wpn/red_axe.mdl" || self.weaponmodel == "progs/beta1/wpn/grey_axe.mdl")
	{
		return WPN_AXE;
	}
	if(self.weaponmodel == "progs/beta1/wpn/blue_supershotgun.mdl" || self.weaponmodel == "progs/beta1/wpn/red_supershotgun.mdl" || self.weaponmodel == "progs/beta1/wpn/grey_supershotgun.mdl")
	{
		return WPN_SUPERSHOTGUN;
	}

	if(self.weaponmodel == "progs/beta1/wpn/blue_shotgun.mdl" || self.weaponmodel == "progs/beta1/wpn/red_shotgun.mdl" || self.weaponmodel == "progs/beta1/wpn/grey_shotgun.mdl")
	{
		 return WPN_SHOTGUN;
	}

	if(self.weaponmodel == "progs/beta1/wpn/blue_supernailgun.mdl" || self.weaponmodel == "progs/beta1/wpn/red_supernailgun.mdl")
	{
		return WPN_NAILGUN;
	}
	
	if(self.weaponmodel == "progs/beta1/wpn/blue_railgun.mdl" || self.weaponmodel == "progs/beta1/wpn/red_railgun.mdl" || self.weaponmodel == "progs/beta1/wpn/grey_railgun.mdl")
	{
		return WPN_RAILGUN;
	}

	if(self.weaponmodel == "progs/beta1/wpn/blue_rocketlauncher.mdl" || self.weaponmodel == "progs/beta1/wpn/red_rocketlauncher.mdl")
	{
		return WPN_ROCKETLAUNCHER;
	}

	if(self.weaponmodel == "progs/beta1/wpn/blue_pipelauncher.mdl" || self.weaponmodel == "progs/beta1/wpn/red_pipelauncher.mdl")
	{
		return WPN_PIPELAUNCHER;
	}

	if(self.weaponmodel == "progs/beta1/wpn/blue_shaft.mdl" || self.weaponmodel == "progs/beta1/wpn/red_shaft.mdl")
	{
		return WPN_SHAFT;
	}

	return WPN_NONE;
};
