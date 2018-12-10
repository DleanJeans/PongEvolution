extends 'res://source/mechanics/upgrades/Upgrade.gd'

func unlock():
	GameData.coloring.add_player_color(GameData.scoring.board, 'player_color')
	GameData.coloring.add_ai_color(GameData.scoring.board, 'ai_color')
	GameData.coloring.update_modulate()
	
	GameData.scoring.connect('max_goals_changed', GameData.scoring.board, 'update_max_goals')
	
	GameData.scoring.max_goals = 2
	
	GameData.left_wall.sync_with(GameData.scoring.board.progress)
	GameData.right_wall.sync_with(GameData.scoring.board.progress)
