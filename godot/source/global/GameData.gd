extends Node

var game:Game

var world:Node2D
var ui:CanvasLayer
var feel:Node2D
var mechanics:Node2D

var player:Paddle
var ball:Ball
var ai:Paddle

var top_goal
var bottom_goal

var ball_respawner

var left_wall:Wall
var right_wall:Wall

var unlocker:Unlocker
var scoring:Scoring
var coloring:Coloring

var data = {}

func set_data(name, value):
	data[name] = value

func get_data(name):
	if data.has(name):
		return data[name]
	return null