/// getBgmForRoom(rm)

// return an array of possible background music for a given room

var rm = argument0;

switch rm {
	case rm_forest: {
		//return noone;
		return [snd_bgm_woodland_stream, snd_bgm_verdant_leaves];
		// return [snd_bgms_le, snd_bgm_verdant_leaves];
		break;
	}
	case rm_boss_funfairy: {
		return [snd_bgm_funfairy];
		break;
	}
	case rm_boss_ravebot: {
		return [snd_bgm_ravebot];
		break;
	}
	case rm_factory: {
		// return noone;
		return [snd_bgm_lamplight_blasphemy];
		break;
	}
	case rm_boss_lighteater: {
		return [snd_bgm_lighteater];
	}
}

return noone;