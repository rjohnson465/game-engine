event_inherited();

// lock on logic
if (keyboard_check_released(vk_control)) {
	// always refresh lockOnList (enemies could have left radius or entered
	lockOnList = script_execute(scr_collision_circle_list,x,y,LOCK_ON_DISTANCE,obj_enemy_parent, true, true);
	if (lockOnList == noone) {
		lockOnTarget = noone;
		isLockedOn = false;
	}
	// if already locked on, only look through enemies not yet locked onto
	if (isLockedOn) {
		var closestInstance = noone;
		var foundClosest = false; var i = 1;
		while !foundClosest && i <= ds_list_size(lockOnList) {
			closestInstance = script_execute(scr_find_nth_closest,x,y,obj_enemy_parent, i);
			if ds_list_find_index(lockOnListSeen, closestInstance) == -1 {
				foundClosest = true;
			} else {
				closestInstance = noone;
				i++;
			}
		}
		if closestInstance != noone {
			lockOnTarget = closestInstance;
			ds_list_add(lockOnListSeen, closestInstance);
		} else {
			// we've cycled through all targets; begin cycle again
			ds_list_clear(lockOnListSeen);
			var closestInstance = script_execute(scr_find_nth_closest,x,y,obj_enemy_parent, 1);
			if closestInstance != noone {
				lockOnTarget = closestInstance;
				isLockedOn = true;
				ds_list_add(lockOnListSeen, closestInstance);
			}
		}
	}
	// if not locked on just get the nearest enemy in the list 
	else if (lockOnList != noone){
		var closestInstance = script_execute(scr_find_nth_closest,x,y,obj_enemy_parent, 1);
		if closestInstance != noone {
			lockOnTarget = closestInstance;
			isLockedOn = true;
			ds_list_add(lockOnListSeen, closestInstance);
		}
	}
}
var wallsBetweenLockOnTarget = noone;
if lockOnTarget {
	wallsBetweenLockOnTarget = script_execute(scr_collision_line_list,x,y,lockOnTarget.x,lockOnTarget.y,obj_wall_parent,true,true);
}
// if too far from current lockon target, or esc pressed, or cannot see lockOnTarget no more lock on
if	isLockedOn && ((keyboard_check(vk_escape) && !global.ui.isShowingMenus) 
	|| distance_to_object(lockOnTarget) > LOCK_ON_DISTANCE
	|| wallsBetweenLockOnTarget != noone ) {
	lockOnTarget = noone;
	isLockedOn = false;
}

// move state triggers
var UP = keyboard_check(ord("W"));
var DOWN = keyboard_check(ord("S"));
var LEFT = keyboard_check(ord("A"));
var RIGHT = keyboard_check(ord("D"));
var SHIFT = keyboard_check(vk_shift);
var isMoveInputReceived = UP || DOWN || LEFT || RIGHT;

if isMoveInputReceived && state != CombatantStates.Attacking && state != CombatantStates.Staggering && state != CombatantStates.Dodging {
	state = CombatantStates.Moving;
}
if !isMoveInputReceived && state == CombatantStates.Moving {
	state = CombatantStates.Idle;
}

if state != CombatantStates.Staggering && !isMouseInMenu {
	// player faces mouse if not locked on
	if state == CombatantStates.Idle || state == CombatantStates.Moving 
	|| (ds_map_size(preparingHands)!=0)
	{
		facingDirection = point_direction(x,y,mouse_x,mouse_y);
	}
	// otherwise, player always faces locked on enemy
	if isLockedOn {
		facingDirection = point_direction(x,y,lockOnTarget.x,lockOnTarget.y);
	}
}

