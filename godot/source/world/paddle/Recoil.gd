extends Node2D

export(bool) var enable = true
export(float) var duration = 0.4
export(float) var max_recoil = 100
export(float) var max_recoil_speed = 100
export(float) var damping = 0.1

onready var paddle = get_parent()
onready var initial_y = paddle.position.y
onready var movement = $'../Movement'

func _ready():
	paddle.connect('hit_this_ball', self, '_recoil')

func _recoil(ball):
	if not enable: return
	
	var ball_velocity = ball.velocity
	paddle.velocity.y = ball_velocity.y * 0.3

func _physics_process(delta):
	var displace = paddle.position.y - initial_y
	paddle.velocity.y += range_lerp(displace, -max_recoil, max_recoil, max_recoil_speed, -max_recoil_speed)
	paddle.velocity.y *= 1 - damping