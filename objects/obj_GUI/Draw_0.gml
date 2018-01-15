// lock on target
if (global.player.isLockedOn && global.player.lockOnTarget != noone) {
	draw_sprite(spr_lockon,1,global.player.lockOnTarget.x, global.player.lockOnTarget.y);
}