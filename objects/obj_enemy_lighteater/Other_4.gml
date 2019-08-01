/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// relight all lamplights when boss fight with lighteater starts (so lighteater has healing chances)
if room == rm_boss_lighteater {
	with obj_fairylight {
		lightSconce(noone);
	}
}


/*
// for better pathfinding....
with obj_fairylight {
	solid = false;
}