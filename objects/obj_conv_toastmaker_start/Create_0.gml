event_inherited();
name = "Toastmaker";
ownerNpcName = "Terri the Toaster";
isUrgent = true;
// narrativeState = NarrativeState.LamplightFactory;

var s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "Hello!";
s.sound = snd_conv_terri_toastmaker_terri_1;
s.speaker = obj_npc_terri;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "Ah! Jesus, what the hell?";
s.sound = snd_conv_terri_toastmaker_gary_1;
s.speaker = obj_player;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "What d’you mean, ‘what the hell?’ We’ve got sentient gears and things called ‘unfairies’ running around here, y’think we’re gonna draw the line at ‘talking toaster?’";
s.sound = snd_conv_terri_toastmaker_terri_2;
s.speaker = obj_npc_terri;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "OK fine, fair point. Give me your quest, I guess.";
s.sound = snd_conv_terri_toastmaker_gary_2;
s.speaker = obj_player;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "I want bread. The unfairies took it all from the kitchen. Bring me bread.";
s.sound = snd_conv_terri_toastmaker_terri_3;
s.speaker = obj_npc_terri;
s.func = questStart;
s.funcParam1 = obj_quest_toastmaker;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "Wait, why are you here? Don’t robots run the factory? Are you telling me robots eat toast?";
s.sound = snd_conv_terri_toastmaker_gary_3;
s.speaker = obj_player;
ds_list_add(steps, s);

s = instance_create_depth(x,y,1,obj_conversation_step_parent);
s.text = "Bread now please. It’s been so long since I’ve had bread in me.";
s.sound = snd_conv_terri_toastmaker_terri_4;
s.speaker = obj_npc_terri;
ds_list_add(steps, s);

