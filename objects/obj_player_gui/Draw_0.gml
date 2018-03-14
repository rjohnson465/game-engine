// lock on target
if instance_exists(global.player.lockOnTarget) {
	if (global.player.isLockedOn && global.player.lockOnTarget != noone) {
		draw_sprite(spr_lockon,1,global.player.lockOnTarget.x, global.player.lockOnTarget.y);
	}
} else global.player.lockOnTarget = noone;