persistent	= true; // Controllers are usually persistent.
visible		= true; // We need to be visible to be able to draw something on screen.

// If you comment the following two lines, the whole smoothing system won't work.
application_surface_draw_enable(false);
surface_resize(application_surface, display_get_width(), display_get_height());