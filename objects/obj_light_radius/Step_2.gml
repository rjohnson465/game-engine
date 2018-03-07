if instance_exists(owner) {
	if owner.isShowingLightRadius {
		x = owner.x;
		y = owner.y;
	} 
	if layer != global.player.layer {
		x = -10000;
		y = -10000;
	}
}

