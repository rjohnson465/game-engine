if elevatorCurrentFloor != elevatorFloorToMoveTo {
	
	// immediately populate elevator occupants list
	if !elevatorIsMoving {
		
		// create barrier so player cannot jump off elevator
		elevatorBarrier = instance_create_depth(x,y,layer_get_depth(origLayer),obj_elevator_barrier);
		elevatorBarrier.layer = global.player.layer;
		
		// move sound
		elevatorMoveSound = audio_play_sound_at(snd_elevator_move, x, y, depth, 200, AUDIO_MAX_FALLOFF_DIST, 1, 1, 1);
		
		with obj_combatant_parent {
			if place_meeting_layer(x, y, other) {
				ds_list_add(other.elevatorOccupants, id);
			}
		}
		with obj_npc_parent {
			if place_meeting_layer(x, y, other) {
				ds_list_add(other.elevatorOccupants, id);
			}
		}
	}
	
	elevatorIsMoving = true;
	
	// find out if moving up or down
	var isMovingUp = elevatorFloorToMoveTo > elevatorCurrentFloor;
	
	// If elevatorFrames == elevatorTotalFrames:
	// 1) Update layer of the elevator and all of its occupants
	// 2) Maybe updateRoomLayers, if player is one of those occupants
	// 3) Check if we are at floorToMoveTo. Set elevatorFrame to 0
	// If yes, stop elevator, isMoving = false
	// If no, keep going
	if elevatorMoveFrame == elevatorMoveFrameTotal {
		
		elevatorMoveFrame = 0;
		elevatorScale = 1;
		
		if isMovingUp {
			elevatorCurrentFloor += 1;
		} else {
			elevatorCurrentFloor -= 1;
		}
		
		// update properties object
		updatePersistentElementProperty(id, "ElevatorCurrentFloor", elevatorCurrentFloor);
		
		// Play thud sound?
		audio_play_sound_at(snd_crunchy_thud, x, y, depth, 200, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
		
		// For this frame, draw at normal scale
		draw_self();
		
		if elevatorCurrentFloor == elevatorFloorToMoveTo {	
			elevatorIsMoving = false;
			ds_list_clear(elevatorOccupants);
			audio_play_sound_at(snd_elevator_ding, x, y, depth, 200, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
			audio_stop_sound(elevatorMoveSound); elevatorMoveSound = noone;
			instance_destroy(elevatorBarrier, 1); elevatorBarrier = noone;
		} 
		
		exit;
	}
	
	// at halfway point, change layers
	if elevatorMoveFrame == .5*elevatorMoveFrameTotal {
		var nextFloorNum = isMovingUp ? elevatorCurrentFloor + 1 : elevatorCurrentFloor - 1;
		var nextLayerName = "instances_floor_" + string(nextFloorNum);
		var nextLayer = layer_get_id(nextLayerName);
		layer = nextLayer;
		origLayer = layer;
		depth = layer_get_depth(origLayer) + 5;
		elevatorBarrier.layer = nextLayer;
		
		if ds_exists(elevatorOccupants, ds_type_list) && ds_list_size(elevatorOccupants) > 0 {
			for (var i = 0; i < ds_list_size(elevatorOccupants); i++) {
				var occupant = ds_list_find_value(elevatorOccupants, i); 
				with occupant {
					
					var oldLayer = layer;
					layer = nextLayer;
					if occupant != global.player && variable_instance_exists(occupant, "origLayer") {
						origLayer = layer;
					}
					var lr = noone;
					with obj_light_radius {
						if owner == other {
							lr = id;
						}
					}
					if lr != noone {
						updateLightLayer(lr,oldLayer,layer);
					}
					populatePersonalGrid();
					tempPostX = x;
					tempPostY = y;
					if type == CombatantTypes.Enemy {
						updatePersistentElementProperty(id, "TempPostX", tempPostX);
						updatePersistentElementProperty(id, "TempPostY", tempPostY);
						updatePersistentElementProperty(id, "TempPostZ", layer);
					}
					
					if object_is_ancestor(object_index, obj_npc_parent) {
						npcData.layerName = layer_get_name(layer);
					}
				}
			}
		}
		
		// if occupants include player, update whats visible 
		if ds_list_find_index(elevatorOccupants, global.player) > -1 {
			// update what is visibile to the player 
			global.isUpdatingRoomLayers = true;
			// this elevator may now be covering a previously untraversable fallzone
			global.isPopulatingGrids = true; 
		}
		
		// if the occupants are at or below player layer, they are visible 
		for (var i = 0; i < ds_list_size(elevatorOccupants); i++) {
			var pFloorNum = getLayerFloorNumber(global.player.layer);
			var occupant = ds_list_find_value(elevatorOccupants, i);
			var oFloorNum = getLayerFloorNumber(occupant.layer);
			if oFloorNum <= pFloorNum {
				occupant.visible = true;
			}
		}
		
	}
	
	elevatorMoveFrame += 1;
	
	// find out what scale to draw elevator and all occupants on it, based on movingFrame
	if isMovingUp {
		// start ascent going from scale 1 -> 1.25
		if elevatorMoveFrame <= .5*elevatorMoveFrameTotal {
			elevatorScale = ((1/(2*elevatorMoveFrameTotal)) * elevatorMoveFrame) + 1;
		} else {
			// finish ascent going from scale .75 -> 1
			elevatorScale = ((1/(2*elevatorMoveFrameTotal)) * elevatorMoveFrame) + .5;
		}
	} else {
		// start descent going from scale 1 -> .75
		if elevatorMoveFrame <= .5*elevatorMoveFrameTotal {
			elevatorScale = ((-1/(2*elevatorMoveFrameTotal)) * elevatorMoveFrame) + 1;
		} else {
			// finish descent going from scale 1.25 -> 1
			elevatorScale = ((-1/(2*elevatorMoveFrameTotal)) * elevatorMoveFrame) + 1.5;
		}
	}
}

var pFloorNum = getLayerFloorNumber(global.player.layer);
var myFloorNum = getLayerFloorNumber(origLayer);
visible = myFloorNum <= pFloorNum;
