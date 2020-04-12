/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var p = global.player;
if isInUse {
	
	with p {
		
		p.poiseCurrent = p.poiseMax;
		
		// get rid of all temp xp
		xpTemp = 0;
	}
	
	isInUse = false;
}