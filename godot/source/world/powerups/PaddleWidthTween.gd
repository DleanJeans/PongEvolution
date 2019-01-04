extends Tween

var _paddle:Paddle

func set_paddle(paddle):
	_paddle = paddle

func tween_to(value, duration):
	interpolate_property(_paddle, 'width_multiplier', null, value, duration, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	start()