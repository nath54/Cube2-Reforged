extends Node2D

var spawn_x: float = 0
var spawn_y: float = 0

var x: float = 0
var y: float = 0
var t: float = 50

var max_life: int = 100
var life: int = max_life
var count_dead: int = 0

var speed_x: float = 0
var speed_y: float = 0

var max_speed: float = 30
var acceleration: float = 15
var decceleration: float = 0.97

var catched_keys: Array = []

var rebondit_cols:float = 1

var click = null

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player = self
	if Global.difficulty == 0:
		acceleration = 10
		decceleration = 0.95
		max_speed = 30
	elif Global.difficulty == 1:
		acceleration = 15
		decceleration = 0.96
		max_speed = 35
	elif Global.difficulty == 2:
		acceleration = 20
		decceleration = 0.97
		max_speed = 40
	elif Global.difficulty == 3:
		acceleration = 22
		decceleration = 0.98
		max_speed = 45
	elif Global.difficulty == 4:
		acceleration = 25
		decceleration = 0.99
		max_speed = 50
	# Set skin
	$Skin/Skin.queue_free()
	var skin = load("res://res/skins/"+str(Global.skin)+"/Skin.tscn").instance()
	$Skin.add_child(skin)
	

func movement(delta: float) -> void:
	var f = true
	if Input.is_action_pressed("up") or Global.joystick.y <= -Global.deadzone:
		speed_y -= acceleration * delta
		f = false
	if Input.is_action_pressed("down") or Global.joystick.y >= Global.deadzone:
		speed_y += acceleration * delta
		f = false
	if Input.is_action_pressed("left") or Global.joystick.x <= -Global.deadzone:
		speed_x -= acceleration * delta
		f = false
	if Input.is_action_pressed("right") or Global.joystick.x >= Global.deadzone:
		speed_x += acceleration * delta
		f = false
	#
	if f:
		speed_x *= decceleration
		speed_y *= decceleration
	#
	speed_x = clamp(speed_x, -max_speed, max_speed)
	speed_y = clamp(speed_y, -max_speed, max_speed)
	#

func _process(delta: float):
	if Global.level.lance:
		movement(delta)
		x += speed_x
		y += speed_y
		collisions()
		test_life()
		position = Vector2(x, y);

func test_life() -> void:
	if life <= 0:
		if Global.difficulty == 4:
			Global.lose_game()
		life = max_life
		x = spawn_x
		y = spawn_y
		speed_x = 0
		speed_y = 0
		count_dead += 1
		
	Global.scenes.get_node("Interface/Interface/VBoxContainer/dead").text = "dead "+str(count_dead)+"x"

func square_col(x1:float, y1:float, tx1:float, ty1:float, x2:float, y2:float, tx2:float, ty2:float) -> Dictionary:
	if x1 <= x2 and x1+tx1 >= x2 and y1>=y2 and y1+ty1<=y2+ty2:
		return {"collision": true, "side": "right"}
	elif x1+tx1 >= x2+tx2 and x1 <= x2+tx2 and y1>=y2 and y1+ty1<=y2+ty2:
		return {"collision": true, "side": "left"}
	elif y1 <= y2 and y1+ty1 >= y2 and x1>=x2 and x1+tx1<=x2+tx2:
		return {"collision": true, "side": "bottom"}
	elif y1+ty1 >= y2+ty2 and y1 <= y2+ty2 and x1>=x2 and x1+tx1<=x2+tx2:
		return {"collision": true, "side": "top"}
	elif x1 <= x2 and x1+tx1 >= x2 and y1+ty1 >= y2+ty2 and y1 <= y2+ty2:
		return {"collision": true, "side": "top-right"}
	elif x1 <= x2 and x1+tx1 >= x2 and y1 <= y2 and y1+ty1 >= y2:
		return {"collision": true, "side": "bottom-right"}
	elif x1+tx1 >= x2+tx2 and x1 <= x2+tx2 and y1 <= y2 and y1+ty1 >= y2:
		return {"collision": true, "side": "bottom-left"}
	elif x1+tx1 >= x2+tx2 and x1 <= x2+tx2 and y1+ty1 >= y2+ty2 and y1 <= y2+ty2:
		return {"collision": true, "side": "top-left"}
	elif x1 >= x2 and y1 >= y2 and x1+tx1 <= x2+tx2 and y1+ty1 <= y2+ty2:
		return {"collision": true, "side": "inside"}
	return {"collision": false, "side": null}

