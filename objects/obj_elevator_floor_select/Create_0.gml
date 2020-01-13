associatedElevator = instance_nearest(x, y, obj_elevator);

numFloors = global.elevatorSelectNumFloors;

startFloor = global.elevatorStartFloor;

selectedFloor = getLayerFloorNumber(global.player.layer);

joystickInputFrame = 0;
joystickInputTotalFrames = 30;


global.isTrading = true;

hasSetAlarm = false;