var rd = instance_nearest(x,y,obj_room_data);
with rd {
	fs_save_roomdata_tempfile();
	fs_save_enemydata_tempfile();
}