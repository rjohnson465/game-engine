global.ownerNpcName = "Santa";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = true;
c1.name = "Saving the Holidays (In Progress)";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "How’s it going? Speak to that miscreant, David, yet? Find our stars?";
cs.sound = snd_conv_santa_sthf_santa_1;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "No… wouldn’t it be a better show of faith for you each to deliver your stars to each other, in person?";
cs.sound = snd_conv_santa_sthf_gary_1;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "There’s no time, Gary! Christmas is in less than twenty four hours!";
cs.sound = snd_conv_santa_sthf_santa_2;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Isn’t it always?";
cs.sound = snd_conv_santa_sthf_gary_2;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Ugh, now you sound just like Mrs. Claus. I need a drink...";
cs.sound = snd_conv_santa_sthf_santa_3;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

return c1;