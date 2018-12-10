class_name Movement
extends Node2D

onready var body:KinematicBody2D = get_parent()
var velocity = Vector2()

func _physics_process(delta):
	body.move_and_slide(velocity * body.speed_multiplier)