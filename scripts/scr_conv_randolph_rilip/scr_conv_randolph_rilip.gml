global.ownerNpcName = "Randolph, the Red-Nosed Reindeeer";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = true;
c1.name = "Reindeer Love (In Progress)";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "What, still haven’t found any carrots for my beloved Vixen?";
cs.sound = snd_conv_randolph_rilip_randolph_1;
cs.speaker = obj_npc_randolph;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Hmm… it was once said a fairy citizen of Winter Wonderground had some. Bjorn, he was called.";
cs.sound = snd_conv_randolph_rilip_randolph_2;
cs.speaker = obj_npc_randolph;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "What became of him? Oh, I don’t know. Lots of bad things can happen out in the wild...";
cs.sound = snd_conv_randolph_rilip_randolph_3;
cs.speaker = obj_npc_randolph;
ds_list_add(c1.steps,cs);

return c1;