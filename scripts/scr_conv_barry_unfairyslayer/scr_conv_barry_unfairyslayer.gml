
// unfairy slayer quest
global.ownerNpcName = "The Elder, Barry";
var unfairySlayer = instance_create_depth(x,y,1,obj_conversation_parent);
unfairySlayer.name = "Unfairy Slayer";

var uss1 = instance_create_depth(x,y,1,obj_conversation_step_parent);
uss1.text = "The goddamned unfairies keep sniffing my earlobes.";
uss1.sound = snd_conversation_francis_unfairyslayer_1;
uss1.speaker = obj_npc_barry;
var uss2 = instance_create_depth(x,y,1,obj_conversation_step_parent);
uss2.text = "Show them the meaning of holocaust.";
uss2.sound = snd_conversation_francis_unfairyslayer_2;
uss2.func = questStartUnfairySlayer;
uss2.speaker = obj_npc_barry;
ds_list_add(unfairySlayer.steps,uss1);
ds_list_add(unfairySlayer.steps,uss2);

return unfairySlayer;