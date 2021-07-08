extends Node2D

var mode: int = 0
onready var skin: Node2D = $Skin/Skin

var skin_scale: Vector2 = Vector2(1, 1)
var anim: Dictionary = {"anim": null}

var cl_rars: Dictionary = {
	0: Color(0, 0.2, 0.8),
	1: Color(0.6, 0.6, 0.05),
	2: Color(0.5, 0, 0.6),
	3: Color(0, 1, 0),
	4: Color(1, 0, 0)
}

# Called when the node enters the scene tree for the first time.
func _ready():
	var res: Dictionary = Invocations.invo(Global.id_banniere)
	#
	$Light2D.color = cl_rars[res["rar"]]
	#
	$Skin/Skin.queue_free()
	var file: String = "res://res/skins/"+str(res["id_skin"])+"/Skin.tscn"
	print(file)
	skin = load(file).instance()
	skin.name = "Skin"
	$Skin.add_child(skin)
	skin.position = Vector2(242, 155)
	skin.visible = false


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		print(mode)
		if mode == 0:
			skin.visible = true
			anim = {
				"anim": "skin_scale",
				"value1": Vector2(0, 0),
				"value2": Vector2(1, 1),
				"tps": 1000,
				"tps_deb": OS.get_ticks_msec()
			}
			mode = 1
		elif mode == 1:
			anim = {"anim": null}
			skin.scale = Vector2(1, 1)
			mode = 2
		elif mode == 2:
			Global.scenes.change_scene("res://menus/Shop.tscn")


func _process(delta):
	if anim["anim"] == "skin_scale":
		if OS.get_ticks_msec() - anim["tps_deb"] <= anim["tps"]:
			var min_v = anim["value1"]
			var max_v = anim["value2"]
			skin.scale = min_v + (max_v - min_v) * (OS.get_ticks_msec() - anim["tps_deb"])/(anim["tps"])
		else:
			anim = {"anim": null}
			mode = 1
