extends Control

func _ready():
	$AnimationPlayer.play("Intro")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Intro":
		Global.scenes.change_scene("res://menus/MainMenu.tscn")
