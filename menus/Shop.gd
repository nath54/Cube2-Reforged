extends Control

func _on_BtMenu_pressed():
	Global.scenes.change_scene("res://menus/MainMenu.tscn")

func _ready():
	# On va charger les bannières limitées
	var lims = DataSB.get_bans()
	for b in lims:
		var ban: Control = load("res://menus/invocations/banniere.tscn").instance()
		ban.id_banniere = b
		$VSplitContainer/MainContainer/Invocations/Bannieres.add_child(ban)
	#
	$VSplitContainer/HBoxContainer/HBoxContainer/Money.text = "Money : "+str(Account.money)
	#
	set_menu("Invocations")
	#
	for c in $VSplitContainer/MainContainer/Invocations/Bannieres.get_children():
		var s: Vector2 = Vector2(rect_size.x/2, rect_size.x/3.50)
		if s.x >= 583 and s.x <= 800 and s.y >= 253 and s.y <= 600:
			c.rect_size = s

func _on_ShopMenu_resized():
	for c in $VSplitContainer/MainContainer/Invocations/Bannieres.get_children():
		var s: Vector2 = Vector2(rect_size.x/1.5, rect_size.x/2.6)
		if s.x >= 583 and s.x <= 800 and s.y >= 253 and s.y <= 600:
			c.rect_size = s

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
