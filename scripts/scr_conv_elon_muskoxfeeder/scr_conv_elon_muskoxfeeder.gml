
global.ownerNpcName = "Elon";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isRepeatable = false;
c1.name = "Muskox Feeder";
c1.isUrgent = false;

var c = instance_create_depth(x,y,1,obj_conversation_step_parent);
c.text = "Hello again! I’m in sort of a jam here, and it’s much less delicious than it sounds. Think you can help me?";
c.sound = snd_conv_elon_mf_elon_1;
c.speaker = obj_npc_elon;
ds_list_add(c1.steps,c);

var c = instance_create_depth(x,y,1,obj_conversation_step_parent);
c.text = "Are you about to give me a menial task while I’m in the midst of solving a conspiracy and putting a stop to evil?";
c.sound = snd_conv_elon_mf_gary_1;
c.speaker = obj_player;
ds_list_add(c1.steps,c);

var c = instance_create_depth(x,y,1,obj_conversation_step_parent);
c.text = "Yep! I got so wrapped up in wrapping up presents, I’ve lost some of my muskox pets! They tend to wander off, and I’ll bet they’re hungry by now.";
c.sound = snd_conv_elon_mf_elon_2;
c.speaker = obj_npc_elon;
ds_list_add(c1.steps,c);

var c = instance_create_depth(x,y,1,obj_conversation_step_parent);
c.text = "Please, friend, do me a favor and feed as many as you can! Here’s a bag of their food. I’ll be sure to have a reward for you!";
c.sound = snd_conv_elon_mf_elon_3;
c.speaker = obj_npc_elon;
c.func = scr_elon_give_muskoxfood;
ds_list_add(c1.steps,c);


return c1;