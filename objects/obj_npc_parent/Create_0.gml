event_inherited();
name = "NPC";
// remember this with room_data objects
conversations = ds_list_create();

// all npcs have a "Leave" convo
global.owner = id;
global.ownerNpcName = id;
var leave = instance_create_depth(x,y,1,obj_conversation_parent);
leave.name = "Leave";
leave.isRepeatable = true;

var leave1 = instance_create_depth(x,y,1,obj_conversation_step_parent);
leave1.text = "Goodbye";
leave1.sound = noone;
leave1.func = scr_conversation_leave;
ds_list_add(leave.steps,leave1);

ds_list_add(conversations,leave);


isInteractingWithPlayer = false;
isInConversation = false;

items = noone;
inv = noone;
showBuySell = false;

postX = x;
postY = y;

prevX = x;
prevY = y;

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
lightRadiusAlpha = .5;
lightRadiusScale = .5;
lightRadiusColor = c_white;
lightRadiusSprite = spr_light_point;
isShowingLightRadius = true;

// light radius
/*
global.owner = id;
global.makeLightOnCreate = false;
instance_create_depth(x,y,1,obj_light_radius);*/

menusHandleHeight = 20;

conversationsStartX = mean(MENUS_TOPLEFT_X,MENUS_BOTTOMRIGHT_X);
conversationsStartY = mean(MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_Y);
selectedConversation = noone;

joystickInputFrame = 0;
joystickInputTotalFrames = 30;

/*
global.npc = id;
instance_create_depth(x,y,-1001,obj_npc_gui_parent);
*/

npcData = noone;