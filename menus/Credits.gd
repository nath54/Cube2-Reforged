extends Control

func _ready():
	if rect_size.x / rect_size.y <= 1:
		$VSplitContainer/CenterContainer/GridContainer.columns = 2
	else:
		$VSplitContainer/CenterContainer/GridContainer.columns = 3

func _on_BtMenu_pressed():
	Global.scenes.change_scene("res://menus/MainMenu.tscn")

func _on_Credits_resized():
	if rect_size.x / rect_size.y <= 1:
		$VSplitContainer/CenterContainer/GridContainer.columns = 2
	else:
		$VSplitContainer/CenterContainer/GridContainer.columns = 3
