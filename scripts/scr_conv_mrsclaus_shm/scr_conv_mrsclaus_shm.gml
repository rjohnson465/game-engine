global.ownerNpcName = "Mrs. Claus";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = true;
c1.name = "Rescue Herbie (In Progress)";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Have you found the wolf den yet? It should be east of here, though it’s hard to get into. You may need to get creative to get inside.";
cs.sound = snd_conv_mrsclaus_shm_mrsclaus_1;
cs.speaker = obj_npc_mrsclaus;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "I need those wolf teeth for Kramp -- I mean, I need Herbie to come back safe. Good luck, Gary.";
cs.sound = snd_conv_mrsclaus_shm_mrsclaus_2;
cs.speaker = obj_npc_mrsclaus;
ds_list_add(c1.steps,cs);

return c1;