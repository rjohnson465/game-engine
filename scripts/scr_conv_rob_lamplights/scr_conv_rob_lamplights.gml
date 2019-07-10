
// welcome convo
global.ownerNpcName = "Robort";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isRepeatable = true;
c1.name = "Lamplights";

var c1s1 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1s1.text = "Robort loves lamplights. Robort was made in the image of his Creators, the fairies. Of course we all love lamplights.";
c1s1.sound = snd_conv_rob_lamplights_rob_1;
c1s1.speaker = obj_npc_rob;

var c1s2 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1s2.text = "Their most Holy Light gives Robort warm tingly feelings in his circuits.";
c1s2.sound = snd_conv_rob_lamplights_rob_2;
c1s2.speaker = obj_npc_rob;
ds_list_add(c1.steps,c1s1);
ds_list_add(c1.steps,c1s2);

return c1;