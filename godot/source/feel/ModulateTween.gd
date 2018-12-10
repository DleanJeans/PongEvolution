class_name ModulateTween
extends Tween

const TRANSPARENT = Color(0, 0, 0, 0)

export(Color) var from = TRANSPARENT
export(Color) var to = TRANSPARENT
export(float) var duration = 0.2
export(String) var property = 'modulate'

func tween(parent):
	name = 'ModulateTween'
	
	if parent.has_node(name):
		var in_progress_tween = parent.get_node(name)
		in_progress_tween.name += 'Freed'
		in_progress_tween.queue_free()
	
	parent.call_deferred('add_child', self)
	
	from = parent.modulate
	
	return self

func to(to_color:Color):
	to = to_color
	return self

func from(from_color:Color):
	if from_color:
		from = from_color
	else:
		from = get_parent().modulate
	return self

func duration(duration):
	self.duration = duration
	return self

func property(property):
	self.property = property
	return self

func _ready():
	interpolate_property(get_parent(), property, from, to, duration, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	start()
	connect('tween_completed', self, '_on_tween_completed')

func _on_tween_completed(object, key):
	queue_free()