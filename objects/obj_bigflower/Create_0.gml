event_inherited();
lightRadius = noone;
lightRadiusAlpha = .1;
lightRadiusScale = .5;
lightRadiusColor = make_color_rgb(62,144,255);
lightRadiusSprite = spr_light_point;
isShowingLightRadius = true;
global.owner = id;
global.makeLightOnCreate = true;
lightRadius = instance_create_depth(x,y,depth,obj_light_radius);
stopsAttacks = false;

depth += 1; // hands appear over flower

randomize();
glowMin = 2;
glowMax = 20;
glowAmount = random_range(glowMin,glowMax); // (px offset for "glow" effect)
isGlowIncreasing = true;