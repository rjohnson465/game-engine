event_inherited();
name = "Unfairy Slayer (Complete)";
ownerNpcName = "The Elder, Barry";

s1 = instance_create_depth(x,y,1,obj_conversation_step_parent);
s1.text = "Holy guac, you actually did it. Wow you're a complete psycho, I was just kidding.";
s1.sound = snd_conversation_francis_unfairyslayer_thankyou;
s1.func = completeQuest;
s1.funcParam1 = obj_quest_unfairyslayer;
ds_list_add(steps, s1);
isRepeatable = true;