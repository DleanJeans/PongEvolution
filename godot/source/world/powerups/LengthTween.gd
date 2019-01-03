extends Tween

var paddle:Paddle

func set_paddle(paddle):
	self.paddle = paddle

func tween_to(value, duration):
	interpolate_property(paddle, 'width_multiplier', null, value, duration, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	start()