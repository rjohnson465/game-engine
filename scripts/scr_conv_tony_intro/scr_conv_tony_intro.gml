global.ownerNpcName = "Tony, the Unfairy Godfather";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isRepeatable = false;
c1.name = "Tony Intro";

var c1s1 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1s1.text = "No! No! What have you done? My magnificent beast… We’ll have to start all over...";
c1s1.sound = snd_conv_tony_intro_tony_1;
c1s1.speaker = obj_npc_tony;

var c1s2 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1s2.text = "You will regret the day you crossed Tony, the Unfairy Godfather! You owe me a debt now, and I always get paid in full. The house always wins…";
c1s2.sound = snd_conv_tony_intro_tony_2;
c1s2.speaker = obj_npc_tony;

var c1s3 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1s3.text = "...";
c1s3.sound = noone;
c1s3.speaker = obj_npc_tony;
c1s3.func = scr_tony_runaway;

ds_list_add(c1.steps,c1s1);
ds_list_add(c1.steps,c1s2);
ds_list_add(c1.steps,c1s3);

return c1;