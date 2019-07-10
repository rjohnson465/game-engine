
// welcome convo
global.ownerNpcName = "Robort";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isRepeatable = true;
c1.name = "The Factory";

var c1s1 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1s1.text = "Robort has been here for decades, since the factory was made. Robort is happy to be part of the divine lamplight process.";
c1s1.sound = snd_conv_rob_factory_rob_1;
c1s1.speaker = obj_npc_rob;

var c1s2 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1s2.text = "Here, Robort helps everyone move around the factory, creating beautiful lamplights to light the hearts and minds of all fairies. ";
c1s2.sound = snd_conv_rob_factory_rob_2;
c1s2.speaker = obj_npc_rob;
ds_list_add(c1.steps,c1s1);
ds_list_add(c1.steps,c1s2);

return c1;