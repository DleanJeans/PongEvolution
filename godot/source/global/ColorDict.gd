class_name ColorDict
extends Node

const RED = Color("#F44336")
const GREEN = Color("#00E676")

const YELLOW = Color("#FFD600")
const PURPLE = Color("#AA00FF")

const ORANGE = Color("#FF9100")
const BLUE = Color("#03A9F4")

const PINK = Color("#FF4081")
const LIME = Color("#76FF03")

static func get_colors():
	return [RED, GREEN, YELLOW, PURPLE, ORANGE, BLUE, PINK, LIME]

static func get_opposite(color):
	return {
		RED.to_html(): GREEN,
		GREEN.to_html(): RED,
		
		YELLOW.to_html(): PURPLE,
		PURPLE.to_html(): YELLOW,
		
		ORANGE.to_html(): BLUE,
		BLUE.to_html(): ORANGE,
		
		PINK.to_html(): LIME,
		LIME.to_html(): PINK
	}[color]

static func get_color_name(color:Color):
	return {
		RED: 'Red',
		GREEN: 'Green',
		
		YELLOW: 'Yellow',
		PURPLE: 'Purple',
		
		ORANGE: 'Orange',
		BLUE: 'Blue',
		
		PINK: 'Pink',
		LIME: 'Lime'
	}[color]