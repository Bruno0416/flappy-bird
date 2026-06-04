extends Node

@onready var bird: CharacterBody2D = $Bird
@onready var pipeSpawner: Node2D = $PipeSpawner
@onready var uiManager: CanvasLayer = $UIManager
@onready var ground: Area2D = $Ground

var score: int = 0
var scroll: float = 0
var running: bool = false
const SCROLL_SPEED: float = 240.0
var screenSize: Vector2i

func _ready():
	screenSize = get_window().size

	# conectamos las seniales
	uiManager.restartRequested.connect(new_game)
	pipeSpawner.pipePassed.connect(_on_pipe_scored)
	pipeSpawner.pipeHit.connect(stop_game)
	bird.flapStarted.connect(start_game)
	bird.hitCeiling.connect(stop_game)
	ground.body_entered.connect(func(_body): stop_game())

	new_game()

func new_game():
	running = false
	score = 0
	scroll = 0
	uiManager.reset_ui()
	pipeSpawner.reset()
	bird.reset()

func start_game():
	running = true
	var groundHeight = ground.get_node("Sprite2D").texture.get_height()
	pipeSpawner.start_spawning(groundHeight)

func _process(delta: float):
	if running:
		scroll += SCROLL_SPEED * delta
		if scroll >= screenSize.x:
			scroll = 0
		ground.position.x = -scroll

func _on_pipe_scored():
	score += 1
	uiManager.update_score(score)

func stop_game():
	if not running: return

	running = false
	bird.falling = true
	pipeSpawner.stop_spawning()

	# reproducir sonido de game over
	$DieSound.play()


	if score > ConfigManager.high_score:
		ConfigManager.high_score = score
		ConfigManager.save_data()

	uiManager.show_game_over()
