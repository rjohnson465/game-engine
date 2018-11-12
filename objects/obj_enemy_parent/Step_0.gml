event_inherited();

if state == CombatantStates.Moving && x != postX && y != postY {
	updatePersistentElementProperty(id,"CurrentX",x);
	updatePersistentElementProperty(id,"CurrentY",y);
	updatePersistentElementProperty(id,"CurrentZ",layer);
	updatePersistentElementProperty(id,"FacingDirection",facingDirection);
	updatePersistentElementProperty(id,"FacingDirectionStart",postDir);
}

//if place_meeting_layer(x,y,obj_enemy_parent) {
with obj_combatant_parent {
	if place_meeting_layer(x,y,other) {
		var dir;
		var move_dis = functionalSpeed;  // change this value to your liking

		// If the two instances are in the same location, choose a random direction
		if (x == other.x && y == other.y)
		    dir = random(360);

		// Otherwise, choose the direction opposite of the other instance
		else
		    dir = point_direction(other.x,other.y,x,y);

		// nudge instance to new location if possible

		var dx = lengthdir_x(move_dis,dir);
		var dy = lengthdir_y(move_dis,dir);

		if (!place_meeting(x+dx,y,obj_solid_environment)) {
			x += dx;
		}
		if (!place_meeting(x,y+dy,obj_solid_environment)) {
			y += dy;
		}
		//jumpToNearestFreePoint(1,1,functionalSpeed);
	}
}