
global.ownerNpcName = "Mrs. Claus";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isRepeatable = false;
c1.name = "Rescue Herbie";
c1.isUrgent = false;

var c = instance_create_depth(x,y,1,obj_conversation_step_parent);
c.text = "When I came down here to run the tavern away from Santa, Herbie, an elf, came with me. He’s always been a bit off, but he means well.";
c.sound = snd_conv_mrsclaus_shs_mrsclaus_1;
c.speaker = obj_npc_mrsclaus;
ds_list_add(c1.steps,c);

var c = instance_create_depth(x,y,1,obj_conversation_step_parent);
c.text = "Krampus texted me the other night about how one of his lady friends wears wolf-fang necklaces. I mean, of course I ignored the text, but I might have mentioned this fashion trend around Herbie, once or a dozen times.";
c.sound = snd_conv_mrsclaus_shs_mrsclaus_2;
c.speaker = obj_npc_mrsclaus;
ds_list_add(c1.steps,c);

var c = instance_create_depth(x,y,1,obj_conversation_step_parent);
c.text = "Herbie went off to find me some wolf fangs. I definitely wouldn’t wear them to impress Krampus or anything, haha, that would be silly, right? But just for me.";
c.sound = snd_conv_mrsclaus_shs_mrsclaus_3;
c.speaker = obj_npc_mrsclaus;
ds_list_add(c1.steps,c);

var c = instance_create_depth(x,y,1,obj_conversation_step_parent);
c.text = "Anyway, Herbie’s been gone for a while now. I’m afraid he’s gotten lost in some wolf den somewhere. There’s a big one, southeast of here. I’ll bet that’s where he went.";
c.sound = snd_conv_mrsclaus_shs_mrsclaus_4;
c.speaker = obj_npc_mrsclaus;
ds_list_add(c1.steps,c);

var c = instance_create_depth(x,y,1,obj_conversation_step_parent);
c.text = "If you can find him, please, help him come back to me.";
c.sound = snd_conv_mrsclaus_shs_mrsclaus_5;
c.speaker = obj_npc_mrsclaus;
c.func = questStart;
c.funcParam1 = obj_quest_savingherbie;
ds_list_add(c1.steps,c);

return c1;