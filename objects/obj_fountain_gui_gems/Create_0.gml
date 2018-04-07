depth = -1001;

menusHandleHeight = 20;
inv = ds_list_create();

slotWidth = sprite_get_width(spr_item_slot);
slotHeight = sprite_get_height(spr_item_slot);
invWidth = 5*slotWidth;
invHeight = 4*slotHeight;

width = (MENUS_BOTTOMRIGHT_X-MENUS_TOPLEFT_X)/3;
subMenuTitleHeight = 30;

invTopLeftX = MENUS_TOPLEFT_X+width;
invTopLeftY = MENUS_TOPLEFT_Y+menusHandleHeight+subMenuTitleHeight;

topLeftX = MENUS_TOPLEFT_X+width;
topLeftY = MENUS_TOPLEFT_Y+menusHandleHeight;

selectedItem = noone;

// scroll stuff
scrollLevel = 0; // display items 0 - 19
scrollSpriteWidth = sprite_get_width(spr_scrollarrow);
scrollSpriteHeight = sprite_get_height(spr_scrollarrow);

scrollBarTopLeftX = MENUS_TOPLEFT_X+invWidth+width;
scrollBarTopLeftY = MENUS_TOPLEFT_Y+subMenuTitleHeight+menusHandleHeight;
scrollBarBottomRightX = MENUS_TOPLEFT_X+width+width;
scrollBarBottomRightY = scrollBarTopLeftY+invHeight;
scrollBarWidth = scrollBarBottomRightX - scrollBarTopLeftX;
// scroll button up
var scrollButtonScale = scrollBarWidth / scrollSpriteWidth;
scrollButtonUpTopLeftX = scrollBarTopLeftX+width;
scrollButtonUpTopLeftY = scrollBarTopLeftY;
scrollButtonUpBottomRightX = scrollButtonUpTopLeftX+(scrollSpriteWidth*scrollButtonScale)+width;
scrollButtonUpBottomRightY = scrollButtonUpTopLeftY+(scrollSpriteHeight*scrollButtonScale);
// scroll button down
scrollButtonDownTopLeftX = scrollBarTopLeftX+width+width;
scrollButtonDownTopLeftY = scrollBarBottomRightY-(scrollSpriteHeight*scrollButtonScale);
scrollButtonDownBottomRightX = scrollButtonDownTopLeftX+(scrollSpriteWidth*scrollButtonScale)+width;
scrollButtonDownBottomRightY = scrollBarBottomRightY;

menuButtonCoordinates = ds_map_create();

ds_map_add(menuButtonCoordinates,"InventoryScrollUp",[scrollButtonUpTopLeftX,scrollButtonUpTopLeftY,scrollButtonUpBottomRightX,scrollButtonUpBottomRightY]);
ds_map_add(menuButtonCoordinates,"InventoryScrollDown", [scrollButtonDownTopLeftX,scrollButtonDownTopLeftY,scrollButtonDownBottomRightX,scrollButtonDownBottomRightY]);

isScrollUpPressed = false;
isScrollDownPressed = false;

// selected item / item description box
selectedItem = noone;
for (var i = 0; i < ds_list_size(global.player.inventory); i++) {
	var item = ds_list_find_value(global.player.inventory,i);
	if object_is_ancestor(item.object_index,obj_gem_parent) {
		selectedItem = item; break;
	}
}

itemDescriptionTopLeftX = topLeftX;
itemDescriptionTopLeftY = topLeftY+subMenuTitleHeight+invHeight;
itemDescriptionBottomRightX = topLeftX+width;
itemDescriptionBottomRightY = MENUS_BOTTOMRIGHT_Y;
itemDescriptionHandleHeight = 20;
itemDescriptionCol1XPictures = itemDescriptionTopLeftX+1;
itemDescriptionCol1XText = itemDescriptionTopLeftX+20;
itemDescriptionCol1Width = (.5*width)+70;
itemDescriptionCol2XPictures = itemDescriptionTopLeftX+itemDescriptionCol1Width;
itemDescriptionCol2XText = itemDescriptionCol2XPictures + 20;
itemDescriptionColY = itemDescriptionTopLeftY+itemDescriptionHandleHeight;

joystickInputFrame = 0;
joystickInputTotalFrames = 30;