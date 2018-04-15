depth = -1001;

menusHandleHeight = 20;
subMenuTitleHeight = 30;

joystickInputFrame = 0;
joystickInputTotalFrames = 30;

width = (MENUS_BOTTOMRIGHT_X-MENUS_TOPLEFT_X)/3;

topLeftX = MENUS_TOPLEFT_X+(2*width);
topLeftY = MENUS_TOPLEFT_Y+menusHandleHeight;

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

#macro WISH "Make Wish"
#macro RESETPRICE "Reset Wish Amount"
#macro INCREASE100 "Add 100 Gold"
#macro INCREASE1K "Add 1,000 Gold"
#macro INCREASE10K "Add 10,000 Gold"
#macro INCREASE100K "Add 100,000 Gold"
#macro INCREASE1M "Add 1,000,000 Gold"

allPriceIncrements = ds_list_create();
ds_list_add(allPriceIncrements,WISH);
ds_list_add(allPriceIncrements,RESETPRICE);
ds_list_add(allPriceIncrements,INCREASE100);
ds_list_add(allPriceIncrements,INCREASE1K);
ds_list_add(allPriceIncrements,INCREASE10K);
ds_list_add(allPriceIncrements,INCREASE100K);
ds_list_add(allPriceIncrements,INCREASE1M);

selectedPriceIncrease = INCREASE100;

var midW = mean(topLeftX,topLeftX+width); var midH = 200;
for (var i = 0; i < ds_list_size(allPriceIncrements); i++) {
	var opt = ds_list_find_value(allPriceIncrements,i);
	var w = string_width(opt); var h = string_height(opt);
	var yy = midH+((i)*25);
	var x1 = midW-(.5*w); var y1 = yy-(.5*h);
	var x2 = midW+w; var y2 = yy+h;
	ds_map_replace(menuButtonCoordinates,opt,[x1,y1,x2,y2]);
}

