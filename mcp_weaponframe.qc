/*
============
W_WeaponFrame

Called every frame so impulse events can be handled as well as possible
============
*/

void() W_WeaponFrame =
{
	
	MenuInputImpulses();
	if(matchstate == MATCHSTATE_FINISH)
		return;
		
	DeadOrAliveImpulses();
	AliveImpulses();

	if (self.cloak_complete == 1 && self.iscloaked == 1)
	{

		self.cloak_complete = 0;
		self.iscloaked = 0;
		ChangeWeaponModel(self.weapon);
		ChangeHudAmmo(self,self.weapon);
		return;

	}
		
	//if (self.playerstate & PLAYERSTATE_RELOADING && self.reload_complete == 1)
	if (self.reload_complete == 1 && self.isreloading == 1) // pstate_reloading==0
	{
		self.reload_complete = 0;
		self.isreloading = 0;
		return;
	}
	
	if (self.isreloading == 1)
	{
		if(VisualWeapon() != WPN_RELOAD)
		{
			ChangeWeaponModel(WPN_RELOAD);
			ChangeHudAmmo(self,self.reloadingweapon);
		}
		return;
	}
	if (time < self.attack_finished)
	{
		return;
	}	

	AliveAttackFinishedImpulses();
	//SetCorrectWeapon();
	//ImpulseCommands ();
	if(self.iscloaked == 1)
		return;

	if(self.qsweapon != WPN_NONE)
	{
		if(VisualWeapon() != self.qsweapon)
		{
			ChangeWeaponModel(self.qsweapon);
			ChangeHudAmmo(self,self.qsweapon);
		}
		MCP_Attack(self.qsweapon);
		return;
		
	}
	else
	{
		if(VisualWeapon() != self.weapon)
		{
			ChangeWeaponModel(self.weapon);
			ChangeHudAmmo(self,self.weapon);
		}
	
	}
	if (self.button0)
	{
		MCP_Attack (self.weapon);
		return;
	}
	

};