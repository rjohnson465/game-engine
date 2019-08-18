var color = make_color_rgb(255,227,161);
color = C_GOLD;
light_create_layer(spr_light_point, .3, color, .7, 0, 1);

origLayer = layer;
isObstacleLayerless = false;
neverDeactivate = false;

depth += 1; // hands appear over flower
stopsAttacks = false;


randomize();
floatingFrame = random_range(0, 119);

event_inherited();