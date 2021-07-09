extends Node2D

onready var player:Node = $Player/Player_TopDown

var tx:int = 0
var ty:int = 0
var tc:int = 100
# var map:Array = []
var deb:Array = []
var fin:Array = []
var chem:Array = []
var rng:RandomNumberGenerator = RandomNumberGenerator.new()
var timer:Timer = Timer.new()
var time_max: float = 0
var wait_time: float = 0

var min_x = null
var min_y = null
var max_x = null
var max_y = null

onready var progressStyleBox = $CanvasLayer/Control/VBoxContainer/ProgressBar.get("custom_styles/fg")
var lance: bool = false
var pause: bool = false
# map : 0 = mur, 1 = sol, 2 = mur non mortel

# Les themes pour les differents étages
var themes: Dictionary = {
	1: 0,
	2: 5,
	3: 10,
	4: 15,
	5: 20,
	6: 25,
	7: 30,
	8: 35,
	9: 40,
	10: 45,
	11: 50,
	12: 55,
	13: 60,
	14: 65,
	15: 70
}

func generate() -> void:
	rng.randomize()
	$Map/TileMap.clear()
	if Global.difficulty == 0:
		time_max = 120 + 0.1 * Global.stage # En secondes
	elif Global.difficulty == 1:
		time_max = 100 + 0.1 * Global.stage # En secondes
	elif Global.difficulty == 2:
		time_max = 80 + 0.1 * Global.stage # En secondes
	elif Global.difficulty == 3:
		time_max = 70 + 0.1 * Global.stage # En secondes
	elif Global.difficulty == 4:
		time_max = 60 + 0.1 * Global.stage # En secondes
	#
	tx=50+5*Global.difficulty+int(5*log(Global.stage))
	ty=50+5*Global.difficulty+int(5*log(Global.stage))
	#
	deb = [rng.randi_range( int(tx/3), int(tx/3*2)), rng.randi_range( int(ty/3), int(ty/3*2))]
	var fins:Array = []
	#
	for b in range(Global.difficulty+2): # Plus la difficulté est grande, plus il y aura de branches
		chem = deb
		var ra = 100+10*(Global.difficulty+1)+int(5*log(Global.stage))
		var rb = 150+10*(Global.difficulty+1)+int(10*log(Global.stage))
		for n in range(rng.randi_range(ra, rb)):
			chem[rng.randi_range(0, 1)] += [-1, 1][rng.randi_range(0, 1)]
			if min_x == null or chem[0] < min_x: min_x = chem[0]
			if max_x == null or chem[0] > max_x: max_x = chem[0]
			if min_y == null or chem[1] < min_y: min_y = chem[1]
			if max_y == null or chem[1] > max_y: max_y = chem[1]
			$Map/TileMap.set_cell(chem[0], chem[1], 1)
			for xx in range(-1, 2):
				for yy in range(-1, 2):
					var x:int = chem[0]+xx
					var y:int = chem[1]+yy
					if $Map/TileMap.get_cell(x, y) != 1:
						$Map/TileMap.set_cell(x, y, 0)
		fins.append([chem[0], chem[1]])
	fin = fins[rng.randi_range(0, len(fins)-1)]
	$Items/Fin.position = Vector2(fin[0]*tc, fin[1]*tc)
	#
	if Global.difficulty == 0:
		Global.player.t = 40
		Global.player.scale = Vector2(0.4, 0.4)
	elif Global.difficulty == 1:
		Global.player.t = 50
		Global.player.scale = Vector2(0.5, 0.5)
	elif Global.difficulty == 2:
		Global.player.t = 60
		Global.player.scale = Vector2(0.6, 0.6)
	elif Global.difficulty == 3:
		Global.player.t = 65
		Global.player.scale = Vector2(0.65, 0.65)
	elif Global.difficulty == 4:
		Global.player.t = 70
		Global.player.scale = Vector2(0.7, 0.7)
	#
	Global.player.spawn_x = deb[0] * tc + (tc-Global.player.t) / 2
	Global.player.spawn_y = deb[1] * tc + (tc-Global.player.t) / 2
	Global.player.x = deb[0] * tc + Global.player.t / 3
	Global.player.y = deb[1] * tc + Global.player.t / 3
	Global.player.position = Vector2(Global.player.x, Global.player.y)
	Global.player.set_life()
	#
	
func _ready():
	Global.level = self
	#
	Global.theme = 1
	while Global.stage >= themes[Global.theme+1] and Global.theme < len(themes.keys())-2:
		Global.theme += 1
	if Global.stage >= themes[themes.keys()[-1]]:
		Global.theme = themes.keys()[-1]
	#
	var tileset: TileSet = load("res://game/tiles/TopDown"+str(Global.theme)+".tres")
	$Map/TileMap.tile_set = tileset
	#
	Global.scenes.get_node("Interface/Interface/VBoxContainer/floor").visible = true
	Global.scenes.get_node("Interface/Interface/VBoxContainer/dead").visible = true
	
	Global.scenes.get_node("Interface/Interface/VBoxContainer/floor").text = "floor "+str(Global.stage)
	Global.scenes.get_node("Interface/Interface/VBoxContainer/dead").text = "dead 0x"
	generate()
	#
	while Global.player.square_col(Global.player.x, Global.player.y, Global.player.t, Global.player.t, fin[0]*tc, fin[1]*tc, tc, tc)["collision"]:
		generate()
	wait_time = time_max
	#
	$Camera2D.current = true
	max_x += 2
	max_y += 2
	min_x -= 2
	min_y -= 2
	$Camera2D.position = Vector2((max_x*tc + min_x*tc)/2.0, (max_y*tc + min_y*tc)/2.0)
	var zx = (max_x*tc - min_x*tc)/600.0
	var zy = (max_y*tc - min_y*tc)/600.0
	var z = max(zx, zy)
	$Camera2D.zoom = Vector2(z, z)
	#
	Global.player.get_node("Camera2D").current = false
	yield(get_tree().create_timer(3), "timeout")
	#
	$CanvasLayer/Control/VBoxContainer/ProgressBar.visible = true
	$Camera2D.current = false
	Global.player.get_node("Camera2D").current = true
	#
	lance = true

func _process(delta):
	if lance and not pause:
		var cl = Color(1.0-wait_time/time_max,1.0*wait_time/time_max,0)
		progressStyleBox.bg_color = cl
		$CanvasLayer/Control/VBoxContainer/ProgressBar.value = 100.0*wait_time/time_max
		wait_time -= delta
		if wait_time <= 0:
			Global.lose_game()


func fin():
	$AnimationPlayer.play("fin")
	Global.player.fin = true
	var a: float = 0.01
	Global.player.speed_x = ((fin[0]*tc) - (Global.player.x-tc/2)) * a
	Global.player.speed_y = ((fin[1]*tc) - (Global.player.y-tc/2)) * a


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fin":
		Global.level_fini()
