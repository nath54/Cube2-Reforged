extends Control

var difs: Array = ["baby", "easy", "normal", "hard", "hardcore"]

func _on_BtBack_pressed():
	Global.scenes.change_scene("res://menus/Settings.tscn")

func _ready():
	# Rajout des options de difficulté dans son menubutton
	var m: MenuButton = $VSplitContainer/HBoxContainer2/Difficulty/MenuButton
	var p: PopupMenu = m.get_popup()
	p.connect("id_pressed", self, "change_diff")
	for x in range(5):
		p.add_item(difs[x], x)
	#

func change_diff(new_dif):
	Global.difficulty = new_dif
	Saves.save_params()
	

