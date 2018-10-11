/// showTutorialMessage(message, controllerSprites, mkSprites, enum*, spritesSeparators*)
/// @param message
/// @param controllerSprites
/// @param mkSprites
/// @param *enum
/// @param *spritesSeparators

if global.doNotDisplayTutorialMessages exit;

global.tutMessage = argument[0];
global.tutSpritesController = argument[1];
global.tutSpritesMk = argument[2];
var seps = [];
if argument_count > 4 {
	seps = argument[4];
}
global.tutSpritesSeparators = seps;
instance_create_depth(x,y,1,obj_tutorial_message_firsts);

// set the enum in tutsFirsts map to true (this tut has been shown to the new player)
if argument_count > 3 {
	ds_map_replace(global.player.tutorialFirstsMap, argument[3], true);
}