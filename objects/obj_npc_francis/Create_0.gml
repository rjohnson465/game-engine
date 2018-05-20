/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Francis";
spriteString = "francis";

greeting = snd_greeting_francis;

global.owner = id;
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.name = "Welcome";
//c1.isRepeatable = true;

var c1s1 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1s1.text = "Oh hey, you're definitely going to die without a weapon.";
c1s1.sound = snd_conversation_francis_welcome_1;
var c1s2 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1s2.text = "Here, take this awful piece of shit dagger.";
c1s2.sound = snd_conversation_francis_welcome_2;
c1s2.func = scr_conversation_francis_dagger;
ds_list_add(c1.steps,c1s1);
ds_list_add(c1.steps,c1s2);

ds_list_add(conversations,c1);

var honesty = instance_create_depth(x,y,1,obj_conversation_parent);
honesty.name = "Honesty";
honesty.isRepeatable = true;

var honesty1 = instance_create_depth(x,y,1,obj_conversation_step_parent);
honesty1.text = "You are a very ugly man. I'm sorry to say it so bluntly, but I believe you will never know love, or the touch of a woman.";
honesty1.sound = snd_conversation_francis_honesty_1;
ds_list_add(honesty.steps,honesty1);

ds_list_add(conversations,honesty);


