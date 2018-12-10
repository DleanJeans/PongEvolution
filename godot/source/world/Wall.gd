class_name Wall
extends Node2D

var top_color setget set_top_color
var bottom_color setget set_bottom_color

func set_top_color(value):
	$Body/TopSprite.modulate = value

func set_bottom_color(value):
	$Body/BottomSprite.modulate = value