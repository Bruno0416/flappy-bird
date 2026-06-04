extends Control

@onready var birdSelector: OptionButton = $VBoxContainer/BirdSelector
@onready var playButton: Button = $VBoxContainer/PlayButton

func _ready():
	# agregar opciones al dropdown (texto, id)
	birdSelector.add_item("Rojo (Default)", 0)
	birdSelector.add_item("Azul", 1)
	birdSelector.add_item("Amarillo", 2)

	# seleccionar la opcion previamente guardada
	match ConfigManager.selected_bird:
		"blue":
			birdSelector.select(1)
		"yellow":
			birdSelector.select(2)
		_:
			birdSelector.select(0)

	# conectamos las seniales
	birdSelector.item_selected.connect(_on_bird_selected)
	playButton.pressed.connect(_on_play_pressed)

func _on_bird_selected(index: int):
	match index:
		0:
			ConfigManager.selected_bird = "red"
		1:
			ConfigManager.selected_bird = "blue"
		2:
			ConfigManager.selected_bird = "yellow"

	# guardar la seleccion en disco al instante
	ConfigManager.save_data()

func _on_play_pressed():
	# cargar la escena del juego principal
	get_tree().change_scene_to_file("res://background/scenes/main.tscn")
