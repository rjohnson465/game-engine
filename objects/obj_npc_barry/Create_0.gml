/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "The Elder, Barry";
spriteString = "npc_barry";

greeting = snd_greeting_francis;

items = ds_list_create();
var aqs = makeGem(obj_gem_aquamarine,CRACKED);
aqs.count = 3;
ds_list_add(items,aqs);

ds_list_add(items,instance_create_depth(x,y,1,obj_hand_item_battleaxe));

/*
ds_list_add(conversations, instance_create_depth(x,y,1,obj_conv_wamdk_start));

global.ownerNpcName = "The Elder, Barry";
/*
// honesty convo
var urgent1 = instance_create_depth(x,y,1,obj_conversation_parent);
urgent1.name = "Urgent 1";

var honesty1 = instance_create_depth(x,y,1,obj_conversation_step_parent);
honesty1.text = "Urgent Lamplight.";
honesty1.sound = snd_conversation_francis_honesty_1;
ds_list_add(urgent1.steps,honesty1);
urgent1.isUrgent = true;
urgent1.narrativeState = NarrativeState.LamplightFactory;

ds_list_add(conversations,urgent1);

var urgent2 = instance_create_depth(x,y,1,obj_conversation_parent);
urgent2.name = "Urgent 2";

var honesty2 = instance_create_depth(x,y,1,obj_conversation_step_parent);
honesty2.text = "Urgent Start";
honesty2.sound = snd_conversation_francis_honesty_1;
ds_list_add(urgent2.steps,honesty2);
urgent2.isUrgent = true;
urgent2.narrativeState = NarrativeState.Start;

ds_list_add(conversations,urgent2);

/*
// unfairy slayer quest
var unfairySlayer = instance_create_depth(x,y,1,obj_conversation_parent);
unfairySlayer.name = "Unfairy Slayer";

var uss1 = instance_create_depth(x,y,1,obj_conversation_step_parent);
uss1.text = "The goddamned unfairies keep sniffing my earlobes.";
uss1.sound = snd_conversation_francis_unfairyslayer_1;
var uss2 = instance_create_depth(x,y,1,obj_conversation_step_parent);
uss2.text = "Show them the meaning of holocaust.";
uss2.sound = snd_conversation_francis_unfairyslayer_2;
uss2.func = questStartUnfairySlayer;
ds_list_add(unfairySlayer.steps,uss1);
ds_list_add(unfairySlayer.steps,uss2);

ds_list_add(conversations,unfairySlayer);

/*
// buy / sell
var bs = instance_create_depth(x,y,1,obj_conversation_parent);
bs.isRepeatable = true;

bs.name = "Buy / Sell Items";
var bs1 = instance_create_depth(x,y,1,obj_conversation_step_parent);
bs1.func = buySell;
ds_list_add(bs.steps,bs1);
ds_list_add(conversations,bs);