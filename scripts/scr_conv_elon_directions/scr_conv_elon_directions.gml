global.ownerNpcName = "Elon";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = true;
c1.name = "Directions";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Still a bit lost, hm?";
cs.sound = snd_conv_elon_directions_elon_1;
cs.speaker = obj_npc_elon;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Let’s see… to the east, you’ll find Christmas Town. Never been a more jolly place! You should chat with Santa there, he’s a lovely man, if in desperate need of a pilates class.";
cs.sound = snd_conv_elon_directions_elon_2;
cs.speaker = obj_npc_elon;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "If you venture west, you should happen upon Hannukah Town… you could speak with their Rabbi, David. Between you and me, though, I think his dreidel is loaded.";
cs.sound = snd_conv_elon_directions_elon_3;
cs.speaker = obj_npc_elon;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "If you go south, far enough, you’ll get to the domain of the Abominable Snowman. I highly recommend it, if you’re seeking a painful death.";
cs.sound = snd_conv_elon_directions_elon_4;
cs.speaker = obj_npc_elon;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "There are bound to be some other useful things in the wild, too, but I can’t just be giving all that away now, can I? Go forth, explore! And please pet my beautiful musk oxen when you see them.";
cs.sound = snd_conv_elon_directions_elon_5;
cs.speaker = obj_npc_elon;
ds_list_add(c1.steps,cs);


return c1;