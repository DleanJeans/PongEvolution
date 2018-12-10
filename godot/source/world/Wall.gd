class_name Wall
extends Node2D

var top_color setget set_top_color
var bottom_color setget set_bottom_color

func set_top_color(value):
	$Body/Progress.tint_under = value

func set_bottom_color(value):
	$Body/Progress.tint_progress = value

func sync_with(progress):
	progress.share($Body/Progress)