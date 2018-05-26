// lock on target
if instance_exists(global.player.lockOnTarget) {
	if (global.player.isLockedOn && global.player.lockOnTarget != noone) {
		var rot = (alarm[0]/60)*360;
		draw_sprite_ext(spr_lockon,1,global.player.lockOnTarget.x, global.player.lockOnTarget.y,1,1,rot,c_white,1);
	}
} else global.player.lockOnTarget = noone;