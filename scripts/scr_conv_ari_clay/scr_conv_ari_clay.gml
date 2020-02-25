global.ownerNpcName = "Ari";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = true;
c1.name = "The Wonders of Clay";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "We’ve been mining clay from these fields for centuries. It’s wonderful, and with a little touch of magic, we can make golems, our usually benevolent companions, servants, and guardians.";
cs.sound = snd_conv_ari_clay_ari_1;
cs.speaker = obj_npc_ari;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Clay is used for all sorts of things as well, including some of our buildings, dreidels, and wedding rings! Though of course, after my wife was killed by an Abominable minion, I no longer have use for mine.";
cs.sound = snd_conv_ari_clay_ari_2;
cs.speaker = obj_npc_ari;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "No worries. Hershel’s always been there for me, and I’ll make darn sure he always is.";
cs.sound = snd_conv_ari_clay_ari_3;
cs.speaker = obj_npc_ari;
ds_list_add(c1.steps,cs);


return c1;