class_name MovingUrchin extends CharacterBody2D

const MOVE_SPEED := 5.0
const GRAVITY := 200.0

enum State { CRAWLING, FALLING }

var state := State.CRAWLING
var direction := 1.0

func _physics_process(delta):
	
	match state:
		State.CRAWLING:
			_crawl(delta)
		State.FALLING:
			_fall(delta)
	move_and_slide()

func _crawl(_delta):
	if not is_on_floor() and not is_on_wall():
		state = State.FALLING
		velocity = Vector2.ZERO
		return
	
	if is_on_wall():
		direction *= -1
	
	velocity.x = direction * MOVE_SPEED
	velocity.y = GRAVITY

func _fall(delta):
	velocity.x = 0
	velocity.y += GRAVITY * delta
	
	if is_on_floor():
		state = State.CRAWLING
		direction = [-1.0, 1.0].pick_random()
