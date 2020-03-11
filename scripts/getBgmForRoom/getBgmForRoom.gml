/// getBgmForRoom(rm)

// return an array of possible background music for a given room

var rm = argument0;

switch rm {
	case game_menu: {
		return [snd_bgm_menu]
		break;
	}
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
		return [snd_bgm_lamplight_blasphemy, snd_bgm_factorysins, snd_bgm_robotwarhymn];
		break;
	}
	case rm_boss_lighteater: {
		return [snd_bgm_lighteater];
		break;
	}
	case rm_winter: {
		return [snd_bgm_endless_tundra, snd_bgm_wonderground, snd_bgm_icedrops];
		break;
	}
	case rm_tundra: {
		return [snd_bgm_endless_tundra, snd_bgm_icedrops, snd_bgm_krampuslands];
	}
	case rm_clayfields: {
		return [snd_bgm_endless_tundra, snd_bgm_icedrops, snd_bgm_clayfields];
	}
	case rm_xmas_town: {
		return [snd_bgm_sleighbells];
		break; 
	}
	case rm_hanukkah_village: {
		return [snd_bgm_hanukkah_village];
		break; 
	}
	case rm_krampus: {
		return [snd_bgm_krampus];
		break;
	}
	case rm_golemking: {
		return [snd_bgm_golemlord];
		break;
	}
}

return noone;