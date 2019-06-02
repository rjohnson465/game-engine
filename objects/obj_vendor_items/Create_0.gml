owner = global.owner;
isConfirming = false;
confirmOption = noone;
isAcceptingConfirmInput = false;
isYes = false;

selectedItem = noone;
inv = ds_list_create();
items = owner.items;
isActive = false;

slotWidth = sprite_get_width(spr_item_slot);
slotHeight = sprite_get_height(spr_item_slot);
invWidth = 5*slotWidth;
invHeight = 4*slotHeight;

width = (MENUS_BOTTOMRIGHT_X-MENUS_TOPLEFT_X)/3;
subMenuTitleHeight = 30;
menusHandleHeight = 20;

invTopLeftX = MENUS_TOPLEFT_X;
invTopLeftY = MENUS_TOPLEFT_Y+menusHandleHeight+subMenuTitleHeight;
invBottomRightX = invTopLeftX+invWidth;
invBottomRightY = invTopLeftY+invHeight;

topLeftX = MENUS_TOPLEFT_X;
topLeftY = MENUS_TOPLEFT_Y+menusHandleHeight;

scrollLevel = 0; // display items 0 - 19
scrollSpriteWidth = sprite_get_width(spr_scrollarrow);
scrollSpriteHeight = sprite_get_height(spr_scrollarrow);
scrollBarTopLeftX = MENUS_TOPLEFT_X+invWidth;
scrollBarTopLeftY = MENUS_TOPLEFT_Y+subMenuTitleHeight+menusHandleHeight;
scrollBarBottomRightX = MENUS_TOPLEFT_X+width;
scrollBarBottomRightY = scrollBarTopLeftY+invHeight;
scrollBarWidth = scrollBarBottomRightX - scrollBarTopLeftX;
// scroll button up
var scrollButtonScale = scrollBarWidth / scrollSpriteWidth;
scrollButtonUpTopLeftX = scrollBarTopLeftX;
scrollButtonUpTopLeftY = scrollBarTopLeftY;
scrollButtonUpBottomRightX = scrollButtonUpTopLeftX+(scrollSpriteWidth*scrollButtonScale);
scrollButtonUpBottomRightY = scrollButtonUpTopLeftY+(scrollSpriteHeight*scrollButtonScale);
// scroll button down
scrollButtonDownTopLeftX = scrollBarTopLeftX;
scrollButtonDownTopLeftY = scrollBarBottomRightY-(scrollSpriteHeight*scrollButtonScale);
scrollButtonDownBottomRightX = scrollButtonDownTopLeftX+(scrollSpriteWidth*scrollButtonScale);
scrollButtonDownBottomRightY = scrollBarBottomRightY;

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

filtersHeight = 30;
filtersWidth = 30;
filter = InventoryFilters.Melee;
filterSprites = ds_map_create();
ds_map_add(filterSprites,InventoryFilters.Melee,spr_filter_melee);
ds_map_add(filterSprites,InventoryFilters.Ranged,spr_filter_ranged);
ds_map_add(filterSprites,InventoryFilters.Rings,spr_filter_rings);
ds_map_add(filterSprites,InventoryFilters.Head,spr_filter_head);
ds_map_add(filterSprites,InventoryFilters.Other,spr_filter_other);
ds_map_add(filterSprites,InventoryFilters.Gems,spr_filter_gems);
ds_map_add(filterSprites,InventoryFilters.Keys,spr_filter_keys);

pressedFilter = noone;

joystickInputFrame = 0;
joystickInputTotalFrames = 30;

