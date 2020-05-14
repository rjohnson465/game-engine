// controller interaction
if !ui.isShowingMenus || ui.currentMenu != OPTIONS {
	/*subMenu = SM_MAIN;
	currentOptionsArr = navOptionsArr;
	selectedOption = currentOptionsArr[0];*/
	exit;
}
var p = global.gamePadIndex;

if gamepad_is_connected(p) {
	
	if gamepad_button_check_pressed(p, gp_padd) {
		
		// index of options array currently in
		var curArrIndex = noone;
		var curOptionsArr = noone;
		for (var i = 0; i < array_length_1d(optionsMapOfSubOptsArrays); i++) {
			var entry = optionsMapOfSubOptsArrays[i];
			var arr = entry[1];
			
			if arrayIncludes(arr, selectedOption) && curArrIndex == noone {
				curArrIndex = i;
				curOptionsArr = arr;
			}
		}
		
		var curIndex = arrayGetIndex(curOptionsArr, selectedOption);
		var nextIndex = curIndex + 1;
		var nextArrIndex = noone;
		var nextArr = curOptionsArr;
		if array_length_1d(curOptionsArr) - 1 < nextIndex {
			nextArrIndex = curArrIndex + 1;
			if array_length_1d(optionsMapOfSubOptsArrays) - 1 < nextArrIndex {
				nextArrIndex = 0;
			}
			nextArr = optionsMapOfSubOptsArrays[nextArrIndex];
			nextIndex = 0;
		}
		audio_play_sound(snd_ui_option_change,1,0);
		var nextArrOpts = noone;
		if nextArr == curOptionsArr {
			nextArrOpts = nextArr;
		} else {
			// new submenu
			nextArrOpts = nextArr[1];
		}
		selectedOption = nextArrOpts[nextIndex];
	}
	
	if gamepad_button_check_pressed(p, gp_padu) {
		
		// index of options array currently in
		var curArrIndex = noone;
		var curOptionsArr = noone;
		for (var i = 0; i < array_length_1d(optionsMapOfSubOptsArrays); i++) {
			var entry = optionsMapOfSubOptsArrays[i];
			var arr = entry[1];
			if arrayIncludes(arr, selectedOption) {
				curArrIndex = i;
				curOptionsArr = arr;
			}
		}
		
		var curIndex = arrayGetIndex(curOptionsArr, selectedOption);
		var nextIndex = curIndex - 1;
		var nextArrIndex = noone;
		var nextArr = curOptionsArr;
		if nextIndex < 0 {
			
			nextArrIndex = curArrIndex - 1;
			if nextArrIndex < 0 {
				nextArrIndex = array_length_1d(optionsMapOfSubOptsArrays) - 1;
			}
			var nextArrCat = optionsMapOfSubOptsArrays[nextArrIndex];
			nextArr = nextArrCat[1];
			nextIndex = array_length_1d(nextArr)-1;	
		}
		audio_play_sound(snd_ui_option_change,1,0);
		//var nextArrOpts = noone;
		//if nextArr == curOptionsArr {
		//	nextArrOpts = nextArr;
		//} else {
		//	// new submenu
		//	nextArrOpts = nextArr[1];
		//}
		selectedOption = nextArr[nextIndex];
	}

}