//if !instance_exists(global.player) || global.player == noone exit;
show_debug_message("Event = " + async_load[? "event_type"]);        // Debug cocde so you can see which event has been
show_debug_message("Pad = " + string(async_load[? "pad_index"]));   // triggered and the pad associated with it.

switch(async_load[? "event_type"])             // Parse the async_load map to see which event has been triggered
{
case "gamepad discovered":                     // A game pad has been discovered
    global.gamePadIndex = async_load[? "pad_index"];       // Get the pad index value from the async_load map
    gamepad_set_axis_deadzone(global.gamePadIndex, 0.1);       // Set the "deadzone" for the axis
    gamepad_set_button_threshold(global.gamePadIndex, 0.1);    // Set the "threshold" for the triggers
	window_set_cursor(cr_none);
    break;
case "gamepad lost":                           // Gamepad has been removed or otherwise disabled
    var pad = async_load[? "pad_index"];       // Get the pad index
	window_set_cursor(cr_default);
    break;
}
//}