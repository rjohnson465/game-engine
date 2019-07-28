event_inherited();
name = "NPC";
// remember this with room_data objects
conversations = ds_list_create();


isInteractingWithPlayer = false;
isInConversation = false;

items = noone;
inv = noone;
showBuySell = false;

isStrafing = false;

postX = x;
postY = y;

prevX = x;
prevY = y;

normalSpeed = 2;
alarm[0] = 90;

greeting = noone;

type = CombatantTypes.Ally;
state = CombatantStates.Idle;

facingDirection = image_angle;
previousFacingDirection = 0;
isSlowed = false;
slowedSpeedModifier = 1;

isFairy = true;
isFloating = true;
floatingFrame = random_range(0,59); //0-60 "float" for fairies (grow/shrink)
alpha = 1;
scale = 1;

spriteString = "npc_default";

// light radius
lightRadiusAlpha = .5;
lightRadiusScale = .5;
lightRadiusColor = c_white;
lightRadiusSprite = spr_light_point;
isShowingLightRadius = true;

menusHandleHeight = 20;

// conversationsStartX = mean(MENUS_TOPLEFT_X,MENUS_BOTTOMRIGHT_X);
// conversationsStartY = mean(MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_Y);
selectedConversation = noone;

joystickInputFrame = 0;
joystickInputTotalFrames = 30;

npcData = noone;

urgentFloatingFrame = round(random_range(0,59));

hasReleasedInteract = true;

wanders = true;

isInteractable = true;