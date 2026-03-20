extends CharacterBody2D

const MOVE_SPEED = 100.0
const TONGUE_PULL_FORCE = 4000.0
const GRAVITY = 200.0
const DRAG = 0.88

var tongue_direction = Vector2.ZERO
var is_tongue_active = false
var tongue_hooked: Node2D

func _physics_process(delta):
	velocity.y += GRAVITY * delta

	var h = Input.get_axis("move_left", "move_right")
	velocity.x = h * MOVE_SPEED

	if is_tongue_active:
		velocity += tongue_direction * TONGUE_PULL_FORCE * delta

	# velocity *= DRAG
	move_and_slide()

func _input(_event):
	if Input.is_action_just_pressed("interact"):
		fire_tongue()

func fire_tongue():
	var dir = Vector2.ZERO
	if Input.is_action_pressed("aim_up"):
		dir = Vector2.UP
	elif Input.is_action_pressed("aim_down"):
		dir = Vector2.DOWN
	elif Input.is_action_pressed("aim_left"):
		dir = Vector2.LEFT
	elif Input.is_action_pressed("aim_right"):
		dir = Vector2.RIGHT
	else:
		dir = Vector2.UP 

	tongue_direction = dir
	is_tongue_active = true
	
	await get_tree().create_timer(0.50).timeout
	is_tongue_active = false

func reset() -> void:
	pass
