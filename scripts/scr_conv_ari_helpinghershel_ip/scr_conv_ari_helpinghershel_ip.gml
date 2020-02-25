global.ownerNpcName = "Ari";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = true;
c1.name = "Helping Hershel (In Progress)";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Go on, Hershel’s in the room just south of here. I know you can do it, you buff, hunky boy!";
cs.sound = snd_conv_ari_saving_hershel_ip_ari_1;
cs.speaker = obj_npc_ari;
ds_list_add(c1.steps,cs);

return c1;