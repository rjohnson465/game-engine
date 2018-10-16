// periodically ensure we're not stuck
/*if !isMoving && !place_free(x,y) {
	var dir = 0;
	var origX = x; var origY = y;
	var canMove = false;
	do {
		dir = (dir+45)%360;
		if moveToNearestFreePoint(dir, 1, 0) {
			canMove = true;
		}
	} until (dir == 0)
	if !canMove {
		jumpToNearestFreePoint(0);
	} else {
		x = origX; y = origY;
	}
}