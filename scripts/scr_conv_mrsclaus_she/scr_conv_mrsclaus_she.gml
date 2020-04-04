global.ownerNpcName = "Mrs. Claus";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = false;
c1.name = "Rescue Herbie (Completed)";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Oh yay, you rescued Herbie! And he brought me some wolf teeth, wonderful! Krampus will be so impressed.";
cs.sound = snd_conv_mrsclaus_she_mrsclaus_1;
cs.speaker = obj_npc_mrsclaus;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Am I helping you cheat on your husband?";
cs.sound = snd_conv_mrsclaus_she_gary_1;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Hush now, Gary, but yes. Here’s your reward, you morally ambiguous boy.";
cs.sound = snd_conv_mrsclaus_she_mrsclaus_2;
cs.speaker = obj_npc_mrsclaus;
cs.func = completeQuest;
cs.funcParam1 = obj_quest_savingherbie;
ds_list_add(c1.steps,cs);

return c1;