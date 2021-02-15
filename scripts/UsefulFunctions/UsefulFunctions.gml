// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function approach(_from, _to, _byamount) {
	/// Approach(a, b, amount)
	// Moves "a" towards "b" by "amount" and returns the result
	// Nice because it will not overshoot "b", and works in both directions
	// Examples:
	//      speed = Approach(speed, max_speed, acceleration);
	//      hp = Approach(hp, 0, damage_amount);
	//      hp = Approach(hp, max_hp, heal_amount);
	//      x = Approach(x, target_x, move_speed);
	//      y = Approach(y, target_y, move_speed);

	if (_from < _to)
	{
	    _from += _byamount;
	    if (_from > _to)
	        return _to;
	}
	else
	{
	    _from -= _byamount;
	    if (_from < _to)
	        return _to;
	}
	return _from;
}