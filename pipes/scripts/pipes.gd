extends Node2D

# importar hijos (pipes separados)
@onready var upper = $UpperPipe
@onready var lower = $LowerPipe

# senial de colision
signal hit
signal scored

var hitPlayed : bool = false

func _on_lower_pipe_body_entered(body: Node2D) -> void:
	if not hitPlayed:
		$BonkSound.play()
	hit.emit()
	hitPlayed = true

func _on_upper_pipe_body_entered(body: Node2D) -> void:
	if not hitPlayed:
		$BonkSound.play()
	hit.emit()
	hitPlayed = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	$ScoreSound.play()
	scored.emit()


func set_gap(gap_size: float) -> void:
	var middleGap = gap_size / 2.0

	upper.position.y = -middleGap
	lower.position.y = middleGap
