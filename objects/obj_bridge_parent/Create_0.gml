event_inherited();
postX = x;
postY = y;
key = fs_generate_key();
data = noone;

isObstacleLayerless = false;

sprite_index = global.bridgeSpriteIndex;
image_angle = global.bridgeAngle;
layer = origLayer;
origLayer = layer;
depth = layer_get_depth(layer) + 1;

// global.isPopulatingGrids = true;

// clear grid cells this object used to occupy
var grid = ds_map_find_value(global.grids, getLayerFloorNumber(layer));
mp_grid_clear_rectangle(grid, bbox_left, bbox_top, bbox_right, bbox_bottom);

speed = 0;
vspeed = 0;
hspeed = 0;
path_end();

freesGridCells = true;
