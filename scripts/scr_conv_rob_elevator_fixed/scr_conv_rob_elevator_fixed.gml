
// welcome convo
global.ownerNpcName = "Robort";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isRepeatable = false;
c1.name = "Elevator is Fixed!";
c1.isUrgent = true;
c1.narrativeState = NarrativeState.LamplightFactory;

var c1s1 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1s1.text = "Ah! You found the wires. Good, I can take you to the fourth floor now.";
c1s1.func = scr_rob_take_wires;
c1s1.sound = snd_conv_rob_elevatorfix_rob_1;
c1s1.speaker = obj_npc_rob;

var c1s2 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1s2.text = "By the way, did you happen to see Ravebot? I’ve nearly worked up the courage to talk to him.";
c1s2.sound = snd_conv_rob_elevatorfix_rob_2;
c1s2.speaker = obj_npc_rob;
ds_list_add(c1.steps,c1s1);
ds_list_add(c1.steps,c1s2);

return c1;