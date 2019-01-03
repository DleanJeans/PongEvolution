class_name SpeedIncrease
extends Node2D

export(float) var percent_per_paddle_hit = 2
export(float) var max_multiplier = 3

func _ready():
	GameData.ball_respawner.connect('ball_respawned', self, '_reset_speed')
	GameData.game.connect('ball_added', self, '_connect_increase_speed')

func _connect_increase_speed(ball):
	ball.connect('hit_paddle', self, '_increase_speed', [ball])

func _increase_speed(ball):
	if ball.speed_multiplier >= max_multiplier:
		return
	ball.speed_multiplier += 0.01 * percent_per_paddle_hit

func _reset_speed():
	GameData.ball.speed_multiplier = 1