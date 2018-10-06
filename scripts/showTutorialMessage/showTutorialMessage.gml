/// showTutorialMessage(message, controllerSprites, mkSprites, enum*)
/// @param message
/// @param controllerSprites
/// @param mkSprites
/// @param *enum

global.tutMessage = argument0;
global.tutSpritesController = argument1;
global.tutSpritesMk = argument2;
instance_create_depth(x,y,1,obj_tutorial_message_firsts);

// set the enum in tutsFirsts map to true (this tut has been shown to the new player)
if argument_count == 4 {
	ds_map_replace(global.player.tutorialFirstsMap, argument3, true);
}