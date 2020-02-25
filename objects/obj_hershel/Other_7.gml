if isAwakening {
	isAwakening = false;
	sprite_index = spr_hershel_idle;
}

if isSurrendering {
	isSurrendering = false;
	sprite_index = spr_hershel_sleep;
	isActive = false;
	hp = 100;
}

