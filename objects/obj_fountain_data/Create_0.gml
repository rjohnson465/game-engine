event_inherited();

el = global.fountain;

key = fs_generate_key(el);
postX = el.postX;
postY = el.postY;

ds_map_replace(properties, "isDoneFilling", el.isDoneFilling);
ds_map_replace(properties, "nativeRoom", el.nativeRoom);