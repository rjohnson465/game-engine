depth = -1002;

menusHandleHeight = 20;
subMenuTitleHeight = 30;

joystickInputFrame = 0;
joystickInputTotalFrames = 30;

width = (MENUS_BOTTOMRIGHT_X-MENUS_TOPLEFT_X)/3;

var widthFactor = global.fountainGui.currentMenu == INSERTGEM ? 2 : 1;

topLeftX = MENUS_TOPLEFT_X+(widthFactor*width);
topLeftY = MENUS_TOPLEFT_Y+menusHandleHeight;
bottomRightX = topLeftX + width;
bottomRightY = MENUS_BOTTOMRIGHT_Y;

slotWidth = sprite_get_width(spr_item_slot);
slotHeight = sprite_get_height(spr_item_slot);

namedPrice = 0;

guaranteedPrice = 1000; // TODO make function to assess insertion cost
odds = 0;

menuButtonCoordinates = ds_map_create();
// back button
backButtonTopLeftX = topLeftX;
backButtonTopLeftY = topLeftY;
backButtonBottomRightX = topLeftX+subMenuTitleHeight;
backButtonBottomRightY = topLeftY+subMenuTitleHeight;
ds_map_replace(menuButtonCoordinates,"Back",[backButtonTopLeftX,backButtonTopLeftY,backButtonBottomRightX,backButtonBottomRightY]);
isBackButtonPressed = false;

#macro WISH "Make Wish"
#macro RESETPRICE "Reset Amount"
#macro INCREASE100 "100"
#macro INCREASE1K "1,000"
#macro INCREASE10K "10,000"
#macro INCREASE100K "100,000"
//#macro INCREASE1M "1,000,000"

allPriceIncrements = ds_list_create();
//ds_list_add(allPriceIncrements,WISH);
//ds_list_add(allPriceIncrements,RESETPRICE);
ds_list_add(allPriceIncrements,INCREASE100);
ds_list_add(allPriceIncrements,INCREASE1K);
ds_list_add(allPriceIncrements,INCREASE10K);
ds_list_add(allPriceIncrements,INCREASE100K);
//ds_list_add(allPriceIncrements,INCREASE1M);

selectedPriceIncrease = INCREASE100;


