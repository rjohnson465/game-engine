if frame <= totalFrames {
	frame++;
} else {
	var messageNum = alertNumber;
	with (obj_alert) {
		if alertNumber > messageNum {
			alertNumber--;
		}
	}
	instance_destroy(id,false);
}