// state machine overrides
switch(state) {
	case CombatantStates.Idle: {
		if isFlinching exit;
		speed = 0;
		break;
	}
	case CombatantStates.Moving: {
		if isFlinching {
			break;
		}
		speed = 0;
		var canMove = false;
		var usingSpeed = SHIFT ? functionalSpeed*2 : functionalSpeed;
		if UP && RIGHT && !place_meeting(x+usingSpeed, y+usingSpeed, obj_solid_parent) {
			direction = 45;
		}
		else if UP && LEFT && !place_meeting(x-usingSpeed, y-usingSpeed, obj_solid_parent) {
			direction = 135;
		}
		else if DOWN && LEFT && !place_meeting(x-usingSpeed, y+usingSpeed, obj_solid_parent) {
			direction = 225;
		}
		else if DOWN && RIGHT && !place_meeting(x+usingSpeed, y+usingSpeed, obj_solid_parent) {
			direction = 315;
		}
		else if RIGHT && !place_meeting(x+usingSpeed, y, obj_solid_parent) {
			direction = 0;
		}
		else if LEFT && !place_meeting(x-usingSpeed, y, obj_solid_parent) {
			direction = 180;
		}
		else if UP && !place_meeting(x, y-usingSpeed, obj_solid_parent) {
			direction = 90;
		}
		else if DOWN && !place_meeting(x, y+usingSpeed, obj_solid_parent) {
			direction = 270;
		}
		
		
		var x1 = x +lengthdir_x(usingSpeed,direction);
		var y1 = y +lengthdir_y(usingSpeed,direction);
		canMove = !place_meeting(x1,y1,obj_solid_parent) && !place_meeting(x1,y1,obj_shield_parent);

		if !canMove {
			state = CombatantStates.Idle;
			break;
		}
		
		if (UP || DOWN || LEFT || RIGHT) && canMove {
			// walking backwards is slow
			dirDiff = abs(direction - facingDirection)
			if dirDiff > 135 && dirDiff < 225  {
				speed = .5*functionalSpeed;
			}	
			else speed = functionalSpeed;
		}	
		// run
		if SHIFT && stamina > 0 && canMove {
			speed = speed*1.25;
			stamina -= .5;
		}
		
		break;
	}
	case CombatantStates.Attacking: {
		
		speed = 0;
		var canMove = false;
		var usingSpeed = SHIFT ? functionalSpeed*2 : functionalSpeed;
		if UP && RIGHT && !place_meeting(x+usingSpeed, y+usingSpeed, obj_solid_parent) {
			direction = 45;
		}
		else if UP && LEFT && !place_meeting(x-usingSpeed, y-usingSpeed, obj_solid_parent) {
			direction = 135;
		}
		else if DOWN && LEFT && !place_meeting(x-usingSpeed, y+usingSpeed, obj_solid_parent) {
			direction = 225;
		}
		else if DOWN && RIGHT && !place_meeting(x+usingSpeed, y+usingSpeed, obj_solid_parent) {
			direction = 315;
		}
		else if RIGHT && !place_meeting(x+usingSpeed, y, obj_solid_parent) {
			direction = 0;
		}
		else if LEFT && !place_meeting(x-usingSpeed, y, obj_solid_parent) {
			direction = 180;
		}
		else if UP && !place_meeting(x, y-usingSpeed, obj_solid_parent) {
			direction = 90;
		}
		else if DOWN && !place_meeting(x, y+usingSpeed, obj_solid_parent) {
			direction = 270;
		}
		
		
		var x1 = x +lengthdir_x(usingSpeed,direction);
		var y1 = y +lengthdir_y(usingSpeed,direction);
		canMove = !place_meeting(x1,y1,obj_solid_parent);

		if !canMove {
			speed = 0;
		}
		
		if (UP || DOWN || LEFT || RIGHT) && canMove {
			// walking backwards is slow
			dirDiff = abs(direction - facingDirection)
			if dirDiff > 135 && dirDiff < 225  {
				speed = .25*functionalSpeed;
			}	
			else speed = .5*functionalSpeed;
		}	
		// run
		if SHIFT && stamina > 0 && canMove {
			speed = .5*(speed*1.25);
			stamina -= .5;
		}
		
		
		
		// check if spell attack
		// spells are all 2h and thus use the "r" side (might change this later idk)
		if currentUsingSpell != noone {
			if currentUsingSpell == "aoe" {
				cursor_sprite = spr_lockon;
				var wallsBetweenTarget = script_execute(scr_collision_line_list,x,y,mouse_x,mouse_y,obj_wall_parent,true,true);
				// do not alow aoe spell to be cast beyond walls 
				if wallsBetweenTarget != noone {
					cursor_sprite = -1;
					ds_map_replace(prepFrames,"r",-1);
					ds_map_replace(prepFrameTotals,"r",0);
					ds_map_delete(preparingHands,"r");
					currentUsingSpell = noone;
					state = CombatantStates.Idle;
					break;
				}
				
			}
			speed = .5*speed;
			var currentSpell = ds_map_find_value(knownSpells,currentUsingSpell);
			var MIDDLE_BUTTON_RELEASED = mouse_check_button_released(mb_middle);
			
			//if !isAttacking && !isPreparingAttack && !isRecovering {		
			if ds_map_size(attackingHands) == 0 && ds_map_size(preparingHands) == 0 && ds_map_size(recoveringHands) == 0 {
				//var prepSprite = asset_get_index("spr_player_"+weaponString+"_prep_"+string(global.playerAttackNumberInChain));
				ds_map_replace(prepFrameTotals,"r",currentSpell.castFrames);
				ds_map_replace(prepFrames,"r",0);
				ds_map_replace(preparingHands,"r",1);
			}
			
			// attack sequence 
			//if prepAnimationFrame >= prepAnimationTotalFrames || MIDDLE_BUTTON_RELEASED {
			if ds_map_find_value(prepFrames,"r") >= ds_map_find_value(prepFrameTotals,"r") || MIDDLE_BUTTON_RELEASED {
				cursor_sprite = -1;
				var prepFrame = ds_map_find_value(prepFrames,"r");
				var prepFrameTotal = ds_map_find_value(prepFrameTotals,"r");
				var percentCharged = prepFrame / prepFrameTotal;
				
				var chargeCost = round(percentCharged*currentSpell.maxChargeCost);
				// subtract charges from right hand item first
				if rightHandItem.charges > 0 {
					rightHandItem.charges -= chargeCost;
					if rightHandItem.charges < 0 {
						rightHandItem.charges = 0;
					}
				} else {
					leftHandItem.charges -= chargeCost;
					if leftHandItem.charges < 0 {
						leftHandItem.charges = 0;
					}
				}
				
				// only cast spell if charged enough to cost at least one magic charge
				if chargeCost > 0 {
					stamina -= percentCharged*currentSpell.staminaCost;
					for (var i = 0; i < currentSpell.numberOfProjectiles; i++) {
						global.owner = id;
						global.projectileNumber = i+1;
						global.percentCharged = percentCharged;
						global.handSide = "r";
						//global.spellAttunement = spellAttunement;
						if currentUsingSpell != "aoe" {
							instance_create_depth(x,y,1,obj_attack);	
						} else {
							instance_create_depth(mouse_x,mouse_y,1,obj_attack);	
						}
					}
				}
				ds_map_replace(prepFrames,"r",-1);
				ds_map_replace(prepFrameTotals,"r",0);
				ds_map_delete(preparingHands,"r");
				currentUsingSpell = noone;
				state = CombatantStates.Idle;
			}
			break;
			
		}
		
		// melee / ranged
		
		var LEFTRELEASED = mouse_check_button_pressed(mb_left);
		var RIGHTRELEASED = mouse_check_button_pressed(mb_right);
		
		// iterate over preparing hands 
		// if they just started preparing, need to assign prepare frames / total frames
		// if they are finishing preparing, need to create attack objects
		if ds_map_size(preparingHands) != 0 {
			var hand = ds_map_find_first(preparingHands);
			for (var i = 0; i < ds_map_size(preparingHands); i++) {
				var weapon = hand == "l" ? leftHandItem : rightHandItem;
				var attackInChain = ds_map_find_value(preparingHands,hand);
				
				var prepFrame = ds_map_find_value(prepFrames,hand);
				var prepFrameTotal = ds_map_find_value(prepFrameTotals,hand);
				// check if this hand just started preparing attack
				if prepFrame == -1 {
					ds_map_replace(prepFrames,hand,0);
					var itemSprite = hand == "l" ? leftHandItem.spriteName : rightHandItem.spriteName;
					var prepSprite = asset_get_index("spr_player_"+itemSprite+"_prep_"+string(attackInChain));
					ds_map_replace(prepFrameTotals,hand,sprite_get_number(prepSprite));
				}
				// if at the end of attack preparation, we need to create an attack object (slightly different process for ranged vs melee) 
				else if prepFrame >= prepFrameTotal {
					if ( !(weapon.type == HandItemTypes.Ranged && rightHandItem.isTwoHanded)) {
						speed = 0;
						ds_map_replace(prepFrames,hand,-1);
						ds_map_replace(prepFrameTotals,hand,0);
						ds_map_delete(preparingHands,hand);
						ds_map_replace(attackingHands,hand,attackInChain);
						stamina -= weapon.staminaCostArray[attackInChain-1];
						global.owner = id;
						global.handSide = hand;
						instance_create_depth(x,y,1,obj_attack);
					}
					else {
						ds_map_replace(prepFrames,hand,prepFrame-1);
						isReadyToFire = true;
					}
				} 
				
				// if preparing an attack and no attacks are happening, move back a bit (if you can)
				if ds_map_size(attackingHands) == 0 {
					var x1 = x +lengthdir_x(-.5,facingDirection);
					var y1 = y +lengthdir_y(-.5,facingDirection);
		
					if weapon.type == HandItemTypes.Melee && !place_meeting(x1, y1, obj_solid_parent){
						direction = facingDirection;
						speed = -.5;
					} else {
						//speed = 0;
					}
				} else {
					speed = 0;
				}
				
				hand = ds_map_find_next(preparingHands,hand);
			}
		}
		
		// iterate over recovering hands
		// if they just started recovering, need to assign recover frames / total frames
		// if they just finished recovering, need to check if we need to leave attack state or if we need to attack with that hand again
		if ds_map_size(recoveringHands) != 0 {
			var hand = ds_map_find_first(recoveringHands);
			for (var i = 0; i < ds_map_size(recoveringHands); i++) {
				var weapon = hand == "l" ? leftHandItem : rightHandItem;
				var attackInChain = ds_map_find_value(recoveringHands,hand);
				var recoverFrame = ds_map_find_value(recoverFrames,hand);
				var recoverFrameTotal = ds_map_find_value(recoverFrameTotals,hand);
				
				// check if this hand just started recovering attack
				if recoverFrame == -1 {
					ds_map_delete(attackingHands,hand);
					ds_map_replace(recoverFrames,hand,0);
					var itemSprite = hand == "l" ? leftHandItem.spriteName : rightHandItem.spriteName;
					var recoverSprite = asset_get_index("spr_player_"+itemSprite+"_recover_"+string(attackInChain));
					ds_map_replace(recoverFrameTotals,hand,sprite_get_number(recoverSprite));
				}
				// if at end of recover, we may need to leave attack state (if no other hands are recovering or preparing or attacking)
				else if recoverFrame >= recoverFrameTotal {
					// no matter what, we need to remove this hand from recoveringHands and reset frame values
					ds_map_delete(attackingHands,hand);
					ds_map_replace(recoverFrames,hand,-1);
					ds_map_replace(recoverFrameTotals,hand,0);
					ds_map_delete(recoveringHands,hand);
					
					ds_map_replace(attackAgain,hand,false);
					// wtf 
					// i think this is just in the case that there needs to be a renewed attack chain?
					/*if ds_map_find_value(attackAgain,hand) {
						// make sure there IS a next attack for this item
						var itemSprite = hand == "l" ? leftHandItem.spriteName : rightHandItem.spriteName;
						var prepSprite = asset_get_index("spr_player_"+itemSprite+"_prep_"+string(attackInChain+1));
						if prepSprite != -1 {
							ds_map_replace(preparingHands,hand,attackInChain+1);
						} else ds_map_replace(preparingHands,hand,1);
						ds_map_replace(attackAgain,hand,false);
					} 
					else*/ if ds_map_size(preparingHands) == 0 && ds_map_size(attackingHands) == 0 && ds_map_size(recoveringHands) == 0 {
						state = CombatantStates.Idle;
						break;
					} 
				}
				
				hand = ds_map_find_next(recoveringHands,hand);
			}
		}
		
		// move forward while attacking with a melee attack (if not simultaenously preparing another attack)
		if ds_map_size(attackingHands) != 0 {
			var attackingMelee = 
				(ds_map_find_value(attackingHands,"l") && leftHandItem.type == HandItemTypes.Melee)	||
				(ds_map_find_value(attackingHands,"r") && rightHandItem.type == HandItemTypes.Melee)
			if ds_map_size(preparingHands) == 0 {
				x1 = x + lengthdir_x(2,facingDirection);
				y1 = y + lengthdir_y(2,facingDirection);
				var p =  place_meeting(x1,y1,obj_solid_parent);
				if attackingMelee && !(place_meeting(x1,y1,obj_solid_parent)) {
					direction = facingDirection;
					speed = 1;
				} else {
					speed = 0;
				}
			} else {
				speed = 0;
			}
		}
		
		// this is a 2h ranged weapon, so handSide must be "r"
		if isReadyToFire && LEFTRELEASED && stamina > 0 {
			speed = 0;
			var attackInChain = ds_map_find_value(preparingHands,"r"); // pretty sure this is always gonna be 1
			ds_map_replace(prepFrames,"r",-1);
			ds_map_replace(prepFrameTotals,"r",0);
			isReadyToFire = false;
			ds_map_replace(attackingHands,"r",attackInChain);
			stamina -= rightHandItem.staminaCostArray[attackInChain-1];
			ds_map_delete(preparingHands,"r");
			global.owner = id;
			global.handSide = "r";
			instance_create_depth(x,y,1,obj_attack);
		}
		break;
	}
}



