// Change Mode
/*
if keyboard_check_pressed(ord("M"))
{
	spr_y = 0;
	mode_index++;
	if mode_index > 2
		mode_index = 0;
	mask_index = spr_mask_ok;
}*/

spr_y = 0;
mode_index = 1;
mask_index = spr_mask_ok;
speed_multi = 2;

/// Check for input
xaxis = keyboard_check(ord("D")) - keyboard_check(ord("A"));

if keyboard_check(vk_shift) {
	speed_multi = 3;
}

// Set horizontal speed
xVel = xaxis * speed_multi;

if xaxis != 0
	image_xscale = xaxis;

// Jump
if keyboard_check_pressed(vk_space) && place_meeting(x, y + 1, obj_solid)
{
	yVel = -3.5;
}

// Gravity
if !collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom + 1, obj_solid, true, false)
{
	yVel += 0.185;
	if yVel > 8
		yVel = 8;
}

// Movement
scr_platformer_step();

// Slope sprite positioning
if mode_index == 1 || mode_index == 2
{
	// Check for slope offset
	slope = collision_rectangle(bbox_left, bbox_bottom +1, bbox_right, bbox_bottom + 1, obj_slope, true, true);

	if slope
	{
		var slope_height	= abs(slope.bbox_bottom - slope.bbox_top);
		var slope_base		= abs(slope.bbox_right - slope.bbox_left);
		var angle			= arctan(slope_height / slope_base);
	
		// Slope to the right
		if object_is_ancestor(slope.object_index, obj_slope_rx)
		{
			if bbox_right < slope.bbox_right
				slope_spr_y = slope.bbox_bottom - (bbox_right + xVelSub - slope.bbox_left) * tan(angle);
			else
				slope_spr_y = slope.bbox_top;
		}		
		// Slope to the left
		else if object_is_ancestor(slope.object_index, obj_slope_lx)
		{
			if bbox_left > slope.bbox_left
				slope_spr_y = slope.bbox_top + (bbox_left + xVelSub - slope.bbox_left) * tan(angle);
			else
				slope_spr_y = slope.bbox_top;
		}
	}
	else
		slope_spr_y = 0;	// Not on slopes
}
