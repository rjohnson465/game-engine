// draw the current instructions
if status != ExerciseStepStatus.InProgress exit;
exercise.isShowingAMessage = false;
var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

var rewardItemsActive = false;
if instance_number(obj_item_reward) > 0 rewardItemsActive = true;

if global.player.isAlive && !global.isWishing && !global.ui.isShowingMenus && !rewardItemsActive && !isInConvo {

	var xx = view_get_wport(view_camera[0]) / 2;
	if global.isLooting {
		xx -= 100;
	}
	var yy = view_get_hport(view_camera[0]) - 150;
	drawTutorialMessage(xx, yy, messageController, messageMk, promptSpritesController, promptSpritesMk);
	
}
