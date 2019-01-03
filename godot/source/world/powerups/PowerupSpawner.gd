extends Node2D

var _pool = []
var _queue = []

func add_to_pool(powerup):
	_pool.append(powerup)
	spawn_powerup(_pool.size() - 1)

func _spawn_queued():
	if _queue.size() > 0:
		spawn_powerup(_queue.front())
		_queue.remove(0)

func spawn_powerup(force_index = -1):
	if $CooldownTimer.time_left > 0:
		_queue.append(force_index)
		return
	else:
		$CooldownTimer.start()
	
	var powerup_position
	while true:
		yield(get_tree(), 'idle_frame')
		powerup_position = _get_random_position()
		$OverlapArea.position = powerup_position
		
		yield(get_tree().create_timer(0.05), 'timeout')
		
		if not _overlaps_with_others():
			break
	
	var powerup = _get_random_powerup_if_not_forced(force_index)
	GameData.world.call_deferred('add_child', powerup, true)
	powerup.position = $OverlapArea.global_position
	
func _overlaps_with_others():
	return not $OverlapArea.get_overlapping_areas().empty() or \
	not $OverlapArea.get_overlapping_bodies().empty()

const BALL_SPAWNER_RADIUS = 75
const POWERUP_RADIUS = 35

func _get_random_position():
	var radius = $SpawnArea/Shape.shape.radius
	var hollow_radius = BALL_SPAWNER_RADIUS + POWERUP_RADIUS * 0.75
	
	var angle:float = randf() * PI * 2
	var random = range_lerp(randf(), 0, 1, hollow_radius / radius, 1)
	var distance_to_center = radius * sqrt(random)
	
	var x = distance_to_center * cos(angle)
	var y = distance_to_center * sin(angle)
	var pos = Vector2(x, y)
	
	return pos

func _get_random_powerup_if_not_forced(force_index):
	var index
	if force_index > -1:
		index = force_index
	else:
		index = randi() % _pool.size()
	return _pool[index].instance()