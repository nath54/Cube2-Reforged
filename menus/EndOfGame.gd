extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.mode == "arcade":
		var time: Dictionary = OS.get_datetime()
		# Calcul des highscores
		if Global.stage > Account.arcade_record[Global.difficulty]:
			$CenterContainer/VBoxContainer/HBoxContainer/VBoxContainer2/CenterContainer4/Arcade_Record.text = "You beat your ancient highscore ("+str(Account.arcade_record[Global.difficulty])+") !"
			Account.arcade_record[Global.difficulty] = Global.stage
			Account.date_arcade_record[Global.difficulty] = [time["day"], time["month"], time["year"]]			
		else:
			$CenterContainer/VBoxContainer/HBoxContainer/VBoxContainer2/CenterContainer4/Arcade_Record.text = "Highscore : "+str(Account.arcade_record[Global.difficulty])
		if Global.stage > Account.arcade_record_month[Global.difficulty]:
			$CenterContainer/VBoxContainer/HBoxContainer/VBoxContainer2/CenterContainer3/Arcade_Record_Month.text = "You beat your highscore of the month ("+str(Account.arcade_record_month[Global.difficulty])+") !"
			Account.arcade_record_month[Global.difficulty] = Global.stage
			Account.date_arcade_record_month[Global.difficulty] = [time["day"], time["month"], time["year"]]
		else:
			$CenterContainer/VBoxContainer/HBoxContainer/VBoxContainer2/CenterContainer3/Arcade_Record_Month.text = "Highscore of this month : "+str(Account.arcade_record_month[Global.difficulty])
		# Calcul des gains
		var gains:int = 1
		var g: String = str(Global.stage)
		for x in range(len(g), 0, -1):
			gains += (int(g[x-1])) * (x+1)
		gains *= (5+randf()*5)
		if Global.difficulty == 1:
			gains *= 1.2
		elif Global.difficulty == 2:
			gains *= 1.5
		elif Global.difficulty == 3:
			gains *= 1.7
		elif Global.difficulty == 4:
			gains *= 2
		Account.money += gains
		Saves.save_account()
		# Affichages
		$CenterContainer/VBoxContainer/HBoxContainer/VBoxContainer2/CenterContainer2/Difficulty.text = "Difficulty " + Global.difficulties[Global.difficulty]
		$"CenterContainer/VBoxContainer/HBoxContainer/VBoxContainer/CenterContainer2/Died Floor".text = "You reach the floor "+str(Global.stage)
		$CenterContainer/VBoxContainer/HBoxContainer/VBoxContainer/CenterContainer3/HBoxContainer/Money.text = "You gain : "+str(gains)
	else:
		$CenterContainer/VBoxContainer/CenterContainer2.visible = false;
		$CenterContainer/VBoxContainer/CenterContainer3.visible = false;
	#

func _on_BtMenu_pressed():
	Global.scenes.change_scene("res://menus/MainMenu.tscn")


func _on_BtRetry_pressed():
	if Global.mode == "arcade":
		Global.stage = 1
		Global.scenes.change_scene("res://game/arcade/Arcade.tscn")
