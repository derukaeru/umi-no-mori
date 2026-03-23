extends CharacterBody2D

const MOVE_SPEED := 70.0
const ACCELERATION := 65.0
const TONGUE_PULL_FORCE := 400.0
const GRAVITY := 200.0
const DRAG := 0.98

var can_move := true
var tongue_direction := Vector2.ZERO
var is_tongue_active := false
var is_tongue_tucked := true
var target_hooked: Urchin
var position_hooked: Vector2
var position_hooked_angle: Vector2 = Vector2.ZERO


@onready var tongue = $tongue_tip
@onready var tongue_line = $tongue_line

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	
	if can_move:
		var h = Input.get_axis("move_left", "move_right")
		velocity.x = move_toward(velocity.x, h * MOVE_SPEED, ACCELERATION * delta)
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -140.0
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.4
		
	if not is_tongue_tucked and position_hooked == Vector2.ZERO:
		if is_tongue_active:
			tongue.position += tongue_direction * 3.5
		else:
			tongue.position += -tongue_direction * 3.5
			if tongue.position.length() < 4.0:
				tuck_tongue()
	
	if tongue_line.visible:
		tongue_line.points = [Vector2.ZERO, tongue.position]
	
	if target_hooked:
		target_hooked.global_position = tongue.global_position
	
	if position_hooked != Vector2.ZERO:
		self.global_position += position_hooked_angle * 2
		tongue.global_position = position_hooked
		
		if self.global_position.distance_to(position_hooked) < 2.0:
			position_hooked = Vector2.ZERO
			tuck_tongue()
			can_move = true
	
	velocity *= DRAG
	move_and_slide()

func _input(_event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and is_tongue_tucked and not is_tongue_active and can_move:
		fire_tongue()

func fire_tongue():
	var mouse_pos = get_global_mouse_position()
	tongue_direction = (mouse_pos - global_position).normalized()
	
	tongue_line.visible = true
	
	is_tongue_active = true
	is_tongue_tucked = false
	
	await get_tree().create_timer(0.2).timeout
	
	if position_hooked == Vector2.ZERO:
		is_tongue_active = false

func reset() -> void:
	pass

func tuck_tongue():
	is_tongue_tucked = true
	tongue_line.visible = false
	
	tongue.position = Vector2.ZERO
	
	if target_hooked:
		target_hooked.queue_free()
		target_hooked = null
		GameManager.urchin_money += 1
	
	if position_hooked:
		pass

func _on_tongue_tip_body_entered(body):
	if body.is_in_group("player") and not is_tongue_tucked:
		tuck_tongue()
		return
		
	if body is TileMapLayer:
		position_hooked = tongue.global_position
		position_hooked_angle = (position_hooked - self.global_position).normalized()
		can_move = false

func _on_tongue_tip_area_entered(area):
	if area is Urchin and is_tongue_active:
		is_tongue_active = false
		target_hooked = area
