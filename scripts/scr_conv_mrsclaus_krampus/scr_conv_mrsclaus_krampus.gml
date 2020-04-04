global.ownerNpcName = "Mrs. Claus";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = true;
c1.name = "Krampus";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Sometimes Krampus texts me. I mean, like, no way would that ever happen, but it’s nice to feel wanted, right?";
cs.sound = snd_conv_mrsclaus_krampus_mrsclaus_1;
cs.speaker = obj_npc_mrsclaus;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "I know he’s evil and all that, but mmm have you seen his horns?";
cs.sound = snd_conv_mrsclaus_krampus_mrsclaus_2;
cs.speaker = obj_npc_mrsclaus;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "For all I know, Santa and Vixen are on a date right now, why shouldn’t I have any fun?";
cs.sound = snd_conv_mrsclaus_krampus_mrsclaus_3;
cs.speaker = obj_npc_mrsclaus;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Wait, Santa and a reindeer… ugh… they…?";
cs.sound = snd_conv_mrsclaus_krampus_gary_1;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "No more questions, Gary. Buy a drink or something, okay?";
cs.sound = snd_conv_mrsclaus_krampus_mrsclaus_4;
cs.speaker = obj_npc_mrsclaus;
ds_list_add(c1.steps,cs);

return c1;