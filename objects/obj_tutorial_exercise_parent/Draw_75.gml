var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

var rewardItemsActive = false;
if instance_number(obj_item_reward) > 0 rewardItemsActive = true;

if global.player.isAlive && !rewardItemsActive && !isInConvo && !doNotShowParticles && isShowingAMessage {	
	part_system_drawit(system);
}