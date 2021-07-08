# SAVES AND LOADS
extends Node

func _ready():
	load_params()
	load_account()

func save_params() -> void:
	#
	var data: Dictionary = {
		"difficulty": Global.difficulty,
		"joystick_method": Global.joy_method,
		"joystick_deadzone": Global.deadzone
	}
	#
	var content: String = JSON.print(data)
	#
	var file: File = File.new()
	file.open("user://save_params.dat", File.WRITE)
	file.store_string(content)
	file.close()

func load_params() -> void:
	var file: File = File.new()
	if file.file_exists("user://save_params.dat"):
		file.open("user://save_params.dat", File.READ)
		var content = file.get_as_text()
		file.close()
		var data = JSON.parse(content).result
		Global.difficulty = data["difficulty"]
		Global.joy_method = data["joystick_method"]
		Global.deadzone = data["joystick_deadzone"]

func save_account() -> void:
	#
	var data: Dictionary = {
		"skins": Account.skins,
		"skin_equipe": Account.skin_equipe,
		"money": Account.money,
		"pitys": Account.pitys,
		"arcade_record": Account.arcade_record,
		"date_arcade_record": Account.date_arcade_record,
		"arcade_record_month": Account.arcade_record_month,
		"date_arcade_record_month": Account.date_arcade_record_month
	}
	#
	var content: String = JSON.print(data)
	#
	var file: File = File.new()
	file.open("user://save_acc.dat", File.WRITE)
	file.store_string(content)
	file.close()

func load_account() -> void:
	var file: File = File.new()
	if file.file_exists("user://save_acc.dat"):
		file.open("user://save_acc.dat", File.READ)
		var content: String = file.get_as_text()
		file.close()
		var data: Dictionary = JSON.parse(content).result
		Account.skins = data["skins"]
		Account.skin_equipe = data["skin_equipe"]
		Account.money = data["money"]
		Account.pitys = data["pitys"]
		Account.arcade_record = data["arcade_record"]
		Account.date_arcade_record = data["date_arcade_record"]
		Account.arcade_record_month = data["arcade_record_month"]
		Account.date_arcade_record_month = data["date_arcade_record_month"]
		for dic in [Account.arcade_record, Account.date_arcade_record, Account.arcade_record_month, Account.date_arcade_record_month, Account.pitys, Account.skins]:
			for x in dic.keys():
				dic[int(x)] = dic[str(x)]
				dic.erase(str(x))
