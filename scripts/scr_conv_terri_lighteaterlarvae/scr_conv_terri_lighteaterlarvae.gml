global.ownerNpcName = "Terri the Toaster";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isRepeatable = true;
c1.name = "Lighteater Larvae";

var c1s1 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1s1.text = "Have you seen the weird green slug things today? They’re not normally here… I think the unfairies brought them when they invaded.";
c1s1.sound = snd_conv_terri_lighteaterlarvae_terri_1;
c1s1.speaker = obj_npc_terri;

var c1s2 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1s2.text = "They’re sacrilegious beasts. When they near a lamplight, the Sacred Light grows dim. I’m afraid the unfairies have found a way to put out the Most Holy Lights of our fairy Creators.";
c1s2.sound = snd_conv_terri_lighteaterlarvae_terri_2;
c1s2.speaker = obj_npc_terri;
ds_list_add(c1.steps,c1s1);
ds_list_add(c1.steps,c1s2);

var c1s2 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1s2.text = "In addition to being blasphemers, those things freak me out. I bet their mother isn’t far away...";
c1s2.sound = snd_conv_terri_lighteaterlarvae_terri_3;
c1s2.speaker = obj_npc_terri;
ds_list_add(c1.steps,c1s2);

return c1;