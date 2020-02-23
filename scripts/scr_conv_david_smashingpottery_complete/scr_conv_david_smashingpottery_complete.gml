global.ownerNpcName = "David";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = false;
c1.name = "Smashing Pottery (Complete)";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Ah, it is done -- you have returned Amir to the clay. Thank you. Now my friend may finally rest.";
cs.sound = snd_conv_david_smashingpottery_complete_david_1;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Take this, as your reward. I will not forget this favor, Gary. You are welcome in my village anytime.";
cs.sound = snd_conv_david_smashingpottery_complete_david_2;
cs.speaker = obj_npc_david;
cs.func = completeQuest;
cs.funcParam1 = instance_nearest(x,y,obj_quest_smashingpottery);
ds_list_add(c1.steps,cs);


return c1;