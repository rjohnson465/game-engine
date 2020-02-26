global.ownerNpcName = "Ari";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = true;
c1.isRepeatable = false;
c1.name = "Ari Intro";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Hey! You look strong, well-muscled...";
cs.sound = snd_conv_ari_saving_hershel_ari_1;
cs.speaker = obj_npc_ari;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Uh, thanks, but I’m not interested...";
cs.sound = snd_conv_ari_saving_hershel_gary_1;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Don’t flatter yourself, I just need your help. I’m Ari. In the room just south of here is my Golem, Hershel.";
cs.sound = snd_conv_ari_saving_hershel_ari_2;
cs.speaker = obj_npc_ari;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "We were taking a break from mining, here in the temple, when the Abominable Snowman’s Dark Winter Magic came from the West, and rose all these spirits, these dybbuks. I saw other golems getting possessed, and couldn’t let the same happen to my dear Hershel.";
cs.sound = snd_conv_ari_saving_hershel_ari_3;
cs.speaker = obj_npc_ari;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "I removed his Clay-Heart, so it could not be possessed, but now we’re stranded here -- I can’t carry him back to town, and I can feel the dybbuks circling Hershel’s unconscious body.";
cs.sound = snd_conv_ari_saving_hershel_ari_4;
cs.speaker = obj_npc_ari;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Please, take this clay, a piece of his heart. Put it back in him. The dybbuks will come to possess Hershel, I’m sure, but you can fight them off, can’t you?";
cs.sound = snd_conv_ari_saving_hershel_ari_5;
cs.speaker = obj_npc_ari;
cs.func = addItemToInventory;
cs.funcParam1 = instance_create_depth(x, y, 1, obj_item_clayheart);
cs.funcParam2 = true;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Pull this off, and I’ll reward you handsomely.";
cs.sound = snd_conv_ari_saving_hershel_ari_6;
cs.speaker = obj_npc_david;
cs.func = questStart;
cs.funcParam1 = obj_quest_helpinghershel;
ds_list_add(c1.steps,cs);

return c1;