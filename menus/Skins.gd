extends Control

var filtre: int = -1
onready var grid: GridContainer = $VSplitContainer/HBoxContainer2/ScrollContainer/CenterContainer/GridContainer

func _ready():
	aff()


func _on_BtMenu_pressed():
	Global.scenes.change_scene("res://menus/MainMenu.tscn")


func aff() -> void:
	# On nettoie
	for c in grid.get_children():
		c.queue_free()
	#
	for s in Account.skins.keys():
		if filtre == -1 or filtre == Account.skins[s]["rar"]:
			var skinv = load("res://menus/skins/SkinInv.tscn").instance()
			skinv.skin_id = s
			grid.add_child(skinv)


func _on_BtAll_pressed():
	pass # Replace with function body.


func _on_BtCommon_pressed():
	pass # Replace with function body.


func _on_BtRare_pressed():
	pass # Replace with function body.


func _on_BtEpic_pressed():
	pass # Replace with function body.


func _on_BtLegendary_pressed():
	pass # Replace with function body.


func _on_BtDivine_pressed():
	pass # Replace with function body.
