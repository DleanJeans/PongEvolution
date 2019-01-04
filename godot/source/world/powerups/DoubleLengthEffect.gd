class_name DoubleLengthEffect
extends Node2D

var lengthen_duration = 10
var tween_duration = 0.5

func extend_lifetime():
	$ExpireTimer.start(lengthen_duration)

func _ready():
	$WidthTween.set_paddle(get_parent())
	_lengthen()
	
func _lengthen():
	$WidthTween.tween_to(2, tween_duration)
	
	yield($WidthTween, 'tween_completed')
	
	$ExpireTimer.start(lengthen_duration)

func _expire():
	name = 'Expired%s' % name
	$WidthTween.tween_to(1, tween_duration)
	$ReverseSound.play()
	
	yield($WidthTween, 'tween_completed')
	
	queue_free()