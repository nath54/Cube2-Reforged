# PLAYER SKINS
extends Node

# Les skins possédés en clés
# et le nombre de possédés en valeurs
var skins: Dictionary = {
	1: 1
}

# Skins : 
# possédés : 1
# courrone 1 : 3
# courrone 2 : 5
# courrone 3 : 10

# L'id du skin actuellement équipé
var skin_equipe: int = 6

# La monaie que le joueur a dans le jeu
var money: int = 0

# Record du mode arcade
# En fonction de la difficulté
var arcade_record: Dictionary = {
	0: 0,
	1: 0,
	2: 0,
	3: 0,
	4: 0
}
var date_arcade_record: Dictionary = {
	0: null,
	1: null,
	2: null,
	3: null,
	4: null
}
# Le record de ce moi ci
var arcade_record_month: Dictionary = {
	0: 0,
	1: 0,
	2: 0,
	3: 0,
	4: 0
}
var date_arcade_record_month: Dictionary = {
	0: null,
	1: null,
	2: null,
	3: null,
	4: null
}


# Les pitys que le joueur a pour les invocations
var pitys: Dictionary = {
	4: 0,
	3: 0,
	2: 0,
	1: 0,
	0: 0
}


func _ready():
	var time: Dictionary = OS.get_datetime()
	for d in range(0,5):
		if date_arcade_record_month[d] != null and date_arcade_record_month[d][1] != time["month"]:
			arcade_record_month[d] = 0
			date_arcade_record_month[d] = null
