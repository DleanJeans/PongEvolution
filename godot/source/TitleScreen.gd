extends Control

var clicks = 0

func _process(delta):
	if Input.is_action_just_pressed('left_click'):
		clicks += 1
		match clicks:
			1: $TitleAnimation.play('ShowTitle1')
			2: $TitleAnimation.play('ShowTitle2')
			3:
				$TitleAnimation.seek(2, true)
				$TitleAnimation.play('Pop')

func _on_BallButton_pressed():
	get_tree().change_scene('res://source/Game.tscn')