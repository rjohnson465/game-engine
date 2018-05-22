if owner.depth >= global.player.depth {
	var alpha = 1;
	if owner.isDying {
		alpha = (-owner.dyingFrame/owner.dyingTotalFrames)+1;
	}
	draw_sprite_ext(sprite_index,1,owner.x,owner.y,owner.scale,owner.scale,owner.facingDirection,c_white,alpha);
}