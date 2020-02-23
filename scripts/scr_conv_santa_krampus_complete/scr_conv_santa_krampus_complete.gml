global.ownerNpcName = "Santa";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = false;
c1.name = "The Anti-Santa (Complete)";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Wow you killed Krampus! Congratulations, maybe you won’t get coal this year.";
cs.sound = snd_conv_santa_krampus_complete_santa_1;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "I see you got one of my hats Krampus stole from me. Consider it your reward.";
cs.sound = snd_conv_santa_krampus_complete_santa_2;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Now we must drink, to your most wonderful victory. Suck it, Krampus.";
cs.sound = snd_conv_santa_krampus_complete_santa_3;
cs.speaker = obj_npc_santa;
cs.func = completeQuest;
cs.funcParam1 = instance_nearest(x,y,obj_quest_krampus);;
ds_list_add(c1.steps,cs);

return c1;