extends CharacterBody2D

const WANDER_SPEED := 10.0
const PUFF_KNOCKBACK := 250.0
const GRAVITY := 200.0

enum State { WANDERING, PUFFED }

var state := State.WANDERING
var wander_direction := Vector2.RIGHT
var wander_timer := 0.0

func _ready():
	pick_new_direction()

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	match state:
		State.WANDERING:
			_wander(delta)
		State.PUFFED:
			velocity.x = move_toward(velocity.x, 0, 200 * delta)
	move_and_slide()

func _wander(delta):
	wander_timer -= delta
	if wander_timer <= 0:
		pick_new_direction()

	if is_on_wall():
		wander_direction.x *= -1

	velocity.x = wander_direction.x * WANDER_SPEED

func pick_new_direction():
	wander_direction = Vector2([-1.0, 1.0].pick_random(), 0)
	wander_timer = randf_range(1.5, 3.5)

func puff(player: CharacterBody2D):
	if state == State.PUFFED: return
	state = State.PUFFED
	$AnimationPlayer.play("puff")

	var knockback = (player.global_position - global_position).normalized()
	player.velocity = knockback * PUFF_KNOCKBACK

	await get_tree().create_timer(2.0).timeout
	$AnimationPlayer.play("deflate")
	await get_tree().create_timer(0.5).timeout
	state = State.WANDERING

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		puff(body)
