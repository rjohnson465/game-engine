global.ownerNpcName = "Herbie";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = true;
c1.name = "Abandon Escort Event";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Escort fail now";
cs.sound = noone;
cs.speaker = obj_npc_herbie;
cs.func = scr_event_fail;
cs.funcParam1 = obj_event_saving_herbie;
ds_list_add(c1.steps,cs);

return c1;