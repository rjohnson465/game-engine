x = x + lengthdir_x(16, image_angle);
y = y + lengthdir_y(16, image_angle);

origLayer = layer;
depth = layer_get_depth(layer)-2;

// onlyDrawLightOnPlayerLayer = true;

isOn = false;

// light_create_layer(spr_light_point, .3, c_red, .4, 0, 1);
