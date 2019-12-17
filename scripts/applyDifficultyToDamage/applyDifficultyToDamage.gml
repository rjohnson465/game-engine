/// applyDifficultyToDamage(damage)
/// @param damage

var dmg = argument[0];

var diff = ds_map_find_value(global.optionsManager.optionsMapGameplay, OPT_G_DIFFICULTY);

var multiplier = 1;
switch diff {
	default: {
		multiplier = 1;
		break;
	}
	case OPT_DIFF_EASIEST: {
		multiplier = 0;
		break;
	}
	case OPT_DIFF_EASY: {
		multiplier = .5;
		break;
	}
	case OPT_DIFF_NORMAL: {
		multiplier = 1;
		break;
	}
	case OPT_DIFF_HARD: {
		multiplier = 1.5;
		break;
	}
	case OPT_DIFF_HARDEST: {
		multiplier = 2;
		break;
	}
}

return dmg * multiplier;