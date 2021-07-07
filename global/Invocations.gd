# INVOCATIONS
extends Node

# Banières 
#  - bannière arme
#  - bannière limitée
#  - bannière standard
#
# Pity Divin : 250 voeux
# Pity Légendaire : 100 voeux
# Pity Epique : 10 voeux
#
# Chance d'avoir un divin : 0.01 %
# Chance d'avoir un légendaire : 0.09 % si l'on a pas eu de divin
# Chance d'avoir un épique : 3.9 % si l'on a pas eu de légendaire
# Chance d'avoir un rare : 40 % si l'on a pas eu d'épique
# Chance d'avoir un commun : 100 % si l'on a pas eu de rares
#
# Cout de 1 voeux : 1000 money
# Cout de 10 voeux : 9000 money

# à partir de 10 de pity : 
#   - On a un épique garantit

# à partir de 70 de pity : 
#   - 0.5 % de chance d'avoir un légendaire
#   - 0.05 % de chance d'avoir un divin

# à partir de 80 de pity : 
#   - 5 % de chance d'avoir un légendaire

# à partir de 100 de pity : 
#   - On a un légendaire garantit

# à partir de 150 de pity:
#   - 0.1 % de chance d'avoir un divin

# à partir de 200 de pity:
#   - 1 % de chance d'avoir un divin

# à partir de 250 de pity : 
#   - On a un divin garantit

# Rappels : 
#  0 : commun
#  1 : rare
#  2 : épique
#  3 : légendaire
#  4 : divin

const probs: Dictionary = { # % de chance d'avoir la rareté en fonction du minimum de la pity que l'on a
	4: {0: 0.01, 70: 0.05, 150: 0.1, 200: 1, 250:100},
	3: {0: 0.09, 70: 0.5, 80: 5, 100:100},
	2: {0: 3.9, 10:100},
	1: {0: 40},
	0: {0: 100}
}

# Si on a pas eu de skins limités, on en aura un garantit la prochaine fois
var skins_limite_garantits: Dictionary = {
	4: true,
	3: true,
	2: true, # les premier skin de chaque rareté obtenu 
	1: true, # sur les bannieres limitées est
	0: true  # est garanti d'être de la bannière
}

func invo(id_banniere: String) -> Dictionary: # retourne l'id du skin obtenu et la rareté
	# VERIFICATIONS
	#TODO
	pass
	#
	randomize()
	var rar_ob = 0 # Par défaut, on a un commun
	# On va recuperer la rareté obtenue
	for rarete in [4, 3, 2, 1]:
		# On récupère la probabilité
		var prob: float = 0
		for test_pity in probs[rarete].keys():
			if Account.pitys[rarete] >= test_pity:
				prob = probs[rarete][test_pity]
		# On effectue le tirage
		var tir: float = randf() * 100
		if tir <= prob:
			# On a la rareté obtenue
			rar_ob = rarete
			break
	# On teste si on a le skin garantit
	var skin_ban = "standard" # par défaut la standard
	randomize()
	# On teste s'il y a un skin de la rareté sur la bannière limitée, et on teste la garantie ou le 50/50
	if not len(DataSB.collections[id_banniere]["tries_rar"][rar_ob]) == 0 and (skins_limite_garantits[rar_ob] or randf() > 0.5):
		skin_ban = id_banniere
	# On va tirer au hasard
	randomize()
	var length: int = len(DataSB.collections[skin_ban]["tries_rar"][rar_ob])
	var id_skin = DataSB.collections[skin_ban]["tries_rar"][rar_ob][int(randf()*length)]
	# On va ajouter le skin au compte et faire les modifs nécessaires
	# On ajoute le skin au compte
	if id_skin in Account.skins.keys():
		Account.skins[id_skin] += 1
	else:
		Account.skins[id_skin] = 1
	# On va modifier les pitys
	for p in Account.pitys.keys():
		if p == rar_ob:
			Account.pitys[p] = 0
		else:
			Account.pitys[p] += 1
	# On va sauvegarder
	Saves.save_account()
	#
	return {"id_skin": id_skin, "rar": rar_ob}



func multi(id_banniere: String) -> Dictionary:
	var max_rar: int = 0
	var results: Array = []
	for x in range(10):
		var res: Dictionary = invo(id_banniere)
		if res["rar"] > max_rar:
			max_rar = res["rar"]
	return {"invos": results, "max_rar": max_rar}



