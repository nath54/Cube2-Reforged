extends Control

func _ready():
	#
	$VSplitContainer/CenterContainer/HBoxContainer/VBoxContainer2/HBoxContainer/Label.text = str(Global.money)
	#
	if rect_size.y >= 700 and rect_size.x <= rect_size.y*1.5:
		$VSplitContainer/VBoxContainer/CenterContainer2/GridContainer.columns = 3
	else:
		$VSplitContainer/VBoxContainer/CenterContainer2/GridContainer.columns = 4

func _on_MainMenu_resized():
	if rect_size.y >= 700 and rect_size.x <= rect_size.y*1.5:
		$VSplitContainer/VBoxContainer/CenterContainer2/GridContainer.columns = 3
	else:
		$VSplitContainer/VBoxContainer/CenterContainer2/GridContainer.columns = 4

######################## BUTTONS ########################

func _on_BtPlay_pressed():
	# Global.scenes.change_scene("res://menus/Play.tscn")
	Global.scenes.change_scene("res://game/arcade/Arcade.tscn")

func _on_BtSkins_pressed():
	Global.scenes.change_scene("res://menus/Skins.tscn")


func _on_BtShop_pressed():
	Global.scenes.change_scene("res://menus/Shop.tscn")


func _on_BtSuccess_pressed():
	Global.scenes.change_scene("res://menus/Success.tscn")


func _on_BtSettings_pressed():
	Global.scenes.change_scene("res://menus/Settings.tscn")


func _on_BtHelp_pressed():
	Global.scenes.change_scene("res://menus/Help.tscn")


func _on_BtCredits_pressed():
	Global.scenes.change_scene("res://menus/Credits.tscn")


func _on_BtQuit_pressed():
	get_tree().quit()


