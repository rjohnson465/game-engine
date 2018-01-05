// tell whether two combatants are facing each other
// is_facing(a,b)
{
	var a = argument0;
	var b = argument1;
	
	  
	var angle1 = ((a.facingDirection - 60 + 360))%360;
	var angle2 = (a.facingDirection + 60)%360;
	
	
	// make the angle from angle1 to angle2 to be <= 180 degrees
	  var rAngle = ((angle2 - angle1) % 360 + 360) % 360;
	  if (rAngle >= 180) {
	    var temp = angle2;
	    angle2 = angle1;
	    angle1 = temp;
	  }

	 angle1 = (angle1 + 180)%360;
	 angle2 = (angle2 + 180)%360;

	  // check if it passes through zero
	  if (angle1 <= angle2)
	    return b.facingDirection >= angle1 && b.facingDirection <= angle2;
	  else
	    return b.facingDirection >= angle1 || b.facingDirection <= angle2;
	
}