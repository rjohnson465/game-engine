global.ownerNpcName = "Randolph, the Red-Nosed Reindeeer";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = true;
c1.name = "Mystic Ice";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Have you roamed the wild, and come across old, aquamarine chunks of ice, decorated with swirls of magic?";
cs.sound = snd_conv_randolph_mysticice_randolph_1;
cs.speaker = obj_npc_randolph;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Yes, those are known now only as Mystic Ice, relics from a time long ago. When Santa and Krampus first settled these lands, they were covered in this old, magic ice. He had me help melt much of it with my nose.";
cs.sound = snd_conv_randolph_mysticice_randolph_2;
cs.speaker = obj_npc_randolph;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Now, there are only a few chunks of it left. Who knows what secrets lie behind the ice?";
cs.sound = snd_conv_randolph_mysticice_randolph_3;
cs.speaker = obj_npc_randolph;
ds_list_add(c1.steps,cs);

return c1;