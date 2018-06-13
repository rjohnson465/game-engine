// use macros for elements rather than enums (helps with sprite getting)
#macro PHYSICAL "physical"
#macro SLASH "slash"
#macro PIERCE "pierce"
#macro CRUSH "crush"
#macro MAGIC "magic"
#macro FIRE "fire"
#macro ICE "ice"
#macro POISON "poison"
#macro LIGHTNING "lightning"

#macro C_HANDLES make_color_rgb(47,79,79)
#macro C_DKRGRAY make_color_rgb(42,42,42)

global.ALL_ELEMENTS = [MAGIC,FIRE,ICE,POISON,LIGHTNING];
global.ALL_DAMAGE_TYPES = [PHYSICAL,SLASH,PIERCE,CRUSH,MAGIC,FIRE,ICE,POISON,LIGHTNING];
global.ALL_PHYSICAL_DAMAGE_TYPES = [PHYSICAL,SLASH,PIERCE,CRUSH];

#macro SWORD1H "Sword/1H"
#macro SWORD2H "Sword/2H"
#macro DAGGER "Dagger/1H"
#macro UNARMED "Unarmed"
#macro AXE1H "Axe/1H"
#macro AXE2H "Axe/2H"
#macro BLUNT1H "Club/1H"
#macro BLUNT2H "Club/2H"
#macro RAPIER "Rapier/1H"
#macro SPEAR "Spear/2H"
#macro BOW "Bow/2H"
#macro CROSSBOW "Crossbow/1H"
#macro SHURIKEN "Shuriken/2H"
#macro MUSKET "Musket/2H"
#macro THROWN "Thrown/1H"
#macro PISTOL "Pistol/1H"

global.gamePadIndex = noone;

global.ALL_WEAPON_TYPES = [
	SWORD1H, SWORD2H, DAGGER, UNARMED, AXE1H, AXE2H, BLUNT1H, BLUNT2H, RAPIER, SPEAR,
	BOW, CROSSBOW, SHURIKEN, MUSKET, THROWN, PISTOL
];

depth = -10000;

enum TitleScreenState {
	Options,
	Load
}

state = TitleScreenState.Options;
isLoading = false;
currentSaveFile = "Game.sav";
roomToGoTo = noone;
isReadyToMoveRooms = false;