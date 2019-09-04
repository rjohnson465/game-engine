color = make_color_rgb(255,227,161);
color = C_GOLD;


origLayer = layer;
isObstacleLayerless = false;
neverDeactivate = false;

depth += 1; // hands appear over flower
stopsAttacks = false;


randomize();
floatingFrame = random_range(0, 119);

event_inherited();