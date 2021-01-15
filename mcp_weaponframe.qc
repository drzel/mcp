/*
============
W_WeaponFrame

Called every frame so impulse events can be handled as well as possible
============
*/

void() W_WeaponFrame =
{
	MenuInputImpulses();
	DeadOrAliveImpulses();
	AliveImpulses();

	if (self.cloak_complete == 1 && self.iscloaked == 1)
	{
		self.cloak_complete = 0;
		self.iscloaked = 0;
		W_SetCurrentWeaponModel();
		W_SetCurrentAmmo();
	}
		
	//if (self.playerstate & PLAYERSTATE_RELOADING && self.reload_complete == 1)
	if (self.reload_complete == 1 && self.isreloading == 1) // pstate_reloading==0
	{
		self.reload_complete = 0;
		self.isreloading = 0;
		W_SetCurrentWeaponModel();
		W_SetCurrentAmmo();
	}
	
	if (self.isreloading == 1)
		return;

		



	if (time < self.attack_finished)
	{
		return;
	}	

	AliveAttackFinishedImpulses();
	
	//ImpulseCommands ();
	if(self.iscloaked == 1)
		return;
// check for attack
	if (self.button0)
	{
		W_ZutAttack ();
	}
};