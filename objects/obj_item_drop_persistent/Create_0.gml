event_inherited();
items = ds_list_create();
sprite_index = noone;
isBeingLooted = false;

postX = x; postY = y; postZ = getLayerFloorNumber(layer); roomIndex = room;
currentX = x; currentY = y;

var sw = view_get_wport(view_camera[0]);
var sh = view_get_hport(view_camera[0]);

slotWidth = sprite_get_width(spr_item_slot);
slotHeight = sprite_get_height(spr_item_slot);
scrollLevel = 0;

topLeftX = sw-333.33-10; 
topLeftY = sh-148-10-50; // 10px padding, allow room for prompts
bottomRightX = sw-10;
bottomRightY = sh-10-50;
width = bottomRightX - topLeftX;

handleHeight = 20;

lootTopLeftX = topLeftX;
lootTopLeftY = topLeftY+20;

selectedItem = ds_list_find_value(items,0);

joystickInputFrame = 0;
joystickInputTotalFrames = 30;

global.isLooting = false;

//randomize();
//floatingFrame = random_range(0,59);
//scale = 1;
hasSetAlarm = false;

// light radius
//lightRadius = 256;
var floorNum = getLayerFloorNumber(layer);
lightRadiusAlpha = calculateLightRadiusAlphaLayer(floorNum)*2;
randomize();
floatingFrame = random_range(0, 119);
lightRadiusScale = .25;
lightRadiusColor = c_white;
lightRadiusSprite = spr_light_point;
isShowingLightRadius = true;
global.owner = id;
global.makeLightOnCreate = true;
lightRadius = instance_create_depth(x,y,1,obj_light_radius);

system = part_system_create();
part_system_depth(system,depth);
emitter = part_emitter_create(system);
// item particle
var magic = part_type_create();
part_type_shape(magic, pt_shape_spark);
part_type_color2(magic,C_GOLD,c_white);
part_type_orientation(magic,0,0,0,15,1);
part_type_size(magic,0.01,0.15,0,0);
part_type_speed(magic,.25,1,0,0);
part_type_direction(magic,0,360,0,4);
part_type_life(magic,20,30);
part_type_alpha2(magic, 1, .1);
particle = magic;

isNonPriorityInteractable = true;
isLooted = false;
ds_map_replace(properties, "isLooted", false);
ds_map_replace(properties, "currentX", x);
ds_map_replace(properties, "currentY", y);

distToPickup = 33;