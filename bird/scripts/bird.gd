extends CharacterBody2D

const START_POS = Vector2(100,400)
const GRAVITY : int = 1000
const MAX_VEL : int =  750
const FLAP_SPEED : int = -500
var flying : bool = false
var falling : bool = false

# seniales para el main
signal flapStarted
signal hitCeiling


func _ready():
	reset()


func reset():
	flying = false
	falling = false
	position = START_POS
	set_rotation(0)


func _input(event):
	if event is InputEventKey and Input.is_action_just_pressed("flap"):
		if not flying and not falling:
			flying = true
			flapStarted.emit()

		if flying and not falling:
			flap()
			check_top()

func _physics_process(delta):
	if flying or falling:
		velocity.y += GRAVITY * delta

		if(velocity.y > MAX_VEL):
			velocity.y = MAX_VEL
		if flying:
			set_rotation(deg_to_rad(velocity.y * 0.05))
			$AnimatedSprite2D.play()
		elif falling:
			set_rotation(PI/2)
			$AnimatedSprite2D.stop()

		move_and_collide(velocity * delta)
	else:
		$AnimatedSprite2D.stop()


func flap():
	velocity.y = FLAP_SPEED

func check_top():
	if position.y < 10:
		falling = true
		hitCeiling.emit()
