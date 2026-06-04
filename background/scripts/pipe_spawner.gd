extends Node2D

@export var pipeScene : PackedScene

var pipes: Array = []
var running: bool = false
var screenSize: Vector2i
var groundHeight: int

const SCROLL_SPEED: float = 240.0
const PIPE_DELAY: int = 100
const PIPE_RANGE: int = 200

# seniales para comunicarse con el main
signal pipePassed
signal pipeHit

func _ready():
	screenSize = get_window().size

func reset():
	get_tree().call_group("pipesGroup", "queue_free")
	pipes.clear()

func start_spawning(gHeight: int):
	groundHeight = gHeight
	running = true
	$PipeTimer.start()
	generate_pipes()

func stop_spawning():
	running = false
	$PipeTimer.stop()

func _process(delta: float):
	if running:
		for pipe in pipes:
			pipe.position.x -= SCROLL_SPEED * delta

func _on_pipe_timer_timeout():

	generate_pipes()

func generate_pipes():
	var pipe = pipeScene.instantiate()
	pipe.position.x = screenSize.x + PIPE_DELAY
	pipe.position.y = round(screenSize.y - groundHeight) / 2 + randi_range(-PIPE_RANGE, PIPE_RANGE)

	pipe.hit.connect(func(): pipeHit.emit())
	pipe.scored.connect(func(): pipePassed.emit())

	add_child(pipe)
	pipes.append(pipe)
