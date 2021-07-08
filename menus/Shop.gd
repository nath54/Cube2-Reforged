extends Control

var mode: int = 0 # 0 = portrait   1 = paysage

func _on_BtMenu_pressed():
	Global.scenes.change_scene("res://menus/MainMenu.tscn")

func _ready():
	#
	set_portrait()
	#
	"""
	if rect_size.y >= 700 and rect_size.x <= rect_size.y*1.5:
		set_portrait()
	else:
		set_landscape()
	"""
	#
	set_menu("Invocations")


func _on_ShopMenu_resized():
	pass
	"""
	if rect_size.y >= 700 and rect_size.x <= rect_size.y*1.5:
		set_portrait()
	else:
		set_landscape()
	"""


func set_portrait():
	if mode == 0:
		return
	mode = 0
	#
	var vbox: VBoxContainer = VBoxContainer.new()
	var hbox: HBoxContainer = HBoxContainer.new()
	#
	vbox.name = "MainContainer"
	hbox.name = "MenuContainer"
	hbox.alignment = BoxContainer.ALIGN_CENTER
	var children: Array = $VSplitContainer/MainContainer/MenuContainer.get_children()
	for c in children:
		$VSplitContainer/MainContainer/MenuContainer.remove_child(c)
		hbox.add_child(c)
	#
	vbox.add_child(hbox)
	#
	var controls: Array = $VSplitContainer/MainContainer.get_children()
	for c in controls:
		if c is CenterContainer:
			$VSplitContainer/MainContainer.remove_child(c)
			vbox.add_child(c)
	#
	var maincont: Control = $VSplitContainer/MainContainer
	maincont.name = "Main"
	$VSplitContainer.add_child(vbox)
	maincont.queue_free()
	
	

func set_landscape():
	if mode == 1:
		return
	mode = 1
	#
	var vbox: VBoxContainer = VBoxContainer.new()
	var hbox: HBoxContainer = HBoxContainer.new()
	#
	hbox.name = "MainContainer"
	vbox.name = "MenuContainer"
	var children: Array = $VSplitContainer/MainContainer/MenuContainer.get_children()
	for c in children:
		$VSplitContainer/MainContainer/MenuContainer.remove_child(c)
		vbox.add_child(c)
	#	
	hbox.add_child(vbox)
	#
	var controls: Array = $VSplitContainer/MainContainer.get_children()
	for c in controls:
		if c is CenterContainer:
			$VSplitContainer/MainContainer.remove_child(c)
			hbox.add_child(c)
	#
	var maincont: Control = $VSplitContainer/MainContainer
	maincont.name = "Main"
	$VSplitContainer.add_child(hbox)
	maincont.queue_free()

func set_menu(nom):
	for m in ["Invocations", "Skins", "Weapons", "Ressources"]:
		var n = get_node("VSplitContainer/MainContainer/"+m)
		if m == nom:
			n.visible = true
		else:
			n.visible = false


func _on_BtInvos_pressed():
	set_menu("Invocations")


func _on_BtSkins_pressed():
	set_menu("Skins")


func _on_BtWeapons_pressed():
	set_menu("Weapons")


func _on_BtRessources_pressed():
	set_menu("Ressources")
