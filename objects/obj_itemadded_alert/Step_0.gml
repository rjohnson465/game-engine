if frame <= totalFrames {
	frame++;
} else {
	var messageNum = alertNumber;
	with (obj_itemadded_alert) {
		if alertNumber > messageNum {
			alertNumber--;
		}
	}
	instance_destroy(id,false);
}

if !instance_exists(item) {
	var messageNum = alertNumber;
	with (obj_itemadded_alert) {
		if alertNumber > messageNum {
			alertNumber--;
		}
	}
	instance_destroy(id,false);
}