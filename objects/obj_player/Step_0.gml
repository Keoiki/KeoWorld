/// @description Insert description here
// You can write your code in this editor
global.key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
global.key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
global.key_down = keyboard_check(vk_down) || keyboard_check(ord("S"));
global.key_up = keyboard_check(vk_up) || keyboard_check(ord("W"));
global.key_space = keyboard_check(vk_space);

if (hsp != 0) image_xscale = sign(hsp);

var p1, p2, bbox_side;
tilemap = layer_tilemap_get_id("Collision");
var grounded = (InFloor(tilemap,x,bbox_bottom+1) >= 0);

max_speed = 1;

var move = ((global.key_right) - (global.key_left)) * wlk;
hsp = approach(hsp, max_speed*move, accel);
vsp = approach(vsp, 7, grv);

//Jump
if (grounded || (InFloor(tilemap, bbox_left, bbox_bottom + 1) >= 0) || (InFloor(tilemap, bbox_right, bbox_bottom + 1) >= 0)) {
	if (global.key_space) {
		vsp = -2.65;
		grounded = false;
	}
}

//Re-apply Fractions
hsp += hsp_fraction;
vsp += vsp_fraction;

//Store and Remove Fractions
hsp_fraction = hsp % 1;
hsp -= hsp_fraction;
vsp_fraction = vsp % 1;
vsp -= vsp_fraction;

//Horizontal Collision
if (hsp > 0) bbox_side = bbox_right; else bbox_side = bbox_left;
p1 = tilemap_get_at_pixel(tilemap, bbox_side + hsp, bbox_top);
p2 = tilemap_get_at_pixel(tilemap, bbox_side + hsp, bbox_bottom);
if (tilemap_get_at_pixel(tilemap, x, bbox_bottom) > 1) p2 = 0;
if (p1 == 1) || (p2 == 1) { //Inside a tile with collision
	if (hsp > 0) x = x - (x mod TILE_SIZE) + (TILE_SIZE - 1) - (bbox_right - x);
	else x = x - (x mod TILE_SIZE) - (bbox_left - x);
	hsp = 0;
}
x += hsp;

//Vertical Collision
//Is this not a slope?
if (tilemap_get_at_pixel(tilemap, x, bbox_bottom + vsp) <= 1) {
	if (vsp >= 0) bbox_side = bbox_bottom; else bbox_side = bbox_top;
	p1 = tilemap_get_at_pixel(tilemap, bbox_left, bbox_side + vsp);
	p2 = tilemap_get_at_pixel(tilemap, bbox_right, bbox_side + vsp);
	if (p1 == 1) or (p2 == 1) {
		if (vsp >= 0) y = y - (y % TILE_SIZE) + (TILE_SIZE-1) - (bbox_bottom - y);
		else y = y - (y % TILE_SIZE) - (bbox_top - y);
		vsp = 0;
	}
}

var floordist = InFloor(tilemap, x, bbox_bottom + vsp);
if (floordist >= 0) {
	y += vsp;
	y -= (floordist + 1);
	vsp = 0;
	floordist = -1;
}
y += vsp;

//Walk down slopes
if (grounded) {
	y += abs(floordist) - 1;
	//If at base of current tile
	if ((bbox_bottom % TILE_SIZE) == TILE_SIZE - 1) {
		//If the slope continues
		if (tilemap_get_at_pixel(tilemap, x, bbox_bottom + 1) >= 1) {
			//Move there
			y += abs(InFloor(tilemap, x, bbox_bottom + 1));
		}
	}
}