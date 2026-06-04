extends CanvasLayer

@export var scoreLabel: Label
@export var gameOverScreen: CanvasLayer

signal restartRequested

func reset_ui():
	gameOverScreen.hide()
	update_score(0)

func update_score(new_score: int):
	scoreLabel.text = str(new_score)

func show_game_over():
	gameOverScreen.show()


func _on_game_over_restart() -> void:
	restartRequested.emit()
