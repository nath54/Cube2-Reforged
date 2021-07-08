extends Control

export var id_banniere = "standard"

func _ready():
	$Titre.text = id_banniere
	$Infos.text = DataSB.collections_ban_infos[id_banniere]

func _on_BtHistorique_pressed():
	Global.id_banniere = id_banniere

func _on_Bt1_pressed():
	Global.id_banniere = id_banniere
	Global.scenes.change_scene("res://menus/invocations/Single.tscn")

func _on_Bt10_pressed():
	Global.id_banniere = id_banniere
	Global.scenes.change_scene("res://menus/invocations/Multi.tscn")

