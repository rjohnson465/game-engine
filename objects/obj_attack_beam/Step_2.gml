/// @description Insert description here
// You can write your code in this editor


if !hasSetAlarm && (!owner.isAlive || owner.hp <= 0) {
	event_perform(ev_other, ev_animation_end);
}