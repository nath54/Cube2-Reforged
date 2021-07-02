extends Node2D

var est_scellee:bool = false

func _ready():
	Global.fin = self

func set_scellee(est_scellee:bool):
	self.est_scellee = est_scellee
	if est_scellee:
		$Fin_Scellee.visible = true
		$Fin.visible = false
	else:
		$Fin.visible = true
		$Fin_Scellee.visible = true
