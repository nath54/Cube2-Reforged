extends Node2D

onready var player = $Player/Player_TopDown

var tx = 0
var ty = 0
var tc = 100
var map = []
var deb = null
var fin = null
var chem = null
var rng = RandomNumberGenerator.new()

# map : 0 = mur, 1 = sol, 2 = mur non mortel

func generate():
	tx=50+5*Global.difficulty
	ty=50+5*Global.difficulty
	#
	for y in range(tx):
		map.append([])
		for x in range(ty):
			map[y].append(-1) # -1 = vide
	#
	deb = [rng.randi_range( int(tx/3), int(tx/3*2)), rng.randi_range( int(ty/3), int(ty/3*2))]
	map[deb[1]][deb[0]] = 1 # sol
	var fins = []
	#
	for b in range(Global.difficulty): # Il y aura autant de branches que de difficultés
		chem = deb
		var ra = 100*Global.difficulty+5*Global.stage
		var rb = 110*Global.difficulty+10*Global.stage
		for n in range(rng.randi_range(ra, rb)):
			chem[rng.randi_range(0, 1)] += [-1, 1][rng.randi_range(0, 1)]
			map[chem[1]][chem[0]] = 1
		fins.append([chem[0], chem[1]])
	fin = fins[rng.randi_range(0, len(fins))]


func _process(delta):
	pass
