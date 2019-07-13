global.ownerNpcName = "Terri the Toaster";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isRepeatable = true;
c1.name = "The Factory Robots";

var c1s1 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1s1.text = "The robots are always looking at me with such desire. I’ve considered it, but after my relationship with the fridge, I think I’m gonna take a break from dating.";
c1s1.sound = snd_conv_terri_factoryrobots_terri_1;
c1s1.speaker = obj_npc_terri;

var c1s2 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1s2.text = "Unless, of course… you’re interested?";
c1s2.sound = snd_conv_terri_factoryrobots_terri_2;
c1s2.speaker = obj_npc_terri;
ds_list_add(c1.steps,c1s1);
ds_list_add(c1.steps,c1s2);

return c1;