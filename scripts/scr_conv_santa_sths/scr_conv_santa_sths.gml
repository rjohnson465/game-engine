global.ownerNpcName = "Santa";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = true;
c1.isRepeatable = false;
c1.name = "Saving the Holidays (Stars)";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Ho ho holy moly, you got the stars! Maybe David will come through after all.";
cs.sound = snd_conv_santa_sths_santa_1;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Does this mean you’ll work with David to complete the spell so I can enter the Abominable Lands, kill the snowman, and get into the casino?";
cs.sound = snd_conv_santa_sths_gary_1;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Damn, I really just said that.";
cs.sound = snd_conv_santa_sths_gary_2;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Hm… I suppose so. We must go to the Gazebo, in the Woods of Peace, in central Winter Wonderground. There, David and I will talk, and do the spell.";
cs.sound = snd_conv_santa_sths_santa_2;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

return c1;