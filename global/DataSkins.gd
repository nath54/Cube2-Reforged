extends Node


func _ready():
	trie_collections()


# Parameters : (*obligatoire) [Default Value]
#  *nom : Le nom du skin
#  *rar : La rareté du skin (0=commun 1=rare 2=epique 3=légendaire 4=divin)
#  rot[false] : Si le skin tourne en fonction de la direction
#  agl[0] : L'angle de rotation de base du skin

# Les données du skin en fonction de leurs id
var skins = {
	1: {"nom": "cube", "rar": 0}, # standard
	2: {"nom": "little eyes", "rar": 0}, # standard
	3: {"nom": "black arrow", "rar": 0}, # a changer le nom # standard
	4: {"nom": "rotating eyes", "rar": 2}, # standard
	5: {"nom": "france", "rar": 1}, # country
	6: {"nom": "lighted france", "rar": 3}, # country
	7: {"nom": "red cross", "rar": 0}, # standard
	8: {"nom": "green circle", "rar": 0}, # standard
	9: {"nom": "green arrow", "rar": 3}, # standard
	10: {"nom": "tiles", "rar": 1}, # standard
	11: {"nom": "pacman", "rar": 3}, # standard
	12: {"nom": "hole", "rar": 1}, # standard
	13: {"nom": "red zone", "rar": 3}, # anime
	14: {"nom": "stupid head", "rar": 3}, # standard
	15: {"nom": "line", "rar": 3}, # standard
	16: {"nom": "thrusted", "rar": 3}, # vehicle
	17: {"nom": "space ship", "rar": 4}, # vehicle
	18: {"nom": "germany", "rar": 1}, # country
	19: {"nom": "austria", "rar": 1}, # country
	20: {"nom": "armenia", "rar": 1}, # country
	21: {"nom": "bolivia", "rar": 1}, # country
	22: {"nom": "bulgaria", "rar": 1}, # country
	23: {"nom": "colombia", "rar": 1}, # country
	24: {"nom": "estonia", "rar": 1}, # country
	25: {"nom": "gabon", "rar": 1}, # country
	26: {"nom": "hongria", "rar": 1}, # country
	27: {"nom": "lituania", "rar": 1}, # country
	28: {"nom": "luxembourg", "rar": 1}, # country
	29: {"nom": "netherlands", "rar": 1}, # country
	30: {"nom": "russia", "rar": 1}, # country
	31: {"nom": "sierra leone", "rar": 1}, # country
	32: {"nom": "yemen", "rar": 1}, # country
	33: {"nom": "belgium", "rar": 1}, # country
	34: {"nom": "guinea", "rar": 1}, # country
	35: {"nom": "italia", "rar": 1}, # country
	36: {"nom": "ireland", "rar": 1}, # country
	37: {"nom": "mali", "rar": 1}, # country
	38: {"nom": "nigeria", "rar": 1}, # country
	39: {"nom": "peru", "rar": 1}, # country
	40: {"nom": "romania", "rar": 1}, # country
	41: {"nom": "afghanistan", "rar": 1}, # country
	42: {"nom": "andorra", "rar": 1}, # country
	43: {"nom": "cameroon", "rar": 1}, # country
	44: {"nom": "guatemala", "rar": 1}, # country
	45: {"nom": "mexico", "rar": 1}, # country
	46: {"nom": "moldavia", "rar": 1}, # country
	47: {"nom": "senegal", "rar": 1}, # country
	48: {"nom": "brazil", "rar": 1}, # country
	49: {"nom": "algeria", "rar": 1}, # country
	50: {"nom": "angola", "rar": 1}, # country
	51: {"nom": "malta", "rar": 1}, # country
	52: {"nom": "monaco", "rar": 1}, # country
	53: {"nom": "poland", "rar": 1}, # country
	54: {"nom": "burkina faso", "rar": 1}, # country
	55: {"nom": "algeria", "rar": 1}, # country
	56: {"nom": "porugal", "rar": 1}, # country
	57: {"nom": "usa", "rar": 1}, # country
	58: {"nom": "san marino", "rar": 1}, # country
	59: {"nom": "ukraine", "rar": 1}, # country
	60: {"nom": "vatican", "rar": 1}, # country
	61: {"nom": "switzerland", "rar": 1}, # country
	62: {"nom": "tunisia", "rar": 1}, # country
	63: {"nom": "japan", "rar": 1}, # country
	64: {"nom": "albania", "rar": 1}, # country
	65: {"nom": "bangladesh", "rar": 1}, # country
	66: {"nom": "south korea", "rar": 1}, # country
	67: {"nom": "palaos", "rar": 1}, # country
	68: {"nom": "china", "rar": 1}, # country
	69: {"nom": "black borders", "rar": 0}, # standard
	70: {"nom": "crossed", "rar": 0}, # standard
	71: {"nom": "little square", "rar": 1}, # standard
	72: {"nom": "little lozenge", "rar": 1}, # standard
	73: {"nom": "white on black", "rar": 1}, # standard
	74: {"nom": "blue stripes", "rar": 0}, # standard
	75: {"nom": "red stripes", "rar": 0}, # standard
	76: {"nom": "green peaks", "rar": 3}, # standard
}



