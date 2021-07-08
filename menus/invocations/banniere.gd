extends Control

export var id_banniere = "standard"

var prix1: int = 1000
var prix10: int = 9000

func _ready():
	$Titre.text = id_banniere
	#$Infos.text = DataSB.collections_ban_infos[id_banniere]
	$Infos.text = "Next divine : "+str(250-Account.pitys[4])+"\nNext legendary : "+str(100-Account.pitys[3])+"\nNext epic : "+str(10-Account.pitys[2])

func _on_BtHistorique_pressed():
	Global.id_banniere = id_banniere

func _on_Bt1_pressed():
	if Account.money >= prix1:
		Account.money -= prix1
		Global.id_banniere = id_banniere
		Global.scenes.change_scene("res://menus/invocations/Single.tscn")
	else:
		Global.scenes.alert("Warning !", "You don't have enough money !")

func _on_Bt10_pressed():
	if Account.money >= prix10:
		Account.money -= prix10
		Global.id_banniere = id_banniere
		Global.scenes.change_scene("res://menus/invocations/Multi.tscn")
	else:
		Global.scenes.alert("Warning !", "You don't have enough money !")

