// get to 100% scale at alarm[0] = 0
// geto to 75% alpha at alarm[0] = 0
// draw with c_red overlay

var tf = attackData.mrPrepDuration;
var a = 1;
var a = 1 - (.75/tf)*alarm[0]; // .25 - 1
var scale = 1 - (.75/tf)*alarm[0]; // .25 - 1

draw_sprite_ext(sprite_index,1,x,y,scale,scale,0,c_red,a);