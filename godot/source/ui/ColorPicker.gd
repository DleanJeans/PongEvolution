tool
extends Control

signal picked(color)

export(Vector2) var min_size = Vector2(50, 50)
export(bool) var refresh setget set_refresh

var _showing = true

func set_refresh(value):
	if not Engine.editor_hint: return
	
	for color_rect in $Margin/VBox.get_children():
		color_rect.free()
	
	for color in ColorDict.get_colors():
		var button = TextureButton.new()
		button.expand = true
		button.rect_size = min_size
		button.rect_min_size = min_size
		button.self_modulate = color
		button.texture_normal = load('res://assets/Square.png')
		button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		button.name = 'Button%s' % ColorDict.get_color_name(color)
		
		$Margin/VBox.add_child(button)
		button.owner = get_tree().get_edited_scene_root()

func _ready():
	for button in $Margin/VBox.get_children():
		button.connect('pressed', self, '_user_picked_color', [button.self_modulate])

func _user_picked_color(color:Color):
	emit_signal('picked', color)
	_slide_in()

func _slide_out():
	$AnimationPlayer.play('SlideOut')
	yield($AnimationPlayer, 'animation_finished')
	_showing = true

func _slide_in():
	$AnimationPlayer.play_backwards('SlideOut')
	yield($AnimationPlayer, 'animation_finished')
	_showing = false

func _on_OpenButton_pressed():
	if $AnimationPlayer.is_playing(): return
	
	if not _showing:
		_slide_out()
	else:
		_slide_in()
	_showing = not _showing