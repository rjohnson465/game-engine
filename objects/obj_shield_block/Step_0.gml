x = owner.x;
y = owner.y;
// shields always on the left hand
image_angle = owner.facingDirection+90;

if	!owner.isShielding
	|| owner.state == CombatantStates.Dodging
	|| owner.state == CombatantStates.Attacking
	//|| owner.state == CombatantStates.Staggering
{
	owner.isShielding = false;
	instance_destroy(id,false);
}


