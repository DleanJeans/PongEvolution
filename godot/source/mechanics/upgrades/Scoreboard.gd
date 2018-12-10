extends 'res://source/mechanics/upgrades/Upgrade.gd'

func unlock():
	var scoring = GameData.scoring
	
	scoring.connect('max_goals_changed', scoring.board, 'update_max_goals')
	
	scoring.max_goals = 2
	
	var coloring = GameData.coloring
	
	coloring.add_player_color(GameData.scoring.board, 'player_color')
	coloring.add_ai_color(GameData.scoring.board, 'ai_color')
	
	coloring.add_player_color(GameData.left_wall, 'bottom_color')
	coloring.add_player_color(GameData.right_wall, 'bottom_color')
	coloring.add_ai_color(GameData.left_wall, 'top_color')
	coloring.add_ai_color(GameData.right_wall, 'top_color')
	
	coloring.update_modulate()
	
	yield($'../../BallRespawner', 'ball_respawned')
	GameData.left_wall.sync_with(scoring.board.progress)
	GameData.right_wall.sync_with(scoring.board.progress)