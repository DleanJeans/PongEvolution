extends AnimationPlayer

export(bool) var free_on_finished = true

var delayed = false

func _ready():
	get_parent().scale = Vector2()
	if not delayed:
		play('Pop')

func pop(parent):
	parent.call_deferred('add_child', self)
	return self

func delay(seconds = 1):
	$Timer.start(seconds)
	delayed = true
	return self

func _on_Timer_timeout():
	play('Pop')

func _on_animation_finished(anim_name):
	if free_on_finished:
		queue_free()