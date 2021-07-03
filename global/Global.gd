extends Node

var money = 0

var scenes: Node = null
var player: Node = null
var level: Node = null
var fin: Node = null

# 0: très facile
# 1: facile
# 2: normal
# 3: difficile
# 4: hardcore

var theme = 2
var mode = "arcade"
var difficulty: int = 1
var stage: int = 1
var keys: Array = []

var skin: int = 6

var joy_method: int = 2
var joystick: Vector2 = Vector2.ZERO
var deadzone: float = 40

func level_fini():
	if mode == "arcade":
		stage += 1
		scenes.change_scene("res://game/arcade/TopDownClassic.tscn")

func lose_game():
	scenes.change_scene("res://menus/EndOfGame.tscn")
