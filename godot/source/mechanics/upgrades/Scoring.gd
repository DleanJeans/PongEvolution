extends 'res://source/mechanics/upgrades/Upgrade.gd'

func unlock():
	GameData.coloring.add_player_color(GameData.scoring.board, 'player_color')
	GameData.coloring.add_ai_color(GameData.scoring.board, 'ai_color')
	GameData.coloring.update_modulate()
