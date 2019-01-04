class_name DoubleLength
extends Powerup

signal touched_paddle

const EFFECT_NAME = 'DoubleLengthEffect'

export(float) var tween_duration = 0.5

var paddle:Paddle

func activate(ball:Ball):
	paddle = ball.last_hit_paddle
	if not paddle:
		return
	
	$LifeTimer.stop()
	$Area.collision_layer = 0
	$Area.collision_mask = 0
	
	_fly_to_paddle()
	
	_start_effect()
	$LengthenSound.play()
	yield(self, 'touched_paddle')
	queue_free()
	
func _fly_to_paddle():
	$FlyTween.interpolate_property(self, 'scale', null, Vector2(), tween_duration, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$FlyTween.follow_property(self, 'position', null, paddle, 'position', tween_duration, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$FlyTween.start()
	
	yield($FlyTween, 'tween_completed')
	emit_signal('touched_paddle')

func _start_effect():
	if paddle.has_node(EFFECT_NAME):
		paddle.get_node(EFFECT_NAME).extend_lifetime()
	else:
		paddle.add_child(Scenes.DoubleLengthEffect.instance())