var doDrawDamage = ds_map_find_value(global.optionsManager.optionsMapDisplay, OPT_D_DAMAGENUMBERS);
if !doDrawDamage exit;

if !instance_exists(victim) exit;

if victim.layer != global.player.layer || (!victim.showHp && victim.type != CombatantTypes.Player) exit;
// boss enemies draw their damage above their health bar at the bottom of the screen
// if victim.type == CombatantTypes.Enemy && victim.isBoss exit;

var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);
draw_set_color(c_white);
draw_set_font(font_damage);
draw_set_halign(fa_left);

var x1 = 0; var y1 = 0;

x1 = victimX - vx;
y1 = victimY - vy;
// decrease y1 based on time
y1 -= frame*2;

var text = string(round(amount));
if bonusDamage > 0 {
	text += " + " + string(bonusDamage);
}
var scale = 1;
if frame < 11 && isCriticalHit {
	// scale = ((-1/11)*frame)+2;
	scale = ((-3/11)*frame)+4;
}
if frame > 11 {
	draw_set_alpha(1-((frame-11)/11));
}
var c2 = isCriticalHit ? c_purple : c_yellow;
if victim.type == CombatantTypes.Player {
	c2 = isCriticalHit ? c_maroon : c_red;
}

if color != noone {
	c2 = color;
}

// healing
if color == c_lime {
	text = "+" + string(text);
}

var ang = frame * rotationAngle;
scr_draw_text_outline(x1,y1,text,c_white,c2,scale,scale,ang,c_black);
draw_set_alpha(1);

