/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// if the spore is present for the rooms start event, it does not go through its inactive period
if sporeIsInactive {
	sporeIsInactive = false;
	isInvulnerable = false;
	state = CombatantStates.Idle;
	substate = CombatantMoveSubstates.Chasing;
}

