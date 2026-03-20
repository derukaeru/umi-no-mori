extends CharacterBody2D

const SPEED = 120.0
const JUMP_VELOCITY = -320.0
const GRAVITY = 900.0

const WATER_GRAVITY = 200.0
const WATER_SPEED = 80.0
const WATER_DRAG = 0.85

var is_underwater = false

func _physics_process(delta):
	if is_underwater:
		_underwater_movement(delta)
	else:
		_land_movement(delta)
	move_and_slide()

func _land_movement(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func _underwater_movement(delta):
	velocity.y += WATER_GRAVITY * delta

	var h = Input.get_axis("left", "right")
	var v = Input.get_axis("up", "down")

	velocity.x = h * WATER_SPEED
	if v:
		velocity.y = v * WATER_SPEED

	velocity *= WATER_DRAG

func death():
	pass
