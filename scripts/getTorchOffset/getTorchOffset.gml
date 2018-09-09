/// getTorchOffset(state, frame)
/// @param state "" | "prep" | "attack" | "recover"
/// @param frame

// return an array formatted as [xOff,yOff] for the offset of a torch in player's hand
// this is where fire particles go

var state = argument[0];
var frame = argument[1];

var prepOffsets = ds_map_create();
ds_map_replace(prepOffsets,0,[35, 0]);
ds_map_replace(prepOffsets,1,[45, 10]);
ds_map_replace(prepOffsets,2,[45, 25]);
ds_map_replace(prepOffsets,3,[40, 70]);
ds_map_replace(prepOffsets,4,[20, 75]);
ds_map_replace(prepOffsets,5,[0, 80]);
ds_map_replace(prepOffsets,6,[-5, 75]);
ds_map_replace(prepOffsets,7,[-25, 75]);
ds_map_replace(prepOffsets,8,[-25, 75]);
ds_map_replace(prepOffsets,9,[-25, 75]);
ds_map_replace(prepOffsets,10,[-25, 75]);

var attackOffsets = ds_map_create();
ds_map_replace(attackOffsets,0,[30, 75]);
ds_map_replace(attackOffsets,1,[60, 60]);
ds_map_replace(attackOffsets,2,[75, 30]);
ds_map_replace(attackOffsets,3,[75, -10]);
ds_map_replace(attackOffsets,4,[60, -45]);

var recoverOffsets = ds_map_create();
ds_map_replace(recoverOffsets,0,[60, -45]);
ds_map_replace(recoverOffsets,1,[60, -45]);
ds_map_replace(recoverOffsets,2,[60, -45]);
ds_map_replace(recoverOffsets,3,[50, -45]);
ds_map_replace(recoverOffsets,4,[30, -40]);
ds_map_replace(recoverOffsets,5,[30, -30]);
ds_map_replace(recoverOffsets,6,[40, -15]);
ds_map_replace(recoverOffsets,7,[50, 0]);

var xOff = 35; var yOff = 0; // default, idle offsets
var map = noone;
switch state {
	case "prep": {
		map = prepOffsets; 	break;
	}
	case "attack": {
		map = attackOffsets; break;
	}
	case "recover": {
		map = recoverOffsets; break;
	}
}

if map != noone {
	var offsets = ds_map_find_value(map,frame);
	if offsets != undefined {
		xOff = offsets[0]; yOff = offsets[1];
	}
}

ds_map_destroy(prepOffsets); prepOffsets = -1;
ds_map_destroy(attackOffsets); attackOffsets = -1;
ds_map_destroy(recoverOffsets); recoverOffsets = -1;

return [xOff,yOff];