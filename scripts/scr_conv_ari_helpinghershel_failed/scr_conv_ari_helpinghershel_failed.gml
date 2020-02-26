global.ownerNpcName = "Ari";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = true;
c1.isRepeatable = false;
c1.name = "Helping Hershel (Failed)";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Oh, no, Hershel was possessed wasn’t he?";
cs.sound = snd_conv_ari_saving_hershel_f_ari_1;
cs.speaker = obj_npc_ari;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "He wouldn’t let himself be -- when he realized it was over, he tore his clay heart out.";
cs.sound = snd_conv_ari_saving_hershel_f_gary_1;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Damn, that’s so metal. No worries, here’s some more clay -- try, try again!";
cs.sound = snd_conv_ari_saving_hershel_f_ari_2;
cs.speaker = obj_npc_ari;
cs.func = scr_quest_helpinghershel_getclay;
ds_list_add(c1.steps,cs);

return c1;