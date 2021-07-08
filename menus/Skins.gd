extends Control

var filtre: int = -1
onready var grid: GridContainer = $VSplitContainer/HBoxContainer2/ScrollContainer/CenterContainer/GridContainer

func _ready():
	aff()
	grid.columns = int(rect_size.x / 210)


func _on_BtMenu_pressed():
	Global.scenes.change_scene("res://menus/MainMenu.tscn")


func aff() -> void:
	# On nettoie
	for c in grid.get_children():
		c.queue_free()
	#
	for s in Account.skins.keys():
		if filtre == -1 or filtre == DataSB.skins[s]["rar"]:
			var skinv = load("res://menus/skins/SkinInv.tscn").instance()
			skinv.skin_id = s
			grid.add_child(skinv)


func _on_BtAll_pressed():
	filtre = -1
	aff()


func _on_BtCommon_pressed():
	filtre = 0
	aff()


func _on_BtRare_pressed():
	filtre = 1
	aff()


func _on_BtEpic_pressed():
	filtre = 2
	aff()


func _on_BtLegendary_pressed():
	filtre = 3
	aff()


func _on_BtDivine_pressed():
	filtre = 4
	aff()


func _on_SkinsMenu_resized():
	if grid != null:
		grid.columns = int(rect_size.x / 210)