func collisions() -> void:
	var tc: int = Global.level.tc
	var map: Node = Global.level
	var tilemap: TileMap = map.get_node("Map/TileMap")
	#collisions
	# On va parcourir les cases autour du joueur
	for x in range( int((self.x)/tc)-2 , int((self.x)/tc)+2 ):
		for y in range( int((self.y)/tc)-2 , int((self.y)/tc)+2 ):
			if true:
				# On teste la collision
				var col:Dictionary = square_col(self.x, self.y, self.t, self.t, x*tc, y*tc, tc, tc)
				# S'il n'y a pas de collision, on passe à la case suivante
				if not col["collision"]:
					continue
				#
				# Sinon il y a une collision
				if tilemap.get_cell(x, y)==0 and Global.difficulty>0: self.life=0
				elif (tilemap.get_cell(x, y)==0 and Global.difficulty==0) or tilemap.get_cell(x, y)==2:
					if col["side"] == "right":
						self.x = x * tc - self.t - rebondit_cols
						self.speed_x = 0
					elif col["side"] == "left":
						self.x = ( x + 1 ) * tc + rebondit_cols
						self.speed_x = 0
					if col["side"] == "bottom":
						self.y = y * tc - self.t - rebondit_cols
						self.speed_y = 0
					elif col["side"] == "top":
						self.y = ( y + 1 ) * tc + rebondit_cols
						self.speed_y = 0
					elif col["side"] == "top-left":
						if (x+1) * tc - self.x <= (y + 1) * tc - self.y:
							self.x = ( x + 1 ) * tc + rebondit_cols
							self.speed_x = 0
						else:
							self.y = ( y + 1 ) * tc + rebondit_cols
							self.speed_y = 0
					elif col["side"] == "top-right":
						if (self.x + self.t) - x * tc <= (y + 1) * tc - self.y:
							self.x = x * tc - self.t - rebondit_cols
							self.speed_x = 0
						else:
							self.y = ( y + 1 ) * tc + rebondit_cols
							self.speed_y = 0
					elif col["side"] == "bottom-right":
						if (self.x + self.t) - x * tc <= (self.y + self.t) - y * tc:
							self.x = x * tc - self.t - rebondit_cols 
							self.speed_x = 0
						else:
							self.y = y * tc - self.t - rebondit_cols
							self.speed_y = 0
					elif col["side"] == "bottom-left":
						if (x + 1) * tc - self.x <= (self.y + self.t) - y * tc:
							self.x = ( x + 1 ) * tc + rebondit_cols
							self.speed_x = 0
						else:
							self.y = y * tc - self.t - rebondit_cols
							self.speed_y = 0

				if tilemap.get_cell(x, y) == 2 and map.p1: self.life -= 50
				if map.fin == [x,y]:
					Global.level_fini()
	
	for key in Global.keys:
		if square_col(self.x, self.y, self.t, self.t, key.x, key.y, key.t, key.t):
			self.catched_keys.append( key )
			Global.keys.erase(key)

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			if click == null:
				click = event.position
		else:
			click = null
			Global.joystick = Vector2.ZERO
	elif event is InputEventScreenDrag:
		if click != null:
			var d:Vector2 = event.position - click
			# Methode 1 :
			if Global.joy_method == 1:
				if abs(d.x) >= abs(d.y):
					if d.x <= -Global.deadzone:
						Global.joystick.x = d.x
					elif d.x >= Global.deadzone:
						Global.joystick.x = d.x
				elif abs(d.x) < abs(d.y):
					if d.y <= -Global.deadzone:
						Global.joystick.y = d.y
					elif d.y >= Global.deadzone:
						Global.joystick.y = d.y
			elif Global.joy_method == 2:
				Global.joystick = d
		else:
			Global.joystick = Vector2.ZERO
