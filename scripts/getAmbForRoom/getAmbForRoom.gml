/// getAmbForRoom(rm)

// return 2 arrays of ambient sounds for a given room
// first array is sounds that must always play
// second array is ambient sounds that may occasionally play
// <snd, how often to maybe play it, chance to maybe play it, how long to play it for (range), fade in frames, fade out frames>

var rm = argument0;

switch rm {
	case rm_forest: {
		return [
		[snd_amb_crickets], 
		// periodical sounds
		[
			[snd_amb_forest_cicada, 1200, .5, [200,345], 30, 30],
			[snd_amb_forest_whippoorwill, 1000, .5, [150, 300], 30, 30],
			[snd_amb_forest_owl, 900, .4, [90, 150], 15, 15]
		]
		]; break;
	}
	case rm_boss_funfairy: {
		return [
		[snd_amb_crickets], 
		// periodical sounds
		[
			[snd_amb_forest_cicada, 1200, .5, [200,345], 30, 30],
			[snd_amb_forest_whippoorwill, 1000, .5, [150, 300], 30, 30],
			[snd_amb_forest_owl, 900, .4, [90, 150], 15, 15]
		]
		]; break;
	}
	case rm_factory: {
		return [
		[snd_amb_factory_loop], 
		// periodical sounds
		[
			[snd_amb_factory_clanging, 1200, .5, [150,300], 30, 30],
			[snd_amb_factory_eerie, 1000, .5, [200, 400], 30, 30]
		]
		]; break;
	}
	case rm_boss_ravebot: {
		return [
		[snd_amb_factory_loop], 
		// periodical sounds
		[
			[snd_amb_factory_clanging, 1200, .5, [150,300], 30, 30],
			[snd_amb_factory_eerie, 1000, .5, [200, 400], 30, 30]
		]
		]; break;
	}
	case rm_boss_lighteater: {
		return [
		[snd_amb_factory_loop], 
		// periodical sounds
		[
			[snd_amb_factory_eerie, 1000, .5, [200, 400], 30, 30]
		]
		]; break;
	}
	case rm_winter: {
		return [
			// floor 1
			[
				["1"],
				[snd_amb_winter_wind], 
				// periodical sounds
				[
					[snd_amb_ww_sleighbells, 1000, .5, [200, 400], 30, 30],
					[snd_amb_wolf_howl, 1000, .5, [120, 240], 30, 30]
				]
			],
			// floor 0
			[
				["0"],
				[snd_amb_cavern_drone], 
				// periodical sounds
				[
					[snd_amb_minerocks_fall, 1000, .5, [200, 400], 30, 30],
				]
			]
		]; break;
	}
	case rm_tundra: {
		return [
		[snd_amb_winter_wind], 
		// periodical sounds
		[
			[snd_amb_ww_sleighbells, 1000, .5, [200, 400], 30, 30],
			[snd_amb_wolf_howl, 1000, .5, [120, 240], 30, 30]
		]
		]; break;
	}
	case rm_clayfields: {
		return 
		[
			// floors 1 and 2
			[
				["1", "2"],
				[snd_amb_winter_wind], 
				// periodical sounds
				[
					[snd_amb_ww_sleighbells, 1000, .5, [200, 400], 30, 30],
					[snd_amb_wolf_howl, 1000, .5, [120, 240], 30, 30]
				]
			],
			// floor 0
			[
				["0"],
				[snd_amb_cavern_drone], 
				// periodical sounds
				[
					[snd_amb_minerocks_fall, 1000, .5, [200, 400], 30, 30],
				]
			]
		];
		break;
	}
	case rm_abominable_snowman: {
		return [
			[snd_amb_cavern_drone], 
			// periodical sounds
			[
				[snd_amb_minerocks_fall, 1000, .5, [200, 400], 30, 30],
				[snd_amb_winter_wind, 1000, .5, [200, 400], 30, 30]
			]
		];
		break;
	}
	case rm_abominable_lands: {
		return [
			[snd_amb_cavern_drone], 
			// periodical sounds
			[
				[snd_amb_minerocks_fall, 1000, .5, [200, 400], 30, 30],
				[snd_amb_winter_wind, 1000, .5, [200, 400], 30, 30]
			]
		];
		break;
	}
	case rm_krampus: {
		return [
		[snd_amb_winter_wind], 
		// periodical sounds
		[
			[snd_amb_wolf_howl, 1000, .5, [120, 240], 30, 30]
		]
		]; break;
	}
	case rm_golemking: {
		return [
		[snd_amb_winter_wind], 
		// periodical sounds
		[
			[snd_amb_wolf_howl, 1000, .5, [120, 240], 30, 30]
		]
		]; break;
	}
	case rm_xmas_town: {
		return [
		[snd_amb_winter_wind], 
		// periodical sounds
		[
			[snd_amb_ww_sleighbells, 1000, .5, [200, 400], 30, 30],
			[snd_amb_wolf_howl, 1000, .5, [120, 240], 30, 30]
		]
		]; break;
	}
	case rm_hanukkah_village: {
		return [
		[snd_amb_winter_wind], 
		// periodical sounds
		[
			[snd_amb_ww_sleighbells, 1000, .5, [200, 400], 30, 30],
			[snd_amb_wolf_howl, 1000, .5, [120, 240], 30, 30]
		]
		]; break;
	}
}

return noone;