///Draw Sprite

//draw_set_font(fnt_small)

if mode_index == 0
{
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, image_alpha);
}
else
{
	// Slope Y Position
	if (slope_spr_y != 0)
		var yspr = slope_spr_y;
	else
		var yspr = y + yVelSub;
	draw_sprite_ext(sprite_index, image_index, x + xVelSub, yspr, image_xscale, image_yscale, 0, c_white, image_alpha);
}
draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, c_yellow, c_yellow, c_yellow, c_yellow, true);

/*
draw_set_halign(fa_center)
draw_text(room_width div 2, room_height - 14, "M changes mode:")
draw_text(room_width div 2, room_height - 7, mode[mode_index])