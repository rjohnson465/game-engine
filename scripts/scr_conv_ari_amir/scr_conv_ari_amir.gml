global.ownerNpcName = "Ari";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = true;
c1.name = "Golem Lord Amir";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Have you been to the chamber on the first floor, east of here?";
cs.sound = snd_conv_ari_gka_ari_1;
cs.speaker = obj_npc_ari;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Amir, and old, once-beloved golem lord has been possessed by a particularly nasty dybbuk, and taken up residence there.";
cs.sound = snd_conv_ari_gka_ari_2;
cs.speaker = obj_npc_ari;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "The chamber was once Amir’s throne room, where he listened to his golem subjects wisely, but now it has become a mockery of itself. The possessed Amir wields a terrible metal staff. He's attached a menorah to it, and now it deals deadly fire attacks.";
cs.sound = snd_conv_ari_gka_ari_3;
cs.speaker = obj_npc_ari;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Though maybe, given all this snow, we should be thankful for a little warmth, hm?";
cs.sound = snd_conv_ari_gka_ari_4;
cs.speaker = obj_npc_ari;
ds_list_add(c1.steps,cs);


return c1;