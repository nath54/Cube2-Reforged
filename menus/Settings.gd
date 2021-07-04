extends Control

func _ready():
	pass

func _on_BtMenu_pressed():
	Global.scenes.change_scene("res://menus/MainMenu.tscn")


func _on_BtGeneral_pressed():
	Global.scenes.change_scene("res://menus/settings/GeneralSettings.tscn")


func _on_BtAudio_pressed():
	Global.scenes.change_scene("res://menus/settings/AudioSettings.tscn")


func _on_BtGraphics_pressed():
	Global.scenes.change_scene("res://menus/settings/VideoSettings.tscn")


func _on_BtControls_pressed():
	Global.scenes.change_scene("res://menus/settings/ControlsSettings.tscn")


func _on_BtLanguage_pressed():
	Global.scenes.change_scene("res://menus/settings/LanguageSettings.tscn")


func _on_BtGameData_pressed():
	Global.scenes.change_scene("res://menus/settings/GameDataSettings.tscn")
