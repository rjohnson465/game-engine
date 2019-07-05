
// welcome convo
global.ownerNpcName = "The Elder, Barry";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.name = "Welcome";

var c1s1 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1s1.text = "Oh hey, you're definitely going to die without a weapon.";
c1s1.sound = snd_conversation_francis_welcome_1;
c1s1.speaker = obj_npc_barry;
var c1s2 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1s2.text = "Here, take this awful piece of shit dagger.";
c1s2.sound = snd_conversation_francis_welcome_2;
c1s2.func = scr_conversation_francis_dagger;
c1s2.speaker = obj_npc_barry;
ds_list_add(c1.steps,c1s1);
ds_list_add(c1.steps,c1s2);

return c1;