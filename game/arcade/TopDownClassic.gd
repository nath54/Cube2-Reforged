extends Node2D

onready var player:Node = $Player/Player_TopDown

var tx:int = 0
var ty:int = 0
var tc:int = 100
var map:Array = []
var deb:Array = []
var fin:Array = []
var chem:Array = []
var rng:RandomNumberGenerator = RandomNumberGenerator.new()

# map : 0 = mur, 1 = sol, 2 = mur non mortel

func generate() -> void:
	tx=50+5*Global.difficulty+int(5*log(Global.stage))
	ty=50+5*Global.difficulty+int(5*log(Global.stage))
	#
	for y in range(tx):
		map.append([])
		for x in range(ty):
			map[y].append(-1) # -1 = vide
			# $Map/TileMap.set_cell(x, y, 0)
	#
	deb = [rng.randi_range( int(tx/3), int(tx/3*2)), rng.randi_range( int(ty/3), int(ty/3*2))]
	map[deb[1]][deb[0]] = 1 # sol
	var fins:Array = []
	#
	for b in range(Global.difficulty+2): # Plus la difficulté est grande, plus il y aura de branches
		chem = deb
		var ra = 100*(Global.difficulty+1)+int(5*log(Global.stage))
		var rb = 110*(Global.difficulty+1)+int(10*log(Global.stage))
		for n in range(rng.randi_range(ra, rb)):
			chem[rng.randi_range(0, 1)] += [-1, 1][rng.randi_range(0, 1)]
			chem = [clamp(chem[0], 0, tx-1), clamp(chem[1], 0, ty-1)]
			map[chem[1]][chem[0]] = 1 # 1 = sol
			$Map/TileMap.set_cell(chem[0], chem[1], 1)
			for xx in range(-1, 2):
				for yy in range(-1, 2):
					var x:int = chem[0]+xx
					var y:int = chem[1]+yy
					if $Map/TileMap.get_cell(x, y) != 1:
						$Map/TileMap.set_cell(x, y, 0)
						map[y][x] = 0 # 0 = vide
		fins.append([chem[0], chem[1]])
	fin = fins[rng.randi_range(0, len(fins)-1)]
	#
	Global.player.x = deb[0] * tc
	Global.player.y = deb[1] * tc
	#
	
func _ready():
	Global.level = self
	generate()


func _draw():
	var cx: int = int(Global.player.x - Global.player.t/2)
	var cy: int = int(Global.player.y - Global.player.t/2)
	var ct: float = Global.player.t
	draw_rect(Rect2(cx, cy, ct, ct), Color(255, 0, 0))

func _process(delta):
	pass
	"""
	var pcx:int = int(Global.player.x/tc)
	var pcy:int = int(Global.player.y/tc)
	for x in range(pcx-10,pcx+10):
		for y in range(pcy-10, pcy+10):
			if x >= 0 and y >= 0 and x < tx and y < ty:
				$Map/TileMap.set_cell(x, y, map[y][x])
	"""
