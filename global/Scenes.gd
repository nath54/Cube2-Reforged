# SCENES
extends Node

func _ready():
	Global.scenes = self
	change_scene("res://menus/Intro.tscn")


func change_scene(path):
	# On nettoie l'interface
	$Interface/Interface/VBoxContainer/floor.visible = false
	$Interface/Interface/VBoxContainer/dead.visible = false
	# On détruit l'anciene scene
	for c in $Root.get_children():
		c.queue_free()
	# On crée la nouvelle scene
	var sc = load(path).instance()
	#
	$Root.add_child(sc)
	

func _process(delta):
	$Interface/Interface/VBoxContainer/fps.text = str(Engine.get_frames_per_second())

func quit():
	Saves.save_params()
	Saves.save_account()
	get_tree().quit()

