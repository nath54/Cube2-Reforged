extends Control

var difs: Array = ["baby", "easy", "normal", "hard", "hardcore"]

onready var menuButton: MenuButton = $VSplitContainer/HBoxContainer2/Difficulty/MenuButton
onready var popupMenu: PopupMenu = menuButton.get_popup()

func _on_BtBack_pressed():
	Global.scenes.change_scene("res://menus/Settings.tscn")

func _ready():
	# Rajout des options de difficulté dans son menubutton
	popupMenu.connect("id_pressed", self, "change_diff")
	for x in range(5):
		popupMenu.add_item(difs[x], x)
	#
	menuButton.text = difs[Global.difficulty]

func change_diff(new_dif):
	Global.difficulty = new_dif
	menuButton.text = difs[new_dif]
	Saves.save_params()
	

