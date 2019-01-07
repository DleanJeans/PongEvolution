extends Unlockable

func unlock():
	var scoreboard = GameData.scoreboard
	var coloring = GameData.coloring
	
	coloring.add_player_color(scoreboard, 'player_color')
	coloring.add_ai_color(scoreboard, 'ai_color')
	
	coloring.add_player_color(GameData.left_wall, 'bottom_color')
	coloring.add_player_color(GameData.right_wall, 'bottom_color')
	coloring.add_ai_color(GameData.left_wall, 'top_color')
	coloring.add_ai_color(GameData.right_wall, 'top_color')
	
	coloring.update_modulate()
	
	GameData.left_wall.sync_with(scoreboard.progress)
	GameData.right_wall.sync_with(scoreboard.progress)