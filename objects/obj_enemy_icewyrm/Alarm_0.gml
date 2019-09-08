/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if state != CombatantStates.Attacking {
	chooseMeleeAttack();
	alarm[0] = 60;
}