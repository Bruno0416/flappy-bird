extends CanvasLayer

@export var scoreLabel: Label
@export var gameOverScreen: PackedScene

signal restart_requested

func reset_ui():
    gameOverScreen.hide()
    update_score(0)

func update_score(new_score: int):
    scoreLabel.text = str(new_score)

func show_game_over():
    gameOverScreen.show()

func _on_restart_button_pressed():
    restart_requested.emit()
