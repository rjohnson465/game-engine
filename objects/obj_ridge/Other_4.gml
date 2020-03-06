if fallDirectionString == noone exit;

switch fallDirectionString {
	case "up": {
		fallDirectionMin = 360;
		fallDirectionMax = 180;
		break;
	}
	case "right": {
		fallDirectionMin = 270;
		fallDirectionMax = 90;
		break;
	}
	case "left": {
		fallDirectionMin = 90;
		fallDirectionMax = 270;
		break;
	}
	case "down": {
		fallDirectionMin = 180;
		fallDirectionMax = 360;
		break;
	}
}