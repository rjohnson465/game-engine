/// drainTemporaryDefenses()

/// called by player, drains temporary defense boosts, removes all empty entries

if !ds_exists(temporaryDefenses, ds_type_list) exit;
if ds_list_size(temporaryDefenses) == 0 exit;

var indexesToDestroy = ds_list_create();
for (var i = 0; i < ds_list_size(temporaryDefenses); i++) {
	var entry = ds_list_find_value(temporaryDefenses, i);
	if !is_array(entry) continue;
	var defenseType = entry[0];
	var framesLeft = entry[1];
	var defenseAmount = entry[2];
	var newFramesLeft = framesLeft - 1;
	var totalDur = entry[3];
	var itemSprite = entry[4];
	var newEntry = [defenseType, newFramesLeft, defenseAmount, totalDur, itemSprite];
	ds_list_replace(temporaryDefenses, i, newEntry);
	
	// maybe ready this entry for deletion later if framesLeft is 0
	if newFramesLeft <= 0 {
		ds_list_replace(temporaryDefenses, i, noone);
	}
}

// remove any dead defense boosts 
for (var i = 0; i < ds_list_size(temporaryDefenses); i++) {
	var entry = ds_list_find_value(temporaryDefenses, i);
	if entry == noone {
		ds_list_delete(temporaryDefenses, i);
	}
}

// mem leak
ds_list_destroy(indexesToDestroy); indexesToDestroy = -1;
