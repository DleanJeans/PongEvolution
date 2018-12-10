extends 'res://source/mechanics/upgrades/Upgrade.gd'

func unlock():
	var player_control = PlayerControl.new()
	player_control.name = 'PlayerControl'
	GameData.mechanics.add_child(player_control)