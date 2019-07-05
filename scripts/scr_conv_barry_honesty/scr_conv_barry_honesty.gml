// honesty convo
global.ownerNpcName = "The Elder, Barry";
var honesty = instance_create_depth(x,y,1,obj_conversation_parent);
honesty.name = "Honesty";
honesty.isRepeatable = true;
var honesty1 = instance_create_depth(x,y,1,obj_conversation_step_parent);
honesty1.speaker = obj_npc_barry;
honesty1.text = "You are a very ugly man. I'm sorry to say it so bluntly, but I believe you will never know love, or the touch of a woman.";
honesty1.sound = snd_conversation_francis_honesty_1;
ds_list_add(honesty.steps,honesty1);

return honesty;