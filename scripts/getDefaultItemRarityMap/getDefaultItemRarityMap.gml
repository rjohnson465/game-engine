/// getDefaultItemRarityMap()

// return default Rarity map <Rarity,probability> by act

//var act = argument[0];
var map = ds_map_create();

//switch act {
//	case 1: {
		ds_map_replace(map,ItemRarities.Normal,75);
		ds_map_replace(map,ItemRarities.Fine,20);
		ds_map_replace(map,ItemRarities.Masterwork,4);
		ds_map_replace(map,ItemRarities.Legendary,1);
		//break;
//	}
//}

return map;