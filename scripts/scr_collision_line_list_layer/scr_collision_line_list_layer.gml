/// collision_line_list_layer(x1,y1,x2,y2,obj,prec,notme, isVerbose)
//
//  Returns a list data structure populated with the ids of instances 
//  colliding with a given line, or noone if no instances found.
//
/// @param x1
/// @param y1       start point of the collision line, real
/// @param x2
/// @param y2       end point of the collision line, real
/// @param obj         object to check for collision (or all), real
/// @param prec        true for precise collision checking, bool
/// @param notme       true to ignore the calling instance, bool
/// @param isVerbose* whether or not to include objects with "origLayer"
///
/// GMLscripts.com/license
{
    var x1,y1,x2,y2,obj,prec,notme,dsid,i;
    x1 = argument[0];
    y1 = argument[1];
    x2 = argument[2];
    y2 = argument[3];
    obj = argument[4];
    prec = argument[5];
    notme = argument[6];
    dsid = ds_list_create();
	var isVerbose = false;
	if argument_count > 7 {
		isVerbose = argument[7];
	}
    with (obj) {
		
		var lay = layer;
		if isVerbose {
			lay = variable_instance_exists(id, "origLayer") ? origLayer : layer;
		}
		
		// only if these two objects are on same layer OR have depth within 5 of each other
        if (!notme || id != other.id) && ((lay == other.layer) || (abs(abs(other.depth)-abs(depth)) <= 5)) {
            i = collision_line(x1,y1,x2,y2,id,prec,false);
            if (i != noone) ds_list_add(dsid,i);
        }
    }
    if (ds_list_empty(dsid)) {
        ds_list_destroy(dsid); dsid = -1;
        dsid = noone;
    }
    return dsid;
}