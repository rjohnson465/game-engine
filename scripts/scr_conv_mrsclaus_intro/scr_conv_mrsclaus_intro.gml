global.ownerNpcName = "Mrs. Claus";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = true;
c1.isRepeatable = false;
c1.name = "Mrs. Claus Intro";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Hey, Santa!";
cs.sound = snd_conv_mrsclaus_intro_gary_1;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Ugh you people, always giving him all the credit. No, it’s just me, Mrs. Claus. Sorry to disappoint.";
cs.sound = snd_conv_mrsclaus_intro_mrsclaus_1;
cs.speaker = obj_npc_mrsclaus;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Oh, my b. Why aren’t you with Santa in Christmas Town?";
cs.sound = snd_conv_mrsclaus_intro_gary_2;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "My sorry excuse for a husband’s always working, drinking, flirting with his reindeer and elves, but always too busy for me. I’m taking a little break from him to run this tavern, maybe some space will do us some good.";
cs.sound = snd_conv_mrsclaus_intro_mrsclaus_2;
cs.speaker = obj_npc_mrsclaus;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Feel free to hang around. I know the wild can be dangerous; I’ve got a few things for sale that might help.";
cs.sound = snd_conv_mrsclaus_intro_mrsclaus_3;
cs.speaker = obj_npc_mrsclaus;
ds_list_add(c1.steps,cs);

return c1;