# Les collections des skins : 

var collections = {
	"standard": {"skins": [0, 1, 2, 3, 4, 7, 8, 9, 10, 11, 12, 14, 15, 69, 70, 71, 72, 73, 74, 75, 76], "bg": ""},
	"countries": {"skins": [5, 6, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68], "bg": ""}, # septembre
	"sports": {"skins": [], "bg": ""}, # juillet
	"christmas": {"skins": [], "bg": ""}, # décembre
	"halloween": {"skins": [], "bg": ""}, # octobre
	"easter": {"skins": [], "bg": ""}, # avril
	"animals": {"skins": [], "bg": ""}, # septembre / octobre
	"summer": {"skins": [], "bg": ""}, # juillet
	"deluxe": {"skins": [], "bg": ""}, # mai
	"back to school": {"skins": [], "bg": ""}, # septembre
	"middle ages": {"skins": [], "bg": ""}, # janvier / fevrier
	"fantasy": {"skins": [], "bg": ""}, # juin
	"technologies": {"skins": [], "bg": ""}, # juin
	"fruits & vegetables": {"skins": [], "bg": ""}, #juin
	"smileys": {"skins": [], "bg": ""}, # aout
	"nature": {"skins": [], "bg": ""}, # mai
	"arts": {"skins": [], "bg": ""}, # juin
	"celebrities": {"skins": [], "bg": ""}, # novembre
	"food": {"skins": [], "bg": ""}, # mars
	"monuments": {"skins": [], "bg": ""}, # octobre
	"blobs": {"skins": [], "bg": ""}, # janvier
	"mythology": {"skins": [], "bg": ""}, # octobre
	"flowers": {"skins": [], "bg": ""}, # avril
	"hell": {"skins": [], "bg": ""},  # mai
	"love": {"skins": [], "bg": ""}, # février
	"vehicles": {"skins": [16, 17], "bg": ""}, # janvier
	"china": {"skins": [], "bg": ""}, # février
	"japan": {"skins": [], "bg": ""}, # fin février
	"egypt": {"skins": [], "bg": ""}, # janvier
	"space": {"skins": [], "bg": ""}, # avril
	"anime": {"skins": [13], "bg": ""}, # 15 décembre
	"jobs": {"skins": [], "bg": ""}, # mai
	"pirates": {"skins": [], "bg": ""}, # septembre / octobre
	"masks": {"skins": [], "bg": ""}, # mars
	"": {"skins": [], "bg": ""},
};

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
# Chance d'avoir un légendaire : 0.09 %
# Chance d'avoir un épique : 3.9 %
# Chance d'avoir un rare : 40 %
# Chance d'avoir un commun : 56 %
#
# Cout de 1 voeux : 100 money
# Cout de 10 voeux : 900 money

func trie_collections():
	for c in collections.keys():
		var rars = {0: [], 1: [], 2: [], 3: [], 4: []}
		for s in collections[c]["skins"]:
			rars[skins[s]["rar"]].append(s)
		collections[c]["tries_rar"] = rars


# Dates des bannières 
# Clé : "jour/moi"

var dates = {
	"1/1": "egypt",
	"8/1": "vehicles",
	"14/1": "blobs",
	"25/1": "middle ages",
	"4/2": "china",
	"14/2": "love",
	"22/2": "japan",
	"1/3": "hell",
	"10/3": "masks",
	"20/3": "food",
	"30/3": "easter",
	"9/4": "flowers",
	"19/4": "space",
	"29/4": "jobs",
	"9/5": "technologies",
	"19/5": "nature",
	"29/5": "deluxe",
	"8/6": "fantasy",
	"18/6": "arts",
	"28/6": "fruits & vegetables",
	"8/7": "summer",
	"18/7": "sports",
	"28/7": "pirates",
	"7/8": "smileys",
	"17/8": null,
	"27/8": "back to school",
	"6/9": "countries",
	"16/9": null,
	"26/9": "animals",
	"6/10": "mythology",
	"16/10": "monuments",
	"26/10": "halloween",
	"5/11": null,
	"15/11": "celebrities",
	"25/11": null,
	"2/12": null,
	"10/12": "anime",
	"20/12": "christmas",
}

