global.ownerNpcName = "David";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = false;
c1.name = "Smashing Pottery";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "I’m sure you’ve seen many of our golems misbehaving, murdering, and generally acting with poor manners. Many have been possessed by dybukks, malicious spirits.";
cs.sound = snd_conv_david_smashingpottery_david_1;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "There is one among them, larger and more powerful than the rest, named Amir. Through his strength and service, he became a leader among his people. He was once my dear friend, but has now been possessed by a particularly nasty dybukk.";
cs.sound = snd_conv_david_smashingpottery_david_2;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Please, if you find him, end his suffering and return him to the clay. I will reward you handsomely, should you succeed.";
cs.sound = snd_conv_david_smashingpottery_david_3;
cs.speaker = obj_npc_david;
cs.func = questStart;
cs.funcParam1 = obj_quest_smashingpottery;
ds_list_add(c1.steps,cs);


return c1;