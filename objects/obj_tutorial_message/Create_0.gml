promptSpritesController = [];
promptSpritesMk = [];
promptSpritesSeparators = [];
message = "Fountains save progress, and maybe, grant wishes... You revive at your last fountain on death.";
origLayer = layer;
depth = layer_get_depth(layer) + 5;
system = part_system_create();
part_system_depth(system,layer_get_depth(origLayer));
emitter = part_emitter_create(system);
// particle
particle = part_type_create();
part_type_shape(particle, pt_shape_cloud);
part_type_color2(particle,c_aqua,c_white);
part_type_alpha2(particle,.75,.15);
part_type_orientation(particle,0,0,0,15,1);
part_type_size(particle,0.1,0.25,0,0);
part_type_speed(particle,.05,.15,0,0);
part_type_direction(particle,0,360,0,4);
part_type_life(particle,10,45);

isActive = false;

var floorNum = getLayerFloorNumber(layer);
lightRadiusAlpha = calculateLightRadiusAlphaLayer(floorNum)*2;
if lightRadiusAlpha < .5 lightRadiusAlpha = .5;
lightRadiusScale = .1;
lightRadiusColor = c_aqua;
lightRadiusSprite = spr_light_point;
isShowingLightRadius = true;
global.owner = id;
global.makeLightOnCreate = true;
lightRadius = instance_create_depth(x,y,1,obj_light_radius);

key = fs_generate_key(id);

postX = x; postY = y;

	
/* 
isCurrentInteractableObject = isCurrentInteractionObject(id);
