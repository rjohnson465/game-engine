if upDirectionString == noone exit;

switch upDirectionString {
	case "up": {
		upDirectionMin = 360;
		upDirectionMax = 180;
		break;
	}
	case "right": {
		upDirectionMin = 270;
		upDirectionMax = 90;
		break;
	}
	case "left": {
		upDirectionMin = 90;
		upDirectionMax = 270;
		break;
	}
	case "down": {
		upDirectionMin = 180;
		upDirectionMax = 360;
		break;
	}
}