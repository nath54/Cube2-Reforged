extends Node2D

var mode: int = 0

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
	var skin = load("res://res/skins/"+str(res["id_skin"])+"/Skin.tscn").instance()
	$Skin.add_child(skin)
	skin.position = Vector2(242, 155)


func _input(event):
	if event is InputEventScreenTouch:
		if mode == 0:
			$AnimationPlayer.play("invoc")
			mode = 1
		elif mode == 1:
			Global.scenes.change_scene("res://menus/Shop.tscn")

