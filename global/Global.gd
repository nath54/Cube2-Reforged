# GLOBAL
extends Node

var scenes: Node = null
var player: Node = null
var level: Node = null
var fin: Node = null


# difficulties :             0       1        2        3        4 
var difficulties: Array = ["baby", "easy", "normal", "hard", "hardcore"]

var theme: int = 2
var mode: String = "arcade"
var difficulty: int = 0
var stage: int = 1
var keys: Array = []

var joy_method: int = 1
var joystick: Vector2 = Vector2.ZERO
var deadzone: float = 40

func level_fini():
	if mode == "arcade":
		stage += 1
		scenes.change_scene("res://game/arcade/TopDownClassic.tscn")

func lose_game():
	scenes.change_scene("res://menus/EndOfGame.tscn")
