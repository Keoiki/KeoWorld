/// @func scr_draw_collisions()
function scr_draw_collisions() {
	with(obj_entity_parent)
	{
		draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, c_yellow, c_yellow, c_yellow, c_yellow, false);
	}
}

function scr_platformer_init() {
	// Initialize the variables used for movement code
	xVel = 0;                // X Velocity
	yVel = 0;                // Y Velocity

	xVelSub = 0;             // X Sub-pixel movement
	yVelSub = 0;             // Y Sub-pixel movement

	xdir    = 0;             // X direction 1/0/-1
	ydir    = 0;             // Y direction 1/0/-1

	// Previous X/Y coords to use as we see fit
	xprev   = 0;             // Previous X ausiliary var
	yprev   = 0;             // Previous Y ausiliary var

	// Axis
	xaxis   = 0;             // Input X Axis
	yaxis   = 0;             // Input Y Axis
}

function scr_platformer_step() {
	/**********************
	  Horizontal Movement
	 **********************/
	if xVel != 0
	{
	    xVelSub    += xVel;
	    vxNew       = round(xVelSub);
	    xVelSub    -= vxNew;
	    xdir        = sign(vxNew);
	    xprev       = x;
	
		// Avoid moving subpixel sprite if colliding with wall
		instance_deactivate_object(obj_slope) // Don't consider slopes
		if collision_rectangle(bbox_left + sign(xVel), bbox_top, bbox_right + sign(xVel), bbox_bottom, obj_solid, true, true)
		{
			xVel		= 0;
			xVelSub		= 0;
			vxNew		= 0;
		}
		instance_activate_object(obj_slope);
		
	    // Horizontal
	    repeat(abs(vxNew))
	    {
	        // In case of horizontal collision
	        if collision_rectangle(bbox_left + xdir, bbox_top, bbox_right + xdir, bbox_bottom, obj_solid, true, true)
	        {
	            // If it's a slope up
	            if !collision_rectangle(bbox_left + xdir, bbox_top - 1, bbox_right + xdir, bbox_bottom - 1, obj_solid, true, true)
	            {
	                y--;         // Move Up
	                x += xdir;   // Move Ahead
	            }
	            // If it's not a slope
	            else
	            {
	                xVelSub = 0;
	                xVel = 0;    // Stop completely
	                break;       // Stop repeating. We're still.
	            }
	        }
	        // If there is no obstacle ahead
	        else
	        {
	            // In case it's a slope down
	            if (yVel >= 0) && !collision_rectangle(bbox_left + xdir, bbox_top + 1, bbox_right + xdir, bbox_bottom + 1, obj_solid, true, true) && collision_rectangle(bbox_left + xdir, bbox_top + 2, bbox_right + xdir, bbox_bottom + 2, obj_solid, true, true)
	            {
					y++;         // Move Down
				}
	            // Move ahead then
	            x += xdir;
	        }
	    }
	}

	/**********************
	  Vertical Movement
	 **********************/
	if yVel != 0
	{
	    yVelSub    += yVel;
	    vyNew       = round(yVelSub);
	    yVelSub    -= vyNew;
	    ydir        = sign(vyNew);
	    yprev       = y;
	    // Going Down
	    if ydir == 1
	    {
	        for (y = y; y < yprev + vyNew; y++)
	        {
	            if collision_rectangle(bbox_left, bbox_bottom + 1, bbox_right, bbox_bottom + 1, obj_solid, true, true)
	            {
					yVel = 0;
	                yVelSub = 0;
	                break;
          
	            }
	        }
	     }
	     else if ydir == -1
	     {
	        for (y = y; y > yprev + vyNew; y--)
	        {
	            var ceiling = collision_rectangle(bbox_left, bbox_top - 1, bbox_right, bbox_top - 1, obj_solid, true, true);

	            if ceiling > 0
	            {
	                yVel = 0;
	                yVelSub = 0;
	                break;
	            }
	        }
	    }
	}
}
