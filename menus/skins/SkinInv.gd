extends Control

export var skin_id: int = 0

var cl_rars: Dictionary = {
	0: Color(0, 0.2, 0.8),
	1: Color(0.6, 0.6, 0.05),
	2: Color(0.5, 0, 0.6),
	3: Color(0, 1, 0),
	4: Color(1, 0, 0)
}

var style: StyleBoxFlat = StyleBoxFlat.new()

func _ready():
	$Panel.add_stylebox_override("panel", style)
	style.set_bg_color(cl_rars[DataSB.skins[skin_id]["rar"]])
	#
	$Skin/ViewportContainer/Skin.queue_free()
	var file: String = "res://res/skins/"+str(skin_id)+"/Skin.tscn"
	var skin: Node2D = load(file).instance()
	skin.name = "Skin"
	$Skin/ViewportContainer.add_child(skin)
	skin.position = Vector2(70, 70)
	skin.scale = Vector2(1, 1)
	$Skin/NomSkin.text = DataSB.skins[skin_id]["nom"]
	if Account.skin_equipe == skin_id:
		$Skin/BtEquip.disabled = true
		$Skin/BtEquip.text = "equiped"
	else:
		$Skin/BtEquip.disabled = false
		$Skin/BtEquip.text = "equip"

func _on_BtEquip_pressed():
	Account.skin_equipe = skin_id
	Global.scenes.change_scene("res://menus/Skins.tscn")

