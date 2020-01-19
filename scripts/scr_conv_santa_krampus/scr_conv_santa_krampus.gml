global.ownerNpcName = "Santa";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = false;
c1.name = "The Anti-Santa";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "I have lived in fear and shame of the evil monster, Krampus, long enough";
cs.sound = snd_conv_santa_krampus_santa_1;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "He spreads despair and hates Christmas. He stole my elves and tortured and twisted them to his cause. He once texted Mrs. Claus at 2AM a single eggplant emoji.";
cs.sound = snd_conv_santa_krampus_santa_2;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Please, venture to his abode, and slay Krampus. Do this for a holly jolly reward.";
cs.sound = snd_conv_santa_krampus_santa_3;
cs.speaker = obj_npc_santa;
cs.func = questStart;
cs.funcParam1 = obj_quest_krampus;
ds_list_add(c1.steps,cs);

return c1;