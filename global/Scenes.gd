extends Node

func _ready():
	Global.scenes = self
	change_scene("res://menus/Intro.tscn")


func change_scene(path):
	# On détruit l'anciene scene
	for c in $Root.get_children():
		c.queue_free()
	# On crée la nouvelle scene
	var sc = load(path).instance()
	#
	$Root.add_child(sc)
	

func _process(delta):
	$Interface/fps.text = str(Engine.get_frames_per_second())
