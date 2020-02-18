neverDeactivate = false;
material = WOOD; 
stopsAttacks = false;
isObstacleLayerless = false;
origLayer = layer;
// depth  5;

var back = instance_create_depth(x, y, layer_get_depth(origLayer), obj_ww_claythone_lower);
back.image_angle = image_angle;