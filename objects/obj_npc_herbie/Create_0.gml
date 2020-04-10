 /// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Herbie the Elf";
spriteString = "npc_elf_1";

faceSprite = spr_face_elf_1; 

wanders = false;

initialPostX = 100;
initialPostY = 500;


gridPath = path_add();
personalGrid = noone;

wolfDenPostX = 7009;
wolfDenPostY = 5699;


tavernPostX = 534;
tavernPostY = 6325;

greeting = [snd_npc_herbie_greeting_1, snd_npc_herbie_greeting_2];


pathObjectivesKeys = [
	"t1",
	"p1",
	"p2",
	"p3",
	"t2",
	"p4",
	"p5",
	"p6",
	"t2.5",
	"t3",
	"p7",
	"t4",
	"p8",
	"t5",
	"mrsclaus"
];