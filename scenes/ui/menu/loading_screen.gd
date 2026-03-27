extends CanvasLayer

signal loading_screen_ready

@onready var anim_player := $AnimationPlayer

func _ready():
	await anim_player.animation_finished
	loading_screen_ready.emit()

func _on_loading_finished(new_val: float) -> void:
	pass
	
func _on_progress_changed() -> void:
	anim_player.play_backwards("transition")
	await anim_player.animation_finished
	queue_free()
