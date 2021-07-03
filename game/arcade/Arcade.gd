extends Node

var modes = ["res://game/arcade/TopDownClassic.tscn"];

func _ready():
	var r = int(rand_range(0, len(modes)))
	Global.scenes.change_scene(modes[r])

