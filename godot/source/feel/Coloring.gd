class_name Coloring
extends Node2D

var _player_colored_properties = {}
var _ai_colored_properties = {}

func _ready():
	_player_colored_properties = { GameData.player: '' }
	_ai_colored_properties = { GameData.ai: '' }
	
	GameData.ball.connect('hit_this_paddle', self, '_change_ball_color', [GameData.ball])
	GameData.game.connect('ball_added', self, '_connect_ball_for_color_change')

func _connect_ball_for_color_change(ball):
	ball.connect('hit_this_paddle', self, '_change_ball_color', [ball])

func add_player_color(node, custom_property = ''):
	_player_colored_properties[node] = custom_property

func add_ai_color(node, custom_property = ''):
	_ai_colored_properties[node] = custom_property

func update_modulate():
	_tween_all(GameData.player.modulate, GameData.ai.modulate)

func _tween_all(player_color, ai_color):
	_tween_nodes(_player_colored_properties, player_color)
	_tween_nodes(_ai_colored_properties, ai_color)

func set_player_color(color:Color):
	var ai_color = ColorDict.get_opposite(color.to_html())
	
	_tween_all(color, ai_color)

func _tween_nodes(nodes, color:Color):
	for node in nodes:
		var custom_property = nodes[node]
		if custom_property == '':
			custom_property = 'modulate'
		ModulateTween.new().tween(node).to(color).property(custom_property)

func _change_ball_color(paddle:Paddle, ball:Ball):
	ModulateTween.new().tween(ball).to(paddle.modulate)
	
	if ball in _player_colored_properties:
		_player_colored_properties.erase(ball)
		_ai_colored_properties[ball] = ''
	elif ball in _ai_colored_properties:
		_ai_colored_properties.erase(ball)
		_player_colored_properties[ball] = ''
	elif paddle in _player_colored_properties:
		_player_colored_properties[ball] = ''
	elif paddle in _ai_colored_properties:
		_ai_colored_properties[ball] = ''