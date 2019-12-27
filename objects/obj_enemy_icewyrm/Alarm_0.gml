/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if state != CombatantStates.Attacking && lockOnTarget != noone && substate != CombatantMoveSubstates.ReturningToPost {
	chooseMeleeAttack();
	alarm[0] = 60;
}