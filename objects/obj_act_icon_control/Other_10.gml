// Create act icon objects
var len = array_length(global.actorder) - 1;
var val = array_length(ACTS[len]) - 1;

for (var i = 0; i < val + 1; i++) {
	var act = instance_create_layer(ACTS[val][i][0], ACTS[val][i][1], "Instances", obj_chapter_act_icon);
	with act {
		actID = array_get(global.actorder, i);
	}
}