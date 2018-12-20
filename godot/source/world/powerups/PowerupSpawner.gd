extends Node2D

func _ready():
	spawn_multiball()

func spawn_multiball():
	var multiball = load('res://source/world/powerups/MultiBall.tscn').instance()
	GameData.world.call_deferred('add_child', multiball)
	multiball.position = get_random_position()

func get_random_position():
	var extents = $Area/Shape.shape.extents
	var x = extents.x * rand_range(-1, 1)
	var y = extents.y * rand_range(-1, 1)
	var position = Vector2(x, y) + global_position
	return position

func _on_Timer_timeout():
	spawn_multiball()