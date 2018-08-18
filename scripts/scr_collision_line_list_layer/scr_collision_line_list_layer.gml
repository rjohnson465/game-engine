/// collision_line_list_layer(x1,y1,x2,y2,obj,prec,notme)
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
///
/// GMLscripts.com/license
{
    var x1,y1,x2,y2,obj,prec,notme,dsid,i;
    x1 = argument0;
    y1 = argument1;
    x2 = argument2;
    y2 = argument3;
    obj = argument4;
    prec = argument5;
    notme = argument6;
    dsid = ds_list_create();
    with (obj) {
		// only if these two objects are on same layer OR have depth within 5 of each other
        if (!notme || id != other.id) && (layer == other.layer || abs(abs(other.depth)-abs(depth)) <= 5) {
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