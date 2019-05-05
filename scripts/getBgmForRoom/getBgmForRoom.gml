/// getBgmForRoom(rm)

// return an array of possible background music for a given room

var rm = argument0;

switch rm {
	case rm_forest: {
		//return noone;
		return [snd_bgm_verdant_leaves];
		break;
	}
	case rm_boss_funfairy: {
		return [snd_bgm_funfairy];
		break;
	}
	case rm_factory: {
		return noone;
		break;
	}
}

return noone;