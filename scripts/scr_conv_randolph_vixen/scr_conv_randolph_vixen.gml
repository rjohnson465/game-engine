global.ownerNpcName = "Randolph, the Red-Nosed Reindeeer";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = true;
c1.name = "Vixen";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Vixen, my beloved, is the most beautiful reindeer in the world. I could write songs and poems to describe her wonders for years, if I had thumbs or any degree of literacy.";
cs.sound = snd_conv_randolph_vixen_randolph_1;
cs.speaker = obj_npc_randolph;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "You are very ugly, my friend, so I fear you will never know such love. Perhaps from a desperate, sentient toaster or something, but that would be far too shocking.";
cs.sound = snd_conv_randolph_vixen_randolph_2;
cs.speaker = obj_npc_randolph;
ds_list_add(c1.steps,cs);

return c1;