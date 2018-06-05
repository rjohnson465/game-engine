if !instance_exists(global.player.leftHandItem) && !instance_exists(global.player.rightHandItem) exit;
if (global.player.leftHandItem == noone && global.player.rightHandItem == noone) || global.player.leftHandItem.chargesMax == 0 && global.player.rightHandItem.chargesMax == 0 {
	x = -100;
	y = -100;
}