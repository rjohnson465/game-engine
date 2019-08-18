if state == CombatantStates.Moving {
	sprite_index = spr_muskox_move;
} else {
	sprite_index = spr_muskox;
}

image_angle = facingDirection;

draw_self();