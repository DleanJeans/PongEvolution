class_name Game
extends Node2D

signal player_scored
signal ai_scored
signal ball_added(ball)
signal ball_removed(ball)

func _init():
	yield(self, 'tree_entered')
	GameData.game = self
	GameData.world = $World
	GameData.feel = $Feel
	GameData.ui = $UI
	GameData.mechanics = $Mechanics
	GameData.top_goal = $World/GoalTop
	GameData.bottom_goal = $World/GoalBottom
	GameData.left_wall = $World/LeftWall
	GameData.right_wall = $World/RightWall
	GameData.ball_respawner = $World/BallRespawner
	GameData.ball = $World/Ball
	GameData.player = $World/PlayerPaddle
	GameData.ai = $World/AIPaddle
	GameData.scoreboard = $World/Scoreboard

func _ready():
	GameData.ball.velocity.y = -500
	
	_connect_goal_signals()
	_connect_ball_signals()

func _connect_goal_signals():
	GameData.top_goal.connect('detected_ball', self, '_emit_player_scored')
	GameData.bottom_goal.connect('detected_ball', self, '_emit_ai_scored')

func _connect_ball_signals():
	get_tree().connect('node_added', self, '_emit_if_ball_added')
	get_tree().connect('node_removed', self, '_emit_if_ball_removed')
	emit_signal('ball_added', GameData.ball)

func _emit_if_ball_added(node):
	if node is Ball:
		emit_signal('ball_added', node)

func _emit_if_ball_removed(node):
	if node is Ball:
		emit_signal('ball_removed', node)

func _emit_player_scored():
	emit_signal('player_scored')

func _emit_ai_scored():
	emit_signal('ai_scored')