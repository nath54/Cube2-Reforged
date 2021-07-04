extends Control

func _ready():
	pass

func _on_BtBack_pressed():
	Global.scenes.change_scene("res://menus/Settings.tscn")
