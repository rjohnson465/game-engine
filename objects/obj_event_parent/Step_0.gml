/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// activate associated walls when active
if isActive && !hasActivatedWalls {
	for (var i = 0; i < array_length_1d(associatedWallKeys); i++) {
		var wKey = associatedWallKeys[i];
		var w = noone;
		with obj_event_wall {
			if key == wKey {
				w = id;
			}
		}
		
		if w != noone {
			w.isUntraversable = true;
		}
	}
	
	hasActivatedWalls = true;
	
	global.isPopulatingGrids = true;
}

if isActive {
	part_emitter_burst(system, emitter, part, 25);
}
