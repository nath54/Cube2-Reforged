extends Node

var scenes: Node = null
var player: Node = null
var level: Node = null
var fin: Node = null

# 0: très facile
# 1: facile
# 2: normal
# 3: difficile
# 4: hardcore

var mode = "arcade"
var difficulty: int = 0
var stage: int = 1
var keys: Array = []

func level_fini():
	if mode == "arcade":
		stage += 1
		scenes.change_scene("res://game/arcade/TopDownClassic.tscn")
