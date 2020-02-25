global.ownerNpcName = "Ari";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = true;
c1.isRepeatable = false;
c1.name = "Helping Hershel (Completed)";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Thank you so much, you borderline bodybuilder you.";
cs.sound = snd_conv_ari_saving_hershel_c_ari_1;
cs.speaker = obj_npc_ari;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "As promised, your reward!";
cs.sound = snd_conv_ari_saving_hershel_c_ari_2;
cs.speaker = obj_npc_ari;
cs.func = completeQuest;
cs.funcParam1 = obj_quest_helpinghershel;
ds_list_add(c1.steps,cs);

return c1;