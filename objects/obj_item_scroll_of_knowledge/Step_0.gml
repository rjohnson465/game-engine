/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isInUse {
	with global.player {
		var thirdTempXp = round(xpTemp / 3);
		xp += thirdTempXp;
		xpTemp -= thirdTempXp;
	}
	isInUse = false;
}