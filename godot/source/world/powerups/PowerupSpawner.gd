extends Node2D

func _ready():
	spawn_multiball()

func spawn_multiball():
	var powerup_position
	while true:
		yield(get_tree(), 'idle_frame')
		powerup_position = get_random_position()
		$OverlapArea.position = powerup_position
		
		yield(get_tree().create_timer(0.05), 'timeout')
		
		if not overlaps_with_others():
			break
	
	var multiball = Scenes.MultiBall.instance()
	GameData.world.call_deferred('add_child', multiball, true)
	multiball.position = $OverlapArea.global_position

func overlaps_with_others():
	return not $OverlapArea.get_overlapping_areas().empty() or \
	not $OverlapArea.get_overlapping_bodies().empty()

func get_random_position():
	var radius = $SpawnArea/Shape.shape.radius
	var hollow_radius = 75 + 35 * 0.75
	
	var angle:float = randf() * PI * 2
	var random = range_lerp(randf(), 0, 1, hollow_radius / radius, 1)
	var distance_to_center = radius * sqrt(random)
	
	var x = distance_to_center * cos(angle)
	var y = distance_to_center * sin(angle)
	var pos = Vector2(x, y)
	
	return pos

func _on_Timer_timeout():
	spawn_multiball()