/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

eventName = "Defeat the unfairies!";
associatedWallKeys = ["unfairies_wall_1", "unfairies_wall_2", "unfairies_wall_3"];

global.event = id;
ds_list_add(eventSteps, instance_create_depth(x,y,1,obj_evstep_constructionhat_guards_1));

eventBgm = snd_bgm_ev_fight_1;

// todo maybe make this state different
if global.player.narrativeState > NarrativeState.WinterWonderground {
	instance_destroy(id, 1);
}