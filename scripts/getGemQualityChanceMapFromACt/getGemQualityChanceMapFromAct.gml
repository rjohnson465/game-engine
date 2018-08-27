/// getDefaultItemTypeChanceMapFromAct(act)
/// @param act number

var act = argument[0];
var map = ds_map_create();

switch act {
	case 1: {
		ds_map_replace(map,CRACKED,[0,25]);
		ds_map_replace(map,NORMAL,[25,50]);
		ds_map_replace(map,EXQUISITE,[50,75]);
		ds_map_replace(map,FLAWLESS,[75,100]);
		break;
	}
	case 2: {
		ds_map_replace(map,CRACKED,[10,20]);
		ds_map_replace(map,NORMAL,[20,100]);
		ds_map_replace(map,EXQUISITE,[0,10]);
		ds_map_replace(map,FLAWLESS,[-1,-1]);
		break;
	}
	case 3: {
		ds_map_replace(map,CRACKED,[0,2]);
		ds_map_replace(map,NORMAL,[10,25]);
		ds_map_replace(map,EXQUISITE,[25,100]);
		ds_map_replace(map,FLAWLESS,[2,10]);
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