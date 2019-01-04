extends Node2D

var BouncingSound = load('res://assets/wav/Bouncing.tres')

func _ready():
	GameData.game.connect('ball_added', self, '_connect_sounds')
	GameData.game.connect('player_scored', $GoalUp, 'play')
	GameData.game.connect('ai_scored', $GoalDown, 'play')
	GameData.scoring.connect('score_reset', self, '_play_explosion_if_multiball')

func _play_explosion_if_multiball():
	if GameData.world.has_node('PowerupSpawner'):
		$Explosion.play()

func _connect_sounds(ball:Ball):
	ball.connect('hit_ball', self, '_play_bouncing_sound', [ball])
	ball.connect('hit_wall', self, '_play_bouncing_sound', [ball])
	ball.connect('hit_paddle', self, '_play_bouncing_sound', [ball])

func _play_bouncing_sound(ball:Ball):
	ball.add_child(Scenes.BouncingSound.instance())