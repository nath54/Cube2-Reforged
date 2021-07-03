extends Node2D

var est_scellee:bool = false
var theme_actu:int = 1

func _ready():
	Global.fin = self
	set_theme(Global.theme)

func set_theme(theme:int):
	get_node(str(theme_actu)).visible = false
	get_node(str(theme)).visible = true
	theme_actu = theme

func set_scellee(est_scellee:bool):
	self.est_scellee = est_scellee
	"""
	if est_scellee:
		get_node(str(theme_actu)+"/Fin_Scellee").visible = true
		get_node(str(theme_actu)+"/Fin").visible = false
	else:
		get_node(str(theme_actu)+"/Fin").visible = true
		get_node(str(theme_actu)+"/Fin_Scellee").visible = true
	"""
