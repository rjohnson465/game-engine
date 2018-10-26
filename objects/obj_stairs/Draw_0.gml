var vx = camera_get_view_x(view_camera[0]); var vy = camera_get_view_y(view_camera[0]);
var vw = camera_get_view_width(view_camera[0]); var vh = camera_get_view_height(view_camera[0]);
if !point_in_rectangle(x,y,vx-100,vy-100,vx+vw+100,vy+vh+100) exit; 
var playerFloor = getLayerFloorNumber(global.player.layer);

var ys = floorDown == playerFloor ? 1 : -1;
var c1 = floorDown == playerFloor ? c_navy : c_maroon;
var c2 = floorDown == playerFloor ? c_aqua : make_color_rgb(255, 201, 240);
part_type_color2(part,c1,c2);
floatingFrame += 1;
floatingFrame %= 60;
scale = .1*cos((pi*floatingFrame)/30)+.9;

var delta = .1;
if isGlowIncreasing && glowAmount >= glowMax {
	isGlowIncreasing = false;
} else if glowAmount <= glowMin {
	isGlowIncreasing = true;
}
if !isGlowIncreasing {
	delta*= -1;
}
glowAmount += delta;


gpu_set_blendmode(bm_add);
for(var c = 0;c < 360;c += 15){
	draw_sprite_ext(spr_stairs_arrow,1,x+lengthdir_x(glowAmount,c),y+lengthdir_y(glowAmount,c),scale,ys*scale,0,c2,.15);
}
gpu_set_blendmode(bm_normal)
draw_sprite_ext(spr_stairs_arrow,1,x,y,scale,ys*scale,0,c2,1);