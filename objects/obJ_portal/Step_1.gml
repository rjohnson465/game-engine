/*if distance_to_object(obj_player) < 20 && !isUntraversable {
	maybeAddObjectToInteractionList(id);
} else maybeRemoveObjectFromInteractionList(id); */

var fn = getLayerFloorNumber(layer);
var pfn = getLayerFloorNumber(global.player.layer);
if fn > pfn exit;
scale = .1*cos((pi*scaleFrame)/30)+.9;
scaleFrame = (scaleFrame + 1)%60;

light_set_multiscale(lightScaleX*scale, lightScaleY*scale);


if layer == global.player.layer {
	var sw = sprite_width*scale; var sh = sprite_height*scale;
	var x1 = x-(.5*sw); var y1 = y - (.5*sh);
	var x2 = x1 + sw; var y2 = y1 + sh;
	part_emitter_region(system, emitter, x1,x2,y1,y2,ps_shape_rectangle,ps_distr_gaussian);
	// 32x32 is 10, so map 1024 to 10
	var area = sprite_width * sprite_height;
	var num = (5*area) / 512;
	if num > 40 num = 40;
	part_emitter_burst(system, emitter, part, num);
}

// if there is a living boss in the room, make portal untraversable

//if !isUntraversable {
isUntraversable = false;
with obj_enemy_parent {
	if isBoss && isAlive {
		other.isUntraversable = true;
		with other {
			light_set_color(c_white);
			audio_emitter_gain(audioEmitter,0);
		}
	}
}
//} else 
if !isUntraversable && _light_color != c_fuchsia {
	light_set_color(c_fuchsia)
	audio_emitter_gain(audioEmitter,1);
}