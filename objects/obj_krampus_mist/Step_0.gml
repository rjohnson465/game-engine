with obj_attack {
	if place_meeting(x, y, other) && owner == global.player && isRanged || isSpell {
		instance_destroy(id, 1);
		audio_play_sound_at(snd_hit_ice_1, x, y, depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
		with other {
			part_emitter_region(system, emitter, other.x, other.x+1, other.y, other.y+1, ps_shape_ellipse, ps_distr_gaussian);
			part_emitter_burst(system, emitter, partSnowflake, 10);
		}
	}
}


var w = bbox_right - bbox_left;
var h = bbox_bottom - bbox_top;
var a = w * h;
var gridSquares = (a / 32) / 32;
var pNum = 1;
part_emitter_region(system, emitter, bbox_left, bbox_right, bbox_top, bbox_bottom, ps_shape_rectangle, ps_distr_gaussian);
part_emitter_burst(system, emitter, partSmoke, pNum);