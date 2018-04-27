x = owner.x;
y = owner.y;
depth = owner.depth;
// shields always on the right hand
image_angle = owner.facingDirection;

if	!owner.isShielding
	|| owner.state == CombatantStates.Dodging
	|| owner.state == CombatantStates.Attacking
	//|| owner.state == CombatantStates.Staggering
{
	owner.isShielding = false;
	instance_destroy(id,false);
}

if owner.type == CombatantTypes.Player && global.ui.isShowingMenus {
	owner.isShielding = false;
}

