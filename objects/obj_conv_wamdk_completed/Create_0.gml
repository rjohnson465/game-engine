event_inherited();
name = "Where Are My Damn Keys (Complete)";
ownerNpcName = "The Elder, Barry";

var s1 = instance_create_depth(x,y,1,obj_conversation_step_parent);
s1.text = "Great work, Gary. Let's get mochas together when this all blows over.";
s1.sound = snd_conv_wamdk_complete_1;
s1.func = completeQuest;
s1.funcParam1 = instance_nearest(x, y, obj_quest_wamdk);
s1.speaker = obj_npc_barry;
ds_list_add(steps, s1);

var s1 = instance_create_depth(x,y,1,obj_conversation_step_parent);
s1.text = "For now, no time to waste. Get to the Lamplight Factory, south of here, and see what you can find.";
s1.sound = snd_conv_wamdk_complete_2;
s1.speaker = obj_npc_barry;
ds_list_add(steps, s1);
isRepeatable = false;