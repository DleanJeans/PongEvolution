extends Unlockable

func unlock():
	var coloring = Coloring.new()
	var color_picker = Scenes.ColorPicker.instance()
	
	GameData.coloring = coloring
	GameData.feel.add_child(coloring)
	GameData.ui.add_child(color_picker)
	
	color_picker.connect('picked', coloring, 'set_player_color')
	
	yield(get_tree(), 'idle_frame')
	color_picker._user_picked_color(ColorDict.GREEN)