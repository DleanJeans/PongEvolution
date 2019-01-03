class_name DoubleLength
extends Powerup

signal touched_paddle

const POWERUP_NAME = 'DoubleLength'

export(float) var duration = 10
export(float) var tween_duration = 0.5

var paddle:Paddle

func activate(ball:Ball):
	paddle = ball.last_hit_paddle
	if not paddle:
		return
	else:
		$WidthTween.set_paddle(paddle)
	
	$LifeTimer.stop()
	
	_fly_to_paddle()
	
	yield(self, 'touched_paddle')
	
	_start_effect()
	_lengthen()
	hide()
	
func _fly_to_paddle():
	$ActivationTween.interpolate_property(self, 'scale', null, Vector2(), tween_duration, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$ActivationTween.start()
	$LengthenSound.play()
	yield($ActivationTween, 'tween_completed')
	emit_signal('touched_paddle')

func _on_ActivationTween_tween_step(object, key, elapsed, value):
	position = position.linear_interpolate(paddle.position, 0.1)

func _start_effect():
	if paddle.has_node(POWERUP_NAME):
		paddle.get_node(POWERUP_NAME).extend_lifetime()
		queue_free()
	else:
		get_parent().remove_child(self)
		paddle.add_child(self)
		name = POWERUP_NAME

func _lengthen():
	$WidthTween.tween_to(2, tween_duration)
	
	yield($WidthTween, 'tween_completed')
	
	$ExpireTimer.start(duration)

func _expire():
	$WidthTween.tween_to(1, tween_duration)
	$ReverseSound.play()
	
	yield($WidthTween, 'tween_completed')
	
	queue_free()

func extend_lifetime():
	$ExpireTimer.start(duration)
