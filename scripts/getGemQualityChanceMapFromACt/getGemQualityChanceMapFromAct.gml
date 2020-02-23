/// getDefaultItemTypeChanceMapFromAct(act)
/// @param act number

var act = argument[0];
var map = ds_map_create();

switch act {
	case 1: {
		ds_map_replace(map,CRACKED,[0,75]);
		ds_map_replace(map,NORMAL,[75,100]);
		ds_map_replace(map,EXQUISITE,[-1,-1]);
		ds_map_replace(map,FLAWLESS,[-1,-1]);
		break;
	}
	case 2: {
		ds_map_replace(map,CRACKED,[0,40]);
		ds_map_replace(map,NORMAL,[40,95]);
		ds_map_replace(map,EXQUISITE,[95,100]);
		ds_map_replace(map,FLAWLESS,[-1,-1]);
		break;
	}
	case 3: {
		ds_map_replace(map,CRACKED,[0,10]);
		ds_map_replace(map,NORMAL,[10,75]);
		ds_map_replace(map,EXQUISITE,[75,90]);
		ds_map_replace(map,FLAWLESS,[90,100]);
		break;
	}
	case 4: {
		ds_map_replace(map,CRACKED,[-1,-1]);
		ds_map_replace(map,NORMAL,[0,20]);
		ds_map_replace(map,EXQUISITE,[50,100]);
		ds_map_replace(map,FLAWLESS,[20,50]);
		break;
	}
}




return map;