event_inherited();
name = "Unfairy Slayer (Complete)";
ownerNpcName = "Francis";

s1 = instance_create_depth(x,y,1,obj_conversation_step_parent);
s1.text = "Holy guac, you actually did it. Wow you're a complete psycho, I was just kidding.";
s1.sound = snd_conversation_francis_welcome_1;
ds_list_add(steps, s1);