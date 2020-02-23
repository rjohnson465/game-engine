/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

questGiver = obj_npc_barry;
name = "Saving the Holidays";
description = "I tracked Tony to Winter Wonderground, where he escaped into his Olive Branch Casino. I must find someone to vouch for me so I can follow him.";

global.quest = id;
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_savingtheholidays_1));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_savingtheholidays_2));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_savingtheholidays_3));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_savingtheholidays_4));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_savingtheholidays_5));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_savingtheholidays_6));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_savingtheholidays_7));

xpReward = 1000;


system = part_system_create();
part_system_depth(system, -10000);
emitter = part_emitter_create(system);
part = part_type_create();
part_type_shape(part, pt_shape_snow);
part_type_color2(part,c_navy,c_ltgray);
part_type_orientation(part,0,0,0,15,1);
part_type_size(part,.2,.5,0,0);
part_type_speed(part,2,3,0,0);
part_type_direction(part,0,360,0,4);
part_type_life(part,15,30);