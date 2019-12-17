/// @description Insert description here
// You can write your code in this editor
origLayer = layer;
depth = layer_get_depth(origLayer) + 5;
global.bridgeSpriteIndex = sprite_index;
global.bridgeAngle = image_angle;
// Inherit the parent event
event_inherited();

elevatorMoveSound = noone;
elevatorMusicSound = noone;

// it takes 2 seconds to go from one floor to the next, 60 frames
elevatorMoveFrame = 0;
elevatorMoveFrameTotal = 60;

elevatorScale = 1;

// any elevator occupants will be moved to the next floor with the elevator
elevatorOccupants = ds_list_create();
elevatorIsMoving = false;

elevatorBarrier = noone;

neverDeactivate = true;

elevatorCurrentFloor = getLayerFloorNumber(layer);
elevatorFloorToMoveTo = elevatorCurrentFloor;

elevatorName = noone;

// properties = ds_map_create();
ds_map_add(properties, "ElevatorCurrentFloor", elevatorCurrentFloor);
