global.ownerNpcName = "Elon";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = true;
c1.name = "Ice Wyrms";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "I’ve driven many Ice Wyrms off my stead over the past few years. My musk oxen hate them nearly as much as I hate a day without presents.";
cs.sound = snd_conv_elon_iceywrms_elon_1;
cs.speaker = obj_npc_elon;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "They’re real hard to get rid of… they burrow underground to move, and it’s hard to know where they’ll pop up next.";
cs.sound = snd_conv_elon_iceywrms_elon_2;
cs.speaker = obj_npc_elon;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "If you do manage to hit one, try using fire. Those things hate fire, nearly as much as I hate folks who think a muskox and a yak are the same thing.";
cs.sound = snd_conv_elon_iceywrms_elon_3;
cs.speaker = obj_npc_elon;
ds_list_add(c1.steps,cs);


return c1;