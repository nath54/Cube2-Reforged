extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.mode == "arcade":
		var gains:int = 0
		$"CenterContainer/VBoxContainer/CenterContainer2/Died Floor".text = "You reach the floor "+str(Global.stage)
		$CenterContainer/VBoxContainer/CenterContainer3/HBoxContainer/Money.text = "You gain : "+str(gains)
	else:
		$CenterContainer/VBoxContainer/CenterContainer2.visible = false;
		$CenterContainer/VBoxContainer/CenterContainer3.visible = false;
	#

func _on_BtMenu_pressed():
	Global.scenes.change_scene("res://menus/MainMenu.tscn")


func _on_BtRetry_pressed():
	if Global.mode == "arcade":
		Global.stage = 1
		Global.scenes.change_scene("res://game/arcade/Arcade.tscn")
