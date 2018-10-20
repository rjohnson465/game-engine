/// maybeUpdatePotentialPath(xx,yy)
/// @param xx
/// @param yy

// only update the "path" if alarm[9] is 0 OR if there is no path set atm

var xx = argument[0]; 
var yy = argument[1];

var noPath =  path == noone || path == undefined || path_index == noone || path_index == -1;

if alarm[9] == 0 || noPath {
	mp_potential_path(path,xx,yy,functionalSpeed,4,0);
	return true;
}
return false;