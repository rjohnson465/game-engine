sprite_index = global.bridgeSpriteIndex;
image_angle = global.bridgeAngle;
layer = origLayer;
origLayer = layer;
depth = layer_get_depth(layer) + 1;
populateGrids();