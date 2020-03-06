/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var p = global.player;
if layer == p.layer && rectangle_in_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, p.bbox_left, p.bbox_top, p.bbox_right, p.bbox_bottom) 
	&& !isActive && !isFinished {
	scr_event_start(id);
}

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
