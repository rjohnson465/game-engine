global.ownerNpcName = "Santa";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = true;
c1.name = "Krampus Elves";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "If you venture north of here, you will enter a dangerous tundra, ruled by the evil, Christmas-hating monster, Krampus.";
cs.sound = snd_conv_santa_krampuselves_santa_1;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Krampus took my elves, long ago, and twisted them with vile magic, making them his minions. He calls them Krampus-elves, to mock me.";
cs.sound = snd_conv_santa_krampuselves_santa_2;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Beware these foul creatures, Gary. They are strong, and resist ice and magic attacks with ease.";
cs.sound = snd_conv_santa_krampuselves_santa_3;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

return c1;