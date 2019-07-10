
// welcome convo
global.ownerNpcName = "Robort";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isRepeatable = true;
c1.name = "The Other Robots";

var c1s1 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1s1.text = "Robort is the only elevator robot. All other robots work eternally to create more Most Sacred Lamplights for our deserving fairy lords, such as you.";
c1s1.sound = snd_conv_rob_otherrobots_rob_1;
c1s1.speaker = obj_npc_rob;
ds_list_add(c1.steps,c1s1);

var c1s2 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1s2.text = "When the factory is invaded, the other robots get hostile. They’ll probably try to kill you. Sorry about that.";
c1s2.sound = snd_conv_rob_otherrobots_rob_1b;
c1s2.speaker = obj_npc_rob;
ds_list_add(c1.steps,c1s2);

var c1s2 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1s2.text = "Most other robots bore Robort, but there is one Robort likes. He can dance and rave in ways that make Robort most jealous and excited. One day, Robort will hold his hand.";
c1s2.sound = snd_conv_rob_otherrobots_rob_2;
c1s2.speaker = obj_npc_rob;
ds_list_add(c1.steps,c1s2);

var c1s2 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1s2.text = "The thought brings Robort joy, even though little else does.";
c1s2.sound = snd_conv_rob_otherrobots_rob_3;
c1s2.speaker = obj_npc_rob;
ds_list_add(c1.steps,c1s2);

return c1;