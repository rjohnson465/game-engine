/// @description makeGlanceMaskCircle(centerX,centerY,radius)
/// @param centerXOffset
/// @param centerYOffset
/// @param radius

// returns true if there are no walls between player and it 
var centerXOffset = argument[0];
var centerYOffset = argument[1];
var radius = argument[2];
var circle = instance_create_depth(0,0,1,obj_glance_mask_circle);
circle.centerXOffset = centerXOffset;
circle.centerYOffset = centerYOffset;
circle.radius = radius;
return circle;