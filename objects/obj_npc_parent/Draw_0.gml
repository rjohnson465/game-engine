updateIsMoving();
shader_reset();
alpha = 1;
scale = 1;
// fairies float
if isFairy || isFloating {
	scale = .1*cos((pi*floatingFrame)/30)+.9; // normal floating
} 

with obj_elevator {
	if elevatorIsMoving {
		var pos = ds_list_find_index(elevatorOccupants, other);
		if pos >= 0 {
			other.scale = elevatorScale;
		}
	}
}

if state == CombatantStates.Moving {
	updateMoveSpriteAndImageSpeed();
	draw_sprite_ext(sprite_index, image_index, x, y, scale, scale, facingDirection, c_white, alpha);
} else {
	updateMoveSpriteAndImageSpeed();
	draw_sprite_ext(sprite_index, image_index, x, y, scale, scale, facingDirection, c_white, alpha);
}

if isFairy {
	floatingFrame += 1;
	floatingFrame = floatingFrame % 60;
}

with obj_light_radius {
	if owner == other.id {
		light_set_scale(other.lightRadiusScale*other.scale);
	}
}

// draw hands
var handSpr = asset_get_index("spr_"+spriteString+"_hand");
if handSpr >= 0 {

	// right hand 
	draw_sprite_ext(handSpr,image_index,x,y,scale,scale,facingDirection,c_white,alpha);
	
	// left hand
	draw_sprite_ext(handSpr,image_index,x,y,scale,-scale,facingDirection,c_white,alpha);
}

