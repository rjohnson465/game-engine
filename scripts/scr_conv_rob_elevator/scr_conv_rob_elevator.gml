
// welcome convo
global.ownerNpcName = "Rob the Robot";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.name = "Use Elevator";
c1.isRepeatable = true;

var c1s2 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1s2.text = "Elevator text";
c1s2.sound = noone;
c1s2.func = scr_conversation_rob_elevatorselect;
ds_list_add(c1.steps,c1s2);

return c1;