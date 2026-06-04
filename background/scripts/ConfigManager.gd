extends Node

const SAVE_PATH = "user://gamesave.save"

var high_score: int = 0
var selected_bird: String = "default"

func _ready():
	load_data()

func save_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		var data_to_save = {
			"high_score": high_score,
			"selected_bird": selected_bird
		}
		file.store_var(data_to_save)


func load_data():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file:
			var data = file.get_var()
			if typeof(data) == TYPE_DICTIONARY:
				high_score = data.get("high_score", 0)
				selected_bird = data.get("selected_bird", "default")
