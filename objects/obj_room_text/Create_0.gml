roomName = global.roomName; 
message = roomName;
totalFrames = 90;
frame = 0;

fade = instance_nearest(x,y,obj_fade);

with obj_room_text {
	 if id != other {
		 instance_destroy(id,1);
	 }
}