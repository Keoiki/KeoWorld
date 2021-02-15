/// @description 
var camX = camera_get_view_x(camera);
var camY = camera_get_view_y(camera);
var camW = camera_get_view_width(camera);
var camH = camera_get_view_height(camera);

var targetX = obj_player.x - camW/2;
var targetY = obj_player.y - camH/2;

targetX = clamp(targetX, 0, room_width - camW);
targetY = clamp(targetY, 0, room_height - camH);

camX = lerp(camX, targetX, CAM_SMOOTH);
camY = lerp(camY, targetY, CAM_SMOOTH);

var wheel = mouse_wheel_down() - mouse_wheel_up();

if (wheel != 0) {
	wheel *= 0.1;
	
	var addW = camW * wheel;
	var addH = camH * wheel;
	
	camW += addW;
	camH += addH;
	
	camX -= addW / 2;
	camY -= addH / 2;
}

camera_set_view_pos(camera, camX, camY - 3);
camera_set_view_size(camera, camW, camH);