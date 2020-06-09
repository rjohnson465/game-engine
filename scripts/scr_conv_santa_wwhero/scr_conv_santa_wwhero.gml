global.ownerNpcName = "Santa";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = true;
c1.name = "The Hero of Winter Wonderground";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Ah, Gary! The Hero of Winter Wonderground. Thanks again for freeing us from the tyranny of the Abominable Snowman!";
cs.sound = snd_conv_santa_wwhero_santa_1;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Now if you could just give me the key to a successful marriage, then we’d really be onto something, eh?";
cs.sound = snd_conv_santa_wwhero_santa_2;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

return c1;