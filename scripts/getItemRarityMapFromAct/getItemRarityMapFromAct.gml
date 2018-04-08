/// getItemRarityMapFromAct(act)
/// @param act

// return default Rarity map <Rarity,probability> by act

var act = argument[0];
var map = ds_map_create();

switch act {
	case 1: {
		ds_map_replace(map,ItemRarities.Normal,80);
		ds_map_replace(map,ItemRarities.Fine,20);
		ds_map_replace(map,ItemRarities.Masterwork,1);
		ds_map_replace(map,ItemRarities.Legendary,0);
		break;
	}
}

return map;