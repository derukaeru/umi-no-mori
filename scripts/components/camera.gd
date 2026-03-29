extends Camera2D

const ROOM_SIZE = Vector2(256, 192)
const TRANSITION_SPEED = 0.3

var is_transitioning := false

func _physics_process(_delta):
	if is_transitioning: return
	check_room_transition()

func check_room_transition():
	var player = Util.get_player()
	
	var camera_room = (global_position / ROOM_SIZE).floor()
	var player_room = (player.global_position / ROOM_SIZE).floor()
	
	if player_room != camera_room:
		transition_to_room(player_room)

func transition_to_room(room: Vector2):
	is_transitioning = true
	
	var player = Util.get_player()
	if player: player.can_move = false
	
	var target = room * ROOM_SIZE
	
	var tween = create_tween()
	tween.tween_property(self, "global_position", target, TRANSITION_SPEED)
	tween.tween_callback(func(): 
		is_transitioning = false
		player.can_move = true
	)

func screen_shake(strength: float = 5.0, duration: float = 0.3):
	var tween = create_tween()
	var shakes = 6
	var step = duration / shakes
	for i in shakes:
		var _offset = Vector2(
			randf_range(-strength, strength),
			randf_range(-strength, strength)
		)
		tween.tween_property(self, "offset", _offset, step)
	tween.tween_property(self, "offset", Vector2.ZERO, step)
