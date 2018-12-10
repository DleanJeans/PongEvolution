extends 'res://source/mechanics/upgrades/Upgrade.gd'

func unlock():
	var coloring = Coloring.new()
	var color_picker = Scenes.ColorPicker.instance()
	
	GameData.coloring = coloring
	GameData.feel.add_child(coloring)
	GameData.ui.add_child(color_picker)
	
	color_picker.connect('picked', coloring, 'set_player_color')
	
	coloring.add_player_color(GameData.left_wall, 'bottom_color')
	coloring.add_player_color(GameData.right_wall, 'bottom_color')
	coloring.add_ai_color(GameData.left_wall, 'top_color')
	coloring.add_ai_color(GameData.right_wall, 'top_color')
