name = "NPC";
// remember this with room_data objects
conversations = ds_list_create();
isInteractingWithPlayer = false;
isInConversation = false;

postX = x;
postY = y;

normalSpeed = 2;
alarm[0] = 90;

greeting = noone;

type = CombatantTypes.Ally;
state = CombatantStates.Idle;

facingDirection = 0;
isSlowed = false;

isFairy = true;
isFloating = true;
floatingFrame = random_range(0,59); //0-60 "float" for fairies (grow/shrink)
alpha = 1;
scale = 1;

// light radius
lightRadius = 256;
lightRadiusAlpha = .5;
lightRadiusScale = 1;
lightRadiusColor = c_white;
lightRadiusSprite = spr_light_point;
isShowingLightRadius = true;

// light radius
global.owner = id;
global.makeLightOnCreate = false;
instance_create_depth(x,y,1,obj_light_radius);

menusHandleHeight = 20;

conversationsStartX = mean(MENUS_TOPLEFT_X,MENUS_BOTTOMRIGHT_X);
conversationsStartY = mean(MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_Y);
selectedConversation = noone;

joystickInputFrame = 0;
joystickInputTotalFrames = 30;