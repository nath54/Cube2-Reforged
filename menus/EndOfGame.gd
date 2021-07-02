extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.mode == "arcade":
		$Win
	else:
		$CenterContainer/VBoxContainer/CenterContainer2.visible = false;
		$CenterContainer/VBoxContainer/CenterContainer3.visible = false;




func _on_Button_pressed():
	Global.scenes.change_scene("res://menus/MainMenu.tscn")
