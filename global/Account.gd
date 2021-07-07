# PLAYER SKINS
extends Node

# Les skins possédés en clés
# et le nombre de possédés en valeurs
var skins = {
	1: 1
}

# Skins : 
# possédés : 1
# courrone 1 : 3
# courrone 2 : 5
# courrone 3 : 10

# L'id du skin actuellement équipé
var skin_equipe = 6

# La monaie que le joueur a dans le jeu
var money = 0

# Record du mode arcade
var arcade_record = 0
var date_arcade_record = null
# Le record de ce moi ci
var arcade_record_month = 0
var date_arcade_record_month = null


# Les pitys que le joueur a pour les invocations
var pitys: Dictionary = {
	4: 0,
	3: 0,
	2: 0,
	1: 0,
	0: 0
}


