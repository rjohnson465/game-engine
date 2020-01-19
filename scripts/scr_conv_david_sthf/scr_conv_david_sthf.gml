global.ownerNpcName = "David";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = true;
c1.name = "Saving the Holidays (In Progress)";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "How’s it going? Speak to that schmuck, Santa? Find our stars?";
cs.sound = snd_conv_david_sthf_david_1;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "No… wouldn’t it be a better show of faith for you each to deliver your stars to each other, in person?";
cs.sound = snd_conv_david_sthf_gary_1;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "You want to talk to me about faith, Gary?";
cs.sound = snd_conv_david_sthf_david_2;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Nope. No. No. Nope. Nevermind. Sorry.";
cs.sound = snd_conv_david_sthf_gary_2;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);


return c1;