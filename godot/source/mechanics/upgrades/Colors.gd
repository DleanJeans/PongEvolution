extends 'res://source/mechanics/upgrades/Upgrade.gd'

func unlock():
	var coloring = Coloring.new()
	var color_picker = Scenes.ColorPicker.instance()
	
	GameData.coloring = coloring
	GameData.feel.add_child(coloring)
	GameData.ui.add_child(color_picker)
	
	color_picker.connect('picked', coloring, 'set_player_color')
