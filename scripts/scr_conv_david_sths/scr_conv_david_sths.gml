global.ownerNpcName = "David";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = true;
c1.isRepeatable = false;
c1.name = "Saving the Holidays (Stars)";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Ah, you came through with the stars. Perhaps Santa is less of a meshugener than I thought!";
cs.sound = snd_conv_david_sths_david_1;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Does this mean you’ll work with Santa to complete the spell so I can enter the Abominable Lands, kill the snowman, and get into the casino?";
cs.sound = snd_conv_david_sths_gary_1;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Damn, I really just said that.";
cs.sound = snd_conv_david_sths_gary_2;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Hm… Yes, indeed, Gary. If not for you, than for my dear Hans. We must go to the Gazebo, in the Woods of Peace, in central Winter Wonderground. There, Santa and I will talk, and do the spell.";
cs.sound = snd_conv_david_sths_david_2;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);


return c1;