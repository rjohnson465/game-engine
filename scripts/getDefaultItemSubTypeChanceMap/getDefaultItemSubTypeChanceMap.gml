/// getDefaultItemSubTypeChanceMap(itemType)
/// @param itemType 

var itemType = argument[0];
var map = ds_map_create();

switch itemType {
	case ItemTypes.HandItem: {
		ds_map_replace(map,HandItemTypes.Melee,[60,100]);
		ds_map_replace(map,HandItemTypes.Ranged,[25,60]);
		ds_map_replace(map,HandItemTypes.Shield,[0,25]);
		break;
	}
	case ItemTypes.Other: {
		ds_map_replace(map,"gem",[5,100]);
		ds_map_replace(map,"orb",[0,5]);
		break;
	}
}

return map;