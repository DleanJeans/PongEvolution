extends Node

signal detected_this_ball(ball)
signal detected_ball

func _on_Ball_entered(ball):
	emit_signal('detected_this_ball', ball)
	emit_signal('detected_ball')
